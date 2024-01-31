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
    PL_iter(:) = PL_iter_start(par_indx)-1:-1:1;
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

% Run optimization iterations
[x, fval, simd, Pval] =...
    runOptimizationIterations(x, fval, simd, Pval, PL_iter, settings,...
    model_folders, par_indx, delta_par, temp_lb, temp_up,...
    alg, section,temp_array);

str_end_alg_names = {'end    sa', 'start  sa', 'end    ps',...
    'start  ps', 'end    fm', 'start  fm'};
% Display completion message for current parameter and optimization method
for i = 1:length(str_end_alg_names)
    if parfor_indices <= length(settings.pltest) * i
        disp(['P' num2str(par_indx) ' ' str_end_alg_names{i} ' finished']);
        break;
    end
end
end

function [x, fval, simd, Pval] =...
    runOptimizationIterations(x, fval, simd, Pval, PL_iter,...
    settings, model_folders, par_indx, delta_par, temp_lb, temp_up,...
    alg, section,temp_array)
% Manages optimization iterations for a specific parameter and method.
% Iteratively adjusts the parameter value and calls the appropriate
% optimization method. Ensures the optimization process adheres to the
% bounds and settings specified.
%
% Inputs:
% - x, fval, simd, Pval: Containers for optimization results.
% - PL_iter: Current range of indices in the profile likelihood calculation.
% - settings: A structure containing optimization settings.
% - model_folders: Directory containing the model files.
% - par_indx: Index of the parameter being optimized.
% - delta_par: Incremental step size for the parameter search.
% - temp_lb, temp_up: Adjusted lower and upper bounds for the parameters.
% - alg: Array containing the algorithm to use and its index.
% - section: Part of the parameter space being optimized ('start' or 'end').
% - temp_array: Array of parameter values excluding the current parameter.
%
% Outputs:
% - x, fval, simd, Pval: Updated optimization results after running this
% iteration.
%
% This function orchestrates the optimization process, adjusting the
% parameter value and invoking the optimization algorithm as per the
% current position in the parameter space.

% Initialize additional variables for optimization
offset = 0;
prev_fval = inf;
ratio = 1.5;

% Iterate over the PL values
for PL_iter_current = PL_iter
    if PL_iter_current == PL_iter(1)
        if section == "end"
            pos = ((PL_iter(1)-1)*4+4)-4+1;
        else
            pos = ((PL_iter(1)-1)*4+(4-4))+1;
        end
        pos_minus_1 = pos;
        x{alg{2}}{pos_minus_1} = temp_array;

    end


    % Adjust settings for the current position in the parameter space
    settings.PLval =...
        settings.lb(par_indx) + abs(delta_par) * (PL_iter_current - 1);

    current_pos = 4;
    pass_pos(1:4) = false;

    % Execute optimization for specific positions within the parameter space
    while current_pos <= 4
        optimize = false;
        step = 0;
        if (current_pos == 2 && ~pass_pos(1)) || (current_pos == 4 && ~pass_pos(3))

            % Get the score for the current solution
            x_score = x{alg{2}}{pos_minus_1};
            [score,~,~] = f_sim_score(x_score, settings, model_folders);
        end

        % Run optimization methods for position 1 and position 3
        if current_pos == 1 || current_pos == 3
            optimize = true;

            % Set pass_pos depending on the current step
            pass_pos(current_pos) = true;
            step = 1;

            % Run optimization methods for position 2
        elseif current_pos == 2
            % If the current score is less than the previous score
            % multiplied by the ratio, run the optimization method again
            if score < ratio * prev_fval || pass_pos(1)
                optimize = true;
                step = 2;

                % Set pass_pos depending on the current step
                pass_pos(current_pos) = true;
            else
                step = -1;
            end

            % Run optimization methods for position 4
        else
            % If the current score is less than the previous score
            % multiplied by the ratio or repeat_3 flag is set, run the
            % optimization method again
            if score < ratio * prev_fval || pass_pos(3)
                optimize = true;
                pass_pos(current_pos) = true;
            elseif pass_pos(2)
                step = -1;
            else
                step = -2;
            end
        end

        if optimize
            % Call the optimization method with the current settings
            % and step
            pos_minus_1 = pos;

            if section == "end"
                pos = ((PL_iter_current-1)*4+current_pos)-4+1;
            else
                pos = ((PL_iter_current-1)*4+(4-current_pos))+1;
            end

            % Execute the optimization method with updated settings and current step
            [x, fval, simd{alg{2}}{pos}, Pval, prev_fval, offset] =...
                run_optimization_method(x, fval, Pval,...
                offset, temp_lb, temp_up,...
                settings, model_folders, alg,PL_iter_current,current_pos, pos,pos_minus_1,0);
        end

        current_pos = current_pos + step;
        if ~pass_pos(4)
            % Update PLval and inter_step based on the step
            settings.PLval = settings.PLval + delta_par * step/4;
        else
            break
        end
    end
end
end

