function [x, fval] = ...
    optimize_towards_start(x_ini,fval_ini,parfor_index_2, ...
    local_min_up, local_min_down, settings, model_folder, PL_iter_start, ...
    alg,start_over_position)
% This function optimizes parameters in the direction of the starting point
% to mitigate abrupt drops in the profile likelihood analysis (PLA) graphs.
% It aims to optimize until it reaches the starting point or until the
% function value doesn't significantly improve (less than 5% increase).
%
% Inputs:
% - parfor_index_2: Index for parallel execution.
% - local_min_up: Indices of local minima in the upward direction.
% - local_min_down: Indices of local minima in the downward direction.
% - settings: A structure containing various settings for the optimization
% process.
% - model_folder: Directory containing the model files.
% - PL_iter_start: Indices of the starting points for profile likelihood
% calculation.
% - alg: The optimization algorithm to use ('sa', 'ps', or 'fm').
%
% Outputs:
% - x_optimized: Optimized parameter values.
% - fval_optimized: Objective function values at the optimized parameters.
% - simd_optimized: Simulated data corresponding to the optimized
% parameters.
% - Pval_optimized: Parameter values at which the function was optimized.

alg = {'sa',1};

settings.plsao = optimoptions(@simulannealbnd,'Display','off', ...
    'InitialTemperature',...
    ones(1,settings.parnum-1)*1,'MaxTime',60,'ReannealInterval',40);

% Determine the parameter index, position to optimize, and direction
[param_index, pos_to_opt, is_up] = ...
    locate_minima_for_optimization(parfor_index_2, local_min_up, local_min_down);

% Determine the direction towards the starting point
if is_up
    direction = -1;% Move downwards towards the starting point
else
    direction = 1;% Move upwards towards the starting point
end

next_pos_to_opt = PL_iter_start(param_index)*4;

if ~ismember(parfor_index_2,start_over_position)
    [~, next_pos_to_opt, ~] = ...
        locate_minima_for_optimization(parfor_index_2-1, local_min_up, local_min_down);
end

% Set initial values for the optimization
current_pos = pos_to_opt;
offset = 0; % Initialize offset

par_indx = param_index;

% Set the parameter index for profile likelihood calculations
settings.PLind = par_indx;

% Remove the current parameter from the bestpa, lb, and ub arrays
temp_lb = settings.lb;
temp_lb(par_indx) = [];
temp_up = settings.ub;
temp_up(par_indx) = [];

sortes_plas = find(settings.pltest==param_index)+(~is_up*length(settings.pltest));

    fval{sortes_plas}{:} = fval_ini{par_indx};
    x{sortes_plas}{:}= x_ini{par_indx};

% Optimization loop: Continue until the starting point is reached
% or the new value is less than 5% more than the previous value
while current_pos ~= next_pos_to_opt

    if current_pos+direction >= length(fval{sortes_plas}{:})
        fprintf("\n break 1 " + ...
            "\n parfor_index_2: " + parfor_index_2 + ...
            "\n param_index: " + param_index + ...
            "\n current_pos: " + current_pos + ...
            "\n final_pos: " + next_pos_to_opt + ...
            "\n direction: " + direction + ...
            "\n current_pos: " + current_pos + ...
            "\n direction: " + direction + ...
            "\n lenght_fval: " + length(fval{sortes_plas}{:}) + "\n" )
        % disp(current_pos+direction)
        % disp(length(fval{sortes_plas}{:}))
        break
    end

    delta = (settings.ub(par_indx) - settings.lb(par_indx)) / settings.plres;

    if is_up
        delta_par = delta;
    else
        delta_par = -delta;
    end

    old_fval = fval{sortes_plas}{:}(current_pos+direction);
    old_current_pos = current_pos;
    if current_pos+direction*2 <= length(fval{sortes_plas}{:})
        old_fval_2 = fval{sortes_plas}{:}(current_pos+direction*2);
    else
        old_fval_2 = old_fval;
    end

    while old_fval == 0
        current_pos = current_pos + direction;
        if current_pos+direction*2 <= length(fval{sortes_plas}{:})
            old_fval_2 = fval{sortes_plas}{:}(current_pos+direction*2);
        else
            old_fval_2 = old_fval;
        end
        old_fval = fval{sortes_plas}{:}(current_pos+direction);
    end
    
    plas = 2;
    if direction == -1
        while old_fval_2 == 0 && current_pos+direction*plas >= next_pos_to_opt
             plas = plas + 1;
            if current_pos+direction*plas <= length(fval{sortes_plas}{:})
                old_fval_2 = fval{sortes_plas}{:}(current_pos+direction*plas);
            else
                old_fval_2 = old_fval;
            end
        end
    else
        while old_fval_2 == 0 && current_pos+direction*plas <= next_pos_to_opt
             plas = plas + 1;
            if current_pos+direction*plas <= length(fval{sortes_plas}{:})
                old_fval_2 = fval{sortes_plas}{:}(current_pos+direction*plas);
            else
                old_fval_2 = old_fval;
            end
        end
    end

    % Calculate the parameter value at the current position
    settings.PLval = settings.lb(par_indx) + abs(delta_par)/4 * (current_pos + direction-1);

    % Perform optimization using the selected method
    % if any(strcmp(alg, {'sa', 'ps', 'fm'}))
    [temp_x, temp_fval, temp_simd{alg{2}}{current_pos+direction}, temp_Pval, prev_fval{sortes_plas}, offset] =...
        run_optimization_method(x{sortes_plas}, fval{sortes_plas}, ...
        offset, temp_lb, temp_up, settings, model_folder, ...
        alg, 1, 1, current_pos+direction, old_current_pos,1);

    fprintf("\n parfor_index_2: " + parfor_index_2 + ...
        "\n param_index: " + param_index + ...
        "\n current_pos: " + current_pos + ...
        "\n final_pos: " + next_pos_to_opt + ...
        "\n direction: " + direction + ...
        "\n PLval: " + settings.PLval + ...
        "\n previous score: " + fval{sortes_plas}{:}(old_current_pos) + ...
        "\n old score: " + old_fval + ...
        "\n new score: " + temp_fval{:}(current_pos+direction) + ...
        "\n next score: " +  old_fval_2 + "\n")

    % Check if the new value is less than 5% more than the previous value
    if temp_fval{:}(current_pos+direction) >= old_fval
        fprintf("\n break 2 " + ... 
            "\n parfor_index_2: " + parfor_index_2 + ...
            "\n param_index: " + param_index + ...
            "\n current_pos: " + current_pos + ...
            "\n final_pos: " + next_pos_to_opt + ...
            "\n direction: " + direction + ...
            "\n new score: " + temp_fval{:}(current_pos+direction) + ...
            "\n old score: " + old_fval + "\n")
        break; % Exit the loop if the condition is met
    end

    x{sortes_plas} = temp_x;
    fval{sortes_plas} = temp_fval;
     
    if fval{sortes_plas}{:}(current_pos+direction) >= old_fval_2 * 1.05
        fprintf("\n break 3 " + ... 
            "\n parfor_index_2: " + parfor_index_2 + ...
            "\n param_index: " + param_index + ...
            "\n current_pos: " + current_pos + ...
            "\n final_pos: " + next_pos_to_opt + ...
            "\n direction: " + direction + ...
            "\n new score: " + temp_fval{:}(current_pos+direction)+ ...
            "\n next score*1.05: " + old_fval_2 * 1.05 + "\n");
        break; % Exit the loop if the condition is met
    end

    % else
    %     error('Invalid optimization algorithm specified');
    % end
    current_pos = current_pos + direction;
end
end