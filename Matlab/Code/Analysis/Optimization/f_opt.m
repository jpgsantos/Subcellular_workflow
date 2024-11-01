function [result,parameter_array] = f_opt(settings,model_folders)
% This function performs optimization on a given objective function using
% different optimization algorithms. The available algorithms include
% fmincon, Simulated annealing, Pattern search, Genetic algorithm, Particle
% swarm, and Surrogate optimization. It iterates through the
% optimization_algorithms cell array and calls the appropriate optimization
% algorithm if its flag is set in the 'settings'.
%
% Inputs:
% - settings: A struct containing settings for the optimization algorithms.
% - model_folders: An array containing information about the models to be
% optimized.
%
% Outputs:
% - result: A vector containing the results of each optimization algorithm.
% - parameter_array: A matrix containing the parameters for each
% optimization algorithm result.
%
% Used Functions:
% - run_algorithm: Handles the execution of a specific optimization
% algorithm.
% - optimize_algorithm: Sets up the optimization algorithm and executes it.
% - run_optimization: Runs the selected optimization algorithm with
% appropriate settings.
% - run_optimizer: Executes the chosen optimization algorithm.
% - prepare_optimization_options: Prepares the optimization options based
% on the algorithm.
% - get_plot_functions: Returns the appropriate plotting function for the
% optimization algorithm.
% - f_opt_start: Returns the starting point and the starting population for
% optimization algorithms.
% 
% Loaded Variables:
% - optimization_algorithms: A cell array containing optimization algorithm
% names and flags.
% - algorithm_flag: The flag corresponding to the optimization algorithm.
% - objective_function: A function handle to the objective function for
% optimization.
% - options: A struct containing options for the optimization algorithm.
% - plot_functions: A cell array containing plot functions specific to each
% optimization algorithm.

% settings.optt = 60*60;
% settings.popsize = 720;
% Set the random seed for reproducibility
rng(settings.rseed);

% Initialize the cell array containing optimization algorithm names and
% corresponding settings flags
optimization_algorithms = {
    'Genetic algorithm', 'ga';
    'fmincon', 'fmincon';
    'Simulated annealing', 'sa';
    'Pattern search', 'psearch';
   'Particle swarm', 'pswarm';
    'Surrogate optimization', 'sopt'};

p = gcp(); % If no pool, do not create new one.
poolsize = p.NumWorkers;

settings.pat_original = settings.pat;
settings.pa_original = settings.pa;


settings.pat = 1:poolsize;
for n = 1:poolsize
settings.pa(n, :) = settings.pa(1, :);
end
parfor n = 1:poolsize
[~] = f_diagnostics(settings, model_folders);
end

% Iterate through the optimization_algorithms cell array and call the
% corresponding algorithms if their flag is set in the settings
for i = 1:size(optimization_algorithms, 1)
    % algorithm_func = optimization_algorithms{i, 1};
    algorithm_flag = optimization_algorithms{i, 2};
opt_time = tic;
    if settings.(algorithm_flag)
        [result(i), parameter_array(i, :)] = ...
            run_algorithm(@optimize_algorithm,...
            optimization_algorithms{i, 1}, settings, model_folders);
    end
disp(convertCharsToStrings(optimization_algorithms{i, 2}) + ": " + ...
    toc(opt_time))
end
end

function [algorithm_result, algorithm_parameter_array] =...
    run_algorithm(algorithm_func, optimization_algorithms_names,...
    settings, model_folders)

% Define the objective function
objective_function = @(x)f_sim_score(x, settings, model_folders, 0, 0);

% Call the optimization algorithm
algorithm_result = algorithm_func(optimization_algorithms_names,...
    settings, objective_function);

% Find the minimum value and its corresponding parameters
[~, min_index] = min(algorithm_result.fval);
algorithm_parameter_array = algorithm_result.x(min_index, :);
end

function result_opt = optimize_algorithm(algorithm_name,...
    settings, objective_function)
p = gcp(); % If no pool, do not create new one.

