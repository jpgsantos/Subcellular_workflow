function rst = f_PL_m(settings,model_folder)
% This function performs profile likelihood (PL) optimization for a given
% model using two optimization algorithms: simulated annealing and fmincon.
% The function first finds the index of the starting point for PL
% calculation, prepares indices for parallel execution, and runs the
% optimization for each parameter in parallel. After the optimization, the
% results are assigned to the correct struct entries.
%
% INPUTS:
%   settings - A struct containing various settings for the
%   optimization process, such as pltest, plsa, plfm, lb, ub, and more.
%   model_folder  - A folder containing the model to be optimized.
%
% OUTPUTS:
%   rst - A struct containing the optimization results for both simulated
%   annealing and fmincon, including the optimized parameter values,
%   objective function values, and simulated data.
%
% FUNCTIONS CALLED:
%   get_PL_iter_start - Calculates the index closest to the best parameter
%   value.
%   f_PL_s - Runs the optimization for the given parameter index.
%   assign_struct_values - Assigns the values of x, fval, and simd to the
%   corresponding struct entries.
%   sim_a  - Runs simulated annealing optimization.
%   fmin_con - Runs fmincon optimization.
%   f_sim_score - Calculates the objective function score for a given set
%   of parameters.
%
% LOADED VARIABLES:
%   PL_iter_start - A vector containing the indices of the starting points
%   for PL calculation.
%   parfor_indices - A vector containing the indices for parallel
%   execution.
%   x, fval, simd - Cell arrays containing the optimization results for
%   each parameter.


% Find the index of the starting point for profile likelihood (PL)
% calculation
PL_iter_start = cellfun(@(x) get_PL_iter_start(x, settings), num2cell(settings.pltest));

% Prepare parfor loop indices
a = settings.plsa * (1:length(settings.pltest)*2);
b = settings.plfm * (length(settings.pltest)*2+1:length(settings.pltest)*4);
parfor_indices = [a(a ~= 0),b(b ~= 0)];

% Run the optimization for each parameter in parallel
parfor par_indx = parfor_indices
    [x{par_indx},fval{par_indx},simd{par_indx}] = f_PL_s(par_indx,PL_iter_start,settings,model_folder);
end


% Assign the values of x and fval to the correct struct entries
param_length = length(settings.pltest);
rst = assign_struct_values(PL_iter_start, settings, x, fval, simd, param_length);
end

function idx = get_PL_iter_start(x, settings)
% Calculate the index closest to the best parameter value
range = linspace(settings.lb(x), settings.ub(x), settings.plres + 1);
[~,idx] = min(abs(settings.bestpa(x) - range));
end

function rst = assign_struct_values(PL_iter_start, settings, x, fval, simd, param_length)
% Assign the values of x, fval, and simd to the corresponding struct
% entries

for par_indx = settings.pltest
    % Prepare array indices
    array1 = PL_iter_start(par_indx)-1:-1:1;
    array2 = PL_iter_start(par_indx):settings.plres+1;
    old_index1 = par_indx+param_length;
    old_index2 = par_indx+param_length*2;
    old_index3 = par_indx+param_length*3;

    % Assign values for simulated annealing
    if settings.plsa

        x{1,par_indx}{1}(array1) = x{1,old_index1}{1}(array1);
        fval{1,par_indx}{1}(array1) = fval{1,old_index1}{1}(array1);
        simd{1,par_indx}{1}(array1) = simd{1,old_index1}{1}(array1);
        rst.sa.xt(par_indx) = x{par_indx}(1);
        rst.sa.fvalt(par_indx) = fval{par_indx}(1);
        rst.sa.simdt(par_indx) = simd{par_indx}(1);
    end
    % Assign values for fmincon
    if settings.plfm

        x{1,par_indx}{2}(array1) = x{1,old_index3}{2}(array1);
        x{1,par_indx}{2}(array2) = x{1,old_index2}{2}(array2);
        fval{1,par_indx}{2}(array1) = fval{1,old_index3}{2}(array1);
        fval{1,par_indx}{2}(array2) = fval{1,old_index2}{2}(array2);
        simd{1,par_indx}{2}(array1) = simd{1,old_index3}{2}(array1);
        simd{1,par_indx}{2}(array2) = simd{1,old_index2}{2}(array2);

        rst.fm.xt(par_indx) = x{par_indx}(2);
        rst.fm.fvalt(par_indx) = fval{par_indx}(2);
        rst.fm.simdt(par_indx) = simd{par_indx}(2);
    end
end
end

