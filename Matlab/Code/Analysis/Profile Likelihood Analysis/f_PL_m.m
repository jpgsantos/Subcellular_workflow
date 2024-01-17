function rst = f_PL_m(settings,model_folder)
% This function performs profile likelihood (PL) optimization for a given
% model using three optimization algorithms: fmincon, simulated annealing and pattern search.
% The function first finds the index of the starting point for PL
% calculation, prepares indices for parallel execution, and runs the
% optimization for each parameter in parallel. After the optimization, the
% results are assigned to the correct struct entries.
%
% Inputs: - settings: A struct containing various settings for the
% optimization process, such as pltest, plsa, plfm, lb, ub, and more. -
% model_folder: A folder containing the model to be optimized.
%
% Outputs: - rst: A struct containing the optimization results for both
% simulated annealing and fmincon, including the optimized parameter
% values, objective function values, and simulated data.
%
% Used Functions: 
% - get_PL_iter_start: Calculates the index closest to the best parameter
% value. 
% - f_PL_s: Runs the optimization for the given parameter index. 
% - assign_struct_values: Assigns the values of x, fval, and simd to the 
% corresponding struct entries. 
% - sim_a: Runs simulated annealing optimization. 
% - fmin_con: Runs fmincon optimization. 
% - f_sim_score: Calculates the objective function score for a given set of
% parameters.
%
% Loaded Variables: - PL_iter_start: A vector containing the indices of the
% starting points for PL calculation. - parfor_indices: A vector containing
% the indices for parallel execution. - x, fval, simd: Cell arrays
% containing the optimization results for each parameter.

% Find the index of the starting point for profile likelihood (PL)
% calculation
for n = settings.pltest
% Calculate the index closest to the best parameter value
range = linspace(settings.lb(n), settings.ub(n), settings.plres + 1);
[~,PL_iter_start(n)] = min(abs(settings.bestpa(n) - range));
end
% PL_iter_start = cellfun(@(x) get_PL_iter_start(x, settings), num2cell(settings.pltest));
alg = {'sa','ps','fm'};

% Iterate through each optimization algorithm to prepare parallel indices
parfor_indices = [];
for i = 1:length(alg)
    if settings.(['pl' alg{i}])
        parfor_indices = [parfor_indices,settings.(['pl' alg{i}]) * (length(settings.pltest)*((i-1)*2)+1:length(settings.pltest)*(i*2))];
    end
end

% Execute optimization for each parameter in parallel
parfor parfor_indices = parfor_indices
    [x{parfor_indices},fval{parfor_indices},...
        simd{parfor_indices},Pval{parfor_indices}] = ...
        f_PL_s(parfor_indices,PL_iter_start,settings,model_folder);
end
% for parfor_indices = parfor_indices
% 
% x{settings.pltest(parfor_indices)} = x_temp{parfor_indices};
% fval{settings.pltest(parfor_indices)} = fval_temp{parfor_indices};
% simd{settings.pltest(parfor_indices)} = simd_temp{parfor_indices};
% Pval{settings.pltest(parfor_indices)} = Pval_temp{parfor_indices};
% end

% Assign the values of x and fval to the correct struct entries
param_length = length(settings.pltest);
rst = assign_struct_values(settings, x, fval, simd, Pval, param_length,alg);


     [local_min_up,local_min_down,local_min_number] =...
         local_minimuns(rst,settings,PL_iter_start);

for parfor_index_2 = 1:local_min_number
disp("parfor_index_2: " + parfor_index_2)
[x_temp{parfor_index_2},fval_temp{parfor_index_2},...
        simd_temp{parfor_index_2},Pval_temp{parfor_index_2}] = optimize_again(x, fval, simd, Pval,parfor_index_2, local_min_up, local_min_down, settings, model_folder, PL_iter_start, alg);
    

end

end

