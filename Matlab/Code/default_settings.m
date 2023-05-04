function [stg] = default_settings()
% This function returns a structure "stg" containing default settings for a
% model analysis and optimization workflow. The structure includes settings
% related to model import, analysis, simulation, diagnostics, plotting,
% sensitivity analysis, and optimization. Inputs and outputs for the
% function are as follows:
%
%   Inputs: None
%
%   Outputs:
%     - stg: A structure containing fields for various settings, which
%            include import options, analysis options, simulation options,
%            diagnostics settings, plotting options, sensitivity analysis
%            options, and optimization settings.
%
%   Functions called: None
%
%   Loaded variables: None
%
% To understand the function better, please read the comments within the
% code for a detailed explanation of each setting and their default values.

% stg.exprun: Lists experiments to run (example experiment 1 to 3 and
% experiment 6)
% 
% stg.useLog: Determines the scoring method choice (check documentation)
% (Use logarithm)
% 
% stg.optmc: Specifies whether to use multicore wherever available
% (Optimization Multicore)
% 
% stg.rseed: Sets the random seed value (Random seed)
% 
% stg.simcsl: Indicates whether to display simulation diagnostics in the
% console (Simulation Console)
% 
% stg.optcsl: Specifies whether to display optimization results in the
% console (Optimization console)
% 
% stg.save_results: Specifies whether to save results (Save results)
% 
% stg.simdetail: Specifies whether to run detailed simulation for plots
% 
% stg.maxt: Sets the maximum time for each individual function to run in
% seconds (Maximum time)
% 
% stg.eqt: Defines the equilibration time (Equilibration time)
% 
% stg.dimenanal: Specifies whether to perform Dimensional Analysis
% (Dimensional Analysis)
% 
% stg.UnitConversion: Specifies whether to perform Unit conversion (Unit
% conversion)
% 
% stg.abstolscale: Specifies whether to apply Absolute Tolerance Scaling
% (Absolute Tolerance Scaling)
% 
% stg.reltol: Assigns the value of Relative tolerance (Relative tolerance)
% 
% stg.abstol: Assigns the value of Absolute tolerance (Absolute tolerance)
% 
% stg.simtime: Specifies the time units for simulation (Simulation time)
% 
% stg.sbioacc: Specifies whether to run sbioaccelerate (sbioaccelerate)
% 
% stg.abstolstepsize_eq: Provides the absolute tolerance step size for
% equilibration (Absolute tolerance step size for equilibration)
% 
% stg.maxstep: Max step size in the simulation (if empty, Matlab decides
% what's best) (Maximum step)
% 
% stg.maxstepeq: Sets the max step size in the simulation (if empty, Matlab
% decides what's best) (Maximum step)
% 
% stg.maxstepdetail: Sets the max step size in the detailed plots (if
% empty, Matlab decides what's best) (Maximum step)
% 
% stg.errorscore: Specifies the default score when there is a simulation
% error, required to keep optimizations working (error score)
% 
% stg.parnum: Specifies the number of parameters to optimize (Parameter
% number)
% 
% stg.lb: Assigns the array with the lower bound of all parameters (Lower
% bound)
% 
% stg.ub: Assigns the array with the upper bound of all parameters (Upper
% bound)
% 
% stg.partest: Choice of what parameters in the array to test, the indices
% correspond to the parameters in the model and the numbers correspond to
% the parameters in the optimization array (Parameters to test)
% 
% stg.pat: Defines the parameter array to test (Parameter array to test)
% 
% stg.pa: Contains all the parameter arrays (parameters here are in log10
% space) (Parameter arrays)
% 
% stg.bestpa: Provides the best parameter array found so far for the model
% (Best parameter array)
% 
% stg.plot: Specifies whether to plot results (Plots)
% 
% stg.plotoln: Specifies whether to use long names in the title
% 
% stg.sansamples: Sets the number of samples to use in Sensitivity Analysis
% (Sensitivity analysis number of samples)
% 
% stg.sasubmean: Specifies whether to subtract the mean before calculating
% SI and SIT in Sensitivity Analysis (Sensitivity analysis subtract mean)
% 
% stg.sasamplemode: Determines the sampling mode for Sensitivity Analysis
% (Sensitivity analysis sampling mode)
% 
% stg.sasamplesigma: Defines the sigma for creating the normal distribution
% of parameters to perform Sensitivity Analysis (Sensitivity analysis
% sampling sigma)
% 
% stg.optt: Sets the time for the optimization in seconds (Optimization
% time)
% 
% stg.popsize: Defines the population size for the algorithms that use
% populations (Population size)
% 
% stg.osm: Chooses the optimization start method (Optimization start
% method)
% 
% stg.dbs: Specifies the distance from the best parameter array to be used
% in stg.osm method 2 (Distance from best parameter array)
% 
% stg.mst: Specifies whether to use Multistart (Multistart)
% 
% stg.msts: Provides the Multistart size
% 
% stg.optplots: Specifies whether to display Plots (Plots don't work if
% using multistart) (Optimization plots)
% 
% stg.fmincon: Indicates whether to run fmincon (fmincon)
% 
% stg.fm_options: Sets options for fmincon (fmincon options)
% 
% stg.sa: Specifies whether to run simulated annealing (Simulated
% annealing)
% 
% stg.sa_options: Provides options for simulated annealing (Simulated
% annealing options)
% 
% stg.psearch: Specifies whether to run Pattern search (Pattern search)
% 
% stg.psearch_options: Sets options for Pattern search (Pattern search
% options)
% 
% stg.ga: Specifies whether to run Genetic algorithm (Genetic algorithm)
% 
% stg.ga_options: Options for Genetic algorithm (Genetic algorithm options)
% 
% stg.pswarm: Specifies whether to run Particle swarm (Particle swarm)
% 
% stg.pswarm_options: Sets options for Particle swarm (Particle swarm
% options)
% 
% stg.sopt: Specifies whether to run Surrogate optimization (Surrogate
% optimization)
% 
% stg.sopt_options: Provides options for Surrogate optimization (Surrogate
% optimization options)









%% Analysis

% Lists experiments to run (example experiment 1 to 3 and experimet 6)
stg.exprun = [1:3,6];

% Determines the scoring method choice (check documentation) (Use
% logarithm)
stg.useLog = 4;

% Specifies whether to use multicore wherever available (Optimization
% Multicore)
stg.optmc = true;

% Sets the random seed value (Ramdom seed)
stg.rseed = 1;

% Indicates whether to display simulation diagnostics in the console
% (Simulation Console)
stg.simcsl = false;

% Specifies whether to display optimization results in the console
% (Optimization console)
stg.optcsl = false;

% Specifies whether to save results (Save results)
stg.save_results = true;

% Specifies whether to run detailed simulation for plots
stg.simdetail = true;

%% Simulation

% Sets the maximum time for each individual function to run in seconds
% (Maximum time)
stg.maxt = 10;

% Defines the equilibration time (Equilibration time)
stg.eqt  = 50000;

% Specifies whether to perform Dimensional Analysis (Dimensional Analysis)
stg.dimenanal = false;

% Specifies whether to perform Unit conversion (Unit conversion)
stg.UnitConversion = false;

% Specifies whether to apply Absolute Tolerance Scaling (Absolute Tolerance
% Scaling)
stg.abstolscale = true;

% Assigns the value of Relative tolerance (Relative tolerance)
stg.reltol = 1.0E-4;

% Assigns the value of Absolute tolerance (Absolute tolerance)
stg.abstol = 1.0E-4;

% Specifies the time units for simulation (Simulation time)
stg.simtime = "second";

% Specifies whether to run sbioaccelerate (after changing this value you
% need to run "clear functions" to see an effect) (sbioaccelerate)
stg.sbioacc = true;

% Provides the absolute tolerance step size for equilibration (Absolute
% tolerance step size for equilibration)
stg.abstolstepsize_eq = [];

% Max step size in the simulation (if empty matlab decides whats best)
% (Maximum step)
stg.maxstep = 10;

% Sets the max step size in the simulation (if empty, Matlab decides what's
% best) (Maximum step)
stg.maxstepeq = 2;

% Sets the max step size in the detailed plots (if empty, Matlab decides
% what's best) (Maximum step)
stg.maxstepdetail = 2;

% Specifies the default score when there is a simulation error, required to
% keep optimizations working (error score)
stg.errorscore = 10^5;
%% Model

% Specifies the number of parameters to optimize (Parameter number)
stg.parnum = 5;

% Provides the array with the lower bound of all parameters
original_parameter_set = zeros(1,10);

% Assigns the array with the lower bound of all parameters  (Lower bound)
stg.lb = original_parameter_set-5;

% Assigns the array with the upper bound of all parameters (Upper bound)
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

% Defines the parameter array to test (Parameter array to test)
stg.pat = 1:2;

% Contains all the parameter arrays (parameters here are in log10 space)
% (Parameter arrays)
stg.pa(1,:) = [1,1,1,1,1];
stg.pa(1,:) = [1,0,1,2,1];

% Provides the best parameter array found so far for the model (Best
% parameter array)
stg.bestpa = stg.pa(1,:);

%% Plots

% Specifies whether to plot results (Plots)
stg.plot = true;

% Specifies whether to use long names in the title of the output plots in
% f_plot_outputs.m (Plot outputs long names)
stg.plotoln = true;

%% Sensitivity analysis

% Sets the number of samples to use in Sensitivity Analysis (Sensitivity
% analysis number of samples)
stg.sansamples = 100;

% Specifies whether to subtract the mean before calculating SI and SIT in
% Sensitivity Analysis (Sensitivity analysis subtract mean)
stg.sasubmean = true;

% Determines the sampling mode for Sensitivity Analysis; 0 Log uniform
% distribution truncated at the parameter bounds 1 Log normal distribution
% with mu as the best value for a parameter and sigma as stg.sasamplesigma
% truncated at the parameter bounds 2 same as 1 without truncation 3 Log
% normal distribution centered at the mean of the parameter bounds and
% sigma as stg.sasamplesigma truncated at the parameter bounds 4 same as 3
% without truncation. (Sensitivity analysis sampling mode)
stg.sasamplemode = 2;

% Defines the sigma for creating the normal distribution of parameters to
% perform Sensitivity Analysis (Sensitivity analysis sampling sigma)
stg.sasamplesigma = 0.1;

%% Optimization

% Sets the time for the optimization in seconds (fmincon does not respect
% this time!!) (Optimization time)
stg.optt = 60*5;

% Defines the population size for the algorithms that use populations
% (Population size)
stg.popsize = 144;

% Chooses the optimization start method: 1 for random starting point(s)
% inside bounds, 2 for random starting point(s) near the best point
% (Optimization start method)
stg.osm = 1;

% Specifies the distance from the best parameter array to be used in
% stg.osm method 2 (Distance from best parameter array)
stg.dbs = 0.1;

% Specifies whether to use Multistart (Multistart)
stg.mst = false;

% Provides the Multistart size
stg.msts = 1;

% Specifies whether to display Plots (Plots don't work if using multistart)
% (Optimization plots)
stg.optplots = true;

% Indicates whether to run fmincon (no gradient, so this doesn't work well;
% no max time!!) (fmincon)
stg.fmincon = false;

% Sets options for fmincon (fmincon options)
stg.fm_options = optimoptions('fmincon', 'Algorithm', 'interior-point',...
    'MaxIterations', 10, 'OptimalityTolerance', 0, 'StepTolerance', 1e-6,...
    'FiniteDifferenceType', 'central', 'MaxFunctionEvaluations', 10000);

% Specifies whether to run simulated annealing (Simulated annealing)
stg.sa = false;

% Provides options for simulated annealing (Simulated annealing options)
stg.sa_options = optimoptions(@simulannealbnd, 'MaxTime', stg.optt,...
    'ReannealInterval', 40);

% Specifies whether to run Pattern search (Pattern search)
stg.psearch = false;

% Sets options for Pattern search (Pattern search options)
stg.psearch_options = optimoptions(@patternsearch, 'MaxTime', stg.optt,...
    'UseParallel', stg.optmc, 'UseCompletePoll', true,...
    'UseCompleteSearch', true, 'MaxMeshSize',2, ...
    'MaxFunctionEvaluations', 2000);

% Specifies whether to run Genetic algorithm (Genetic algorithm)
stg.ga = false;

% Options for Genetic algorithm (Genetic algorithm options)
stg.ga_options = optimoptions(@ga, 'MaxGenerations', 200, ...
    'MaxTime', stg.optt,'UseParallel', stg.optmc, ...
    'PopulationSize', stg.popsize,'MutationFcn', 'mutationadaptfeasible');
    

% Specifies whether to run Particle swarm (Particle swarm)
stg.pswarm = false;

% Sets options for Particle swarm (Particle swarm options)
stg.pswarm_options = optimoptions('particleswarm', 'MaxTime', stg.optt,...
    'UseParallel', stg.optmc, 'MaxIterations', 200, ...
    'SwarmSize', stg.popsize);
    
% Specifies whether to run Surrogate optimization (Surrogate optimization)
stg.sopt = false;

% Provides options for Surrogate optimization (Surrogate optimization
% options)
stg.sopt_options = optimoptions('surrogateopt', 'MaxTime', stg.optt,...
    'UseVectorized', stg.optmc, 'MaxFunctionEvaluations', 5000,...
    'MinSampleDistance', 0.2, 'MinSurrogatePoints', 32*2+1,'BatchUpdateInterval',360);
end