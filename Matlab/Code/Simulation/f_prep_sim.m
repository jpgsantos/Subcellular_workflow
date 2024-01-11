function result = f_prep_sim(parameters,stg,model_folders)
% This function prepares the parameters for a simulation by setting them
% to the default values defined in the SBTAB and then updating any
% parameters that are being tested. The parameters are also adjusted
% according to any thermodynamic constraints.
%
% Inputs:
% - parameters: Array of parameter values that need to be tested
% - stg: Settings structure containing various settings for the simulation
% - model_folders: Structure containing folder paths for the model data
%
% Outputs:
% - result: Structure containing simulation results and parameter values
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

% Save variables that need to be mantained over multiple function calls
persistent sbtab
persistent Data

data_model = model_folders.model.data.data_model;

% Import the data on the first run
if isempty(sbtab)
    load(data_model,'Data','sbtab')
end

% Set the parameters that are going to be used for the simulation to the
% default ones as definded in the SBTAB
sim_par(:,1) = [sbtab.defpar{:,2}];

% Check if the parametrer needs to be set to the value relevant for Profile
% Likelihood
if isfield(stg,"PLind") && isfield(stg,"PLval")
    parameters = [parameters(1:stg.PLind-1) stg.PLval parameters(stg.PLind:end)];
end

% Update simulation parameters
sim_par = update_simulation_parameters(sim_par, parameters, stg,sbtab);

%  Set the start amount for the species in the model to 0
ssa = zeros(size(sbtab.species,1),max(stg.exprun));

% Initialize the results variable
result = [];
result.parameters = sim_par;
result.simd{stg.exprun(1)} = [];

m=1;
% Run simulations for each experiment
while m <= size(stg.exprun,2)
n=stg.exprun(m);
    % Try catch used because iterations errors can happen unexectedly and
    % we want to be able to continue simulations
    % try
    % Display progress message if appropriate
    if stg.simcsl
        disp("Running dataset number " + n + " of " + stg.exprun(end))
    end

    % Check if this is not the first experiment, the start values are
    % equal to the previous experiment, and the previous simulation
    % was valid
    is_not_first_experiment = n ~= stg.exprun(1);

    start_values_equal = min([sbtab.datasets(n).start_amount{:,2}] ==...
        [sbtab.datasets(stg.exprun(...
        max(find(stg.exprun==n)-1,1))).start_amount{:,2}]);
    previous_simulation_valid = ...
        result.simd{stg.exprun(max(find(stg.exprun==n)-1,1))} ~= 0;

    if is_not_first_experiment && start_values_equal && previous_simulation_valid
        % Set the start amounts based on the previous experiment
        ssa(:,n) = ssa(:,stg.exprun(find(stg.exprun==n)-1));
        if stg.simdetail
            ssa(:,n+2*stg.expn) = ssa(:,stg.exprun(find(stg.exprun==n)-1));
        end
    else
        % Set start amounts for species with non-zero values
        for j = 1:size(sbtab.datasets(n).start_amount,1)

            % Set the start amount of the species to the number defined in
            % the sbtab for each experiment
            ssa(sbtab.datasets(n).start_amount{j,3},n+stg.expn) =...
                sbtab.datasets(n).start_amount{j,2};
        end

        try
            success = true;
                
            while stg.reltol >= 1.0E-3
                while stg.abstol >= 1.0E-6
                    try
                        ssa = equilibrate(n,stg,sim_par,result,model_folders,sbtab,ssa,success);
                        success = true;
                    catch
                        success = false;
                    end
                    if success
                        break
                    end
                    stg.abstol = stg.abstol/10;
                end
                if success
                    break
                end
                stg.abstol = 1.0E-6;
                stg.reltol = stg.reltol/10;
            end
        catch
            % disp("fail_eq")
            m=size(stg.exprun,2)+1;
            for fail = stg.exprun
                result.simd{fail} = 0;
            end
        end

    end

    % Run the main simulation
            
    try
        result = f_sim(n,stg,sim_par,ssa,result,model_folders,success);

        % Run detailed simulation if required
        if stg.simdetail
            result = f_sim(n+2*stg.expn,stg,sim_par,ssa,result,model_folders,success);
        end

        % Check if the simulation output times match the SBTAB data times, if
        % they don't it means that the simulator didn't had enough time to run
        % the model (happens in some unfavorable configurations of parameters,
        % controlled by stg.maxt)
        simulation_times_match = size(Data(n).Experiment.t,1) == size(result.simd{n}.Data(:,end),1);

        % Handle cases where the simulation did not run properly
        if ~simulation_times_match
            result.simd{n} = 0;
        end

    catch 
        % disp("fail_sim")
        m=size(stg.exprun,2)+1;
        for fail = stg.exprun
            result.simd{fail} = 0;
        end
    end
