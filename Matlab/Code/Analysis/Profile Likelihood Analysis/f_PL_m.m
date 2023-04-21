function rst = f_PL_m(settings,model_folder)
% This function performs profile likelihood (PL) optimization for a given
% model using two optimization algorithms: simulated annealing and fmincon.
% The function first finds the index of the starting point for PL
% calculation, prepares indices for parallel execution, and runs the
% optimization for each parameter in parallel. After the optimization, the
% results are assigned to the correct struct entries.
%
% Inputs:
% - settings: A struct containing various settings for the
% optimization process, such as pltest, plsa, plfm, lb, ub, and more.
% - model_folder: A folder containing the model to be optimized.
%
% Outputs:
% - rst: A struct containing the optimization results for both simulated
% annealing and fmincon, including the optimized parameter values,
% objective function values, and simulated data.
%
% Used Functions:
% - get_PL_iter_start: Calculates the index closest to the best parameter
% value.
% - f_PL_s: Runs the optimization for the given parameter index.
% - assign_struct_values: Assigns the values of x, fval, and simd to the
% corresponding struct entries.
% - sim_a: Runs simulated annealing optimization.
% - fmin_con: Runs fmincon optimization.
% - f_sim_score: Calculates the objective function score for a given set
% of parameters.
%
% Loaded Variables:
% - PL_iter_start: A vector containing the indices of the starting points
% for PL calculation.
% - parfor_indices: A vector containing the indices for parallel
% execution.
% - x, fval, simd: Cell arrays containing the optimization results for
% each parameter.

% Find the index of the starting point for profile likelihood (PL)
% calculation
PL_iter_start = cellfun(@(x) get_PL_iter_start(x, settings), num2cell(settings.pltest));

% Prepare parfor loop indices
a = settings.plsa * (1:length(settings.pltest)*2);
b = settings.plfm * (length(settings.pltest)*2+1:length(settings.pltest)*4);
parfor_indices = [a(a ~= 0),b(b ~= 0)];

% Run the optimization for each parameter in parallel
% parfor_indices
parfor par_indx = parfor_indices
    % par_indx
    [x{par_indx},fval{par_indx},simd{par_indx},Pval{par_indx}] = f_PL_s(par_indx,PL_iter_start,settings,model_folder);
    % fval{par_indx}
end

% Assign the values of x and fval to the correct struct entries

param_length = length(settings.pltest);
rst = assign_struct_values(PL_iter_start, settings, x, fval, simd, Pval, param_length);
end

function idx = get_PL_iter_start(x, settings)
% Calculate the index closest to the best parameter value
range = linspace(settings.lb(x), settings.ub(x), settings.plres + 1);
[~,idx] = min(abs(settings.bestpa(x) - range));
end

