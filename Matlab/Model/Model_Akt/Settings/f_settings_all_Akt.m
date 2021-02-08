function [stg] = f_settings_all_Akt()

%% Import

% True or false to decide whether to run import functions
% (Import)
stg.import = true;

% Name of the folder where everything related to the model is stored
% (Folder Model)
stg.folder_model = "Model_Akt";

% Name of the excel file with the sbtab
% (SBtab excel name)
% stg.sbtab_excel_name = "SBTAB_Akt_Benchmark_Paper.xlsx";
stg.sbtab_excel_name = "SBTAB_Akt_Original_Paper.xlsx";
% stg.sbtab_excel_name = "SBTAB_Akt.xlsx";

% Name of the model
% (Name)
stg.name = "Akt";

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
stg.exprun = [1:6];

% Choice between 0,1,2 and 3 to change either and how to apply log10 to the
% scores (check documentation)
% (Use logarithm)
stg.useLog = 0;

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
stg.optcsl = true;

% True or false to decide whether to display PLA results on console 
% (PLA console)
stg.placsl = true;

% True or false to decide whether to save results
% (Save results)
stg.save_results = true;

%% Simulation

% Maximum time for each individual function to run in seconds
% (Maximum time)
stg.maxt = 2;

% Equilibration time
% (Equilibration time)
stg.eqt  = 500000;

% True or false to decide whether to do Dimensional Analysis
% (Dimensional Analysis)
stg.dimenanal = false;

% True or false to decide whether to do Unit conversion
% (Unit conversion)
stg.UnitConversion = false;

% True or false to decide whether to do Absolute Tolerance Scaling
% (Absolute Tolerance Scaling)
stg.abstolscale = false;

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

% Max step size in the simulation (if empty matlab decides whats best)
% (Maximum step)
stg.maxstep = 0.1;

% Max step size in the equilibration (if empty matlab decides whats best)
% (Maximum step)
stg.maxstepeq = [];

%% Model

% Number of parameters to optimize
% (Parameter number)
stg.parnum = 13;
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
stg.lb = zeros(1,stg.parnum)-15;
stg.lb = [-2.17	-1.39	-4.81	-2.29	-1.51	-1.001220343	-5.68	-14.29	-2.92	-1.48	-2.95	-1.72	-3.97311552]-5;


% Array with the upper bound of all parameters
% (Upper bound)
stg.ub = zeros(1,stg.parnum);
stg.ub = [-2.17	-1.39	-4.81	-2.29	-1.51	-1.001220343	-5.68	-14.29	-2.92	-1.48	-2.95	-1.72	-3.97311552]+5;

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
stg.partest(:,1) = [1  ,2  ,3  ,4  ,5  ,6  ,7 , 8, 9, 10, 11, 12, 13, 13];

% stg.ms.partest(:,1) = [0  ,0  ,0  ,0  ,0  ,0  ,0 ,0 ,1 ,2,...
%                        3  ,4  ,5];

% (Parameter array to test)
stg.pat = [1:5];

% All the parameter arrays, in this case there is only one
% (Parameter arrays)

 stg.pa(1,:) = [-2.17	-1.39	-4.81	-2.29	-1.51	-1.001220343	-5.68	-14.29	-2.92	-1.48	-2.95	-1.72	-3.97311552];



% stg.pa(2,:) = [-5.55989864063675,-0.304770080707731,-0.00658873778774330,-0.751543966569368,-4.98658661325973,-10.8262084004129,-2.29017776576445,-5.27676773486169,0,0,-15,-2.29848180793148,-15];
% stg.pa(3,:) = [2.52723394542574,-4.55505147319531,-0.508920962541255,-2.80904902696491,-2.78423589157333,3.29839063037336,-6.08739787954387,-15.4356313371592,-1.48298228662005,-2.27123548566604,-4.11054759435246,0.0669116808884676,-5.01069168359839];

% Optimizations to data original paper
% stg.pa(2,:) = [1.99837860346525,3.21773531642498,-2.99664576051094,-6.52386464561841,3.49000000000000,2.02764930598593,-6.12920049542838,-10.4755549637193,-2.48843433155426,-2.38761738101395,-6.89157363585962,-1.02992025985209,-8.97311552000000];
% stg.pa(3,:) = [-1.49830220718445,3.08176169392623,-0.192999950971736,0.511590618199776,-4.28427284255222,2.60436602629108,-3.54799250776456,-18.6786992697209,2.02647615119919,-2.27148623596889,-5.76903833495506,2.01275872425698,-6.65680299930502];
% stg.pa(4,:) = [-1.08189084062624,2.77116025161156,-0.882459000891841,1.21919779816695,3.49000000000000,3.99877965700000,-6.34890841777506,-14.8100080382540,1.97658603002814,-2.31180455641675,-4.94743961344063,1.77869882289393,-4.35356222391737];
% stg.pa(5,:) = [-2.18592023435350,-6.33909044368424,-1.63175897366133,-5.02359007348132,0.725767874904394,3.48921008481977,-6.12006114923630,-14.3122208580753,-2.38759464662146,-2.56217315554390,-3.86937752855892,0.709870652418509,-5.02041660809796];