m=m+1;
end
end

function sim_par = update_simulation_parameters(sim_par, parameters, settings,sbtab)
% Iterate over all the parameters of the model
for n = 1:size(sim_par,1)

    % Update tested parameters
    if settings.partest(n) > 0
        sim_par(n) = 10.^(parameters(settings.partest(n,1)));
    end

    % Update thermodynamic constrained parameters
    if isfield(settings,'tci') && ~isempty(settings.tci) && ismember(n,settings.tci) && settings.partest(n) > 0
        sim_par = update_thermo_constrained_multiplications(sim_par, parameters,settings, n,sbtab);
        sim_par = update_thermo_constrained_divisions(sim_par, parameters, settings, n,sbtab);
    end
end
end

function sim_par = update_thermo_constrained_multiplications(sim_par, parameters, settings, n,sbtab)
% Iterate over the parameters that need to be mutiplied for calculating the
% parameter that depends on the thermodynamic constraints
for m = 1:size(settings.tcm, 2)
    % Check that the parameter that is going to be used to calculate the
    % parameter dependent on thermodynamic constraintsis is not the default
    if settings.partest(settings.tcm(n, m), 1) > 0
        % Check if the parametrer needs to be set to the value relevant for
        % Profile Likelihood
        if isfield(settings, "PLind") && settings.partest(settings.tcm(n, m), 1) == settings.PLind
            parameters(settings.partest(settings.tcm(n, m), 1)) = settings.PLval;
        end
        % Make the appropriate multiplications to get the thermodinamicly
        % constrained parameter
        sim_par(n) = sim_par(n) * (10 ^ (parameters(settings.partest(settings.tcm(n, m), 1))));
    else
        % Make the appropriate multiplications to get the thermodinamicly
        % constrained parameter
        sim_par(n) = sim_par(n) * (sbtab.defpar{settings.tcm(n, m), 2});
    end
end
end

function sim_par = update_thermo_constrained_divisions(sim_par, parameters, settings, n,sbtab)
% Iterate over the parameters that need to be divided for calculating the
% parameter that depends on the thermodynamic constraints
for m = 1:size(settings.tcd, 2)
    % Check that the parameter that is going to be used to calculate the
    % parameter dependent on thermodynamic constraintsis is not the default
    if settings.partest(settings.tcd(n, m), 1) > 0
        % Check if the parametrer needs to be set to the value relevant for
        % Profile Likelihood
        if isfield(settings, "PLind") && settings.partest(settings.tcd(n, m), 1) == settings.PLind
            parameters(settings.partest(settings.tcd(n, m), 1)) = settings.PLval;
        end
        % Make the appropriate divisions to get the thermodinamicly
        % constrained parameter
        sim_par(n) = sim_par(n) / (10 ^ (parameters(settings.partest(settings.tcd(n, m), 1))));
    else
        % Make the appropriate divisions to get the thermodinamicly
        % constrained parameter
        sim_par(n) = sim_par(n) / (sbtab.defpar{settings.tcd(n, m), 2});
    end
end
end

function ssa = equilibrate(n,stg,sim_par,result,model_folders,sbtab,ssa,success)

% Equilibrate the model 1
result = f_sim(n+stg.expn,stg,sim_par,ssa,result,model_folders,success);

% Update the start amounts based on equilibrium results
for j = 1:size(sbtab.species,1)

    final_amount = result.simd{n+stg.expn}.Data(end,j);

    if final_amount < 1.0e-15
        ssa(j,n) = 0;
        if stg.simdetail
            ssa(j,n+2*stg.expn) = 0;
        end
    else
        ssa(j,n) = final_amount;
        if stg.simdetail
            ssa(j,n+2*stg.expn) = final_amount;
        end
    end
end
end
