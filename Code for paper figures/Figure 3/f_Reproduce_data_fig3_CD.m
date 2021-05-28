function f_Reproduce_data_fig3_CD(folder)
%% Running this script will generate figures 1C and 2C from Nair et al 2016
%% using the updated model with new parameters governing CaMKII autophosphorylation

load(folder + "model_Nair_2016_optimized_fig3.mat");
obj = modelobj;

%% Get steady state values after equilibrating for 50000 s

cnfst = getconfigset(obj);
cnfst.SolverType = 'ode15s';
cnfst.StopTime = 50000;
cnfst.TimeUnits = 'second';
cnfst.SolverOptions.AbsoluteTolerance = 1e-7;
cnfst.SolverOptions.RelativeTolerance = 1e-4;
cnfst.CompileOptions.UnitConversion = 1;
cnfst.SolverOptions.AbsoluteToleranceScaling = 1;
cnfst.RunTimeOptions.StatesToLog = 'all';

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

activationAreaWithMultipleDA = zeros(1,length(DA));

for n = 1:length(DA)
objm{n} = copyobj(obj);
objm{n}.parameters(228).Value = CaStart + DA(n); % par 228 = DA_start
objm_cnfst{n} = getconfigset(objm{n});
objm_cnfst{n}.StopTime = 30;
objm_cnfst{n}.SolverOptions.MaxStep = 0.01;
objm_cnfst{n}.SolverOptions.OutputTimes = 0:0.01:30;
objm_cnfst{n}.RuntimeOptions.StatesToLog = {'pSubstrate'};
objm_cnfst{n}.SolverType = 'ode15s';
objm_cnfst{n}.TimeUnits = 'second';
objm_cnfst{n}.SolverOptions.AbsoluteTolerance = 1e-7;
objm_cnfst{n}.SolverOptions.RelativeTolerance = 1e-4;
objm_cnfst{n}.CompileOptions.UnitConversion = 1;
objm_cnfst{n}.SolverOptions.AbsoluteToleranceScaling = 1;
end

parfor n = 1:length(DA)
    [~,x,~] = sbiosimulate(objm{n},objm_cnfst{n});
    activationAreaWithMultipleDA(n) = sum(x) - x(1) * length(x);
end

new_data{1}(:,1) = t_noDA;
new_data{1}(:,2) = x_noDA;
new_data{2}(:,1) = t_DA;
new_data{2}(:,2) = x_DA;
new_data{3}(:,1) = DA;
new_data{3}(:,2) = activationAreaWithMultipleDA/activationArea;

save(folder + "new_data.mat",'new_data')
end