function rst = f_sim(exp_n,stg,rt,rst)

% Save variables that need to be mantained over multiple function calls
persistent model_run

% If the function is called for the first time, load the appropriate model
% and compile the code for simulation run
if isempty(model_run)
    
    %Generate an empty array to be populated with the model suited for each
    %equilibration and experiment%
    model_run = cell(1,stg.expn*2);
        
    % Iterate over the experiments thar are being run
    for n = stg.ms.exprun
        
        % Load the models for equilibrium
            load("Model/" +stg.folder_model + "/Data/exp/Model_eq_" + stg.name +...
                "_" + n + ".mat",'model_exp')
        
        % Place the loaded models in the correct place in the array, models
        % for equilibrium are set to be on the second half of the array
        model_run{n+stg.expn} = model_exp;
        
        % Compile the matlab code that is going to simulate the model using
        % matlab built in function if the option is selected in settings
        if stg.ms.sbioacc
            sbioaccelerate(model_run{n+stg.expn});
        end
        
        % Load the models for main run
            load("Model/" +stg.folder_model + "/Data/exp/Model_" + stg.name +... 
                "_" + n + ".mat",'model_exp')
        
        % Place the loaded models in the correct place in the array, models
        % for main run are set to be on the first half of the array
        model_run{n} = model_exp;
        
        % Compile the matlab code that is going to simulate the model using
        % matlab built in function if the option is selected in settings
        if stg.ms.sbioacc
            sbioaccelerate(model_run{n});
        end
    end
end

% Iterate over the species in the model 
for k = 1:size(rt.ssa(:,exp_n),1)
    
    % If the values after equilibration are to low set the start amount of
    % the species in the model to 0 to avoid numerical problems
    if rt.ssa(k,exp_n) < 1.0e-15
        model_run{exp_n}.species(k).InitialAmount = 0;
        
    % Else substitute the start amount of the species in the model with the 
    % correct ones for  simulations
    else
        model_run{exp_n}.species(k).InitialAmount =...
            rt.ssa(k,exp_n);
    end
end

% Substitute the values of the parameters in the model for the correct
% one for simultaions
for i = 1:size(rt.par,1)
    model_run{exp_n}.parameters(i).value = rt.par(i);
end

%simulate the model using matlab built in function
rst.simd{exp_n} = sbiosimulate(model_run{exp_n});

end