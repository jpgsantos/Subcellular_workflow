function rst = f_opt_pswarm(stg)

% Set the randomm seed for reproducibility
rng(stg.rseed);

% Get the optimization options from settings
options = stg.pswarm_options;
options.MaxTime = stg.optt;
options.UseParallel = stg.optmc;
options.SwarmSize = stg.popsize;

% Display console messages if chosen in settings
if stg.optcsl
    options.Display = 'iter';
end

% Display plots if chosen in settings
if stg.optplots
    options.PlotFcn = @pswplotbestf;
end

% Set the starting population for the optimization
[~,startpop] = f_opt_start(stg);
options.InitialSwarmMatrix = startpop;

% Optimize the model with multiple starting points if chosen in settings
if stg.mst
    parfor n = 1:stg.msts
        disp(string(n))
        [x(n,:),fval(n),exitflag(n),output(n)] =...
            particleswarm(@(x)f_sim_score(x,stg),...
            stg.parnum,stg.lb,stg.ub,options);
    end
    
    % Optimize the model
else
    [x(1,:),fval(1),exitflag(1),output(1)] =...
        particleswarm(@(x)f_sim_score(x,stg),...
        stg.parnum,stg.lb,stg.ub,options);
end

% Save results
rst.name = 'Particle swarm';
rst.x = x;
rst.fval = fval;
rst.exitflag = exitflag;
rst.output = output;
end