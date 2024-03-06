function [par_indx, pos_to_opt, is_up] = ...
    locate_minima_for_optimization(parfor_index_2, local_min_up, local_min_down)
% This function identifies the parameter index, the position to optimize,
% and the direction (up or down) for the optimize_again function. It
% determines these values based on the parallel index provided.
%
% Inputs:
% - parfor_index_2: Index for parallel execution.
% - local_min_up: Indices of local minima in the upward direction.
% - local_min_down: Indices of local minima in the downward direction.
%
% Outputs:
% - par_indx: Index of the parameter to be optimized.
% - pos_to_opt: Position of the parameter to be optimized.
% - is_up: Boolean indicating the direction of optimization (true for up,
% false for down).

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