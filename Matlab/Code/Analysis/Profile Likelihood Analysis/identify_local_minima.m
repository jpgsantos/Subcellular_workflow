function [local_min_up, local_min_down, local_min_number] = ...
    identify_local_minima(rst, settings, PL_iter_start)

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

local_min_up = cell(max(settings.pltest), 1);
local_min_down = cell(max(settings.pltest), 1);
local_min_number = 0;
for par_indx = settings.pltest

fval = rst.("min").("fvalt"){par_indx};

    current = ...
        fval((PL_iter_start(par_indx) - 1) * 4 + 1);

    for n = (PL_iter_start(par_indx) - 1) * 4 + 1: settings.plres * 4 + 1
        if fval(n) ~= 0
            if current * settings.plotv > fval(n)
                local_min_up{par_indx} = [local_min_up{par_indx}, n];
                local_min_number = local_min_number +1;
            end
            current = fval(n);
        end
    end

    current = fval((PL_iter_start(par_indx) - 1) * 4 + 1);

    for n = (PL_iter_start(par_indx) - 1) * 4 + 1: -1: 1
        if fval(n) ~= 0
            if current * settings.plotv > fval(n)
                local_min_down{par_indx} = [local_min_down{par_indx}, n];
                local_min_number = local_min_number +1;
            end
            current = fval(n);
        end
    end
end
end