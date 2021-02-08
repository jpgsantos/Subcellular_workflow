function [stg] = default_settings()

%% Import

% True or false to decide whether to run import functions
% (Import)
stg.import = true;

% Name of the folder where everything related to the model is stored
% (Folder Model)
stg.folder_model = "Model_Findsim";

% Name of the excel file with the sbtab
% (SBtab excel name)
stg.sbtab_excel_name = "SBTAB_Findsim.xlsx";

% Name of the model
% (Name)
stg.name = "Findsim";

% Name of the default model compartment
% (Compartment name)
stg.cname = "Cell";

% Name of the sbtab saved in .mat format
% (SBtab name)
stg.sbtab_name = "sbtab_" + stg.name;

%% Analysis

% String with the analysis to be run, the options are "diag",
% "opt", "SA"
% and can be combined as for example "RS,diag", to not run any analysis set
% stg.analysis to equal to ""
% (Analysis)

stg.analysis = "diag";

% Experiments to run
% stg.ms.exprun = [1,3,4];
stg.exprun = [1:2];

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

% True or false to decide whether to display optimization results on console 
% (Optimization console)
stg.optcsl = false;

% True or false to decide whether to display PLA results on console 
% (PLA console)
stg.placsl = true;

% True or false to decide whether to save results
% (Save results)
stg.save_results = true;

% True or false to decide whether to run detailed simulation for plots
stg.simdetail = true;

%% Simulation

% Maximum time for each individual function to run in seconds
% (Maximum time)
stg.maxt = 30;

% Equilibration time
% (Equilibration time)
stg.eqt  = 50000;

% True or false to decide whether to do Dimensional Analysis
% (Dimensional Analysis)
stg.dimenanal = false;

% True or false to decide whether to do Unit conversion
% (Unit conversion)
stg.UnitConversion = false;

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

% Number of parameters to optimize
% (Parameter number)
stg.parnum = 15;
% stg.ms.parnum = 5;

% Index for the parameters that have thermodynamic constrains
% (Termodiamic Constrains Index)
% stg.tci = [8];
stg.tci = [];

% Parameters to multiply to the first parameter (in Stg.partest to get
% to the correct thermodynamic constrain formula)
% (Termodiamic Constrains multipliers)
% stg.tcm([8],1) = [4];
% stg.tcm([8],2) = [5];
% stg.tcm([8],3) = [7];

% Parameters to divide to the first parameter (in Stg.partest to get to
% the correct thermodynamic constrain formula)
% (Termodiamic Constrains divisors)
% stg.tcd([8],1) = [1];
% stg.tcd([8],2) = [3];
% stg.tcd([8],3) = [6];

% Array with the lower bound of all parameters
% (Lower bound)

test = [3.565465734	1.903089987	1.301029996	3.264435738	1.602059991	1	4.264435738	1.602059991	1	4.183916142	-0.22184875	-0.823908741 3.43373423	1.204119983	0.602059991];

stg.lb = test-1;
% stg.lb = zeros(1,stg.parnum)-5;

% Array with the upper bound of all parameters
% (Upper bound)
stg.ub = test+1;
% stg.ub = zeros(1,stg.parnum)+5;

%% Diagnostics

