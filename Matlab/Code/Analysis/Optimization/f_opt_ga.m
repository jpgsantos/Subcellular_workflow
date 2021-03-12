function rst = f_opt_ga(stg)

% Set the randomm seed for reproducibility
rng(stg.rseed);

% Get the optimization options from settings
options = stg.ga_options;
options.MaxTime = stg.optt;
options.UseParallel = stg.optmc;
options.PopulationSize = stg.popsize;

% Display console messages if chosen in settings
if stg.optcsl
    options.Display = 'iter';
end

% Display plots if chosen in settings
if stg.optplots
    options.PlotFcn = {@gaplotbestf,...
        @gaplotexpectation,@gaplotrange,@gaplotscorediversity,...
        @gaplotstopping,@gaplotscores,@gaplotdistance,...
        @gaplotselection};
end

% Set the starting population for the optimization
[~,startpop] = f_opt_start(stg);
options.InitialPopulationMatrix = startpop;

% Optimize the model with multiple starting points if chosen in settings
if stg.mst
    parfor n = 1:stg.msts
        disp(string(n))
        [x(n,:),fval(n)] = ga(@(x)f_sim_score(x,stg),stg.parnum,...
            [],[],[],[],stg.lb,stg.ub,[],options);
    end
    
    % Optimize the model
else
    [x(1,:),fval(1)] = ga(@(x)f_sim_score(x,stg),stg.parnum,...
        [],[],[],[],stg.lb,stg.ub,[],options);
end

% Save results
rst.name = 'Genetic algorithm';
rst.x = x;
rst.fval = fval;
rst.exitflag = [];
rst.output = [];
end
