function result =...
    assign_optimization_results(settings, x, fval,  Pval, param_length, alg)
% Assigns optimization results (x, fval, Pval) to the appropriate
% fields in the result structure `rst`. The function organizes results for
% each parameter and optimization method and updates the `rst` structure.
%
% Inputs: - settings: A structure with optimization settings. - x, fval,
% Pval: Cell arrays containing optimization results. - param_length:
% The number of parameters. - alg: The algorithms used for optimization.
%
% Output: - rst: The updated result structure with assigned values.
%
% The function loops over each parameter and optimization method, assigning
% results to the corresponding entries in `rst`.

% Define method index mapping
Out_name = ["xt", "fvalt", "Pval"];
Out_array = {x, fval, Pval};



% Loop over each parameter in the settings and each optimization method
for par_indx = 1:length(settings.pltest)

    x = settings.pltest(par_indx);

    fvalt_values = [];
    for i = 1:length(alg)
        if settings.(['pl' alg{i}])

            old_indices1 = par_indx + param_length * (i * 2 - 2);
            old_indices2 = par_indx + param_length * (i * 2 - 1);

            for n = 1:length(Out_name)
                result.(alg{i}).(Out_name(n)){x}(:) = ...
                    Out_array{n}{1, old_indices1}{i}';
                result.(alg{i}).(Out_name(n)){x}...
                    (1:length(Out_array{n}{1, old_indices2}{i}')) = ...
                    Out_array{n}{1, old_indices2}{i}';
            end
        end
    end

    for n = 1:settings.plres * 4 + 1
        for i = 1:length(alg)
            if settings.(['pl' alg{i}])
                if result.(alg{i}).("fvalt"){x}(n) ~= 0
                    fvalt_values{n}(i) = result.(alg{i}).("fvalt"){x}(n);
                end
            end
        end

        if length(fvalt_values) == n
            % Find minimum non-zero value
            min_fvalt = min(fvalt_values{n}(fvalt_values{n} ~= 0));

            % If there is a valid minimum, assign it and corresponding Pval
            if ~isempty(min_fvalt) && ~isnan(min_fvalt)
                temp_fval(n) = ...
                    min_fvalt;
                % Find index of algorithm with min value
                min_index = find(fvalt_values{n} == min_fvalt, 1, 'first');

                result.("min").("Pval"){x}(n) = ...
                    result.(alg{min_index}).("Pval"){x}(n);

                result.("min").("xt"){x}(n) = ...
                    result.(alg{min_index}).("xt"){x}(n);

            else % hack needs to be checked

                % makes sense
                temp_fval(n) = ...
                    settings.errorscore;

                % hack needs to be checked
                result.("min").("Pval"){x}(n) = ...
                    result.(alg{min_index}).("Pval"){x}(n);

                % hack needs to be checked
                result.("min").("xt"){x}(n) = ...
                    result.(alg{min_index}).("xt"){x}(n);
            end
        end
    end

    for n = 1:settings.plres * 4 + 1

        if mod(n, 4) == 3
            if temp_fval(n) > temp_fval(n - 2) &&...
                    temp_fval(n) > temp_fval(n + 2)
                temp_fval(n) = 0;
            end
        end

        if mod(n, 4) == 2
            if temp_fval(n) > temp_fval(n - 1) &&...
                    temp_fval(n) > temp_fval(n + 3) ||...
                    temp_fval(n) > temp_fval(n - 1) &&...
                    temp_fval(n) > temp_fval(n + 1)
                temp_fval(n) = 0;
            end
        end

        if mod(n, 4) == 0
            if temp_fval(n) > temp_fval(n - 3) &&...
                    temp_fval(n) > temp_fval(n + 1) ||...
                    temp_fval(n) > temp_fval(n - 1) &&...
                    temp_fval(n) > temp_fval(n + 1)
                temp_fval(n) = 0;
            end
        end
    end

    result.("min").("fvalt"){x}(n) = temp_fval(n);
end
end