% function [x, fval, simd, Pval] = optimize_again(parfor_index_2,local_min_up,local_min_down)
% 
% counter = 0;
% for i = 1:length(local_min_up)
%     i
%     for m = 1:length(local_min_up{i})
%         m
%         counter = counter +1;
%         if counter == parfor_index_2
%             par_indx = i;
%             pos_to_opt = local_min_up{i}(m);
%             is_up = true;
%         end
%     end
% end
% 
% for i = 1:length(local_min_down)
%     i
%     for m = 1:length(local_min_down{i})
%         m
%         counter = counter +1;
%         if counter == parfor_index_2
%             par_indx = i;
%             pos_to_opt = local_min_down{i}(m);
%             is_up = false;
%         end
%     end
% end
% par_indx
% pos_to_opt
% is_up
% % x = [];
% % fval = [];
% % simd = [];
% % Pval = [];
% % 
% %  [x, fval, simd, Pval] = runOptimizationIterations(x, fval, simd, Pval, PL_iter,...
% %      settings, model_folders, par_indx, delta_par, temp_lb, temp_up,...
% %      alg, section,temp_array);
% end

function [x, fval, simd, Pval] = ...
optimize_again(x, fval, simd, Pval,parfor_index_2, local_min_up, local_min_down, settings, ...
    model_folder, PL_iter_start, alg)
    x{1}{:}
    x{2}{:}
    % % Initialize output variables
    % x_optimized = {};
    % fval_optimized = {};
    % simd_optimized = {};
    % Pval_optimized = {};
    
% Initialize variables for the optimization
% if settings.(['pl' alg{1}])
    % Set the starting point of PL to the best solution found so far
    % if ~isempty(PL_iter(:))
        % x{alg{2}}{1} = temp_array;
    % else
        % x{1} = [];
    % end
    % fval{1} = [];
    % simd{1} = [];
    % Pval{1} = [];
% end
alg = {'sa',1};
    % Determine the parameter index, position to optimize, and direction
    [param_index, pos_to_opt, is_up] = ...
    identify_position_to_optimize(parfor_index_2, local_min_up, local_min_down);
    
    % Determine the direction towards the starting point
    if is_up
        direction = -1;   % Move upwards towards the starting point
    else
        direction = 1;  % Move downwards towards the starting point
    end

    % Set initial values for the optimization

    % par_indx
    % param_index = settings.pltest(par_indx);
    current_pos = pos_to_opt;
    isFirstIteration = true;
    prev_fval{1+~is_up} = Inf; % Initialize previous fval to Inf
    offset = 0; % Initialize offset

 disp("current_pos: " + current_pos)
 x{1+~is_up}
 x{1+~is_up}{1}
 x{1+~is_up}{1}{1}
 x{1+~is_up}{1}{2}
 x{1+~is_up}{1}{current_pos}
% Pval{1+~is_up}
% Pval{1+~is_up}{current_pos}


par_indx = 2;
% Set the parameter index for profile likelihood calculations
settings.PLind = par_indx;

% Remove the current parameter from the bestpa, lb, and ub arrays
% temp_array = settings.bestpa;
% temp_array(par_indx) = [];
temp_lb = settings.lb;
temp_lb(par_indx) = [];
temp_up = settings.ub;
temp_up(par_indx) = [];

    % Optimization loop: Continue until the starting point is reached
    % or the new value is less than 5% more than the previous value
    while current_pos ~= PL_iter_start(param_index)
        disp("bombo")
        % Update current position
        current_pos = current_pos + direction;
        
        % Calculate the parameter value at the current position

