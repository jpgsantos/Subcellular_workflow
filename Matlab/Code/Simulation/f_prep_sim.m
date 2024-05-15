function result = f_prep_sim(parameters, settings, model_folders, i, j)
% This function prepares the parameters for a simulation by setting them to
% the default values defined in the SBTAB and then updating any parameters
% that are being tested. The parameters are also adjusted according to any
% thermodynamic constraints.
%
% Inputs:
% - parameters: Array of parameter values to be tested
% - settings: Structure containing various settings for the simulation
% - model_folders: Structure with folder paths for model data
% - i, j: Indices for tracking simulations
%
% Outputs:
% - result: Structure with simulation results and updated parameter values
%
% Used Functions:
% - update_simulation_parameters: Function to update simulation parameters
% - f_sim: Function to run the simulation
%
% Variables:
% Loaded:
% - Data: Array of structures containing experimental data
% - sbtab: SBTAB structure containing default parameters and species 
% information
%
% Initialized:
% - sim_par: Array of simulation parameters
% - ssa: Array of species start amounts
%
% Persistent:
% - sbtab: SBTAB structure containing default parameters and species
% information
% - Data: Array of structures containing experimental data

% Save variables across multiple function calls
persistent sbtab Data

% Load data on the first run
if isempty(sbtab) || isempty(Data)
    if isfield(model_folders, 'model') && isfield(model_folders.model, ...
            'data') && isfield(model_folders.model.data, 'data_model')
        data_model_path = model_folders.model.data.data_model;
        load(data_model_path, 'Data', 'sbtab')
    else
        error(['Data model not found in model_folders.' ...
            ' Please check the folder paths.'])
    end
end

% Set simulation parameters to default values from SBtab
if isfield(sbtab, 'defpar')
    sim_par(:, 1) = [sbtab.defpar{:, 2}]; %simulation_parameters
else
    error(['Default parameters not found in SBtab.' ...
        ' Ensure SBtab is properly formatted.'])
end

% Update parameters for Profile Likelihood if needed
if isfield(settings, 'PLind') && isfield(settings, 'PLval')
    if settings.PLind > 0 && settings.PLind <= length(parameters) + 1
        % add stg.PLval in the midle of other parameters
        parameters = ...
        [parameters(1:settings.PLind - 1), settings.PLval, ...
        parameters(settings.PLind:end)]; 
    else
        error(['PLind is out of bounds.' ...
            ' It should be within the range of parameter indices.'])
    end
end

% Update simulation parameters
sim_par = ...
update_simulation_parameters(sim_par, parameters, settings, sbtab);

% Initialize the result structure
result = struct();
result.parameters = sim_par;

% Validate experiment run settings
if ~isempty(settings.exprun) && isnumeric(settings.exprun)
    result.simd = cell(1, max(settings.exprun));
else
    error(['stg.exprun is invalid.' ...
        ' Ensure exprun is a non - empty numeric array.'])
end

success_eq = zeros(1, length(settings.exprun));
error_list_E = "";

if settings.simcsl
    tic
end

% Run simulations for each experiment
for exp_indx = settings.exprun

    prev_success = success_eq(max(1, exp_indx - 1));
    % Equilibration
    [species_start_amounts, success_eq(exp_indx), error_type] =...
        equilibrate_2(exp_indx, settings, sim_par, result, ...
        model_folders, sbtab, prev_success);

    % Main simulation
    if success_eq(exp_indx)

        tolerance_settings = ...
        create_tolerance_settings(exp_indx, settings, 0);

        [~, error_type, result] = ...
            run_with_tolerances(@(success) f_sim(exp_indx, settings, ...
            sim_par, species_start_amounts, result, ...
             model_folders, success), tolerance_settings, result);

        % if ~success_sim
        %     disp("n: " + n + " E" + (n - 1) + " fail_sim_2" + ...
        %         " last error: " + ME.identifier)
        %     result.simd{exp_indx} = 0;
        % end

        % Run detailed simulation if required
        if settings.simdetail
            [~, error_type, result] = ...
            run_with_tolerances(@(success) f_sim(exp_indx + 2 * ...
            settings.expn, settings, sim_par, species_start_amounts, ...
             result, model_folders, success), tolerance_settings, result);
        end

        % Check simulation output times
        if result.simd{exp_indx} ~= 0 && ...
                size(Data(exp_indx).Experiment.t, 1) ~= ...
            size(result.simd{exp_indx}.Data(:, end), 1)
            % disp("n: " + n + " E" + (n - 1) + " fail_sim_out_time" + ...
            %     " time_sim:  " + size(result.simd{n}.Data(:, end), 1) + ...
            %     " data_time: " + size(Data(n).Experiment.t, 1))
            error_type = "st"; %simulation time
            result.simd{exp_indx} = 0;
        end
    else
        result.simd{exp_indx} = 0;
    end
    if result.simd{exp_indx} == 0
        error_list_E = append(error_list_E, ...
            ((exp_indx - 1) + error_type + " "));
    end
    
