function f_Reproduce_data_fig3_CD(folder)
%% Running this script will generate figures 1C and 2C from Nair et al 2016
%% using the updated model with new parameters governing CaMKII autophosphorylation
warning('off','SimBiology:DimAnalysisNotDone_MatlabFcn_Dimensionless')

load(folder + "model_Nair_2016_optimized_fig3.mat",'modelobj');
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

ruleobj=addrule(obj, 'Spine.Ca = Ca_input_fig3(time,Ca_input)');
set(ruleobj,'RuleType','RepeatedAssignment');
addparameter(obj, 'Ca_input', 0);
set(obj.parameters(end), 'ValueUnits', 'dimensionless');

% Assign DA_expression to dopamine
ruleobj=addrule(obj, 'Spine.DA = Spine.DA_expression');
set(ruleobj,'RuleType','RepeatedAssignment');

%% Run simulations

DA = -4:0.2:4;
CaStart = 4;
cnfst.StopTime = 30;
cnfst.SolverOptions.MaxStep = 0.01;
cnfst.SolverOptions.OutputTimes = 0:0.01:30;
cnfst.RuntimeOptions.StatesToLog = {'pSubstrate'};
set(obj.rules(2), 'Active', 1);
set(obj.rules(3), 'Active', 0);

obj.parameters(end).Value = 1;%Ca_input
[t_noDA,x_noDA,~] = sbiosimulate(obj);
activationArea = sum(x_noDA) - x_noDA(1) * length(x_noDA);

set(obj.rules(3), 'Active', 1);
set(obj.parameters(228), 'ValueUnits', 'second'); % par 228 = DA_start
obj.parameters(228).Value = CaStart + 1; % par 228 = DA_start
obj.parameters(end).Value = 2;%Ca_input

[t_DA,x_DA,~] = sbiosimulate(obj);

activationAreaWithMultipleDA = zeros(1,length(DA));

for n = 1:length(DA)
objm{n} = copyobj(obj);
objm{n}.parameters(end).Value = n+2;%Ca_input
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
    warning('off','SimBiology:DimAnalysisNotDone_MatlabFcn_Dimensionless')
    [~,x,~] = sbiosimulate(objm{n},objm_cnfst{n});
    activationAreaWithMultipleDA(n) = sum(x) - x(1) * length(x);
%     ME = MException(errID,msgtext)
end

Nair_2016_optimized_Matlab_data_fig3{1}(:,1) = t_noDA;
Nair_2016_optimized_Matlab_data_fig3{1}(:,2) = x_noDA;
Nair_2016_optimized_Matlab_data_fig3{2}(:,1) = t_DA;
Nair_2016_optimized_Matlab_data_fig3{2}(:,2) = x_DA;
Nair_2016_optimized_Matlab_data_fig3{3}(:,1) = DA;
Nair_2016_optimized_Matlab_data_fig3{3}(:,2) = activationAreaWithMultipleDA/activationArea;

save(folder + "Nair_2016_optimized_Matlab_data_fig3.mat",...
    'Nair_2016_optimized_Matlab_data_fig3')
end