settings.lb(param_index)
settings.ub(param_index)
(settings.ub(param_index) - settings.lb(param_index))
disp("current_pos: " + current_pos)
settings.plres*4
(current_pos / settings.plres)
        param_value = settings.lb(param_index) + (settings.ub(param_index) - settings.lb(param_index)) * (current_pos / (settings.plres*4));
        param_value
        % Prepare inputs for run_optimization_method
        settings.PLval = param_value;
        % x_current = []; % Initialize x_current, as it will be updated by the optimization method
        

        % Perform optimization using the selected method
        % if any(strcmp(alg, {'sa', 'ps', 'fm'}))
            % [x_current, fval_current, simd_current] = run_selected_optimization_method(alg, param_value, settings, model_folder);

            x{1+~is_up}
            x{1+~is_up}{1}
            "sortes"
            [temp_x, temp_fval, temp_simd, temp_Pval, prev_fval{1+~is_up}, offset] =...
                run_optimization_method(x{1+~is_up}, fval{1+~is_up}, simd{1+~is_up}, Pval{1+~is_up}, offset, temp_lb, temp_up, settings, model_folder, {alg, 1}, 1, 1, current_pos, current_pos-direction,1);
            temp_x
            x{1+~is_up} = temp_x;
            fval{1+~is_up}= temp_fval;
            simd{1+~is_up}= temp_simd;
            Pval{1+~is_up}= temp_Pval;
            x{1+~is_up}
            x{1+~is_up}{1}



            % x_temp
% fval_temp
% simd_temp
% Pval_temp
% prev_fval
% offset
%             disp(class(x_temp));
% disp(class(fval_temp));
% disp(class(simd_temp));
% disp(class(Pval_temp));


            % Store the results
            % x_optimized{end+1} = x_temp{1};
            % fval_optimized{end+1} = fval_temp(1);
            % simd_optimized{end+1} = simd_temp{1};
            % Pval_optimized{end+1} = Pval_temp(1);


% fval{1+~is_up}
% fval{1+~is_up}{1}
fval{1+~is_up}{1}(current_pos)
prev_fval{1+~is_up}

             % Check if the new value is less than 5% more than the previous value
            if ~isFirstIteration && fval{1+~is_up}{1}(current_pos) < prev_fval{1+~is_up} * 1.05
                break; % Exit the loop if the condition is met
            end
            
            % After the first iteration, set isFirstIteration to false
            isFirstIteration = false;

            % fval{1}
            % Update the previous value for the next iteration
            % prev_fval = fval(1);
            
        % else
        %     error('Invalid optimization algorithm specified');
        % end
    end
end

function [par_indx, pos_to_opt, is_up] = identify_position_to_optimize(parfor_index_2, local_min_up, local_min_down)
    % Initialize the variables
    par_indx = NaN;
    pos_to_opt = NaN;
    is_up = false;
    
    % Calculate total number of local minima in local_min_up
    total_up = sum(cellfun(@length, local_min_up));
    
    % If the index is within the range of upward local minima
    if parfor_index_2 <= total_up
        % Find which parameter and which position this index corresponds to
        counter = 0;
        for i = 1:length(local_min_up)
            for m = 1:length(local_min_up{i})
                counter = counter + 1;
                if counter == parfor_index_2
                    par_indx = i;
                    pos_to_opt = local_min_up{i}(m);
                    is_up = true;
                    return;
                end
            end
        end
    else
        % Adjust the index for downward local minima
        parfor_index_2 = parfor_index_2 - total_up;
        % Find which parameter and which position this index corresponds to
        counter = 0;
        for i = 1:length(local_min_down)
            for m = 1:length(local_min_down{i})
                counter = counter + 1;
                if counter == parfor_index_2
                    par_indx = i;
                    pos_to_opt = local_min_down{i}(m);
                    is_up = false;
                    return;
                end
            end
        end
    end
end

function [x, fval, simd] = run_selected_optimization_method(alg, param_value, settings, model_folder)
    % Select the optimization method based on the algorithm specified
    switch alg
        case 'sa'
            [x, fval, simd] = sim_a(param_value, settings, model_folder);
        case 'ps'
            [x, fval, simd] = p_search(param_value, settings, model_folder);
        case 'fm'
            [x, fval, simd] = fmin_con(param_value, settings, model_folder);
        otherwise
            error('Invalid optimization algorithm specified');
    end
end

