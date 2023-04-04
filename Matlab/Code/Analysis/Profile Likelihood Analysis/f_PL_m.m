function rst = f_PL_m(settings,model_folder)

% Iterate over the parameters for which PL is going to be calculated
for par_indx = settings.pltest

    % Find the index of the starting point for PL taking into consideration
    % the lower bound and upper bound of the parameter and number of points
    % to be calculated
    [~,PL_iter_start{par_indx}] = min(abs(settings.bestpa(par_indx) -...
        (settings.lb(par_indx):(settings.ub(par_indx) - settings.lb(par_indx))/settings.plres:settings.ub(par_indx))));
end

% Iterate over the parameters for which PL is going to be calculated
if settings.plsa
a = 1:length(settings.pltest)*2;
else
a =[];
end
if settings.plfm
b = length(settings.pltest)*2+1:length(settings.pltest)*4;
else
b = [];
end

parfor par_indx = [a,b]
    [x{par_indx},fval{par_indx},simd{par_indx}] = f_PL_s(par_indx,PL_iter_start,settings,model_folder);
end

leng =length(settings.pltest);

for par_indx = 1:leng
if settings.plsa
    x{1,par_indx}{1}(PL_iter_start{par_indx}-1:-1:1) = x{1,par_indx+leng}{1}(PL_iter_start{par_indx}-1:-1:1);
    fval{1,par_indx}{1}(PL_iter_start{par_indx}-1:-1:1) = fval{1,par_indx+leng}{1}(PL_iter_start{par_indx}-1:-1:1);
    simd{1,par_indx}{1}(PL_iter_start{par_indx}-1:-1:1) = simd{1,par_indx+leng}{1}(PL_iter_start{par_indx}-1:-1:1);
end
if settings.plfm
    x{1,par_indx}{2}(PL_iter_start{par_indx}:settings.plres+1) = x{1,par_indx+leng*2}{2}(PL_iter_start{par_indx}:settings.plres+1);
    x{1,par_indx}{2}(PL_iter_start{par_indx}-1:-1:1) = x{1,par_indx+leng*2}{2}(PL_iter_start{par_indx}-1:-1:1);
    fval{1,par_indx}{2}(PL_iter_start{par_indx}:settings.plres+1) = fval{1,par_indx+leng*2}{2}(PL_iter_start{par_indx}:settings.plres+1);
    fval{1,par_indx}{2}(PL_iter_start{par_indx}-1:-1:1) = fval{1,par_indx+leng*3}{2}(PL_iter_start{par_indx}-1:-1:1);
    simd{1,par_indx}{2}(PL_iter_start{par_indx}:settings.plres+1) = simd{1,par_indx+leng*2}{2}(PL_iter_start{par_indx}:settings.plres+1);
    simd{1,par_indx}{2}(PL_iter_start{par_indx}-1:-1:1) = simd{1,par_indx+leng*2}{2}(PL_iter_start{par_indx}-1:-1:1);
end
end

% Assign the values of x and fval to the correct struct entries, this needs
% to be done because struct assignemnts don't work inside parfor loop
for n = settings.pltest
    if settings.plsa
        rst.sa.xt(n) = x{n}(1);
        rst.sa.fvalt(n) = fval{n}(1);
        rst.sa.simdt(n) = simd{n}(1);
    end
    if settings.plfm
        rst.fm.xt(n) = x{n}(2);
        rst.fm.fvalt(n) = fval{n}(2);
        rst.fm.simdt(n) = simd{n}(2);
    end
end
end

function [x,fval,simd] = f_PL_s(par_indx,PL_iter_start,settings,model_folders)
par_indx_helper = par_indx;

if par_indx_helper <= length(settings.pltest)
    PL_iter_start = PL_iter_start{par_indx};
    PL_iter(:) = PL_iter_start:settings.plres+1;
elseif par_indx_helper <= length(settings.pltest)*2
    par_indx = par_indx-length(settings.pltest);
    PL_iter_start = PL_iter_start{par_indx};
    PL_iter(:) = PL_iter_start-1:-1:1;
elseif par_indx_helper <= length(settings.pltest)*3
    par_indx = par_indx-length(settings.pltest)*2;
    PL_iter_start = PL_iter_start{par_indx};
    PL_iter(:) = PL_iter_start:settings.plres+1;
else
    par_indx = par_indx-length(settings.pltest)*3;
    PL_iter_start = PL_iter_start{par_indx};
    PL_iter(:) = PL_iter_start-1:-1:1;
end

%Set the parameter for which we are going to perform the profile Likelihood
%calculations to the correct one
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



%  Iterate over the values for which PL is going to be calculated starting
%  at the best value going up until the upper bound is reached, going back
%  to the best and going down until the lower bound is reached
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

    if par_indx_helper <= length(settings.pltest)*2
        % Run simulated annealing if chosen in settings
        if settings.plsa
            [x{1}{PL_iter_current},fval{1}(PL_iter_current),simd{1}{PL_iter_current}] =...
                sim_a(PL_iter_current,PL_iter_start,x{1}{PL_iter_current+offset},temp_lb,temp_up,settings,model_folders);
            name = "simulated annealing";
            fval_show = fval{1}(PL_iter_current);
        end
    else
        % Run fmincon if chosen in settings
        if settings.plfm
            [x{2}{PL_iter_current},fval{2}(PL_iter_current),simd{2}{PL_iter_current}] =...
                fmin_con(PL_iter_current,PL_iter_start,x{2}{PL_iter_current+offset},temp_lb,temp_up,settings,model_folders);
            name = "fmincon";
            fval_show = fval{2}(PL_iter_current);
        end
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
% Get the optimization options from settings

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

