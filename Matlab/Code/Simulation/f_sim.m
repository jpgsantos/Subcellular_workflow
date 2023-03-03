function rt = f_sim(experiment_number,settings,sim_par,ssa,rt,main_model_folders)
% This function runs simulations using SimBiology models for a set of
% experiments. It loads the appropriate models and compiles the code for
% simulation run, then substitutes the start amounts of species and
% parameter values based on the real-time results and runs the simulation.
% The results of the simulation are saved in the output variable. The
% function can be called multiple times for different experiments, and it
% maintains the state of the loaded models between calls using persistent
% variables. Inputs: experiment_number, settings, realttime_results,
% results, main_model_folders Outputs: results

% Save variables that need to be mantained over multiple function calls
persistent model_run
persistent config_run

% If the function is called for the first time, load the appropriate model
% and compile the code for simulation run
if isempty(model_run)
    
    % Turn off warning messages
    warning('off','SimBiology:InvalidSpeciesInitAmtUnits')
    
    %Generate an empty array to be populated with the model suited for each
    %equilibration and experiment%
    model_run = cell(1,settings.expn*2);
    config_run = cell(1,settings.expn*2);
    
    % Set the file paths for the different models
    model_exp_default = main_model_folders.model.data.model_exp.default;
    model_exp_eq = main_model_folders.model.data.model_exp.equilibration;
    model_exp_detail = main_model_folders.model.data.model_exp.detail;
    
    % Iterate over the experiments thar are being run
    for n = settings.exprun
        

        % Load the models for detailed simulation and place them in the
        % correct place in the array
        if settings.simdetail
            load(model_exp_detail + n + ".mat",'model_exp','config_exp')
            model_run{n+2*settings.expn} = model_exp;
            config_run{n+2*settings.expn} = config_exp;
            
            % Compile the matlab code that is going to simulate the model
            % using matlab built-in function if the option is selected in
            % settings
            if settings.sbioacc
                sbioaccelerate(model_run{n+2*settings.expn},config_run{n+2*settings.expn});
            end
        end


        % Load the models for equilibrium and place them in the correct
        % place in the array
        load(model_exp_eq + n + ".mat",'model_exp','config_exp')
        model_run{n+settings.expn} = model_exp;
        config_run{n+settings.expn} = config_exp;
        
        % Compile the matlab code that is going to simulate the model using
        % matlab built-in function if the option is selected in settings
        if settings.sbioacc
            sbioaccelerate(model_run{n+settings.expn},config_run{n+settings.expn});
        end
        
        % Load the models for main simulation and place them in the correct
        % place in the array
        load(model_exp_default + n + ".mat",'model_exp','config_exp')
        model_run{n} = model_exp;
        config_run{n} = config_exp;
        
        % Compile the matlab code that is going to simulate the model using
        % matlab built in function if the option is selected in settings
        if settings.sbioacc
            sbioaccelerate(model_run{n},config_run{n});
        end
    end
end

% substitute the start amount of the species in the model with the correct
% ones for  simulations
set(model_run{experiment_number}.species(1:size(ssa(:,experiment_number),1)),...
    {'InitialAmount'},num2cell(ssa(:,experiment_number)));

% Substitute the values of the parameters in the model for the correct one
% for simultaions
set(model_run{experiment_number}.parameters(1:size(sim_par,1)),...
    {'Value'},num2cell(sim_par));

%simulate the model using matlab built in function
rt.simd{experiment_number} = sbiosimulate(model_run{experiment_number},...
    config_run{experiment_number});
end