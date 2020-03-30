function [stg] = f_settings_all_TW()

%% Import

% 0 or 1 to decide whether to run import functions
stg.import = 1;

% Name of the folder where everything related to the model is stored
stg.folder_model = "D1_LTP_time_window";

% Name of the excel file with the sbtab
stg.sbtab_excel_name = "Timing_model_SBtab.xlsx";

% Name of the model
stg.name = "D1_LTP_time_window";

% Name of the model compartment
stg.cname = "Spine";

% Name of the sbtab saved in .mat format
stg.sbtab_name = "sbtab_"+stg.name;

%% Analysis

% String with the analysis to be run, the options are "RS", "diag",
% "optlocal", "optcluster", "PLlocal", "PLcluster", "SAlocal", "SAcluster"
% and can be combined as for example "RS,diag", to not run any analysis set
% stg.analysis to equal to ""

stg.analysis = "diag";

% Experiments to run
stg.ms.exprun = [1:9];

% Choice between 0,1,2 and 3 to change either and how to apply log10 to the
% scores (check documentation)
stg.useLog = 1;

% 0 or 1 to decide whether to use multicore everywhere it is available
stg.optmc = logical(0);

% Choice of ramdom seed
stg.rseed = 1;

% 0 or 1 to decide whether to use display things in the console
stg.csl = 0;

% 0 or 1 to decide whether to display results on console
stg.console = 1;

% 0 or 1 to decide whether to save results
stg.save_results = 0;

%% Simulation

% Maximum time for each individual function to run in seconds
stg.ms.maxt = 10;

% Equilibration time
stg.ms.eqt  = 100000;

% 0 or 1 to decide whether to do Dimensional Analysis
stg.ms.dimenanal = true;

stg.ms.UnitConversion = true;

% 0 or 1 to decide whether to do Absolute Tolerance Scaling
stg.ms.abstolscale = false;

% Number for Relative tolerance
stg.ms.reltol = 1.0E-4;

% Number for Absolute tolerance
stg.ms.abstol = 1.0E-4;

stg.ms.simtime = "second";

% 0 or 1 to decide whether to run sbioaccelerate (after changing this value
% you need to run "clear functions" to see an effect)
stg.ms.sbioacc = 0;

% Max step size in the simulation (if empty matlab decides whats best)
stg.maxstep = [];

%% Model

% Number of parameters to optimize
stg.ms.parnum = 6;

% Index for the parameters that have thermodynamic constrains
stg.ms.tci = [];

% Parameters to multiply to the first parameter (in Stg.ms.partest to get
% to the correct thermodynamic constrain formula)
stg.ms.tcm = [];

% Parameters to divide to the first parameter (in Stg.ms.partest to get to
% the correct thermodynamic constrain formula)
stg.ms.tcd = [];

% Array with the lower bound of all parameters
stg.lb = zeros(1,stg.ms.parnum)-5;

% Array with the upper bound of all parameters
stg.ub = zeros(1,stg.ms.parnum)+4;

%% Diagnostics

% Choice of what parameters in the array to test, the indices correspond to
% the parameters in the model and the numbers correspond to the parameters
% in the optimization array, usually not all parameters are optimized so
% there needs to be a match between one and the other.
stg.ms.partest([216:227],1) =  [1:6,1:6];

stg.pat = 1;

stg.pa(1,:) = zeros(1,6);

stg.pa(1,:) = [-7.244125144,-4.823908741,1,-5.823908741,0.368547198,0.569865286];

% % Best parameter found so far for the model

stg.bestx = [-7.244125144,-4.823908741,1,-5.823908741,0.368547198,0.569865286];

%% Plots

% 0 or 1 to decide whether to do plots
stg.plot = 1;

% 0 or 1 to decide whether to use long names in plot Diag3
stg.plotnames = 1;

%% Profile Likelihood

% Parameter(optimization array) that is being worked on in a specific
% iteration of PL (if -1 no parameter is being worked in PL)
stg.PLind = -1;