end

% Display progress and errors if necessary
if settings.simcsl
    disp("i: " + i + " j: " + j + " E: " + error_list_E + " time: " + toc)
end
end

function tolerance_settings = ...
create_tolerance_settings(exp_indx, settings, equilibrate)
% Create a structure for tolerance settings
    tolerance_settings = ...
    struct('exp_indx', exp_indx, 'reltol', settings.reltol, 'reltol_step', ...
            settings.reltol / 10, 'reltol_min', settings.reltol_min, ...
            'abstol', settings.abstol, 'abstol_step', settings.abstol / 10, ...
             'abstol_min', settings.abstol_min, 'equilibrate', equilibrate);
end

function [success, error_type, result] = ...
    run_with_tolerances(func, tolerance_settings, result)
% Run a function with varying tolerance settings until it succeeds
success = true;
error_type = '';

for reltol = tolerance_settings.reltol: - tolerance_settings.reltol_step:...
    tolerance_settings.reltol_min
    for abstol = ...
        tolerance_settings.abstol: - tolerance_settings.abstol_step:...
            tolerance_settings.abstol_min

        tolerance_settings.stg.reltol = reltol;
        tolerance_settings.stg.abstol = abstol;
        if tolerance_settings.equilibrate
            try
                [result, error_type] = func();
                success = true;
            catch
                error_type = "e"; %equilibration
                success = false;
            end
        else
            try
                result = func(success);
                success = true;
            catch
                % tolerance_settings.exp_indx
                result.simd{tolerance_settings.exp_indx} = 0;
                error_type = "s"; %simulation
                success = false;
            end
        end
        if success
            break;
        end
    end
    if success
        break;
    end
end
end

function [species_start_amounts_1, success_eq, error_type] = ...
equilibrate_2(exp_indx, settings, sim_par, ...
    result, model_folders, sbtab, success_eq)
% Equilibrate the model for the specified experiment
persistent species_start_amounts %species start amount
error_type = "";

% Check if this is not the first experiment, the start values are equal to
% the previous experiment, and the previous simulation was valid
is_not_first_experiment = exp_indx ~= settings.exprun(1);

x = find(settings.exprun == exp_indx) - 1;

start_values_equal = min([sbtab.datasets(exp_indx).start_amount{:, 2}] == ...
    [sbtab.datasets(settings.exprun(max(x, 1))).start_amount{:, 2}]);
previous_simulation_valid = result.simd{settings.exprun(max(x, 1))} ~= 0;

if is_not_first_experiment && start_values_equal && ...
        previous_simulation_valid && success_eq
    % Set the start amounts based on the previous experiment
    species_start_amounts(:, exp_indx) =...
        species_start_amounts(:, settings.exprun(x));
    if settings.simdetail
        species_start_amounts(:, exp_indx + 2*settings.expn) = ...
            species_start_amounts(:, settings.exprun(x));
    end
    success_eq = true;
