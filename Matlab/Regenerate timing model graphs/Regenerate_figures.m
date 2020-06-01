%% Running this script will generate figures 1C and 2C from Nair et al 2016
%% using the updated model with new parameters governing CaMKII autophosphorylation

clear
proj = sbioloadproject('model_D1_LTP_time_window.sbproj');
obj = proj.modelobj;
load('Old_data')

%% Get steady state values after equilibrating for 100000 s

cnfst = getconfigset(obj);
cnfst.SolverType = 'ode15s';
cnfst.StopTime = 50000;
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
set(obj.parameters(end-10:end), 'ValueUnits', 'dimensionless');

ruleobj=addrule(obj, 'Spine.Ca = spiketraindd_Ca(time,nCa_peakfirst,nCa_frequency,nCa_peaksn,nCa_ampbasal,nCa_ampmax_noMg,nCa_k1,nCa_k2,nCa_minpeaklngth,[],nCa_burstfreq,nCa_burstn,nCa_minburstinter,1)');
set(ruleobj,'RuleType','RepeatedAssignment');
set(obj.rules(2), 'Name', '0 Ca spikes with 3 AP');

% Assign DA_expression to dopamine

ruleobj=addrule(obj, 'Spine.DA = Spine.DA_expression');
set(ruleobj,'RuleType','RepeatedAssignment');

%% Run simulations

effector = {'Spine.pSubstrate'};

DA = [-4:0.2:4];
CaStart = 4;
cnfst.StopTime = 30;
cnfst.SolverOptions.MaxStep = 0.01;
cnfst.SolverOptions.OutputTimes = 0:0.01:30;
cnfst.RuntimeOptions.StatesToLog = {'pSubstrate'};
set(obj.rules(2), 'Active', 1);
set(obj.rules(3), 'Active', 0);

[t_noDA,x_noDA,~] = sbiosimulate(obj);
activationArea = sum(x_noDA) - x_noDA(1) * length(x_noDA);

set(obj.rules(3), 'Active', 1);
set(obj.parameters(228), 'ValueUnits', 'second'); % par 228 = DA_start
obj.parameters(228).Value = CaStart + 1; % par 228 = DA_start
[t_DA,x_DA,~] = sbiosimulate(obj);

figHandles = findobj('type', 'figure', 'name', 'Paper Figure 4');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper Figure 4','NumberTitle', 'off');
fig4 = tiledlayout(1,2,'Padding','none','TileSpacing','compact');
% fig4.TileSpacing = 'compact';

nexttile;
% subplot(1,2,1)
hold on
plot(t_noDA, x_noDA/max(x_noDA), '-.k', 'LineWidth', 1)
plot(results{1}(:,1), results{1}(:,2)/max(results{1}(:,2)), '-.r', 'LineWidth', 1)
plot(t_DA, x_DA/max(x_noDA),'k', 'LineWidth', 1)
plot(results{2}(:,1), results{2}(:,2)/max(results{1}(:,2)),'r', 'LineWidth', 1)
set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
legend({'Ca only (new)', 'Ca only (original)','Ca + Da (\Deltat=1s) (new)','Ca + Da (\Deltat=1s) (original)'},'FontSize',6.5);
legend boxoff
title('A','position',[-1.875 3.04])

activationAreaWithMultipleDA = zeros(1,length(DA));
for n = 1:length(DA)
    obj.parameters(228).Value = CaStart + DA(n); % par 228 = DA_start
    [t,x,~] = sbiosimulate(obj);
    activationAreaWithMultipleDA(n) = sum(x) - x(1) * length(x);
    clear t x names
end

nexttile;
% subplot(1,2,2)
hold on
plot(DA, activationAreaWithMultipleDA/activationArea,'k', 'LineWidth', 1)
plot(DA, results{3}(:,2),'r', 'LineWidth', 1)
plot([-4 4], [1 1], '--k', 'LineWidth', 1)
plot([0 0], [0 max(activationAreaWithMultipleDA/activationArea)], '-.', 'LineWidth', 1, 'Color', [0.5 0.5 0.5])
set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel('\Deltat (s)');
ylabel(" Substrate phosphorylation");
legend({'Ca + Da (new)','Ca + Da (original)'},'location','northwest','FontSize',6.5);
legend boxoff
title('B','position',[-4.5 4.06])



%Only saves the graph if running matlab 2020a or later
[majorversion, minorversion] = mcrversion;
if majorversion >= 9
    if minorversion >= 8
        
        fig4.Units = 'inches';
        fig4.OuterPosition = [0 0 6.5 2.15];
        
        exportgraphics(fig4,'Regenerate timing model graphs\Figure 4.png','Resolution',600)
        
        fig4.Units = 'normalized';
        fig4.OuterPosition = [0 0 1 1];
    end
end
