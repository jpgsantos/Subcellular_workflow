function [stg] = Viswan_2018_optimized_sup_fig2()

%% Import

% True or false to decide whether to run import functions
% (Import)
 stg.import = true;

% Name of the folder where everything related to the model is stored
% (Folder Model)
stg.folder_model = "Model_Viswan_2018";

% Name of the excel file with the sbtab
% (SBtab excel name)
stg.sbtab_excel_name = "Viswan_2018_optimized.xlsx";

% Name of the model
% (Name)
stg.name = "Viswan_2018_optimized";

% Name of the default model compartment
% (Compartment name)
stg.cname = "Cell";

% Name of the sbtab saved in .mat format
% (SBtab name)
stg.sbtab_name = "SBtab_" + stg.name;

%% Analysis

% Experiments to run
stg.exprun = [1];

% Choice between 0,1,2 and 3 to change either and how to apply log10 to the
% scores (check documentation)
% (Use logarithm)
stg.useLog = 4;

% True or false to decide whether to use multicore everywhere it is available
% (Optimization Multicore)
stg.optmc = true;

% Choice of ramdom seed
% (Ramdom seed)
stg.rseed = 1;

% True or false to decide whether to save results
% (Save results)
stg.save_results = true;

% True or false to decide whether to run detailed simulation for plots
% (Save results)
stg.simdetail = false;

%% Simulation

% Maximum time for each individual function to run in seconds
% (Maximum time)
stg.maxt = 30;

% Equilibration time
% (Equilibration time)
stg.eqt  = 5000;

% True or false to decide whether to do Dimensional Analysis
% (Dimensional Analysis)
stg.dimenanal = true;

% True or false to decide whether to do Unit conversion
% (Unit conversion)
stg.UnitConversion = true;

% True or false to decide whether to do Absolute Tolerance Scaling
% (Absolute Tolerance Scaling)
stg.abstolscale = true;

% Value of Relative tolerance
% (Relative tolerance)
stg.reltol = 1.0E-4;

% Value of Absolute tolerance
% (Absolute tolerance)
stg.abstol = 1.0E-4;

% Time units for simulation
% (Simulation time)
stg.simtime = "second";

% (Absolute tolerance step size for equilibration)
stg.abstolstepsize_eq = [];

% True or false to decide whether to run sbioaccelerate (after changing this value
% you need to run "clear functions" to see an effect)
% (sbioaccelerate)
stg.sbioacc = true;

% Max step size in the simulation (if empty matlab decides whats best)
% (Maximum step)
stg.maxstep = [];

% Max step size in the equilibration (if empty matlab decides whats best)
% (Maximum step)
stg.maxstepeq = [];

% Max step size in the detailed plots (if empty matlab decides whats best)
% (Maximum step)
stg.maxstepdetail = [10];

% Default score when there is a simulation error, this is needed to keep
% the optimizations working.
% (error score)
stg.errorscore = 10^5;

%% Model

% Number of parameters to optimize
% (Parameter number)
stg.parnum = 29;

original_parameter_set = [0.999968151	-0.301029996	0	-4	-1	0.264435738	1.602059991	1	1.183916142	-0.22184875	-0.823908741	1.183916142	-0.22184875	-0.823908741	0.948847023	0.079181246	-0.522878745	0.948847023	0.079181246	-0.522878745	-2.023562183	-1.096910013	-1.698970004	-0.728933683	-1.096910013	-1.698970004	1.66888375	1.602059991	1];

% Array with the lower bound of all parameters
% (Lower bound)
stg.lb = original_parameter_set-1;

% Array with the upper bound of all parameters
% (Upper bound)
stg.ub = original_parameter_set+1;

%% Diagnostics

% Choice of what parameters in the array to test, the indices correspond to
% the parameters in the model and the numbers correspond to the parameters
% in the optimization array, usually not all parameters are optimized so
% there needs to be a match between one and the other.
% (Parameters to test)
stg.partest(:,1) = [zeros(1,34),1,2,3,4,5,zeros(1,54),6,7,8,zeros(1,3),9:29,zeros(1,40)];