% Optimizations to simulation original paper
% stg.pa(2,:) = [-1.89227085497569,-4.48303715317315,0.0616368030770105,-7.29000000000000,-2.12841892650954,-6.00122034300000,-6.31852693033387,-17.3120880907022,1.94467260523005,-0.775237562826922,-7.95000000000000,-6.30754709193510,-5.20959696083613];
% stg.pa(3,:) = [-0.0685366415740916,-3.47194708816951,-8.00969019290340,-4.53626187222746,-2.88735985442792,-0.0264477979967523,-3.20073728709933,-15.8712858424029,-2.23315342167283,-2.32313594328000,-6.13856554142474,-1.43196217714402,-6.88990704863003];
% stg.pa(4,:) = [2.23072316367629,-6.39000000000000,-1.69434497668317,2.44537746256714,3.49000000000000,3.97221863948802,-6.15206280676003,-17.0382834312995,-0.874136953669974,-3.06720864418238,-5.51323112373631,-1.24949652340966,-6.31424850445345];

% 30 min opt simulation original paper [13,15,17]

% ga
stg.pa(2,:) = [-2.42086540715786,-3.24935270591300,-5.50358814873804,-0.429732350989125,1.61687534421345,-0.663798737879993,-6.01233507106336,-12.6510728391742,-2.39679870776973,-2.18053030812925,-3.80541273616045,-1.44306051512632,-4.57843114427860];
%  pswarm
stg.pa(3,:) = [-2.40121981171952,-6.38531416410197,-1.09875841618271,2.71000000000000,3.42165963705401,3.81277306775525,-5.99154979112011,-19.2900000000000,-2.61470175382565,-2.42179553929476,-3.46177378947215,2.29487623762162,-4.25692493371163];

% 6 min opt simulation original paper [13,15,17]

% ga
% stg.pa(4,:) = [0.460091188408843,-4.51949651377491,-1.04525663437632,0.472604668797392,-1.21192897513094,2.67679610417683,-5.71511687251067,-12.8861546891721,-0.983859957403389,-0.390199125867816,-2.44091458528477,2.43619390801676,0.973421282448140];
% stg.pa(2,:) = [-2.43	-2.64	-3.03	4.79	-0.36	-1.520638112	-5.49	-3.40	-5.26	-1.93	-3.02	-1.54	-2.823908741];

% 60 min opt simulation original paper [13,15,17]

% ga
stg.pa(4,:) = [-2.52416346057154,-1.74687101060155,-2.39377872648839,2.43117095384644,-1.02177945056860,-1.01837219271408,-3.89593620393162,-9.61268781923547,-4.55367200318144,-2.08499567449054,-2.49615183591973,0.653630312903766,-8.95582638514125];

% 60 min opt data original paper [13,15,17]

% ga
stg.pa(5,:) = [-1.77876614157772,-1.44851940922699,-4.57839868067720,-7.10911954606339,-1.52901534196175,0.273623152056231,-5.01524543004682,-14.5741990930338,-3.51849568444816,-2.02136632461335,-2.59671512270533,-1.42779571793519,-3.58800874192562];

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
stg.pltest = (1:13);

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
    'InitialTemperature',...
    ones(1,stg.parnum)*1,'MaxTime',1,'ReannealInterval',40);

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
stg.optt = 60*60;

% Population size for the algorithms that use populations
% (Population size)
stg.popsize = 1080;

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
    'UseParallel',stg.optmc,...
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
stg.ga = true;

% Options for Genetic algorithm
% (Genetic algorithm options)
stg.ga_options = optimoptions(@ga,'MaxGenerations',100,...
    'MaxTime',stg.optt,'UseParallel',stg.optmc,...
    'PopulationSize',stg.popsize,...
    'MutationFcn','mutationadaptfeasible','Display','diagnose');

% True or false to decide whether to run Particle swarm
% (Particle swarm)
stg.pswarm = false;

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