function [local_min_up,local_min_down,local_min_number] = local_minimuns(rst,settings,PL_iter_start)
% Identifies local minima in the optimization results for each parameter.
% It scans the results and marks points as local minima if the value at a
% point is lower than its neighbors by a certain threshold.
%
% Inputs: - rst: The structure containing optimization results. - settings:
% A structure with optimization settings. - PL_iter_start: Vector with the
% starting indices for PL calculation.
%
% Outputs: - local_min_up: Cell array containing indices of upward local
% minima. - local_min_down: Cell array containing indices of downward local
% minima. - local_min_number: Total number of local minima found.
%
% The function separately identifies upward and downward local minima by
% comparing the objective function values at neighboring points.

local_min_up = cell(max(settings.pltest),1);
local_min_down = cell(max(settings.pltest),1);
local_min_number = 0;
for par_indx = settings.pltest

    current = rst.("min").("fvalt"){par_indx}((PL_iter_start(par_indx)-1)*4+1);

    for n = (PL_iter_start(par_indx)-1)*4+1:settings.plres*4+1
        if rst.("min").("fvalt"){par_indx}(n) ~= 0
            if current*0.95 > rst.("min").("fvalt"){par_indx}(n)
                local_min_up{par_indx} = [local_min_up{par_indx},n];
                local_min_number = local_min_number +1;
            end
            current = rst.("min").("fvalt"){par_indx}(n);
        end
    end

    current = rst.("min").("fvalt"){par_indx}((PL_iter_start(par_indx)-1)*4+1);

    for n = (PL_iter_start(par_indx)-1)*4+1:-1:1
        if rst.("min").("fvalt"){par_indx}(n) ~= 0
            if current*0.95 > rst.("min").("fvalt"){par_indx}(n)
                local_min_down{par_indx} = [local_min_down{par_indx},n];
                local_min_number = local_min_number +1;
            end
            current = rst.("min").("fvalt"){par_indx}(n);
        end
    end
end
end

function idx = get_PL_iter_start(x, settings)
% Computes the index nearest to the optimal parameter value for initiating
% the profile likelihood (PL) calculation. It creates a linearly spaced
% range between the lower and upper bounds for the parameter and finds the
% closest point to the best parameter value.
%
% Inputs:
% - x: The parameter index for which the start index is to be found.
% - settings: A structure containing settings such as lower bound (lb),
% upper bound (ub), and best parameter value (bestpa).
%
% Output:
% - idx: The index of the starting point closest to the best parameter 
% value.
range = linspace(settings.lb(x), settings.ub(x), settings.plres + 1);
[~,idx] = min(abs(settings.bestpa(x) - range));
end

function rst =...
    assign_struct_values(settings, x, fval, simd, Pval, param_length, alg)
% Assigns optimization results (x, fval, simd, Pval) to the appropriate
% fields in the result structure `rst`. The function organizes results for
% each parameter and optimization method and updates the `rst` structure.
%
% Inputs: - settings: A structure with optimization settings. - x, fval,
% simd, Pval: Cell arrays containing optimization results. - param_length:
% The number of parameters. - alg: The algorithms used for optimization.
%
% Output: - rst: The updated result structure with assigned values.
%
% The function loops over each parameter and optimization method, assigning
% results to the corresponding entries in `rst`.

% Define method index mapping
Out_name = ["xt", "fvalt", "simdt", "Pval"];
Out_array = {x, fval, simd, Pval};

