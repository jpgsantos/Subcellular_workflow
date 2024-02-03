function [x, fval, output] = reoptimize(rst, settings, PL_iter_start, model_folder, alg, x, fval, simd, Pval, param_length, name)

[local_min_up,local_min_down,local_min_number] =...
    identify_local_minima(rst.(name),settings,PL_iter_start);

start_over_position = 1;
start_over_position_n = 1;
for n = 1:length(local_min_up)
    start_over_position_n = start_over_position_n + length(local_min_up{n});
    start_over_position = [start_over_position,start_over_position_n];
end
for n = 1:length(local_min_down)
    start_over_position_n = start_over_position_n + length(local_min_down{n});
    start_over_position = [start_over_position,start_over_position_n];
end

local_min_up
local_min_down

x_temp_1 = rst.(name).min.xt;
fval_temp_1 = rst.(name).min.fvalt;

parfor parfor_index_2 = 1:local_min_number
    [x_temp{parfor_index_2},fval_temp{parfor_index_2}] = ...
        optimize_towards_start(x_temp_1,fval_temp_1,parfor_index_2, ...
        local_min_up, local_min_down, settings, model_folder, PL_iter_start, ...
        alg,start_over_position);
end

fprintf("local_min_number: " + local_min_number + "\n")

for parfor_index_2 = 1:local_min_number

    [param_index, pos_to_opt, is_up] = ...
        locate_minima_for_optimization(parfor_index_2, local_min_up, local_min_down);

    sortes_plas = find(settings.pltest==param_index)+(~is_up*length(settings.pltest));

    next_pos_to_opt = PL_iter_start(param_index)*4;

    if ~ismember(parfor_index_2,start_over_position)
        [~, next_pos_to_opt, ~] = ...
            locate_minima_for_optimization(parfor_index_2-1, local_min_up, local_min_down);
    end

    up_index_temp = next_pos_to_opt;

    size_lower_array = length(fval{sortes_plas}{:});
    down_index_temp = min(next_pos_to_opt-1,size_lower_array);

    fprintf("sortes_plas: " + sortes_plas + "\n" +...
        "parfor_index_2: " + parfor_index_2 + "\n")

    if is_up
        array_index = up_index_temp:pos_to_opt;
    else
        array_index = pos_to_opt:down_index_temp;
    end

    for n = array_index
        x{sortes_plas}{:}{n} = ...
            x_temp{parfor_index_2}{sortes_plas}{:}{n};
    end

    disp(fval{sortes_plas}{:}(array_index))
    disp(fval_temp{parfor_index_2}{sortes_plas}{:}(array_index))

    fval{sortes_plas}{:}(array_index) = ...
        fval_temp{parfor_index_2}{sortes_plas}{:}(array_index);
end

output = assign_optimization_results(settings, x, fval, simd, Pval, param_length, alg);
end