function [x, fval, simd, Pval] =...
    run_optimization_iterations(x, fval, simd, Pval, PL_iter,...
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
ratio = settings.ratio;

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
                run_optimization_method(x, fval,...
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