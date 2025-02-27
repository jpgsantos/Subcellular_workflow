function [x, fval, output] = ...
    reoptimize(rst, settings, PL_iter_start, model_folder, alg, x, fval, ...
    Pval, param_length, name)

[local_min_up,local_min_down,local_min_number] =...
    identify_local_minima(rst.(name),settings,PL_iter_start);

start_over_position = 1;
start_over_position_n = 1;
for n = 1:length(local_min_up)
    start_over_position_n = ...
        start_over_position_n + length(local_min_up{n});
    start_over_position = [start_over_position, start_over_position_n];
end
for n = 1:length(local_min_down)
    start_over_position_n = ...
        start_over_position_n + length(local_min_down{n});
    start_over_position = [start_over_position, start_over_position_n];
end

x_temp_1 = rst.(name).min.xt;
fval_temp_1 = rst.(name).min.fvalt;
tic

parfor parfor_index_2 = 1: local_min_number
    [x_temp{parfor_index_2}, fval_temp{parfor_index_2}, ...
        current_pos{parfor_index_2}] = ...
        optimize_towards_start(x_temp_1, fval_temp_1, parfor_index_2, ...
        local_min_up, local_min_down, settings, model_folder, ...
        PL_iter_start, start_over_position);
end

time_reopt = toc;

fprintf("local_min_number: " + local_min_number + ...
    "  time: " + time_reopt +"\n")

for parfor_index_2 = 1:local_min_number

    [param_index, pos_to_opt, is_up] = ...
        locate_minima_for_optimization(parfor_index_2, local_min_up, ...
        local_min_down);

    helper = find(settings.pltest == param_index) + ...
        (~is_up * length(settings.pltest));

    next_pos_to_opt = PL_iter_start(param_index) * 4;

    if ~ismember(parfor_index_2,start_over_position)
        [~, next_pos_to_opt, ~] = ...
            locate_minima_for_optimization(parfor_index_2 - 1, ...
            local_min_up, local_min_down);
    end

    up_index_temp = next_pos_to_opt;

    size_lower_array = length(fval{helper}{:});
    down_index_temp = ...
        min(current_pos{parfor_index_2} + 1, size_lower_array);

    delta = ...
        (settings.ub(param_index) - settings.lb(param_index)) / ...
    settings.plres;

    if is_up
        array_index = current_pos{parfor_index_2} - 1:pos_to_opt - 1;
        delta_par = delta;
    else
        array_index = pos_to_opt + 1: down_index_temp;
        delta_par = -delta;
    end

    for n = array_index
        x{helper}{:}{n} = ...
            x_temp{parfor_index_2}{helper}{:}{n};
    end

    fval{helper}{:}(array_index) = ...
        fval_temp{parfor_index_2}{helper}{:}(array_index);
end
output = assign_optimization_results(settings, x, fval, Pval, ...
    param_length, alg);
end