function [x,fval,simd] = f_PL_s(par_indx,PL_iter_start,settings,model_folders)
% Run the optimization for the given parameter index
par_indx_helper = par_indx;

par_indx = mod(par_indx_helper-1, length(settings.pltest)) + 1;
PL_iter_start = PL_iter_start(par_indx);

if par_indx_helper <= length(settings.pltest)
    PL_iter(:) = PL_iter_start:settings.plres+1;
elseif par_indx_helper <= length(settings.pltest)*2
    PL_iter(:) = PL_iter_start-1:-1:1;
elseif par_indx_helper <= length(settings.pltest)*3
    PL_iter(:) = PL_iter_start:settings.plres+1;
else
    PL_iter(:) = PL_iter_start-1:-1:1;
end

% Set the parameter for profile likelihood calculations
settings.PLind = par_indx;

temp_array = settings.bestpa;
temp_array(par_indx) = [];
temp_lb = settings.lb;
temp_lb(par_indx) = [];
temp_up = settings.ub;
temp_up(par_indx) = [];

% Initialize variables
if settings.plsa
    x{1} = cell(settings.plres+1,1);
    fval{1} = zeros(settings.plres+1,1);
    simd{1}= cell(settings.plres+1,1);
    % Set the starting point of PL to the best solution found so far
    x{1}{PL_iter_start} = temp_array;
end
if settings.plfm
    x{2} = cell(settings.plres+1,1);
    fval{2} = zeros(settings.plres+1,1);
    simd{2}= cell(settings.plres+1,1);
    % Set the starting point of PL to the best solution found so far
    x{2}{PL_iter_start} = temp_array;
end

% Iterate over the PL values
for PL_iter_current = PL_iter

    % Set the value of the parameter that is being worked on
    settings.PLval = settings.lb(par_indx)+(settings.ub(par_indx)-settings.lb(par_indx))/...
        settings.plres*PL_iter_current-(settings.ub(par_indx)-settings.lb(par_indx))/settings.plres;

    % Set offset so each optimization allways starts from with the
    % appropriate parameter array
    if PL_iter_current == PL_iter_start
        offset = 0;
    elseif PL_iter_current > PL_iter_start
        offset = -1;
    elseif PL_iter_current < PL_iter_start
        offset = 1;
    end

    % Run simulated annealing if chosen in settings
    if par_indx_helper <= length(settings.pltest)*2 && settings.plsa
        [x{1}{PL_iter_current},fval{1}(PL_iter_current),simd{1}{PL_iter_current}] =...
            sim_a(PL_iter_current,PL_iter_start,x{1}{PL_iter_current+offset},temp_lb,temp_up,settings,model_folders);
        name = "simulated annealing";
        fval_show = fval{1}(PL_iter_current);
        % Run fmincon if chosen in settings
    elseif settings.plfm
        [x{2}{PL_iter_current},fval{2}(PL_iter_current),simd{2}{PL_iter_current}] =...
            fmin_con(PL_iter_current,PL_iter_start,x{2}{PL_iter_current+offset},temp_lb,temp_up,settings,model_folders);
        name = "fmincon";
        fval_show = fval{2}(PL_iter_current);
    end
    % Display console messages if chosen in settings
    if settings.placsl
        disp(name + "m: " + settings.PLind + "  n: " + PL_iter_current +...
            "  PLval: " + settings.PLval + "  fval: " + fval_show)
    end
end
end

function [x,fval,simd] =...
    sim_a(PL_iter_current,PL_iter_start,x,temp_lb,temp_up,settings,model_folders)
% Run simulated annealing optimizations

if PL_iter_current == PL_iter_start
    options = optimoptions(@simulannealbnd,'Display','off', ...
        'InitialTemperature',...
        ones(1,settings.parnum-1)*1,'MaxTime',7.5,'ReannealInterval',35);
else
    options = settings.plsao;

    % number of parameters changed from defenition in settings
    options.InitialTemperature = ones(1,settings.parnum-1)*1;
end
% Optimize the model
[x,fval] = simulannealbnd(@(x)f_sim_score(x,settings,model_folders),...
    x,temp_lb,temp_up,options);

[~,rst,~] = f_sim_score(x,settings,model_folders);
simd = rst.simd{1,1};
end

function [x,fval,simd] =...
    fmin_con(PL_iter_current,PL_iter_start,x,temp_lb,temp_up,settings,model_folders)
% Run fmincon optimization

if PL_iter_current == PL_iter_start
    options = optimoptions('fmincon','Display','off',...
        'Algorithm','interior-point',...
        'MaxIterations',20,'OptimalityTolerance',0,...
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