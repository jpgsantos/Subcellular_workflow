function [stg] = Nair_2016_optimized_fig5()
% stg means (settings)

%% Import

% True or false to decide whether to run import functions
% (Import)
stg.import = true;

% Name of the excel file with the sbtab
% (SBtab excel name)
stg.sbtab_excel_name = "SBtab_Nair_2016_optimized.xlsx";

% Name of the model
% (Name)
stg.name = "Nair_2016_optimized";

% Name of the default model compartment
% (Compartment name)
stg.cname = "Spine";

% Name of the sbtab saved in .mat format
% (SBtab name)
stg.sbtab_name = "SBtab_"+stg.name;

%% Analysis

% Experiments to run
% (Experiments to run)
stg.exprun = [1:10];

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

% True or false to decide whether to use display simulation diagnostics in the
% console
% (Simulation Console)
stg.simcsl = false;

% True or false to decide whether to save results
% (Save results)
stg.save_results = true;

% True or false to decide whether to run detailed simulation for plots
stg.simdetail = false;

%% Simulation

% Maximum time for each individual function to run in seconds
% (Maximum time)
stg.maxt = 5;

% Equilibration time
% (Equilibration time)
stg.eqt  = 50000;

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

% True or false to decide whether to run sbioaccelerate (after changing this value
% you need to run "clear functions" to see an effect)
% (sbioaccelerate)
stg.sbioacc = false;

% (Absolute tolerance step size for equilibration)
stg.abstolstepsize_eq = 0.01;

% Max step size in the simulation (if empty matlab decides whats best)
% (Maximum step)
stg.maxstep = [1];

% Max step size in the equilibration (if empty matlab decides whats best)
% (Maximum step)
stg.maxstepeq = [];

% Max step size in the detailed plots (if empty matlab decides whats best)
% (Maximum step)
stg.maxstepdetail = [1];

% Default score when there is a simulation error, this is needed to keep
% the optimizations working.
% (error score)
stg.errorscore = 10^5;

%% Model

% Number of parameters to optimize
% (Parameter number)
stg.parnum = 6;

% Array with the lower bound of all parameters
% (Lower bound)
stg.lb = zeros(1,stg.parnum)-8;

% Array with the upper bound of all parameters
% (Upper bound)
stg.ub = zeros(1,stg.parnum)+1;

%% Diagnostics

% Choice of what parameters in the array to test, the indices correspond to
% the parameters in the model and the numbers correspond to the parameters
% in the optimization array, usually not all parameters are optimized so
% there needs to be a match between one and the other.
% (Parameters to test)
stg.partest([216:227],1) = [1:6,1:6];

% (Parameter array to test)
stg.pat = [1:1];

% All the parameter arrays, in this case there is only one
% (Parameter arrays)

stg.pa(1,:) = [-6.443697499,-1.638272164,-2.408935393,-5.958607315,-2.26760624,1];


% Best parameter array found so far for the model
% (Best parameter array)
stg.bestpa = [-6.443697499,-1.638272164,-2.408935393,-5.958607315,-2.26760624,1];

%% Plots

% True or false to decide whether to plot results
% (Plots)
stg.plot = false;

% True or false to decide whether to use long names in the title of the outputs
% plots in f_plot_outputs.m
% (Plot outputs long names)
stg.plotoln = true;

end