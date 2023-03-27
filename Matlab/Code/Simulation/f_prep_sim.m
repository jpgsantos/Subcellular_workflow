function result = f_prep_sim(parameters,stg,model_folders)
%   F_PREP_SIM Prepare parameters for simulation This function prepares the
%   parameters for a simulation by setting them to the default values
%   defined in the SBTAB and then updating any parameters that are being
%   tested. The parameters are also adjusted according to any thermodynamic
%   constraints. Inputs parameters: parameters stg: settings mmf: main
%   model folders Outputs rst: results

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

% Iterate over all the parameters of the model
for n = 1:size(sim_par,1)

    % Update tested parameters
    if stg.partest(n) > 0
        sim_par(n) = 10.^(parameters(stg.partest(n,1)));
    end

    % Update thermodynamic constrained parameters
    if isfield(stg,'tci') && ~isempty(stg.tci) && ismember(n,stg.tci) && stg.partest(n) > 0
        sim_par = update_thermo_constrained_multiplications(sim_par, parameters,stg, n);
        sim_par = update_thermo_constrained_divisions(sim_par, parameters, stg, n);
    end
end

%  Set the start amount for the species in the model to 0
ssa = zeros(size(sbtab.species,1),max(stg.exprun));

% Initialize the results variable
result = [];
result.parameters = sim_par;
% Iterate over all the experiments that are being run
for n = stg.exprun

    % Try catch used because iterations errors can happen unexectedly and
    % we want to be able to continue simulations
    try

        % If the correct setting is chosen display messages to console
        if stg.simcsl
            disp("Running dataset number " + n +...
                " of " + stg.exprun(end))
        end

        % Check that this is not the first time the experiments are being
        % run and that the start values for the species are different from
        % the previous experiment

        if n ~= stg.exprun(1) && ...
                min([sbtab.datasets(n).start_amount{:,2}] ==...
                [sbtab.datasets(max(1,stg.exprun(...
                find(stg.exprun==n)-1))).start_amount{:,2}])...
                && result.simd{n-1} ~= 0

            % Set the values of the start amounts to the values obtained
            % after the first equilibration
            ssa(:,n) =...
                ssa(:,stg.exprun(find(stg.exprun==n)-1));
            if stg.simdetail
                ssa(:,n+2*stg.expn) =...
                    ssa(:,stg.exprun(find(stg.exprun==n)-1));
            end
        else
            if n ~= stg.exprun(1)

            end
            % Iterate over the numbre of species that need a starting value
            % different than 0
            for j = 1:size(sbtab.datasets(n).start_amount,1)

                % Set the start amount of the species to the number defined
                % in the sbtab for each experiment
                ssa(sbtab.datasets(n...
                    ).start_amount{j,3},n+stg.expn) =...
                    sbtab.datasets(n).start_amount{j,2};
            end

            % Equilibrate the model
            result = f_sim(n+stg.expn,stg,sim_par,ssa,result,model_folders);

            for j = 1:size(sbtab.species,1)

                % Set the starting amount for species that after
                % equilibrium have very low values to zero

                if result.simd{n+stg.expn}.Data(end,j) < 1.0e-15
                    ssa(j,n) = 0;

                % Set the starting amount for the rest of the species
                else
                    ssa(j,n) =...
                        result.simd{n+stg.expn}.Data(end,j);
                    if stg.simdetail
                        ssa(j,n+2*stg.expn) =...
                            result.simd{n+stg.expn}.Data(end,j);
                    end
                end
            end
        end

        % Simulate the model
        result = f_sim(n,stg,sim_par,ssa,result,model_folders);
        try
            if stg.simdetail
                result = f_sim(n+2*stg.expn,stg,sim_par,ssa,result,model_folders);
            end
        catch
        end

        % Check If the times of the simultaion output and the simulation
        % data from SBTAB match, if they don't it means that the simulator
        % didn't had enough time to run the model (happens in some
        % unfavorable configurations of parameters, controlled by stg.maxt
        if size(Data(n).Experiment.t,1) ~=...
                size(result.simd{n}.Data(:,end),1)
            % Set the simulation output to be 0, this is a non function
            % value that the score function expects in simulations that did
            % not worked properly
            result.simd{n} = 0;
        end
    catch ME
        disp(ME.identifier + " " + n)

        % Set the simulation output to be 0, this is a non function value
        % that the score function expects in simulations that did not
        % worked properly
        result.simd{n} = 0;
    end
end
end

function sim_par = update_thermo_constrained_multiplications(sim_par, parameters, settings, n)
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

function sim_par = update_thermo_constrained_divisions(sim_par, parameters, stg, n)
% Iterate over the parameters that need to be divided for calculating the
% parameter that depends on the thermodynamic constraints
for m = 1:size(stg.tcd, 2)
    % Check that the parameter that is going to be used to calculate the
    % parameter dependent on thermodynamic constraintsis is not the default
    if stg.partest(stg.tcd(n, m), 1) > 0
        % Check if the parametrer needs to be set to the value relevant for
        % Profile Likelihood
        if isfield(stg, "PLind") && stg.partest(stg.tcd(n, m), 1) == stg.PLind
            parameters(stg.partest(stg.tcd(n, m), 1)) = stg.PLval;
        end
        % Make the appropriate divisions to get the thermodinamicly
        % constrained parameter
        sim_par(n) = sim_par(n) / (10 ^ (parameters(stg.partest(stg.tcd(n, m), 1))));
    else
        % Make the appropriate divisions to get the thermodinamicly
        % constrained parameter
        sim_par(n) = sim_par(n) / (sbtab.defpar{stg.tcd(n, m), 2});
    end
end
end