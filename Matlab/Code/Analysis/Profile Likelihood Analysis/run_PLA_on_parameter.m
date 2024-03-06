function [x,fval,simd,Pval] =...
    run_PLA_on_parameter(parfor_indices, PL_iter_start, settings, model_folders)
% Executes optimization for a given parameter. It manages the direction of
% parameter search, sets the range for PL_iter based on the current
% parameter index, and performs optimization using the specified method
% (simulated annealing, fmincon, or pattern search) for a single parameter.
%
% Inputs:
% - parfor_indices: Indices for parallel execution.
% - PL_iter_start: Indices of the starting points for PL calculation.
% - settings: A structure with optimization settings.
% - model_folders: Directory containing the model files.
%
% Outputs:
% - x: Optimized parameter values.
% - fval: Objective function values.
% - simd: Simulated data.
% - Pval: Parameter values.
%
% This function handles both forward and reverse direction searches and
% iterates through the parameter space, calling runOptimizationIterations
% for each step.

% Calculate the actual parameter index based on the input
par_indx = settings.pltest(mod(parfor_indices-1, length(settings.pltest)) + 1);

% Determine the direction of the parameter search and set the range for
% PL_iter based on the current parameter index

% Calculate the step size for the search
delta = (settings.ub(par_indx) - settings.lb(par_indx)) / settings.plres;

if mod(parfor_indices - 1, length(settings.pltest)*2) < length(settings.pltest)
    % Set the search range in the forward direction
    delta_par = delta;
    PL_iter(:) = PL_iter_start(par_indx):settings.plres+1;
    section = "end";
else
    % Calculate the step size for the search in the reverse direction
    delta_par = -delta;
    % Set the search range in the reverse direction
    PL_iter(:) = PL_iter_start(par_indx):-1:1;
    section = "start";
end

% Set the parameter index for profile likelihood calculations
settings.PLind = par_indx;

% Remove the current parameter from the bestpa, lb, and ub arrays
temp_array = settings.bestpa;
temp_array(par_indx) = [];
temp_lb = settings.lb;
temp_lb(par_indx) = [];
temp_up = settings.ub;
temp_up(par_indx) = [];

% Choose optimization algorithm based on the settings and index
if parfor_indices <= length(settings.pltest)*2 && settings.plsa
    alg = {'sa',1};
elseif parfor_indices > length(settings.pltest)*2 &&...
        parfor_indices <= length(settings.pltest)*4 && settings.plps
    alg = {'ps',2};
elseif parfor_indices > length(settings.pltest)*4 && settings.plfm
    alg = {'fm',3};
end

% Initialize variables for the optimization
if settings.(['pl' alg{1}])
    % Set the starting point of PL to the best solution found so far
    % if ~isempty(PL_iter(:))
    % x{alg{2}}{1} = temp_array;
    % else
    x{alg{2}} = [];
    % end
    fval{alg{2}} = [];
    simd{alg{2}} = [];
    Pval{alg{2}} = [];
end
tic
% Run optimization iterations
[x, fval, simd, Pval] =...
    run_optimization_iterations(x, fval, simd, Pval, PL_iter, settings,...
    model_folders, par_indx, delta_par, temp_lb, temp_up,...
    alg, section,temp_array);

 time_run_optimization_iterations = toc;


str_end_alg_names = {'end    sa', 'start  sa', 'end    ps',...
    'start  ps', 'end    fm', 'start  fm'};
% Display completion message for current parameter and optimization method
for i = 1:length(str_end_alg_names)
    if parfor_indices <= length(settings.pltest) * i
        disp("P" + num2str(par_indx) + " " + str_end_alg_names{i} + " finished time: " + time_run_optimization_iterations);
        break;
    end
end
end