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
% Used Functions: - get_PL_iter_start: Calculates the index closest to the
% best parameter value. - f_PL_s: Runs the optimization for the given
% parameter index. - assign_struct_values: Assigns the values of x, fval,
% and simd to the corresponding struct entries. - sim_a: Runs simulated
% annealing optimization. - fmin_con: Runs fmincon optimization. -
% f_sim_score: Calculates the objective function score for a given set of
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

% Prepare parfor loop indices
parfor_indices = [];
for i = 1:length(alg)
    if settings.(['pl' alg{i}])
        parfor_indices = [parfor_indices,settings.(['pl' alg{i}]) * (length(settings.pltest)*((i-1)*2)+1:length(settings.pltest)*(i*2))];
    end
end
% Run the optimization for each parameter in parallel parfor_indices
parfor parfor_indices = parfor_indices
    [x{parfor_indices},fval{parfor_indices},...
        simd{parfor_indices},Pval{parfor_indices}] = ...
        f_PL_s(parfor_indices,PL_iter_start,settings,model_folder);
end
% for parfor_indices = parfor_indices
% 
% x{settings.pltest(parfor_indices)} = x_temp{parfor_indices};
% fval{settings.pltest(parfor_indices)} = fval_temp{parfor_indices};
% simd{settings.pltest(parfor_indices)} = simd_temp{parfor_indices};
% Pval{settings.pltest(parfor_indices)} = Pval_temp{parfor_indices};
% end

% Assign the values of x and fval to the correct struct entries
param_length = length(settings.pltest);
rst = assign_struct_values(settings, x, fval, simd, Pval, param_length,alg);


     [local_min_up,local_min_down,local_min_number] =...
         local_minimuns(rst,settings,PL_iter_start)
parfor parfor_index_2 = 1:local_min_number

[x{parfor_index_2},fval{parfor_index_2},...
        simd{parfor_index_2},Pval{parfor_index_2}] = optimize_again(parfor_index_2,local_min_up,local_min_down)

end

end

function [x, fval, simd, Pval] = optimize_again(parfor_index_2,local_min_up,local_min_down)

counter = 0;
for i = 1:length(local_min_up)
    i
    for m = 1:length(local_min_up{i})
        m
        counter = counter +1;
        if counter == parfor_index_2
            par_indx = i;
            pos_to_opt = local_min_up{i}(m);
            is_up = true;
        end
    end
end

for i = 1:length(local_min_down)
    i
    for m = 1:length(local_min_down{i})
        m
        counter = counter +1;
        if counter == parfor_index_2
            par_indx = i;
            pos_to_opt = local_min_down{i}(m);
            is_up = false;
        end
    end
end
par_indx
pos_to_opt
is_up
% x = [];
% fval = [];
% simd = [];
% Pval = [];
% 
%  [x, fval, simd, Pval] = runOptimizationIterations(x, fval, simd, Pval, PL_iter,...
%      settings, model_folders, par_indx, delta_par, temp_lb, temp_up,...
%      alg, section,temp_array);


end

function [local_min_up,local_min_down,local_min_number] = local_minimuns(rst,settings,PL_iter_start)
local_min_up = cell(max(settings.pltest),1);
local_min_down = cell(max(settings.pltest),1);
local_min_number = 0;
for par_indx = settings.pltest

    current = rst.("min").("fvalt"){par_indx}((PL_iter_start(par_indx)-1)*4+1);

    for n = (PL_iter_start(par_indx)-1)*4+1:settings.plres*4+1
        if rst.("min").("fvalt"){par_indx}(n) ~= 0
            if current*0.95 > rst.("min").("fvalt"){par_indx}(n)
                local_min_up{par_indx} = [local_min_up{par_indx},n];
                local_min_number = local_min_number +1;
            end
            current = rst.("min").("fvalt"){par_indx}(n);
        end
    end

    current = rst.("min").("fvalt"){par_indx}((PL_iter_start(par_indx)-1)*4+1);

    for n = (PL_iter_start(par_indx)-1)*4+1:-1:1
        if rst.("min").("fvalt"){par_indx}(n) ~= 0
            if current*0.95 > rst.("min").("fvalt"){par_indx}(n)
                local_min_down{par_indx} = [local_min_down{par_indx},n];
                local_min_number = local_min_number +1;
            end
            current = rst.("min").("fvalt"){par_indx}(n);
        end
    end
