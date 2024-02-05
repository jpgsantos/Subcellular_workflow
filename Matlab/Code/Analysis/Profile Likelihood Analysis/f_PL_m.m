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
        parfor_indices = ...
            [parfor_indices,settings.(['pl' alg{i}]) * ...
            (length(settings.pltest)*((i-1)*2)+1:length(settings.pltest)*(i*2))];
    end
end

% Execute optimization for each parameter in parallel
parfor parfor_indices = parfor_indices
    [x{parfor_indices},fval{parfor_indices},...
        simd{parfor_indices},Pval{parfor_indices}] = ...
        run_PLA_on_parameter(parfor_indices,PL_iter_start,settings,model_folder);
end

for parfor_indices = parfor_indices
% Calculate the actual parameter index based on the input
par_indx = settings.pltest(mod(parfor_indices-1, length(settings.pltest)) + 1);

delta = (settings.ub(par_indx) - settings.lb(par_indx)) / settings.plres;
    for n = 1:length(fval{parfor_indices})
        Pval{parfor_indices}{n} = (settings.lb(par_indx) + abs(delta)/4 * (1:settings.plres*4+1))-abs(delta)/4;
    end
end

% Assign the values of x and fval to the correct struct entries
param_length = length(settings.pltest);
rst = assign_optimization_results(settings, x, fval, simd, Pval, param_length,alg);

rst.reopt1 = rst;

for n = 1:15
    [x, fval, rst.("reopt" + (n+1))] = reoptimize(rst, settings, PL_iter_start, model_folder, alg, x, fval, simd, Pval, param_length,"reopt" + n);
end

% rst.test = reoptimize(rst, settings, PL_iter_start, model_folder, alg, x, fval, simd, Pval, param_length,"test");
% 
% rst.test2 = reoptimize(rst, settings, PL_iter_start, model_folder, alg, x, fval, simd, Pval, param_length,"test");
% 
% rst.test3 = reoptimize(rst, settings, PL_iter_start, model_folder, alg, x, fval, simd, Pval, param_length,"test2");
end