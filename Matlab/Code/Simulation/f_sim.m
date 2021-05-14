function rst = f_sim(exp_n,stg,rt,rst)

% Save variables that need to be mantained over multiple function calls
persistent model_run
persistent config_run

% If the function is called for the first time, load the appropriate model
% and compile the code for simulation run
if isempty(model_run)
    
    %Generate an empty array to be populated with the model suited for each
    %equilibration and experiment%
    model_run = cell(1,stg.expn*2);
    config_run = cell(1,stg.expn*2);
    
    % Iterate over the experiments thar are being run
    for n = stg.exprun
        
        if stg.simdetail
            % Load the models for equilibrium
            load("Model/" +stg.folder_model + "/Data/exp/Model_diag_" + stg.name +...
                "_" + n + ".mat",'model_exp','config_exp')

            % Place the loaded models in the correct place in the array,
            % models for equilibrium are set to be on the second half of
            % the array
            model_run{n+2*stg.expn} = model_exp;
            config_run{n+2*stg.expn} = config_exp;
            
            % Compile the matlab code that is going to simulate the model
            % using matlab built in function if the option is selected in
            % settings
            if stg.sbioacc
                sbioaccelerate(model_run{n+2*stg.expn},config_run{n+2*stg.expn});
            end
        end
        % Load the models for equilibrium
        load("Model/" +stg.folder_model + "/Data/exp/Model_eq_" + stg.name +...
            "_" + n + ".mat",'model_exp','config_exp')
        %         load("Model/" +stg.folder_model + "/Data/exp/Model_diag_"
        %         + stg.name +...
        %             "_" + n + ".mat",'model_exp')
        
        % Place the loaded models in the correct place in the array, models
        % for equilibrium are set to be on the second half of the array
        model_run{n+stg.expn} = model_exp;
        config_run{n+stg.expn} = config_exp;
        
        % Compile the matlab code that is going to simulate the model using
        % matlab built in function if the option is selected in settings
        if stg.sbioacc
            sbioaccelerate(model_run{n+stg.expn},config_run{n+stg.expn});
        end
        
        % Load the models for main run
        load("Model/" +stg.folder_model + "/Data/exp/Model_" + stg.name +...
            "_" + n + ".mat",'model_exp','config_exp')
        
        % Place the loaded models in the correct place in the array, models
        % for main run are set to be on the first half of the array
        model_run{n} = model_exp;
        config_run{n} = config_exp;
        
        % Compile the matlab code that is going to simulate the model using
        % matlab built in function if the option is selected in settings
        if stg.sbioacc
            sbioaccelerate(model_run{n},config_run{n});
        end
    end
end

% substitute the start amount of the species in the model with the correct
% ones for  simulations
set(model_run{exp_n}.species(1:size(rt.ssa(:,exp_n),1)),{'InitialAmount'},num2cell(rt.ssa(:,exp_n)))

% Substitute the values of the parameters in the model for the correct one
% for simultaions
set(model_run{exp_n}.parameters(1:size(rt.par,1)),{'Value'},num2cell(rt.par))

%simulate the model using matlab built in function
rst.simd{exp_n} = sbiosimulate(model_run{exp_n},config_run{exp_n});
end