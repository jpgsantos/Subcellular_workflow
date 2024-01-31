function [x, fval, simd, Pval, prev_fval, offset] = ...
    run_optimization_method(x, fval, Pval, offset, temp_lb,...
    temp_up, settings, model_folders, alg, PL_iter_current, current_pos, pos,pos_minus_1,debug)
% Executes the chosen optimization method for the current parameter and position.
% It runs either simulated annealing, fmincon, or pattern search based on the algorithm
% specified and returns the optimized variables, function values, and simulation data.
%
% Inputs:
% - x, fval, simd, Pval, prev_fval, offset: Containers for optimization results and parameters.
% - temp_lb, temp_up: Lower and upper bounds for the optimization.
% - settings: A structure containing optimization settings.
% - model_folders: Directory containing the model files.
% - alg: Array containing the algorithm to use and its index.
% - PL_iter_current, current_pos: Current position in the parameter space.
% - pos, pos_minus_1: Indices for the current and previous positions.
%
% Outputs:
% - x, fval, simd, Pval, prev_fval, offset: Updated optimization results and parameters.
%
% The function decides which optimization algorithm to run, executes it, and updates
% the result containers with the latest optimization outcomes.

offset = offset+1;

% Determine the optimization function based on the algorithm
if alg{2} == 1
    optimization_func = @sim_a;
elseif alg{2} == 2
    optimization_func = @fmin_con;
elseif alg{2} == 3
    optimization_func = @p_search;
else
    error('No optimization method specified');
end

if debug
    % alg{2}
    % pos_minus_1
    % x{alg{2}}
    % x{alg{2}}{pos_minus_1}
end
% Run the selected optimization function

% disp("alg{1}: " + alg{1})
% disp("alg{2}: " + alg{2})

[x{alg{2}}{pos}, fval{alg{2}}(pos),...
    simd] = ...
    optimization_func(offset, ...
    x{alg{2}}{pos_minus_1}, temp_lb, temp_up, settings, ...
    model_folders);

% Update parameter value and previous function value after optimization
Pval{alg{2}}(pos) = settings.PLval;
prev_fval = fval{alg{2}}(pos);

% Optional: Display current optimization status
disp(convertCharsToStrings(alg{1}) + " m: " + settings.PLind + "  n: " +...
    PL_iter_current + "." + current_pos + "  PLval: " + settings.PLval +...
    " fval: " + prev_fval);
end


function [x,fval,simd] =...
    sim_a(PL_iter_current,x,temp_lb,temp_up,settings,model_folders)
% Executes the simulated annealing optimization algorithm. It configures the
% algorithm settings, applies it to the current set of parameters, and returns the optimized results.
%
% Inputs:
% - PL_iter_current: Current iteration of profile likelihood calculation.
% - x: Current parameter values.
% - temp_lb, temp_up: Lower and upper bounds for the parameters.
% - settings: A structure containing optimization settings.
% - model_folders: Directory containing the model files.
%
% Outputs:
% - x: Optimized parameter values.
% - fval: Objective function value at the optimized parameters.
% - simd: Simulated data corresponding to the optimized parameters.
%
% This function is tailored for the simulated annealing algorithm and handles
% the optimization process including the algorithm configuration and execution.

% Set optimization options based on the iteration
if PL_iter_current == 1
    % Define initial options for the first iteration
    options = optimoptions(@simulannealbnd,'Display','off', ...
        'InitialTemperature',...
        ones(1,settings.parnum-1)*1,'MaxTime',1,'ReannealInterval',40);
else
    % Use predefined options from settings
    options = settings.plsao;
end
% Execute the optimization
[x,fval] = simulannealbnd(@(x)f_sim_score(x,settings,model_folders),...
    x,temp_lb,temp_up,options);

% Compute and store the result of the optimization
[~,rst,~] = f_sim_score(x,settings,model_folders);
simd = rst.simd{1,1};
end

function [x,fval,simd] =...
    fmin_con(PL_iter_current,x,temp_lb,temp_up,settings,model_folders)
% Executes the fmincon optimization algorithm. It sets the algorithm options, runs the optimization
% for the current parameters within the specified bounds, and returns the optimized results.
%
% Inputs:
% - PL_iter_current: Current iteration of profile likelihood calculation.
% - x: Current parameter values.
% - temp_lb, temp_up: Lower and upper bounds for the parameters.
% - settings: A structure containing optimization settings.
% - model_folders: Directory containing the model files.
%
% Outputs:
% - x: Optimized parameter values.
% - fval: Objective function value at the optimized parameters.
% - simd: Simulated data corresponding to the optimized parameters.
%
% This function specifically manages the fmincon optimization process, adjusting settings
% and ensuring the optimization is performed within the defined parameter space.

% Set optimization options based on the iteration
if PL_iter_current == 1
    % Define initial options for the first iteration
    options = optimoptions('fmincon','Display','off',...
        'Algorithm','interior-point',...
        'MaxIterations',1,'OptimalityTolerance',0,...
        'StepTolerance',1e-6,'FiniteDifferenceType','central');
else
    % Use predefined options from settings
    options = settings.plfmo;
end

% Execute the optimization
[x,fval] = fmincon(@(x)f_sim_score(x,settings,model_folders),...
    x,[],[],[],[],temp_lb,temp_up,[],options);

% Compute and store the result of the optimization
[~,rst,~] = f_sim_score(x,settings,model_folders);
simd = rst.simd{1,1};
end

function [x,fval,simd] =...
    p_search(PL_iter_current,x,temp_lb,temp_up,settings,model_folders)
% Executes the pattern search optimization algorithm. Configures the algorithm,
% applies it to the parameter set, and returns the optimized results.
%
% Inputs:
% - PL_iter_current: Current iteration of profile likelihood calculation.
% - x: Current parameter values.
% - temp_lb, temp_up: Lower and upper bounds for the parameters.
% - settings: A structure containing optimization settings.
% - model_folders: Directory containing the model files.
%
% Outputs:
% - x: Optimized parameter values.
% - fval: Objective function value at the optimized parameters.
% - simd: Simulated data corresponding to the optimized parameters.
%
% The function is dedicated to the pattern search algorithm, handling its configuration,
% execution, and the return of the optimization results.

% Set optimization options based on the iteration
if PL_iter_current == 1
    % Define initial options for the first iteration
    options = optimoptions(@patternsearch,'Display','off',...
        'MaxTime',1,...
        'UseCompletePoll',false,'UseCompleteSearch',false,...
        'MaxMeshSize',1,'MaxFunctionEvaluations',10000);
else
    % Use predefined options from settings
    options = settings.plpso;
end

% Execute the optimization
[x, fval] = ...
    patternsearch(@(x)f_sim_score(x,settings,model_folders), x, ...
    [], [], [], [], temp_lb,temp_up, [], options);

% Compute and store the result of the optimization
[~,rst,~] = f_sim_score(x,settings,model_folders);
simd = rst.simd{1,1};
end