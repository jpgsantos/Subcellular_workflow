function f_Reproduce_data_fig7_C(folder)
%% Running this script will generate figures 1C and 2C from Nair et al 2016
%% using the updated model with new parameters governing CaMKII autophosphorylation

load(folder + "model_Nair_2016_optimized_fig7.mat",'modelobj');
obj = modelobj;

%% Get steady state values after equilibrating for 50000 s

cnfst = getconfigset(obj);
cnfst.SolverType = 'ode15s';
cnfst.StopTime = 2000;
cnfst.TimeUnits = 'second';
cnfst.SolverOptions.AbsoluteTolerance = 1e-4;
cnfst.SolverOptions.RelativeTolerance = 1e-4;
cnfst.CompileOptions.UnitConversion = 1;
cnfst.SolverOptions.AbsoluteToleranceScaling = 1;
cnfst.RunTimeOptions.StatesToLog = 'all';
cnfst.SolverOptions.AbsoluteToleranceStepSize = 0.01;

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

ruleobj=addrule(obj, 'Spine.Ca = Ca_input_fig7(time)');
set(ruleobj,'RuleType','RepeatedAssignment');

% Assign DA_expression to dopamine
ruleobj=addrule(obj, 'Spine.DA = Spine.DA_expression');
set(ruleobj,'RuleType','RepeatedAssignment');

%% Run simulations

DA = -4:0.25:4;
CaStart = 4;
cnfst.StopTime = 20;
cnfst.SolverOptions.MaxStep = 0.0001;
cnfst.SolverOptions.OutputTimes = 0:0.0001:20;
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
objm_cnfst{n}.StopTime = 20;
objm_cnfst{n}.SolverOptions.MaxStep = 0.0001;
objm_cnfst{n}.SolverOptions.OutputTimes = 0:0.0001:20;
objm_cnfst{n}.RuntimeOptions.StatesToLog = {'pSubstrate'};
objm_cnfst{n}.SolverType = 'ode15s';
objm_cnfst{n}.TimeUnits = 'second';
objm_cnfst{n}.SolverOptions.AbsoluteTolerance = 1e-4;
objm_cnfst{n}.SolverOptions.RelativeTolerance = 1e-4;
objm_cnfst{n}.CompileOptions.UnitConversion = 1;
objm_cnfst{n}.SolverOptions.AbsoluteToleranceScaling = 1;
end

parfor n = 1:length(DA)
    n
    [~,x,~] = sbiosimulate(objm{n},objm_cnfst{n});
    activationAreaWithMultipleDA(n) = sum(x) - x(1) * length(x);
end

Nair_2016_optimized_Matlab_data_fig7{1}(:,1) = t_noDA;
Nair_2016_optimized_Matlab_data_fig7{1}(:,2) = x_noDA;
Nair_2016_optimized_Matlab_data_fig7{2}(:,1) = t_DA;
Nair_2016_optimized_Matlab_data_fig7{2}(:,2) = x_DA;
Nair_2016_optimized_Matlab_data_fig7{3}(:,1) = DA;
Nair_2016_optimized_Matlab_data_fig7{3}(:,2) = activationAreaWithMultipleDA/activationArea;
Nair_2016_optimized_Matlab_data_fig7{3}(:,3) = activationAreaWithMultipleDA;
Nair_2016_optimized_Matlab_data_fig7{3}(:,4) = activationArea;

save(folder + "Nair_2016_optimized_Matlab_data_fig7.mat",...
    'Nair_2016_optimized_Matlab_data_fig7')
end