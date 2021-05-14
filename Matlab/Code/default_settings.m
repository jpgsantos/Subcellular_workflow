function [stg] = default_settings()

%% Import

% True or false to decide whether to run import functions (Import)
stg.import = true;


% Name of the excel file with the sbtab (SBtab excel name)
stg.sbtab_excel_name = "SBTAB.xlsx";

% Name of the model (Name)
stg.name = "model_name";

% Name of the default model compartment (Compartment name)
stg.cname = "Compartment";

% Name of the sbtab saved in .mat format (SBtab name)
stg.sbtab_name = "SBtab_" + stg.name;

%% Analysis

% Experiments to run (example experiment 1 to 3 and experimet 6)
stg.exprun = [1:3,6];

% Choice between 0,1,2 and 3,4 to choose the scoring method (check
% documentation) (Use logarithm)
stg.useLog = 4;

% True or false to decide whether to use multicore everywhere it is
% available (Optimization Multicore)
stg.optmc = true;

% Choice of ramdom seed (Ramdom seed)
stg.rseed = 1;

% True or false to decide whether to use display simulation diagnostics in
% the console (Simulation Console)
stg.simcsl = false;

% True or false to decide whether to display optimization results on
% console (Optimization console)
stg.optcsl = false;

% True or false to decide whether to save results (Save results)
stg.save_results = true;

% True or false to decide whether to run detailed simulation for plots
stg.simdetail = true;

%% Simulation

% Maximum time for each individual function to run in seconds (Maximum
% time)
stg.maxt = 10;

% Equilibration time (Equilibration time)
stg.eqt  = 50000;

% True or false to decide whether to do Dimensional Analysis (Dimensional
% Analysis)
stg.dimenanal = false;

% True or false to decide whether to do Unit conversion (Unit conversion)
stg.UnitConversion = false;

% True or false to decide whether to do Absolute Tolerance Scaling
% (Absolute Tolerance Scaling)
stg.abstolscale = true;

% Value of Relative tolerance (Relative tolerance)
stg.reltol = 1.0E-4;

% Value of Absolute tolerance (Absolute tolerance)
stg.abstol = 1.0E-4;

% Time units for simulation (Simulation time)
stg.simtime = "second";

% True or false to decide whether to run sbioaccelerate (after changing
% this value you need to run "clear functions" to see an effect)
% (sbioaccelerate)
stg.sbioacc = true;

% Max step size in the simulation (if empty matlab decides whats best)
% (Maximum step)
stg.maxstep = [10];

% Max step size in the equilibration (if empty matlab decides whats best)
% (Maximum step)
stg.maxstepeq = [2];

% Max step size in the detailed plots (if empty matlab decides whats best)
% (Maximum step)
stg.maxstepdetail = [2];

%% Model

% Number of parameters to optimize (Parameter number)
stg.parnum = 5;

original_parameter_set = zeros(1,10);

% Array with the lower bound of all parameters (Lower bound)
stg.lb = original_parameter_set-5;

% Array with the upper bound of all parameters (Upper bound)
stg.ub = original_parameter_set+5;

%% Diagnostics

% Choice of what parameters in the array to test, the indices correspond to
% the parameters in the model and the numbers correspond to the parameters
% in the optimization array, usually not all parameters are optimized so
% there needs to be a match between one and the other. (Parameters to test)
% In this example there are ten parameters in this imaginary model and we
% are only interested in parameter 2,4,8,9, and 10. Note that stg.parnum is
% five because of this and not ten
stg.partest(:,1) = [0,1,0,2,0,0,0,3,4,5];

% (Parameter array to test)
stg.pat = [1:2];

% All the parameter arrays, in this case there is only one (parameters here
% are in log10 space)(Parameter arrays)
stg.pa(1,:) = [1,1,1,1,1];
stg.pa(1,:) = [1,0,1,2,1];

% Best parameter array found so far for the model (Best parameter array)
stg.bestpa = stg.pa(1,:);

%% Plots

% True or false to decide whether to plot results (Plots)
stg.plot = true;

% True or false to decide whether to use long names in the title of the
% outputs plots in f_plot_outputs.m (Plot outputs long names)
stg.plotoln = true;

%% Sensitivity analysis

% Number of samples to use in SA (Sensitivity analysis number of samples)
stg.sansamples = 100;

% True or false to decide whether to subtract the mean before calculating
% SI and SIT (Sensitivity analysis subtract mean)
stg.sasubmean = true;