% (Parameter array to test)

stg.pat = [1:100];

% All the parameter arrays, in this case there is only one
% (Parameter arrays)
for n = 1:50
stg.pa(n,:) = original_parameter_set;
stg.pa(n+100,:) = [1.96572016882948,0.696562506302059,-0.996040381141367,-3.11034092897009,-0.973844523519245,-0.668025949025669,2.59465388739465,0.821642334185851,0.184025833869534,-1.12642000773566,0.160827786219299,1.51031750477815,0.742351565443275,0.162924008347975,0.961312010386403,-0.248754892166113,0.410390386133758,1.91147862618757,-0.299582944179546,0.471435107855951,-1.02889736355468,-1.78044498165455,-2.60207784517252,-1.04051750850729,-0.117125379982777,-2.61666645250405,1.74485667438292,0.602240496586201,1.99920811055418];
end
% Best parameter array found so far for the model
% (Best parameter array)
stg.bestpa = [1.96572016882948,0.696562506302059,-0.996040381141367,-3.11034092897009,-0.973844523519245,-0.668025949025669,2.59465388739465,0.821642334185851,0.184025833869534,-1.12642000773566,0.160827786219299,1.51031750477815,0.742351565443275,0.162924008347975,0.961312010386403,-0.248754892166113,0.410390386133758,1.91147862618757,-0.299582944179546,0.471435107855951,-1.02889736355468,-1.78044498165455,-2.60207784517252,-1.04051750850729,-0.117125379982777,-2.61666645250405,1.74485667438292,0.602240496586201,1.99920811055418];

%% Plots

% True or false to decide whether to plot results
% (Plots)
stg.plot = false;

% True or false to decide whether to use long names in the title of the outputs
% plots in f_plot_outputs.m
% (Plot outputs long names)
stg.plotoln = false;

%% Sensitivity analysis

% Number of samples to use in SA
% (Sensitivity analysis number of samples)
stg.sansamples = 100;

% True or false to decide whether to subtract the mean before calculating SI and
% SIT
% (Sensitivity analysis subtract mean)
stg.sasubmean = true;

% Choose the way you want to obtain the samples of the parameters for 
% performing the SA;
% 0 Log uniform distribution truncated at the parameter bounds
% 1 Log normal distribution with mu as the best value for a parameter and
% sigma as stg.sasamplesigma truncated at the parameter bounds
% 2 same as 1 without truncation
% 3 Log normal distribution centered at the mean of the parameter bounds and
% sigma as stg.sasamplesigma truncated at the parameter bounds
% 4 same as 3 without truncation.
% (Sensitivity analysis sampling mode)
stg.sasamplemode = 2;

% Sigma for creating the normal distribution of parameters to perform
% sensitivity analysis
% (Sensitivity analysis sampling sigma)
stg.sasamplesigma = 0.1;

stg.gsabootstrapsize = ceil(sqrt(stg.sansamples));
%% Optimization

%  Time for the optimization in seconds (fmincon does not respect this
% time!!)
% (Optimization time)
stg.optt = 60*30;

% Population size for the algorithms that use populations
% (Population size)
stg.popsize = 1440;

% True or false to decide whether to display Plots (Plots doesn't work if using
% multicore)
% (Optimization plots)
stg.optplots = true;

% True or false to decide whether to run fmincon (no gradient so this doesn't work
% very well, no max time!!)
stg.fmincon = false;

% True or false to decide whether to run simulated annealing
% (Simulated annealing)
stg.sa = false;

% True or false to decide whether to run Pattern search
% (Pattern search)
stg.psearch = false;

% True or false to decide whether to run Genetic algorithm
% (Genetic algorithm)
stg.ga = true;

% True or false to decide whether to run Particle swarm
% (Particle swarm)
stg.pswarm = true;

% True or false to decide whether to run Surrogate optimization
% (Surrogate optimization)
stg.sopt = false;
end