% poolsize = p.NumWorkers;
% mst = settings.mst;
% optt = settings.optt = 60*10;
% if contains(algorithm_name, {'Pattern search', 'Surrogate optimization'})
% settings.mst = true;
% settings.msts = poolsize;
% elseif contains(algorithm_name, {'fmincon', 'Simulated annealing'})
% settings.mst = true;
% settings.msts = poolsize*5;
% settings.optt = optt/5;
% else
% settings.mst = mst;
% settings.msts = poolsize;
% settings.optt = optt;
% end

% Determine the starting point for the optimization
[startpoint, ~, spop] = f_opt_start(settings);

% Prepare optimization options based on settings and algorithm_name
options = prepare_optimization_options(settings, algorithm_name);

% Execute the optimization algorithm
[x, fval, exitflag, output] = run_optimization(settings, algorithm_name,...
    objective_function, startpoint, spop, settings.lb, settings.ub,...
     options);

% Save optimization results
result_opt.name = algorithm_name;
result_opt.x = x;
result_opt.fval = fval;
result_opt.exitflag = exitflag;
result_opt.output = output;
end

function [x, fval, exitflag, output] = run_optimization(settings,...
    algorithm_name, objective_function, startpoint, spop, lb, ub,...
    options)

% Run the optimization algorithm using either multiple starting points (mst)
% or a single starting point (the average of the lower and upper bounds)
if settings.mst
    parfor n = 1:settings.msts
        [x(n,:), fval(n), exitflag(n), output(n)] = ...
            run_optimizer(algorithm_name, objective_function,...
            startpoint(n,:), spop{n}, lb, ub, options);
    end
else

    [x(1,:), fval(1), exitflag(1), output(1)] = ...
        run_optimizer(algorithm_name, objective_function,...
        (lb + ub) / 2, spop, lb, ub, options);

    % [x(1,:), fval(1), exitflag(1), output(1)] = ...
    %     run_optimizer(algorithm_name, objective_function,...
    %     settings.bestpa, spop, lb, ub, options);
end
end

function [x, fval, exitflag, output] = ...
    run_optimizer(algorithm_name, objective_function, startpoint, spop,...
    lb, ub, options)
% Execute the appropriate optimization algorithm based on algorithm_name
switch algorithm_name
    case 'fmincon'
        [x, fval, exitflag, output] = ...
            fmincon(objective_function, startpoint, ...
            [], [], [], [], lb, ub, [], options);
    case 'Simulated annealing'
        [x, fval, exitflag, output] = ...
        simulannealbnd(objective_function, startpoint, lb, ub, options);
    case 'Pattern search'
        
        [x, fval, exitflag, output] = ...
            patternsearch(objective_function, startpoint, ...
            [], [], [], [], lb, ub, [], options);
    case 'Genetic algorithm'
        parnum = length(lb);
        [x, fval,exitflag,output] = ga(objective_function, parnum, ...
            [], [], [], [], lb, ub, [], options);
    case 'Particle swarm'
        parnum = length(lb);
        [x, fval, exitflag, output] = ...
            particleswarm(objective_function, parnum, lb, ub, options);
    case 'Surrogate optimization'
        options.InitialPoints = spop;
        [x, fval, exitflag, output] = ...
        surrogateopt(objective_function, lb, ub, options);
    otherwise
        error('Unsupported optimization algorithm.');
end
end

function options = prepare_optimization_options(settings, algorithm_name)

% Set options for each algorithm
switch algorithm_name
    case 'fmincon'
        options = settings.fm_options;
        options.UseParallel = settings.optmc;
    case 'Simulated annealing'
        options =  settings.sa_options;
        options.MaxTime = settings.optt;
    case 'Pattern search'
        options = settings.psearch_options;
        options.MaxTime = settings.optt;
        options.UseParallel = settings.optmc;
    case 'Genetic algorithm'

        % test = settings.pa_original(settings.pat_original, :);

        options = settings.ga_options;
        options.MaxTime = settings.optt;
        % options.PopulationSize = settings.popsize+length(test);
        options.PopulationSize = settings.popsize;
        options.UseParallel = settings.optmc;
        [~, startpop, ~] = f_opt_start(settings);
        options.InitialPopulationMatrix = startpop;
    case 'Particle swarm'
        options = settings.pswarm_options;
        options.MaxTime = settings.optt;
        options.SwarmSize = settings.popsize;
        options.UseParallel = settings.optmc;
        [~, startpop, ~] = f_opt_start(settings);
        options.InitialSwarmMatrix = startpop;
    case 'Surrogate optimization'
        options = settings.sopt_options;
        options.MaxTime = settings.optt;
        options.UseParallel = settings.optmc;
    otherwise
        error('Unsupported optimization algorithm.');
