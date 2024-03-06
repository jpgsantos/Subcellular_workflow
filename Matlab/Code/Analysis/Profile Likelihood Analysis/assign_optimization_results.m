function rst =...
    assign_optimization_results(settings, x, fval, simd, Pval, param_length, alg)
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
                rst.(alg{i}).(Out_name(n)){settings.pltest(par_indx)}(:) = ...
                    Out_array{n}{1,old_indices1}{i}';
                rst.(alg{i}).(Out_name(n)){settings.pltest(par_indx)}(1:length(Out_array{n}{1,old_indices2}{i}')) = ...
                    Out_array{n}{1,old_indices2}{i}';
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
                rst.("min").("fvalt"){settings.pltest(par_indx)}(n) = ...
                    min_fvalt;
                % Find index of algorithm with min value
                min_index = find(fvalt_values{n} == min_fvalt, 1, 'first');
                rst.("min").("Pval"){settings.pltest(par_indx)}(n) = ...
                    rst.(alg{min_index}).("Pval"){settings.pltest(par_indx)}(n);
                rst.("min").("xt"){settings.pltest(par_indx)}(n) = ...
                    rst.(alg{min_index}).("xt"){settings.pltest(par_indx)}(n);
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