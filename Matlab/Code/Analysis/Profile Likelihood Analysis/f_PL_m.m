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
% - assign_struct_values: Assigns the values of x, and fval, to the
% corresponding struct entries.
% - sim_a: Runs simulated annealing optimization.
% - fmin_con: Runs fmincon optimization.
% - f_sim_score: Calculates the objective function score for a given set of
% parameters.
%
% Loaded Variables: - PL_iter_start: A vector containing the indices of the
% starting points for PL calculation. - parfor_indices: A vector containing
% the indices for parallel execution. - x, fval: Cell arrays
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
        parfor_indices = ...
            [parfor_indices,settings.(['pl' alg{i}]) * ...
            (length(settings.pltest)*((i-1)*2)+1:length(settings.pltest)*(i*2))];
    end
end

% Execute optimization for each parameter in parallel
parfor idx = parfor_indices
    [x{idx},fval{idx},Pval{idx}] = ...
        run_PLA_on_parameter(idx,PL_iter_start,settings,model_folder);
end

% Add code to start both optimizations from the same parameter value and
% then select the best point for the start

for idx = parfor_indices
    n_parameters = length(settings.pltest);

    if mod(idx,n_parameters*2) == 1
        for idx_2 = 1:n_parameters

            test = floor(idx/n_parameters)*n_parameters+idx_2;

            if min(fval{test}{end}(length(fval{test+n_parameters}{end})),...
                    fval{test+n_parameters}{end}(end)) ==...
                    fval{test}{end}(length(fval{test+n_parameters}{end}))

                fval{test+n_parameters}{end}(end) = [];
            end
        end
    end
    % Calculate the actual parameter index based on the input
    par_indx = settings.pltest(mod(idx-1, length(settings.pltest)) + 1);

    delta = (settings.ub(par_indx) - settings.lb(par_indx)) / settings.plres;
    for n = 1:length(fval{idx})
        Pval{idx}{n} = (settings.lb(par_indx) + abs(delta)/4 * (1:settings.plres*4+1))-abs(delta)/4;
    end
end

% Assign the values of x and fval to the correct struct entries
param_length = length(settings.pltest);
rst = assign_optimization_results(settings, x, fval, Pval, param_length,alg);

rst.reopt1 = rst;

for n = 1:settings.plroptn
    [x, fval, rst.("reopt" + (n+1))] = reoptimize(rst, settings, PL_iter_start, model_folder, alg, x, fval, Pval, param_length,"reopt" + n);
end
end