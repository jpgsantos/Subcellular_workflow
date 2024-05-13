function [rst,parameter_array] = f_opt(stg,model_folders)
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

% Set the random seed for reproducibility
rng(stg.rseed);

% stg.pat = 1:11;
% stg.pa(6,:) = [-0.0721256315952573	3.85925219234454	-4.45474393769259	4.80711593922123	1.81551970886112	0.116477751358678	-5.15130256888107	2.60049464195022	-1.28481583913816	5	2.00035798174333	0	-0.822069847997329	-0.513152176257966	0.361256359662353	-1.54090995428695	4.67987943691734	-0.302560881588427	-1.23842268551077	2.53441228307745	3.28966277418410	-2.84972800956611	-3.72841555690487	-2.16357503041607	-0.791957227889094	-1.39042867970304	-0.236002557461883	-1.85301602364561	-0.305051191901373	2.24409218731721	5	0.0310182808260719	2.37002472778682	1.36792752508684	-0.122551691437624	3.22752307662812	-1.71579925047583	4.75761321248425	3.54979610718447];
% stg.pa(7,:) = [-0.313344840862168	3.60320622557244	-6.27587761774880	4.60753553090127	2.36638698283940	1.83373869862091	-4.86717716308523	4.29894637676612	-1.11880552677058	5	3.15853481854701	0.286851029134888	-0.746013076509247	-0.588951181091719	1.18810405883423	-1.38835918094012	5	-0.457227075612345	-0.859672037194528	2.08832054058988	4.09298543363788	-4.89048903367987	-2.92707402958540	-2.88744741233517	-1.45854681203412	-1.68398747273743	0.142035759208910	-4.30109787986442	-0.316073053057373	1.39973476535623	4.58266121002638	0.232157948732978	2.04324381665526	4.42207802429861	4.35544588789176	4.93666848839536	4.00796222368333	-0.285508461805238	4.11694447100723];
% stg.pa(8,:) = [0.224171041091921	4.14569797565945	-5.12597656250000	-0.496693347229529	4.99365916737560	3.47175706309718	-2.91358950941646	4.99478040588219	-2.09135355218179	3.17468635994875	-2.64960461615035	-2.70634614440303	-4.74692357284192	2.47599944617985	-1.95265486171263	-0.330930209982217	-2.67025403518381	2.17100728862926	-2.33477945091628	1.30046258369044	-1.99865611205045	1.56979042273472	-2.45998532306605	-2.63884143061326	-2.39098413000749	-1.89436039224478	-3.32669679209138	-1.79131443366105	0.723760585964272	-1.53322404649485	2.02435464510106	-0.131281208613985	4.99965382285601	-0.546875000000000	4.99949048885803	-0.709637936876491	4.99156445431856	-3.18473047388415	4.99240235776297];
% stg.pa(9,:) = [-2.66551688372615	0.993431383698675	-1.10174682562248	4.63463523002781	-2.67437142846715	1.80107767250241	-0.190513429226968	4.99102098314214	-0.538542289915456	2.56666362351891	-4.47528947286596	1.89212178267655	-3.90395846473541	1.00669041367702	-6.28945187806723	-0.567320330581571	-3.42356360043274	1.44157207731980	-0.962228887991148	1.75045715488755	1.15418660045812	-2.07534860027468	-4.21228393047385	-3.03750269400012	-1.96952214105076	1.21576971656058	1.31794877997709	-1.78547453324719	1.87129929453546	0.397187412713838	4.99932045920549	-6.35060255264147	-0.996646827368708	0.974907167334302	0.112572331528156	3.79693879884129	-1.62623130583418	4.99801043434554	4.99268427215826];
% stg.pa(10,:) = [-2.66317769621730	1.02370382763652	-0.939480621101256	4.70508710389274	-2.69607634135895	1.82748408237913	-0.150382726361319	4.99331489554819	-0.549967136648519	2.55892890485386	-4.47870776486379	1.90008457566312	-3.89852494816204	0.985627270462801	-6.82823992707279	-0.574568600278611	-3.40901867253310	1.43656899412068	-0.970648630331776	1.74058836481228	1.15962305593731	-2.08640734725935	-4.20919142219151	-3.02937745860192	-1.96521544157891	1.22101177025554	1.32143204434352	-1.78177545426105	1.87867895731182	0.384970191647108	5	-6.98242187500000	-1.02320131104099	0.973333983439277	0.119351827225223	3.79922935422435	-1.63823708458622	4.13867187500000	4.99556858926333];
% stg.pa(11,:) = [-2.66058942488610	1.03417291146655	-0.884652037838503	4.72209745565193	-2.73107045951388	1.83573949814568	-0.227155100563737	5	-0.550252600278361	2.56625985264795	-4.47845948209861	1.90555177826180	-3.88942024906913	0.967997747199750	-6.79025946051160	-0.573792623107412	-3.40648184495623	1.43326639939027	-0.990330435195278	1.71972130107372	1.15558898312971	-2.07872333491625	-4.20712294826830	-3.02022526924633	-1.95798564806103	1.22448597944984	1.32143204434352	-1.77805619281384	1.88351452023022	-0.771159456995886	5	-7	-1.02439869619350	0.977815813330646	0.129037106724630	3.80150145150804	-1.67318087441388	4.19121415300231	5];