% Loop over each parameter in the settings and each optimization method
for par_indx = 1:length(settings.pltest)
    fvalt_values = [];
    for i = 1:length(alg)
        if settings.(['pl' alg{i}])

            old_indices1 = par_indx + param_length * (i*2-2);
            old_indices2 = par_indx + param_length * (i*2-1);

            for n = 1:length(Out_name)
                rst.(alg{i}).(Out_name(n)){settings.pltest(par_indx)}(:) = Out_array{n}{1,old_indices1}{i}';
                rst.(alg{i}).(Out_name(n)){settings.pltest(par_indx)}(1:length(Out_array{n}{1,old_indices2}{i}')) = Out_array{n}{1,old_indices2}{i}';
            end
        end
    end

    for n = 1:settings.plres*4+1
        for i = 1:length(alg)
            if settings.(['pl' alg{i}])
                if rst.(alg{i}).("fvalt"){settings.pltest(par_indx)}(n) ~= 0
                    fvalt_values{n}(i) = rst.(alg{i}).("fvalt"){settings.pltest(par_indx)}(n);
                end
            end
        end

        if length(fvalt_values) == n
            % Find minimum non-zero value
            min_fvalt = min(fvalt_values{n}(fvalt_values{n} ~= 0));

            % If there is a valid minimum, assign it and corresponding Pval
            if ~isempty(min_fvalt)
                rst.("min").("fvalt"){settings.pltest(par_indx)}(n) = min_fvalt;
                % Find index of algorithm with min value
                min_index = find(fvalt_values{n} == min_fvalt, 1, 'first');
                rst.("min").("Pval"){settings.pltest(par_indx)}(n) = rst.(alg{min_index}).("Pval"){settings.pltest(par_indx)}(n);
            end
        end
    end

    for n = 1:settings.plres*4+1

        if mod(n,4) == 3
            if rst.("min").("fvalt"){settings.pltest(par_indx)}(n) > rst.("min").("fvalt"){settings.pltest(par_indx)}(n-2) &&...
                    rst.("min").("fvalt"){settings.pltest(par_indx)}(n) > rst.("min").("fvalt"){settings.pltest(par_indx)}(n+2)
                rst.("min").("fvalt"){settings.pltest(par_indx)}(n) = 0;
            end
        end

        if mod(n,4) == 2
            if rst.("min").("fvalt"){settings.pltest(par_indx)}(n) > rst.("min").("fvalt"){settings.pltest(par_indx)}(n-1) &&...
                    rst.("min").("fvalt"){settings.pltest(par_indx)}(n) > rst.("min").("fvalt"){settings.pltest(par_indx)}(n+3) ||...
                    rst.("min").("fvalt"){settings.pltest(par_indx)}(n) > rst.("min").("fvalt"){settings.pltest(par_indx)}(n-1) &&...
                    rst.("min").("fvalt"){settings.pltest(par_indx)}(n) > rst.("min").("fvalt"){settings.pltest(par_indx)}(n+1)
                rst.("min").("fvalt"){settings.pltest(par_indx)}(n) = 0;
            end
        end

        if mod(n,4) == 0
            if rst.("min").("fvalt"){settings.pltest(par_indx)}(n) > rst.("min").("fvalt"){settings.pltest(par_indx)}(n-3) &&...
                    rst.("min").("fvalt"){settings.pltest(par_indx)}(n) > rst.("min").("fvalt"){settings.pltest(par_indx)}(n+1) ||...
                    rst.("min").("fvalt"){settings.pltest(par_indx)}(n) > rst.("min").("fvalt"){settings.pltest(par_indx)}(n-1) &&...
                    rst.("min").("fvalt"){settings.pltest(par_indx)}(n) > rst.("min").("fvalt"){settings.pltest(par_indx)}(n+1)
                rst.("min").("fvalt"){settings.pltest(par_indx)}(n) = 0;
            end
        end
    end
end
end

function [x,fval,simd,Pval] =...
    f_PL_s(parfor_indices, PL_iter_start, settings, model_folders)
% Executes optimization for a given parameter index. It manages the
% direction of parameter search, sets the range for PL_iter based on the
% current parameter index, and performs optimization using the specified
% method (simulated annealing, fmincon, or pattern search) for a single
% parameter.
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
            [x, fval, simd, Pval, prev_fval, offset] =...
                run_optimization_method(x, fval, simd, Pval,...
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

function [x, fval, simd, Pval, prev_fval, offset] = ...
run_optimization_method(x, fval, simd, Pval, offset, temp_lb,...
temp_up, settings, model_folders, alg,PL_iter_current,current_pos, pos,pos_minus_1,debug)
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
x{alg{2}}{pos_minus_1}
end
% Run the selected optimization function
    [x{alg{2}}{pos}, fval{alg{2}}(pos),...
        simd{alg{2}}{pos}] = ...
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