% Which parameters to do PL on, it should be all parameters but can also be
% a subset for testing purposes
stg.pltest = (1:6);

% How many points to do for each parameter in the PL
stg.plres = 20;

% 0 or 1 to decide whether to do plots after calculating PL
stg.plplot = 1;

% 0 or 1 to decide whether to run simulated annealing
stg.plsa = 0;

% Options for simulated annealing
stg.plsao = optimoptions(@simulannealbnd,'Display','off', ...
    'InitialTemperature',...
    ones(1,stg.ms.parnum)*1,'MaxTime',1,'ReannealInterval',40);

% 0 or 1 to decide whether to run fmincon
stg.plfm = 0;

% Options for fmincon
stg.plfmo = optimoptions('fmincon','Display','off',...
    'Algorithm','interior-point',...
    'MaxIterations',1,'OptimalityTolerance',0,...
    'StepTolerance',1e-6,'FiniteDifferenceType','central','UseParallel',logical(0));

%% Sensitivity analysis

% Number of samples to use in SA
stg.sansamples = 5;

% 0 or 1 to decide whether to subtract the mean before calculating SI and
% SIT
stg.sasubmean = 1;

%% Optimization

%  Time for the optimization in seconds (fmincon does not respect this
% time!!)
stg.optt = 60*5;

% Population size (for the algorithms that use populations)
stg.popsize = 36;

% optimization start method, choose between:
% 1 Random starting point or group of starting points inside the bounds
% 2 Random starting point or group of starting points near the best point
stg.osm = 1;

% Distanse from best point to be used in stg.osm method 2
stg.dbs = 0.1;

% 0 or 1 to decide whether to use Multistart
stg.mst = 0;

% Multistart size
stg.msts = 1;

% 0 or 1 to decide whether to display Plots (Plots doesn't work if using
% multicore)
stg.optplots = 0;

% 0 or 1 to decide whether to run fmincon (no gradient so this doesn't work
% very well, no max time!!)
stg.fmincon = 0;

% Options for fmincon
stg.fm_options = optimoptions('fmincon',...
    'UseParallel',stg.optmc,...
    'Algorithm','interior-point',...
    'MaxIterations',1,'OptimalityTolerance',0,...
    'StepTolerance',1e-6,'FiniteDifferenceType','central',...
    'MaxFunctionEvaluations',10000);

% 0 or 1 to decide whether to run simulated annealing
stg.sa = 0;

% Options for simulated annealing
stg.sa_options = optimoptions(@simulannealbnd, ...
    'MaxTime',stg.optt,...
    'InitialTemperature',...
    ones(1,stg.ms.parnum)*2,'ReannealInterval',40);

% 0 or 1 to decide whether to run Pattern search
stg.psearch = 0;

% Options for Pattern search
stg.psearch_options = optimoptions(@patternsearch,...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'UseCompletePoll',true,'UseCompleteSearch',true,...
    'MaxMeshSize',2,'MaxFunctionEvaluations',2000);

% 0 or 1 to decide whether to run Genetic algorithm
stg.ga = 0;

% Options for Genetic algorithm
stg.ga_options = optimoptions(@ga,'MaxGenerations',100,...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'PopulationSize',stg.popsize,...
    'MutationFcn','mutationadaptfeasible','Display','diagnose');

% 0 or 1 to decide whether to run Particle swarm
stg.pswarm = 1;

% Options for Particle swarm
stg.pswarm_options = optimoptions('particleswarm',...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'SwarmSize',stg.popsize);

% 0 or 1 to decide whether to run Surrogate optimization
stg.sopt = 0;

% Options for Surrogate optimization
stg.sopt_options = optimoptions('surrogateopt',...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'MaxFunctionEvaluations',5000,...
    'MinSampleDistance',0.2,'MinSurrogatePoints',32*2+1);

%% Cluster

% Number of cluster workers to use
stg.clw = 1;

% Name of your accont in the cluster you are using
stg.claccount =  'snic2019-3-94';

% Amount of time the code is going to be given to run on the cluster
stg.cltime = 60;

end

