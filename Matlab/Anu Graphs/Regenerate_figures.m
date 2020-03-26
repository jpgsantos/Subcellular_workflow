%% Running this script will generate figures 1C and 2C from Nair et al 2016 
%% using the updated model with new parameters governing CaMKII autophosphorylation

clear
proj = sbioloadproject('D1_LTP_time_window_SimBiology.sbproj');
obj = proj.m1;

effector = {'Neuron.pSubstrate'};

DA = [-4:0.2:4];
CaStart = obj.parameters(240).Value;

cnfst = getconfigset(obj);
cnfst.StopTime = 30;
cnfst.SolverType = 'ode15s';   
cnfst.SolverOptions.MaxStep = 0.01;
cnfst.SolverOptions.OutputTimes = 0:0.01:30;
cnfst.RuntimeOptions.StatesToLog = {'pSubstrate'};

set(obj.rules(2), 'Active', 0);
[t,x_noDA,names] = sbiosimulate(obj);
activationArea = sum(x_noDA) - x_noDA(1) * length(x_noDA);

set(obj.rules(2), 'Active', 1);
obj.parameters(230).Value = CaStart + 1;
[t,x_DA,names] = sbiosimulate(obj);

subplot(2,1,1)
hold on
plot(t, x_noDA/max(x_noDA), '-.', 'LineWidth', 2)
plot(t, x_DA/max(x_noDA), 'LineWidth', 2)
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
legend({'Calcium only', 'Calcium + Dopamine (\Deltat=1s)'});

activationAreaWithMultipleDA = zeros(1,length(DA));

for i = 1:length(DA)
    obj.parameters(230).Value = CaStart + DA(i);
    [t,x,names] = sbiosimulate(obj);
    activationAreaWithMultipleDA(i) = sum(x) - x(1) * length(x);
    clear t x names
end

subplot(2,1,2)
hold on
plot(DA, activationAreaWithMultipleDA/activationArea, 'LineWidth', 2)
plot([-4 4], [1 1], '-.', 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
plot([0 0], [0 max(activationAreaWithMultipleDA/activationArea)], '-.', 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('\Deltat (s)');
ylabel('Substrate phosphorylation');

