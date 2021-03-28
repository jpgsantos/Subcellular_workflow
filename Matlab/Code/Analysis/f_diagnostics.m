function rst = f_diagnostics(stg)

% Run the model and obtain scores for fitness Multi Core
if stg.optmc
    disp("Running the model and obtaining Scores (Multicore)")
    
    % Iterate over the parameter arrays to be tested
    parfor n = stg.pat
        [~,rst(n),~] = f_sim_score(stg.pa(n,:),stg);
    end
    
    % Run the model and obtain scores for fitness single Core
else
    disp("Running the model and obtaining Scores (Singlecore)")
    
    % Iterate over the parameter arrays to be tested
    for n = stg.pat
        [~,rst(n),~] = f_sim_score(stg.pa(n,:),stg);
    end
end
end