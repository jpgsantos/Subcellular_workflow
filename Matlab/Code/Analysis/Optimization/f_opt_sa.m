function rst = f_opt_sa(stg)

% Set the randomm seed for reproducibility
rng(stg.rseed);

% Set the starting point for the optimization
[startpoint,~] = f_opt_start(stg);

% Get the optimization options from settings
options = stg.sa_options;
options.MaxTime = stg.optt;
options.InitialTemperature = ones(1,stg.parnum)*2;

% Display console messages if chosen in settings
if stg.optcsl
    options.Display = 'iter';
end

% Display plots if chosen in settings
if stg.optplots
    options.PlotFcn =...
        {@saplotbestf,@saplottemperature,@saplotf,@saplotstopping,@saplotx};
end

% Optimize the model with multiple starting points if chosen in settings
if stg.mst
    parfor n = 1:stg.msts
        disp(string(n))
        [x(n,:),fval(n),exitflag(n),output(n)] =...
            simulannealbnd(@(x)f_sim_score(x,stg),startpoint(n,:),...
            stg.lb,stg.ub,options);
    end
    
    % Optimize the model
else
    [x(1,:),fval(1),exitflag(1),output(1)] =...
        simulannealbnd(@(x)f_sim_score(x,stg),startpoint(1,:),...
        stg.lb,stg.ub,options);
end

% Save results
rst.name = 'Simulated annealing';
rst.x = x;
rst.fval = fval;
rst.exitflag = exitflag;
rst.output = output;
end