end

% Enable plots if chosen in settings
if settings.optplots
    % Set the appropriate PlotFcn based on the optimization algorithm
    options.PlotFcn = get_plot_functions(algorithm_name);
end

% Enable console messages if chosen in settings
if settings.optcsl
    options.Display = 'iter';
end
end

function plot_functions = get_plot_functions(algorithm_name)

% Set the appropriate PlotFcn based on the optimization algorithm
switch algorithm_name
    case 'fmincon'
        plot_functions = ...
            {@optimplotx, @optimplotfunccount, @optimplotfval, ...
            @optimplotstepsize, @optimplotfirstorderopt};
    case 'Simulated annealing'
        plot_functions = ...
            {@saplotbestf, @saplottemperature, @saplotf, ...
            @saplotstopping, @saplotx};
    case 'Pattern search'
        plot_functions = ...
            {@psplotbestf, @psplotfuncount, @psplotmeshsize, @psplotbestx};
    case 'Genetic algorithm'
        plot_functions = ...
            {@gaplotbestf, @gaplotexpectation, @gaplotrange, ...
            @gaplotscorediversity, @gaplotstopping, ...
            @gaplotscores, @gaplotdistance, @gaplotselection, @gaplotbestindiv};
    case 'Particle swarm'
        plot_functions = {@pswplotbestf};
    case 'Surrogate optimization'
        plot_functions = {@surrogateoptplot};
    otherwise
        error('Unsupported optimization algorithm.');
end
end

function [spoint,spop_mc,spop_sc] = f_opt_start(settings)
% Set the randomm seed for reproducibility
rng(settings.rseed);

test = settings.pa_original(settings.pat_original, :);

% Optimization Start method 1
if settings.osm == 1
% stg.pat_original
% stg.pa_original
% for n = stg.pat_original
%     n
%     stg.pa_original(n,:)

% end
% test
% lhsdesign(stg.popsize,stg.parnum).*(stg.ub-stg.lb)+stg.lb

% test = stg.pa_original(stg.pat_original,:);
    % Get a random starting point or group of starting points, if using
    % multistart, inside the bounds
    spoint = lhsdesign(settings.msts, settings.parnum) .* ...
    (settings.ub - settings.lb) + settings.lb;

    % Get a group of ramdom starting points inside the bounds
    spop_mc = lhsdesign(settings.popsize, settings.parnum) .* ...
        (settings.ub - settings.lb) + settings.lb;
    % spop_mc = [lhsdesign(settings.popsize,settings.parnum).*(settings.ub-stg.lb)+settings.lb;test];

    % Get a group of ramdom starting points inside the bounds
    for n = 1:settings.msts
    spop_sc{n} = lhsdesign(ceil(settings.popsize / 36), ...
        settings.parnum) .* (settings.ub-  settings.lb) + settings.lb;
    end
    % Optimization Start method 2
elseif settings.osm == 2
    
    % Get a random starting point or group of starting points, if using
    % multistart, near the best point
    spoint = settings.bestpa - settings.dbpa + ...
        (settings.dbpa * 2 * lhsdesign(settings.msts, settings.parnum));
    
    spoint = max(min(5,spoint), -7);

    % Get a group of random starting points near the best point
    spop_mc = settings.bestpa - settings.dbpa + ...
        (settings.dbpa * 2 * lhsdesign(settings.popsize, settings.parnum));

    spop_mc = max(min(settings.ub,spop_mc),settings.lb);
    spop_mc = [spop_mc;test];
    for n = 1:settings.msts
    spop_sc{n} = settings.bestpa - settings.dbpa + ...
        (settings.dbpa * 2 * lhsdesign(ceil(settings.popsize / 36), ...
        settings.parnum));

    spop_sc{n} = max(min(settings.ub,spop_sc{n}), settings.lb);
    end
end
end