else
    % Set start amounts for species with non - zero values
    for j = 1:size(sbtab.datasets(exp_indx).start_amount, 1)
        % Set the start amount of the species to the number defined in
        % the sbtab for each experiment
        species_start_amounts(sbtab.datasets(exp_indx).start_amount{j, 3}, ...
            exp_indx + settings.expn) =...
            sbtab.datasets(exp_indx).start_amount{j, 2};
    end

    tolerance_settings = create_tolerance_settings(exp_indx, settings, 1);

    [success_eq, error_type, species_start_amounts] = ...
        run_with_tolerances(@() equilibrate(exp_indx, settings, sim_par, ...
        result, model_folders, sbtab, species_start_amounts, success_eq), ...
         tolerance_settings, species_start_amounts);
end
species_start_amounts_1 = species_start_amounts;
end

function sim_par = ...
    update_simulation_parameters(sim_par, parameters, settings, sbtab)
% Update simulation parameters based on input and thermodynamic constraints

% Iterate over all the parameters of the model
for n = 1:length(sim_par)
    % Update tested parameters
    if settings.partest(n) > 0
        sim_par(n) = 10 .^ parameters(settings.partest(n, 1));
    end
    % Update thermodynamic constrained parameters
    if isfield(settings, 'tci') && ~isempty(settings.tci) &&...
            ismember(n, settings.tci) && settings.partest(n) > 0
        sim_par = ...
        update_thermo_constrained(sim_par, parameters, settings, n, sbtab);
    end
end
end

function sim_par = ...
update_thermo_constrained(sim_par, parameters, settings, n, sbtab)
% Update parameters constrained by thermodynamic laws

key_1 = ["tcm", "tcd"];
key_2 = ["*", "/"];

for k=1:2
    count = 0;
    for m = 1:size(settings.(key_1(k)), 2)
        if settings.(key_1(k))(n, m) ~= 0
            count = count + 1;
        end
    end
    % Iterate over the parameters that need to be multiplied for
    % calculating the parameter that depends on the thermodynamic
    % constraints
    for m = 1:count
        % Check that the parameter that is going to be used to calculate
        % the parameter dependent on thermodynamic constraints is not the
        % default
        if settings.partest(settings.(key_1(k))(n, m), 1) > 0
            % Check if the parameter needs to be set to the value relevant
            % for Profile Likelihood
            if isfield(settings, "PLind") && ...
                settings.partest(settings.(key_1(k))(n, m), 1) == ...
                settings.PLind
                parameters(settings.partest(settings.(key_1(k))(n, m), 1)) = ...
                    settings.PLval;
            end
            % Make the appropriate multiplications to get the
            % thermodynamically constrained parameter
            eval("sim_par(n) = sim_par(n) " + key_2(k) + ...
                " (10 ^ (parameters(settings.partest(" + ...
                "settings.(key_1(k))(n, m), 1))));");
        else
            % Make the appropriate multiplications to get the
            % thermodynamically constrained parameter
            eval("sim_par(n) = sim_par(n) " + key_2(k) + ...
                "(sbtab.defpar{settings.(key_1(k))(n, m), 2});");
        end
    end
end
end

function [species_start_amounts, error_type] = ...
    equilibrate(n, settings, sim_par, result, model_folders, sbtab, ...
    species_start_amounts, success)
% Equilibrate the model

result = f_sim(n + settings.expn, settings, sim_par, species_start_amounts, ...
    result, model_folders, success);
error_type = "";

if result.simd{n + settings.expn}.Time(end, 1) ~= settings.eqt
    % disp("n: " + n + " E" + (n - 1) + " time_eq: " + ...
    %     result.simd{n + stg.expn}.Time(end, 1) + " stg.eqt: " + stg.eqt)
    error("E" + (n - 1) + " fail_eq_out_time")
    error_type = "et"; %equilibration time
end

% Update the start amounts based on equilibrium results
for j = 1:size(sbtab.species, 1)
    final_amount = result.simd{n + settings.expn}.Data(end, j);
    if final_amount < 1.0e - 10
        species_start_amounts(j, n) = 0;
        if settings.simdetail
            species_start_amounts(j, n + 2 * settings.expn) = 0;
        end
    else
        species_start_amounts(j, n) = final_amount;
        if settings.simdetail
            species_start_amounts(j, n + 2 * settings.expn) = final_amount;
        end
    end
end
end