% stg.bestpa = [-2.66317769621730	1.02370382763652	-0.939480621101256	4.70508710389274	-2.69607634135895	1.82748408237913	-0.150382726361319	4.99331489554819	-0.549967136648519	2.55892890485386	-4.47870776486379	1.90008457566312	-3.89852494816204	0.985627270462801	-6.82823992707279	-0.574568600278611	-3.40901867253310	1.43656899412068	-0.970648630331776	1.74058836481228	1.15962305593731	-2.08640734725935	-4.20919142219151	-3.02937745860192	-1.96521544157891	1.22101177025554	1.32143204434352	-1.78177545426105	1.87867895731182	0.384970191647108	5	-6.98242187500000	-1.02320131104099	0.973333983439277	0.119351827225223	3.79922935422435	-1.63823708458622	4.13867187500000	4.99556858926333];

% stg.pa(8,:) = [];

% stg.dbpa = 1;


% stg.popsize = 1080;
% stg.osm = 2;
% stg.optt = 60*30;
% stg.useLog = 3;

% Initialize the cell array containing optimization algorithm names and
% corresponding settings flags
optimization_algorithms = {
    'Genetic algorithm', 'ga';
    'fmincon', 'fmincon';
    'Simulated annealing', 'sa';
    'Pattern search', 'psearch';
   'Particle swarm', 'pswarm';
    'Surrogate optimization', 'sopt'
    };

p = gcp(); % If no pool, do not create new one.
poolsize = p.NumWorkers;

stg.pat_original = stg.pat;
stg.pa_original = stg.pa;


stg.pat = 1:poolsize;
for n = 1:poolsize
stg.pa(n,:) = stg.pa(1,:);
end
parfor n = 1:poolsize
[~] = f_diagnostics(stg,model_folders);
end

% Iterate through the optimization_algorithms cell array and call the
% corresponding algorithms if their flag is set in the settings
for i = 1:size(optimization_algorithms, 1)
    % algorithm_func = optimization_algorithms{i, 1};
    algorithm_flag = optimization_algorithms{i, 2};

    if stg.(algorithm_flag)
        [rst(i), parameter_array(i, :)] = ...
            run_algorithm(@optimize_algorithm,...
            optimization_algorithms{i, 1}, stg, model_folders);
    end
end
end

function [algorithm_result, algorithm_parameter_array] =...
    run_algorithm(algorithm_func, optimization_algorithms_names,...
    settings, model_folders)

% Define the objective function
objective_function = @(x)f_sim_score(x, settings, model_folders,0,0);

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
% if contains(algorithm_name,{'fmincon','Simulated annealing','Pattern search','Surrogate optimization'})
% settings.mst = true;
% settings.msts = poolsize;
% else
% settings.mst = mst;
% settings.msts = poolsize;
% end

% Determine the starting point for the optimization
[startpoint, ~, spop] = f_opt_start(settings);

% Prepare optimization options based on settings and algorithm_name
options = prepare_optimization_options(settings, algorithm_name);

% Execute the optimization algorithm
[x, fval, exitflag, output] = run_optimization(settings, algorithm_name,...
    objective_function, startpoint, spop, settings.lb,...
    settings.ub, options);

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

    % [x(1,:), fval(1), exitflag(1), output(1)] = ...
    %     run_optimizer(algorithm_name, objective_function,...
    %     (lb + ub) / 2, spop, lb, ub, options);

    [x(1,:), fval(1), exitflag(1), output(1)] = ...
        run_optimizer(algorithm_name, objective_function,...
        settings.bestpa, spop, lb, ub, options);
end
end

function [x, fval, exitflag, output] = ...
    run_optimizer(algorithm_name, objective_function, startpoint, spop,...
    lb, ub, options)

