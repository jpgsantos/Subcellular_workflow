%% Running this script will generate figures 1C and 2C from Nair et al 2016 
%% using the updated model with new parameters governing CaMKII autophosphorylation

clear
proj = sbioloadproject('model_D1_LTP_time_window.sbproj');
obj = proj.m1; %modelobj;

%% Get steady state values after equilibrating for 100000 s

cnfst = getconfigset(obj);
cnfst.SolverType = 'ode15s';
cnfst.StopTime = 100000;
cnfst.TimeUnits = 'second';
cnfst.SolverOptions.AbsoluteTolerance = 1e-9;
cnfst.SolverOptions.RelativeTolerance = 1e-6;
cnfst.CompileOptions.UnitConversion = 1;
cnfst.SolverOptions.AbsoluteToleranceScaling = 0;
cnfst.RunTimeOptions.StatesToLog = 'all';
% set(obj.rules(2), 'Active', 0); % Uncomment if Ca input is incorporated
% set(obj.rules(3), 'Active', 0); % Uncomment if DA input is incorporated

[t,species,~] = sbiosimulate(obj);

SteadyState=species(length(t),:);

for i=1:length(SteadyState)
    if SteadyState(i)<0
        SteadyState(i)=0;
    end
end

for i=1:length(SteadyState)
    set(obj.species(i), 'InitialAmount', SteadyState(i));
end

%% Add parameters used by the Calcium input

addparameter(obj, 'nCa_peaksn', 10);
addparameter(obj, 'nCa_peakfirst', 4);
addparameter(obj, 'nCa_minpeaklngth', 0.01);
addparameter(obj, 'nCa_minburstinter', 5);
addparameter(obj, 'nCa_k2', 9.3);
addparameter(obj, 'nCa_k1', 39.4);
addparameter(obj, 'nCa_frequency', 10);
addparameter(obj, 'nCa_burstn', 1.0);
addparameter(obj, 'nCa_burstfreq', 0.03);
addparameter(obj, 'nCa_ampmax_noMg', 1200);
addparameter(obj, 'nCa_ampbasal', 60);
set(obj.parameters(231:241), 'ValueUnits', 'dimensionless');

ruleobj=addrule(obj, 'Spine.Ca = spiketraindd_Ca(time,nCa_peakfirst,nCa_frequency,nCa_peaksn,nCa_ampbasal,nCa_ampmax_noMg,nCa_k1,nCa_k2,nCa_minpeaklngth,[],nCa_burstfreq,nCa_burstn,nCa_minburstinter,1)');
set(ruleobj,'RuleType','RepeatedAssignment');
set(obj.rules(2), 'Name', '0 Ca spikes with 3 AP');

% Assign DA_expression to dopamine

ruleobj=addrule(obj, 'Spine.DA = Spine.DA_expression');
set(ruleobj,'RuleType','RepeatedAssignment');

%% Run simulations

effector = {'Spine.pSubstrate'};

%DA = [-4:0.2:4];
DA = [-4:1:4];

CaStart = obj.parameters(232).Value;
cnfst.StopTime = 30;
cnfst.SolverOptions.MaxStep = 0.01;
cnfst.SolverOptions.OutputTimes = 0:0.01:30;
%cnfst.RuntimeOptions.StatesToLog = {'pSubstrate','DA','Ca','CaM_Ca2','D1R_DA'};

cnfst.RuntimeOptions.StatesToLog = {'pSubstrate','DA','Ca','CaM','PP1','D32','CaM_Ca2','D1R_DA','cAMP','CaMKII_CaM_Ca2',...
    'B72PP2A_Ca_pARPP21','PP1_pSubstrate', 'PDE10c','CaMKII_CaM_Ca2_psd','PP2B_CaM_Ca2','pARPP21'};

set(obj.rules(2), 'Active', 1);
set(obj.rules(3), 'Active', 0);

[t_noDA,x_noDA,~] = sbiosimulate(obj);
activationArea = sum(x_noDA(:,1)) - x_noDA(1,1) * length(x_noDA(:,1));

set(obj.rules(3), 'Active', 1);
set(obj.parameters(228), 'ValueUnits', 'second');
obj.parameters(228).Value = CaStart + 1;
[t_DA,x_DA,~] = sbiosimulate(obj);

subplot(2,1,1)
hold on
plot(t_noDA, x_noDA(:,1)/max(x_noDA(:,1)), '-.', 'LineWidth', 2)
plot(t_DA, x_DA(:,1)/max(x_noDA(:,1)), 'LineWidth', 2)
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
legend({'Calcium only', 'Calcium + Dopamine (\Deltat=1s)'});

activationAreaWithMultipleDA = zeros(1,length(DA));
for n = 1:length(DA)
    obj.parameters(228).Value = CaStart + DA(n);
    [t,x,~] = sbiosimulate(obj);
    activationAreaWithMultipleDA(n) = sum(x(:,1)) - x(1,1) * length(x(:,1));
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