% if ispc
%     load("Model\" + stg.folder_model +"\Results\bestx.mat",'bestx');
%     load("Model\" + stg.folder_model +"\Results\padiag.mat",'pa');
% else
%     load("Model/" + stg.folder_model +"/Results/bestx.mat",'bestx');
%     load("Model/" + stg.folder_model +"/Results/padiag.mat",'pa');
% end

% Choice of what parameters in the array to test, the indices correspond to
% the parameters in the model and the numbers correspond to the parameters
% in the optimization array, usually not all parameters are optimized so
% there needs to be a match between one and the other.
% (Parameters to test)
% stg.partest(:,1) = [1,zeros(1,159)];

stg.partest(:,1) = [zeros(1,90),1,2,3,4,5,6,7,8,9,10,11,12,10,11,12,zeros(1,34),13,14,15,13,14,15,zeros(1,15)];

% stg.ms.partest(:,1) = [0  ,0  ,0  ,0  ,0  ,0  ,0 ,0 ,1 ,2,...
%                        3  ,4  ,5];

% (Parameter array to test)
stg.pat = [1:6];

% All the parameter arrays, in this case there is only one
% (Parameter arrays)

 stg.pa(5,:) = [4.34356751226841,0.923670780241194,0.673875847564401,3.45149572954397,2.50559833769720,0.00415615022018036,5.24486891989970,1.52326843941571,1.99064830038686,3.88062066075096,0.124508238614293,0.173288877821028,3.60553925673816,1.38243382569349,1.39831064384363];


 stg.pa(1,:) = [3.565465734	1.903089987	1.301029996	3.264435738	1.602059991	1	4.264435738	1.602059991	1	4.183916142	-0.22184875	-0.823908741 3.43373423	1.204119983	0.602059991];
%  stg.pa(2,:) = [1.47051661397124,-4.58771378327779,4.88472131798021,-4.47919212582039,-0.793785681798660,1.71742167512146,3.51108966232211,4.25446620406408,3.31352552011681,3.98680623624496,4.32884031430711,4.07169863187831,4.70715213220524,4.30810875901718,2.42131569665967];
%  stg.pa(3,:) = [-5,4.12135585802449,4.99146911624014,-2.54227308884864,2.54704499352413,-2.02597328941843,1.85757330256128,-3.04266952712744,4.20592980948317,4.65444168720118,-4.98129815674133,4.88305072306658,4.22788671025649,5,4.99997935458053];
 stg.pa(2,:) = [3.00782327965918,4.44103049270336,4.98689658505079,-4.46679183533548,4.83522766774498,1.79750232381264,3.57310348907238,-3.59344694743980,4.80528800453270,3.36780261465713,2.60490617774707,4.94602680659227,2.63969992012040,-3.92136714482799,2.35542805692282];
 stg.pa(5,:) = [-4.26279353805345,2.88643200396286,4.41496882294233,0.123672432876000,4.09629756048136,4.34966183555361,2.65916568571896,1.36526071837012,2.20182274204792,3.79352258710029,-3.46305900574538,-0.0994467635636818,3.14330662044877,3.64289011525887,4.33806057175983];
 stg.pa(6,:) = [2.69719440794330,0.183113486119264,4.80716764448831,-4.07115143573228,1.37733833852969,-0.128928118114379,3.81317398116445,-1.56434352721003,0.546332576501559,4.32332566297067,-3.50440094711640,1.45818898376434,3.59073083362675,4.03069341930590,4.22839598948340];
 stg.pa(3,:) = [4.39041799990433,-0.485184857967128,-4.72079121923554,4.97203264419559,4.18950214248611,-3.73493921705331,3.54203779163694,-4.18713079085033,-4.90627884689042,4.99999785495303,-1.78844283387361,1.76402762860888,4.70494274198218,-0.483157240386130,-0.911361474223092];
 stg.pa(4,:) = [1.11389406834506,-0.722033566206175,3.17293462462387,1.40396873098917,-4.02336305666310,-4.24983854952258,3.87893750075415,-4.26923209185099,-5,5,-4.82474735566891,3.18705402011508,4.34754000362115,-3.44834931956091,-0.835477432766747];
 
 
 
 
 % Best parameter array found so far for the model
% (Best parameter array)
stg.bestpa = stg.pa(1,:);

%% Plots

% True or false to decide whether to plot results
% (Plots)
stg.plot = true;

% True or false to decide whether to use long names in the title of the outputs
% plots in f_plot_outputs.m
% (Plot outputs long names)
stg.plotoln = true;

%% Sensitivity analysis

% Number of samples to use in SA
% (Sensitivity analysis number of samples)
stg.sansamples = 36;

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

%% Profile Likelihood

% Parameter(optimization array) that is being worked on in a specific
% iteration of PL (if -1 no parameter is being worked in PL)
% (Profile Likelihood Index)
stg.PLind = -1;

% Which parameters to do PL on, it should be all parameters but can also be
% a subset for testing purposes
% (Profile Likelihood parameters to Test)
stg.pltest = (1:15);

% How many points to do for each parameter in the PL
% (Profile Likelihood Resolution)
stg.plres = 20;

% True or false to decide whether to do plots after calculating PL
% (Profile Likelihood Plots)
stg.plplot = true;

% True or false to decide whether to run simulated annealing
% (Profile Likelihood Simulated Annealing)
stg.plsa = true;

% Options for simulated annealing
stg.plsao = optimoptions(@simulannealbnd,'Display','off', ...
    'MaxTime',5,'ReannealInterval',40);

% 0 or 1 to decide whether to run fmincon
% (Profile Likelihood FMincon)
stg.plfm = false;

% Options for fmincon
stg.plfmo = optimoptions('fmincon','Display','off',...
    'Algorithm','interior-point',...
    'MaxIterations',1,'OptimalityTolerance',0,...
    'StepTolerance',1e-6,'FiniteDifferenceType','central');

%% Optimization

%  Time for the optimization in seconds (fmincon does not respect this
% time!!)
% (Optimization time)
stg.optt = 60*5;

% Population size for the algorithms that use populations
% (Population size)
stg.popsize = 144;

% optimization start method, choose between:
% 1 Random starting point or group of starting points inside the bounds
% 2 Random starting point or group of starting points near the best point
% (Optimization start method)
stg.osm = 1;

% Distance from best parameter array to be used in stg.osm method 2
% (Distance from best parameter array)
stg.dbs = 0.1;

% True or false to decide whether to use Multistart
% (Multistart)
stg.mst = false;

% Multistart size
stg.msts = 1;

% True or false to decide whether to display Plots (Plots doesn't work if using
% multicore)
% (Optimization plots)
stg.optplots = true;

% True or false to decide whether to run fmincon (no gradient so this doesn't work
% very well, no max time!!)
stg.fmincon = false;

% Options for fmincon
% (fmincon options)
stg.fm_options = optimoptions('fmincon',...
    'Algorithm','interior-point',...
    'MaxIterations',2,'OptimalityTolerance',0,...
    'StepTolerance',1e-6,'FiniteDifferenceType','central',...
    'MaxFunctionEvaluations',10000);

% True or false to decide whether to run simulated annealing
% (Simulated annealing)
stg.sa = false;

% Options for simulated annealing
% (Simulated annealing options)
stg.sa_options = optimoptions(@simulannealbnd, ...
    'MaxTime',stg.optt,...
    'InitialTemperature',...
    ones(1,stg.parnum)*2,'ReannealInterval',40);

% True or false to decide whether to run Pattern search
% (Pattern search)
stg.psearch = false;

% Options for Pattern search
% (Pattern search options)
stg.psearch_options = optimoptions(@patternsearch,...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'UseCompletePoll',true,'UseCompleteSearch',true,...
    'MaxMeshSize',2,'MaxFunctionEvaluations',2000);

% True or false to decide whether to run Genetic algorithm
% (Genetic algorithm)
stg.ga = false;

% Options for Genetic algorithm
% (Genetic algorithm options)
stg.ga_options = optimoptions(@ga,'MaxGenerations',100,...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'PopulationSize',stg.popsize,...
    'MutationFcn','mutationadaptfeasible');

% True or false to decide whether to run Particle swarm
% (Particle swarm)
stg.pswarm = true;

% Options for Particle swarm
% (Particle swarm options)
stg.pswarm_options = optimoptions('particleswarm',...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'SwarmSize',stg.popsize);

% True or false to decide whether to run Surrogate optimization
% (Surrogate optimization)
stg.sopt = false;

% Options for Surrogate optimization
% (Surrogate optimization options)
stg.sopt_options = optimoptions('surrogateopt',...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'MaxFunctionEvaluations',5000,...
    'MinSampleDistance',0.2,'MinSurrogatePoints',32*2+1);
end