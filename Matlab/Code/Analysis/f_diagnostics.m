function rst = f_diagnostics(stg,mmf)

% Run the model and obtain scores for fitness Multi Core
if stg.optmc
    disp("Running the model and obtaining Scores (Multicore)")
    
    pa = stg.pa;
    % Iterate over the parameter arrays to be tested
    parfor n = stg.pat
        [~,rst(n),~] = f_sim_score(pa(n,:),stg,mmf);
    end
    
    % Run the model and obtain scores for fitness single Core
else
    disp("Running the model and obtaining Scores (Singlecore)")
    
    % Iterate over the parameter arrays to be tested
    for n = stg.pat
        [~,rst(n),~] = f_sim_score(stg.pa(n,:),stg,mmf);
    end
end
end