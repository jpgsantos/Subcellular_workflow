function results = f_sim(experiment_idx,settings,simulation_parameters,...
    species_start_amount,results,main_model_folders,success)
% This function runs simulations using SimBiology models for a set of
% experiments. It loads the appropriate models and compiles the code for
% simulation run, then substitutes the start amounts of species and
% parameter values based on real-time results and runs the simulation. The
% results of the simulation are saved in the output variable. The function
% can be called multiple times for different experiments, and it maintains
% the state of the loaded models between calls using persistent variables.
%
% Inputs:
% - experiment_idx: Indices of experiments to run
% - settings: Simulation settings (e.g., sbioaccelerate, simdetail, expn,
% exprun)
% - simulation_parameters: Parameter values for simulations
% - species_start_amount: Start amounts for species in simulations
% - results: Output variable to save simulation results
% - main_model_folders: Paths for model files (e.g., model_exp_default,
% model_exp_eq, model_exp_detail)
%
% Outputs:
% - results: Simulation results (e.g., simd)
%
% Functions called:
% - sbioaccelerate: Compile model code for faster simulation run
% - sbiosimulate: Run simulation of SimBiology model with specified
% configuration
%
% Variables:
% Loaded:
% - model_exp: SimBiology model for each experiment
% - config_exp: SimBiology model configuration for each experiment
%
% Initialized:
% None
%
% Persistent:
% - models: Cell array containing the SimBiology models for each experiment
% - configs: Cell array containing the configurations for each SimBiology
% model

% Save variables that need to be mantained over multiple function calls
persistent models
persistent configs

rel_tol_ind = abs(log10(settings.reltol_min)-log10(settings.reltol))+1;
abs_tol_ind = abs(log10(settings.abstol_min)-log10(settings.abstol))+1;
% If the function is called for the first time, load the appropriate model
% and compile the code for simulation run
if isempty(models)

    % Turn off warning messages
    warning('off','all')

    % Generate an empty array to be populated with the model suited for
    % each equilibration and experiment
    models = cell(1, 1, settings.expn * (2 + settings.simdetail));
    configs = cell(1, 1, settings.expn * (2 + settings.simdetail));

    % Set the file paths for the different models
    model_exp_default = main_model_folders.model.data.model_exp.default;
    model_exp_eq = main_model_folders.model.data.model_exp.equilibration;
    model_exp_detail = main_model_folders.model.data.model_exp.detail;

    % Iterate over the experiments thar are being run
    for n = settings.exprun
        for j = 1:rel_tol_ind
            for k = 1:abs_tol_ind
                % Load and compile SimBiology models for each experiment

                % Load models for main simulation
                load(model_exp_default + n + ".mat", 'model_exp', ...
                    'config_exp')
                models{j, k, n} = model_exp;
                configs{j, k, n} = config_exp;

                % Load models for equilibrium
                load(model_exp_eq + n + ".mat", 'model_exp', 'config_exp')
                models{j, k, n+settings.expn} = model_exp;
                configs{j, k, n+settings.expn} = config_exp;

                % Load models for detailed simulation
                if settings.simdetail
                    load(model_exp_detail + n + ".mat", 'model_exp', ...
                        'config_exp')
                    models{j, k, n+2*settings.expn} = model_exp;
                    configs{j, k, n+2*settings.expn} = config_exp;
                end
                % Compile the model code if the option is selected in
                % settings
                if settings.sbioacc
                    sbioaccelerate(models{j, k, n}, configs{j,k,n});
                    sbioaccelerate(models{j, k, n+settings.expn}, ...
                        configs{j, k, n+settings.expn});
                    if settings.simdetail
                        sbioaccelerate(models{j, k, n+2*settings.expn}, ...
                            configs{j, k, n+2*settings.expn});
                    end
                end
            end
        end
    end
end

% substitute the start amount of the species in the model with the correct
% ones for  simulations
set(models{rel_tol_ind,abs_tol_ind,experiment_idx}.species(...
    1:size(species_start_amount(:,experiment_idx),1)),...
    {'InitialAmount'}, num2cell(species_start_amount(:,experiment_idx)));

% Substitute the values of the parameters in the model for the correct one
% for simultaions
set(models{rel_tol_ind,abs_tol_ind,experiment_idx}.parameters(...
    1:size(simulation_parameters,1)),...
    {'Value'}, num2cell(simulation_parameters));

if ~success
    configs_fail = configs{rel_tol_ind,abs_tol_ind,experiment_idx};
    configs_fail.SolverOptions.AbsoluteTolerance = settings.abstol;
    configs_fail.SolverOptions.RelativeTolerance = settings.reltol;
    results.simd{experiment_idx} = ...
    sbiosimulate(models{rel_tol_ind,abs_tol_ind,experiment_idx},...
        configs_fail);
else
    % simulate the model using matlab built in function
    results.simd{experiment_idx} = ...
        sbiosimulate(models{rel_tol_ind,abs_tol_ind,experiment_idx},...
        configs{rel_tol_ind,abs_tol_ind,experiment_idx});
end
end