end
end

function idx = get_PL_iter_start(x, settings)
% Calculate the index closest to the best parameter value
range = linspace(settings.lb(x), settings.ub(x), settings.plres + 1);
[~,idx] = min(abs(settings.bestpa(x) - range));
end

function rst =...
    assign_struct_values( settings, x, fval, simd, Pval, param_length, alg)
% Assign the values of x, fval, and simd to the corresponding struct entries

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
                rst.(alg{i}).(Out_name(n)){settings.pltest(par_indx)}(:) = Out_array{n}{1,old_indices1}{i}';
                rst.(alg{i}).(Out_name(n)){settings.pltest(par_indx)}(1:length(Out_array{n}{1,old_indices2}{i}')) = Out_array{n}{1,old_indices2}{i}';
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
                rst.("min").("fvalt"){settings.pltest(par_indx)}(n) = min_fvalt;
                % Find index of algorithm with min value
                min_index = find(fvalt_values{n} == min_fvalt, 1, 'first');
                rst.("min").("Pval"){settings.pltest(par_indx)}(n) = rst.(alg{min_index}).("Pval"){settings.pltest(par_indx)}(n);
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

function [x,fval,simd,Pval] =...
    f_PL_s(parfor_indices, PL_iter_start, settings, model_folders)
% Run the optimization for the given parameter index

% Calculate the actual parameter index based on the input
par_indx = settings.pltest(mod(parfor_indices-1, length(settings.pltest)) + 1);

% Determine the direction of the parameter search and set the range for
% PL_iter based on the current parameter index

% Calculate the step size for the search
delta = (settings.ub(par_indx) - settings.lb(par_indx)) / settings.plres;

if mod(parfor_indices - 1, length(settings.pltest)*2) < length(settings.pltest)
    % Set the search range in the forward direction
    delta_par = delta;
    PL_iter(:) = PL_iter_start(par_indx):settings.plres+1;
    section = "end";
else
    % Calculate the step size for the search in the reverse direction
    delta_par = -delta;
    % Set the search range in the reverse direction
    PL_iter(:) = PL_iter_start(par_indx)-1:-1:1;
    section = "start";
end

% Set the parameter index for profile likelihood calculations
settings.PLind = par_indx;

% Remove the current parameter from the bestpa, lb, and ub arrays
temp_array = settings.bestpa;
temp_array(par_indx) = [];
temp_lb = settings.lb;
temp_lb(par_indx) = [];
temp_up = settings.ub;
temp_up(par_indx) = [];

% Check if Simulated Annealing (SA) or Fmincon optimization methods should
% be used
if parfor_indices <= length(settings.pltest)*2 && settings.plsa
    alg = {'sa',1};
elseif parfor_indices > length(settings.pltest)*2 &&...
    parfor_indices <= length(settings.pltest)*4 && settings.plps
    alg = {'ps',2};
elseif parfor_indices > length(settings.pltest)*4 && settings.plfm
    alg = {'fm',3};
end

% Initialize variables for the optimization
if settings.(['pl' alg{1}])
    % Set the starting point of PL to the best solution found so far
    % if ~isempty(PL_iter(:))
        % x{alg{2}}{1} = temp_array;
    % else
        x{alg{2}} = [];
    % end
    fval{alg{2}} = [];
    simd{alg{2}} = [];
    Pval{alg{2}} = [];
end

% Run optimization iterations
[x, fval, simd, Pval] =...
    runOptimizationIterations(x, fval, simd, Pval, PL_iter, settings,...
    model_folders, par_indx, delta_par, temp_lb, temp_up,...
    alg, section,temp_array);

str_end_alg_names = {'end    sa', 'start  sa', 'end    ps',...
    'start  ps', 'end    fm', 'start  fm'};
for i = 1:length(str_end_alg_names)
    if parfor_indices <= length(settings.pltest) * i
        disp(['P' num2str(par_indx) ' ' str_end_alg_names{i} ' finished']);
        break;
    end
end
end

function [x, fval, simd, Pval] =...
    runOptimizationIterations(x, fval, simd, Pval, PL_iter,...
    settings, model_folders, par_indx, delta_par, temp_lb, temp_up,...
    alg, section,temp_array)

% Initialize additional variables for optimization
offset = 0;
prev_fval = inf;
ratio = 1.5;

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

    % Set the value of the parameter that is being worked on
    settings.PLval =...
        settings.lb(par_indx) + abs(delta_par) * (PL_iter_current - 1);

    current_pos = 4;
    pass_pos(1:4) = false;

    % Run optimization methods for different steps
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

            [x, fval, simd, Pval, prev_fval, offset] =...
                run_optimization_method(x, fval, simd, Pval,...
                offset, temp_lb, temp_up,...
                settings, model_folders, alg,PL_iter_current,current_pos, pos,pos_minus_1);
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

function [x, fval, simd, Pval, prev_fval, offset] = ...
run_optimization_method(x, fval, simd, Pval, offset, temp_lb,...
temp_up, settings, model_folders, alg,PL_iter_current,current_pos, pos,pos_minus_1)
% This function runs an optimization method (either simulated annealing,
% fmincon, or pattern search) and returns the optimized variables (x),
% function values (fval), simulation data (simd), parameter values (Pval),
% and previous function values (prev_fval).

offset = offset+1;

% Determine which algorithm to run and its corresponding index
if alg{2} == 1
    optimization_func = @sim_a;
elseif alg{2} == 2
    optimization_func = @fmin_con;
elseif alg{2} == 3
    optimization_func = @p_search;
else
    error('No optimization method specified');
end

% Run the chosen optimization method
    [x{alg{2}}{pos}, fval{alg{2}}(pos),...
        simd{alg{2}}{pos}] = ...
    optimization_func(offset, ...
    x{alg{2}}{pos_minus_1}, temp_lb, temp_up, settings, ...
    model_folders);

% Assign parameter value and previous function value
Pval{alg{2}}(pos) = settings.PLval;
prev_fval = fval{alg{2}}(pos);

% Optional: Display optimization method, model index, iteration, parameter
% value, and function value 
disp(convertCharsToStrings(alg{1}) + " m: " + settings.PLind + "  n: " +...
    PL_iter_current + "." + current_pos + "  PLval: " + settings.PLval +...
    " fval: " + prev_fval);
end


function [x,fval,simd] =...
    sim_a(PL_iter_current,x,temp_lb,temp_up,settings,model_folders)
% Run simulated annealing optimizations
if PL_iter_current == 1
    options = optimoptions(@simulannealbnd,'Display','off', ...
        'InitialTemperature',...
        ones(1,settings.parnum-1)*1,'MaxTime',1,'ReannealInterval',40);
else
    options = settings.plsao;
end
% Optimize the model
[x,fval] = simulannealbnd(@(x)f_sim_score(x,settings,model_folders),...
    x,temp_lb,temp_up,options);

[~,rst,~] = f_sim_score(x,settings,model_folders);
simd = rst.simd{1,1};
end

function [x,fval,simd] =...
    fmin_con(PL_iter_current,x,temp_lb,temp_up,settings,model_folders)
% Run fmincon optimization
if PL_iter_current == 1
    options = optimoptions('fmincon','Display','off',...
        'Algorithm','interior-point',...
        'MaxIterations',1,'OptimalityTolerance',0,...
        'StepTolerance',1e-6,'FiniteDifferenceType','central');
else
    % Get the optimization options from settings
    options = settings.plfmo;
end

% Optimize the model
[x,fval] = fmincon(@(x)f_sim_score(x,settings,model_folders),...
    x,[],[],[],[],temp_lb,temp_up,[],options);

[~,rst,~] = f_sim_score(x,settings,model_folders);
simd = rst.simd{1,1};
end

function [x,fval,simd] =...
    p_search(PL_iter_current,x,temp_lb,temp_up,settings,model_folders)
% Run fmincon optimization
if PL_iter_current == 1
    options = optimoptions(@patternsearch,'Display','off',...
    'MaxTime',1,...
    'UseCompletePoll',false,'UseCompleteSearch',false,...
    'MaxMeshSize',1,'MaxFunctionEvaluations',10000);
else
    % Get the optimization options from settings
    options = settings.plpso;
end

% Optimize the model
[x, fval] = ...
            patternsearch(@(x)f_sim_score(x,settings,model_folders), x, ...
            [], [], [], [], temp_lb,temp_up, [], options);

[~,rst,~] = f_sim_score(x,settings,model_folders);
simd = rst.simd{1,1};
end