% Execute the appropriate optimization algorithm based on algorithm_name
switch algorithm_name
    case 'fmincon'
        % startpoint
        % min(startpoint)
        % max(startpoint)
        % lb
        % ub
        [x, fval, exitflag, output] = ...
            fmincon(objective_function, startpoint, [], [], [], [], lb, ub, [], options);
    case 'Simulated annealing'
        [x, fval, exitflag, output] = ...
        simulannealbnd(objective_function, startpoint, lb, ub, options);
    case 'Pattern search'
        
        [x, fval, exitflag, output] = ...
            patternsearch(objective_function, startpoint, ...
            [], [], [], [], lb, ub, [], options);
    case 'Genetic algorithm'
        parnum = length(lb);
        [x, fval] = ga(objective_function, parnum, ...
            [], [], [], [], lb, ub, [], options);
        exitflag = [" "];
        output = [" "];
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

function options = prepare_optimization_options(stg, algorithm_name)

% Set options for each algorithm
switch algorithm_name
    case 'fmincon'
        options = stg.fm_options;
        options.UseParallel = stg.optmc;
    case 'Simulated annealing'
        options =  stg.sa_options;
        options.MaxTime = stg.optt;
    case 'Pattern search'
        options = stg.psearch_options;
        options.MaxTime = stg.optt;
        options.UseParallel = stg.optmc;
    case 'Genetic algorithm'

        test = stg.pa_original(stg.pat_original,:);

        options = stg.ga_options;
        options.MaxTime = stg.optt;
        options.PopulationSize = stg.popsize+length(test);
        % options.PopulationSize = stg.popsize;
        options.UseParallel = stg.optmc;
        [~,startpop,~] = f_opt_start(stg);
        options.InitialPopulationMatrix = startpop;
    case 'Particle swarm'
        options = stg.pswarm_options;
        options.MaxTime = stg.optt;
        options.SwarmSize = stg.popsize;
        options.UseParallel = stg.optmc;
        [~,startpop,~] = f_opt_start(stg);
        options.InitialSwarmMatrix = startpop;
    case 'Surrogate optimization'
        options = stg.sopt_options;
        options.MaxTime = stg.optt;
        options.UseParallel = stg.optmc;
    otherwise
        error('Unsupported optimization algorithm.');
end

% Enable plots if chosen in settings
if stg.optplots
    % Set the appropriate PlotFcn based on the optimization algorithm
    options.PlotFcn = get_plot_functions(algorithm_name);
end

% Enable console messages if chosen in settings
if stg.optcsl
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
            @gaplotscores, @gaplotdistance, @gaplotselection};
    case 'Particle swarm'
        plot_functions = {@pswplotbestf};
    case 'Surrogate optimization'
        plot_functions = {@surrogateoptplot};
    otherwise
        error('Unsupported optimization algorithm.');
end
end

function [spoint,spop_mc,spop_sc] = f_opt_start(stg)
% Set the randomm seed for reproducibility
rng(stg.rseed);

test = stg.pa_original(stg.pat_original,:);

% Optimization Start method 1
if stg.osm == 1
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
    spoint = lhsdesign(stg.msts,stg.parnum).*(stg.ub-stg.lb)+stg.lb;

    % Get a group of ramdom starting points inside the bounds
    spop_mc = lhsdesign(stg.popsize,stg.parnum).*(stg.ub-stg.lb)+stg.lb;
    % spop_mc = [lhsdesign(stg.popsize,stg.parnum).*(stg.ub-stg.lb)+stg.lb;test];

    % Get a group of ramdom starting points inside the bounds
    for n = 1:stg.msts
    spop_sc{n} = lhsdesign(ceil(stg.popsize/36),stg.parnum).*(stg.ub-stg.lb)+stg.lb;
    end
    % Optimization Start method 2
elseif stg.osm == 2
    
    % Get a random starting point or group of starting points, if using
    % multistart, near the best point
    spoint = stg.bestpa - stg.dbpa +...
        (stg.dbpa*2*lhsdesign(stg.msts,stg.parnum));
    
    spoint = max(min(5,spoint),-7);


    % Get a group of random starting points near the best point
    spop_mc = stg.bestpa - stg.dbpa +...
        (stg.dbpa*2*lhsdesign(stg.popsize,stg.parnum));

    spop_mc = max(min(stg.ub,spop_mc),stg.lb);
    spop_mc = [spop_mc;test];
    for n = 1:stg.msts
    spop_sc{n} = stg.bestpa - stg.dbpa +...
        (stg.dbpa*2*lhsdesign(ceil(stg.popsize/36),stg.parnum));

    spop_sc{n} = max(min(stg.ub,spop_sc{n}),stg.lb);
    end


end
end