% Choose the way you want to obtain the samples of the parameters for
% performing the SA; 0 Log uniform distribution truncated at the parameter
% bounds 1 Log normal distribution with mu as the best value for a
% parameter and sigma as stg.sasamplesigma truncated at the parameter
% bounds 2 same as 1 without truncation 3 Log normal distribution centered
% at the mean of the parameter bounds and sigma as stg.sasamplesigma
% truncated at the parameter bounds 4 same as 3 without truncation.
% (Sensitivity analysis sampling mode)
stg.sasamplemode = 2;

% Sigma for creating the normal distribution of parameters to perform
% sensitivity analysis (Sensitivity analysis sampling sigma)
stg.sasamplesigma = 0.1;

%% Profile Likelihood

% Parameter(optimization array) that is being worked on in a specific
% iteration of PL (if -1 no parameter is being worked in PL) (Profile
% Likelihood Index)
stg.PLind = -1;

% Which parameters to do PL on, it should be all parameters but can also be
% a subset for testing purposes (Profile Likelihood parameters to Test)
stg.pltest = (1:15);

% How many points to do for each parameter in the PL (Profile Likelihood
% Resolution)
stg.plres = 20;

% True or false to decide whether to do plots after calculating PL (Profile
% Likelihood Plots)
stg.plplot = true;

% True or false to decide whether to run simulated annealing (Profile
% Likelihood Simulated Annealing)
stg.plsa = false;

% Options for simulated annealing
stg.plsao = optimoptions(@simulannealbnd,'Display','off', ...
    'MaxTime',5,'ReannealInterval',40);

% 0 or 1 to decide whether to run fmincon (Profile Likelihood FMincon)
stg.plfm = false;

% Options for fmincon
stg.plfmo = optimoptions('fmincon','Display','off',...
    'Algorithm','interior-point',...
    'MaxIterations',1,'OptimalityTolerance',0,...
    'StepTolerance',1e-6,'FiniteDifferenceType','central');

%% Optimization

%  Time for the optimization in seconds (fmincon does not respect this
% time!!) (Optimization time)
stg.optt = 60*5;

% Population size for the algorithms that use populations (Population size)
stg.popsize = 144;

% optimization start method, choose between: 1 Random starting point or
% group of starting points inside the bounds 2 Random starting point or
% group of starting points near the best point (Optimization start method)
stg.osm = 1;

% Distance from best parameter array to be used in stg.osm method 2
% (Distance from best parameter array)
stg.dbs = 0.1;

% True or false to decide whether to use Multistart (Multistart)
stg.mst = false;

% Multistart size
stg.msts = 1;

% True or false to decide whether to display Plots (Plots doesn't work if
% using multicore) (Optimization plots)
stg.optplots = true;

% True or false to decide whether to run fmincon (no gradient so this
% doesn't work very well, no max time!!)
stg.fmincon = false;

% Options for fmincon (fmincon options)
stg.fm_options = optimoptions('fmincon',...
    'Algorithm','interior-point',...
    'MaxIterations',2,'OptimalityTolerance',0,...
    'StepTolerance',1e-6,'FiniteDifferenceType','central',...
    'MaxFunctionEvaluations',10000);

% True or false to decide whether to run simulated annealing (Simulated
% annealing)
stg.sa = false;

% Options for simulated annealing (Simulated annealing options)
stg.sa_options = optimoptions(@simulannealbnd, ...
    'MaxTime',stg.optt,...
    'ReannealInterval',40);

% True or false to decide whether to run Pattern search (Pattern search)
stg.psearch = false;

% Options for Pattern search (Pattern search options)
stg.psearch_options = optimoptions(@patternsearch,...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'UseCompletePoll',true,'UseCompleteSearch',true,...
    'MaxMeshSize',2,'MaxFunctionEvaluations',2000);

% True or false to decide whether to run Genetic algorithm (Genetic
% algorithm)
stg.ga = false;

% Options for Genetic algorithm (Genetic algorithm options)
stg.ga_options = optimoptions(@ga,'MaxGenerations',200,...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'PopulationSize',stg.popsize,...
    'MutationFcn','mutationadaptfeasible');

% True or false to decide whether to run Particle swarm (Particle swarm)
stg.pswarm = false;

% Options for Particle swarm (Particle swarm options)
stg.pswarm_options = optimoptions('particleswarm',...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,'MaxIterations',200,...
    'SwarmSize',stg.popsize);

% True or false to decide whether to run Surrogate optimization (Surrogate
% optimization)
stg.sopt = false;

% Options for Surrogate optimization (Surrogate optimization options)
stg.sopt_options = optimoptions('surrogateopt',...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'MaxFunctionEvaluations',5000,...
    'MinSampleDistance',0.2,'MinSurrogatePoints',32*2+1);
end