function rst = assign_struct_values(PL_iter_start, settings, x, fval, simd, Pval, param_length)
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

        % disp("par_indx: " + par_indx)
        % disp(fval)
        % disp(fval{1,par_indx})
        % disp(fval{1,old_index1})

        % x{1,par_indx}{1}
        % x{1,old_index1}{1}
        % if fval{1,par_indx}(1) == 0 %% figure out this behaviour
        % x{1,par_indx}{1} = [x{1,old_index1}{1}';x{1,par_indx}{1}(2:end)'];
        % fval{1,par_indx}{1} = [fval{1,old_index1}{1}';fval{1,par_indx}{1}(2:end)'];
        % simd{1,par_indx}{1} = [simd{1,old_index1}{1}';simd{1,par_indx}{1}(2:end)'];
        % Pval{1,par_indx}{1} = [Pval{1,old_index1}{1}';Pval{1,par_indx}{1}(2:end)'];
        % else
        x{1,par_indx}{1} = [flip(x{1,old_index1}{1}');x{1,par_indx}{1}'];
        fval{1,par_indx}{1} = [flip(fval{1,old_index1}{1}');fval{1,par_indx}{1}'];
        simd{1,par_indx}{1} = [flip(simd{1,old_index1}{1}');simd{1,par_indx}{1}'];
        Pval{1,par_indx}{1} = [flip(Pval{1,old_index1}{1}');Pval{1,par_indx}{1}'];
        % end

        % x{1,par_indx}{1}(array1) = x{1,old_index1}{1}(array1);
        % fval{1,par_indx}{1}(array1) = fval{1,old_index1}{1}(array1);
        % simd{1,par_indx}{1}(array1) = simd{1,old_index1}{1}(array1);
        rst.sa.xt(par_indx) = x{par_indx}(1);
        rst.sa.fvalt(par_indx) = fval{par_indx}(1);
        rst.sa.simdt(par_indx) = simd{par_indx}(1);
        rst.sa.Pval(par_indx) = Pval{par_indx}(1);
    end
    % Assign values for fmincon
    if settings.plfm

        x{1,par_indx}{2} = [flip(x{1,old_index3}{2}');x{1,old_index2}{2}'];
        fval{1,par_indx}{2} = [flip(fval{1,old_index3}{2}');fval{1,old_index2}{2}'];
        simd{1,par_indx}{2} = [flip(simd{1,old_index3}{2}');simd{1,old_index2}{2}'];
        Pval{1,par_indx}{2} = [flip(Pval{1,old_index3}{2}');Pval{1,old_index2}{2}'];

        % x{1,par_indx}{2}(array1) = x{1,old_index3}{2}(array1);
        % x{1,par_indx}{2}(array2) = x{1,old_index2}{2}(array2);
        % fval{1,par_indx}{2}(array1) = fval{1,old_index3}{2}(array1);
        % fval{1,par_indx}{2}(array2) = fval{1,old_index2}{2}(array2);
        % simd{1,par_indx}{2}(array1) = simd{1,old_index3}{2}(array1);
        % simd{1,par_indx}{2}(array2) = simd{1,old_index2}{2}(array2);



        rst.fm.xt(par_indx) = x{par_indx}(2);
        rst.fm.fvalt(par_indx) = fval{par_indx}(2);
        rst.fm.simdt(par_indx) = simd{par_indx}(2);
        rst.fm.Pval(par_indx) = Pval{par_indx}(2);
    end
end
end

function [x,fval,simd,Pval] = f_PL_s(par_indx,PL_iter_start,settings,model_folders)
% Run the optimization for the given parameter index
par_indx_helper = par_indx;

par_indx = mod(par_indx_helper-1, length(settings.pltest)) + 1;
PL_iter_start = PL_iter_start(par_indx);
% PL_iter_start = 1;

if par_indx_helper <= length(settings.pltest)
    PL_iter(:) = PL_iter_start:settings.plres+1;
    sortes = 1;
elseif par_indx_helper <= length(settings.pltest)*2
    sortes = -1;
    PL_iter(:) = PL_iter_start-1:-1:1;
elseif par_indx_helper <= length(settings.pltest)*3
    PL_iter(:) = PL_iter_start:settings.plres+1;
    sortes = 1;
else
    sortes = -1;
    PL_iter(:) = PL_iter_start-1:-1:1;
end

PL_iter_start = 1;

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

    x{1} = [];
    fval{1} = [];
    simd{1} = [];
    Pval{1} = [];
    % x{1} = cell(length(PL_iter),1);
    % fval{1} = zeros(length(PL_iter),1);
    % simd{1} = cell(length(PL_iter),1);
    % Pval{1} = zeros(length(PL_iter),1);
    % Set the starting point of PL to the best solution found so far
    x{1}{PL_iter_start} = temp_array;
end
% x{1}
if settings.plfm

    x{2} = [];
    fval{2} = [];
    simd{2} = [];
    Pval{2} = [];



    % x{2} = cell(length(PL_iter),1);
    % fval{2} = zeros(length(PL_iter),1);
    % simd{2}= cell(length(PL_iter),1);
    % Set the starting point of PL to the best solution found so far
    x{2}{PL_iter_start} = temp_array;
end

offset = 0;
prev_fval_sa = inf;
prev_fval_fm = inf;
% PL_iter
offset_2 = 0;

ratio = 1.25;

% disp(PL_iter)

% Iterate over the PL values
for PL_iter_current = PL_iter

    % Set the value of the parameter that is being worked on
    settings.PLval = settings.lb(par_indx)+(settings.ub(par_indx)-settings.lb(par_indx))/...
        settings.plres*PL_iter_current-(settings.ub(par_indx)-settings.lb(par_indx))/settings.plres;

    inter_step = 4;
    repeat = false;
    repeat_2 = false;
    repeat_3 = false;
    while inter_step <= 4
        % disp("inter_step  "+inter_step)
        % disp("repeat  "+repeat)

        % Run simulated annealing if chosen in settings
        % if par_indx_helper <= length(settings.pltest)*2 && settings.plsa
        % disp("sortes")
        if inter_step == 1 || inter_step == 3

            % disp("yey 2")
            if par_indx_helper <= length(settings.pltest)*2 && settings.plsa
                [x{1}{PL_iter_start+offset},fval{1}(PL_iter_start+offset),simd{1}{PL_iter_start+offset}] =...
                    sim_a(PL_iter_start+offset,PL_iter_start,x{1}{PL_iter_start+offset_2},temp_lb,temp_up,settings,model_folders);
                name = "simulated annealing";
                fval_show = fval{1}(PL_iter_start+offset);
                prev_fval_sa = fval{1}(PL_iter_start+offset);
                Pval{1}(PL_iter_start+offset) = settings.PLval;
            elseif settings.plfm
                [x{2}{PL_iter_start+offset},fval{2}(PL_iter_start+offset),simd{2}{PL_iter_start+offset}] =...
                    fmin_con(PL_iter_start+offset,PL_iter_start,x{2}{PL_iter_start+offset_2},temp_lb,temp_up,settings,model_folders);
                name = "fmincon";
                fval_show = fval{2}(PL_iter_start+offset);
                prev_fval_sa = fval{2}(PL_iter_start+offset);
                Pval{2}(PL_iter_start+offset) = settings.PLval;
            end

            if inter_step == 1
                repeat = true;
            else
                repeat_3 = true;
            end

            
            disp(name + " m: " + settings.PLind + "  n: " + PL_iter_current +"."+ inter_step +...
                "  PLval: " + settings.PLval + "  fval: " + fval_show)

            offset_2 = offset;
            offset = offset+1;

            settings.PLval = settings.PLval + sortes*(settings.ub(par_indx) - settings.lb(par_indx)) / settings.plres * 0.25;
            inter_step = inter_step +1;

        elseif inter_step == 2
            % disp("yey 1")

            if par_indx_helper <= length(settings.pltest)*2 && settings.plsa
                [score,~,~] = f_sim_score(x{1}{PL_iter_start+offset_2}, settings, model_folders);
            elseif settings.plfm
                [score,~,~] = f_sim_score(x{2}{PL_iter_start+offset_2}, settings, model_folders);
            end

            % disp("1.1 " + score)
            % disp("1.2 " + prev_fval_sa)
            if score < ratio * prev_fval_sa && ~repeat_2 || repeat && ~repeat_2

                

                % disp("yey 1.1")
            if par_indx_helper <= length(settings.pltest)*2 && settings.plsa
                [x{1}{PL_iter_start+offset},fval{1}(PL_iter_start+offset),simd{1}{PL_iter_start+offset}] =...
                    sim_a(PL_iter_start+offset,PL_iter_start,x{1}{PL_iter_start+offset_2},temp_lb,temp_up,settings,model_folders);
                name = "simulated annealing";
                fval_show = fval{1}(PL_iter_start+offset);
                prev_fval_sa = fval{1}(PL_iter_start+offset);
                Pval{1}(PL_iter_start+offset) = settings.PLval;
            elseif settings.plfm
                [x{2}{PL_iter_start+offset},fval{2}(PL_iter_start+offset),simd{2}{PL_iter_start+offset}] =...
                    fmin_con(PL_iter_start+offset,PL_iter_start,x{2}{PL_iter_start+offset_2},temp_lb,temp_up,settings,model_folders);
                name = "fmincon";
                fval_show = fval{2}(PL_iter_start+offset);
                prev_fval_sa = fval{2}(PL_iter_start+offset);
                Pval{2}(PL_iter_start+offset) = settings.PLval;
           end


                % inter_step = -1;
                
                disp(name + " m: " + settings.PLind + "  n: " + PL_iter_current+"."+inter_step +...
                    "  PLval: " + settings.PLval + "  fval: " + fval_show)
                offset_2 = offset;
                offset = offset+1;

                inter_step = inter_step +2;
                settings.PLval = settings.PLval + sortes*(settings.ub(par_indx) - settings.lb(par_indx)) / settings.plres * 0.5;
                repeat_2 = true;
            else

                if repeat || repeat_2
                    settings.PLval = settings.PLval + sortes*(settings.ub(par_indx) - settings.lb(par_indx)) / settings.plres * 0.25;
                    inter_step = inter_step +1;
                else
                    settings.PLval = settings.PLval - sortes*(settings.ub(par_indx) - settings.lb(par_indx)) / settings.plres * 0.25;
                    inter_step = inter_step -1;
                end
            end
        else
            % disp("yey 0")

            if par_indx_helper <= length(settings.pltest)*2 && settings.plsa
                [score,~,~] = f_sim_score(x{1}{PL_iter_start+offset_2}, settings, model_folders);
            elseif settings.plfm
                [score,~,~] = f_sim_score(x{2}{PL_iter_start+offset_2}, settings, model_folders);
            end
            % disp("2 " + score)
            % disp("2 " + prev_fval_sa)

            if score < ratio * prev_fval_sa || repeat_3

                

                % disp("yey 0.1")

            if par_indx_helper <= length(settings.pltest)*2 && settings.plsa
                [x{1}{PL_iter_start+offset},fval{1}(PL_iter_start+offset),simd{1}{PL_iter_start+offset}] =...
                    sim_a(PL_iter_start+offset,PL_iter_start,x{1}{PL_iter_start+offset_2},temp_lb,temp_up,settings,model_folders);
                name = "simulated annealing";
                fval_show = fval{1}(PL_iter_start+offset);
                prev_fval_sa = fval{1}(PL_iter_start+offset);
                Pval{1}(PL_iter_start+offset) = settings.PLval;
            elseif settings.plfm
                [x{2}{PL_iter_start+offset},fval{2}(PL_iter_start+offset),simd{2}{PL_iter_start+offset}] =...
                    fmin_con(PL_iter_start+offset,PL_iter_start,x{2}{PL_iter_start+offset_2},temp_lb,temp_up,settings,model_folders);
                name = "fmincon";
                fval_show = fval{2}(PL_iter_start+offset);
                prev_fval_sa = fval{2}(PL_iter_start+offset);
                Pval{2}(PL_iter_start+offset) = settings.PLval;
            end

                % prev_fval_sa = fval{1}(PL_iter_start+offset);
                
                disp(name + " m: " + settings.PLind + "  n: " + PL_iter_current+"."+inter_step +...
                    "  PLval: " + settings.PLval + "  fval: " + fval_show)

                inter_step = 5;
                offset_2 = offset;
                offset = offset+1;
            else
                if repeat
                    settings.PLval = settings.PLval - sortes*(settings.ub(par_indx) - settings.lb(par_indx)) / settings.plres * 0.25;

                    inter_step = inter_step -1;
                else

                    settings.PLval = settings.PLval - sortes*(settings.ub(par_indx) - settings.lb(par_indx)) / settings.plres * 0.5;

                    inter_step = inter_step -2;
                end

            end
        end
        % end
    end

    % Run fmincon if chosen in settings
    % if settings.plfm
    %     [x{2}{PL_iter_current},fval{2}(PL_iter_current),simd{2}{PL_iter_current}] =...
    %         fmin_con(PL_iter_current,PL_iter_start,x{2}{PL_iter_start+offset},temp_lb,temp_up,settings,model_folders);
    %     name = "fmincon";
    %     fval_show = fval{2}(PL_iter_current);
    % 
    %     % if fval_temp < 2 * prev_fval_fm
    %     %     if PL_iter_current > PL_iter_start
    %     %         offset = offset-1;
    %     %     elseif PL_iter_current < PL_iter_start
    %     %         offset =offset+ 1;
    %     %     end
    %     %     prev_fval_fm = fval{2}(PL_iter_current);
    %     %     inter_step = 3;
    %     % end
    % end

    % Display console messages if chosen in settings
    % if settings.placsl
    %     disp(name + "m: " + settings.PLind + "  n: " + PL_iter_current +...
    %         "  PLval: " + settings.PLval + "  fval: " + fval_show)
    % end

    % x{1}
    % fval{1}
    % fval{1}(PL_iter_start+offset)
end
end

function [x,fval,simd] =...
    sim_a(PL_iter_current,PL_iter_start,x,temp_lb,temp_up,settings,model_folders)
% Run simulated annealing optimizations
% disp("why???")
if PL_iter_current == PL_iter_start
    options = optimoptions(@simulannealbnd,'Display','off', ...
        'InitialTemperature',...
        ones(1,settings.parnum-1)*1,'MaxTime',5,'ReannealInterval',40);
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
        'MaxIterations',3,'OptimalityTolerance',0,...
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