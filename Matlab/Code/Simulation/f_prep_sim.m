function rst = f_prep_sim(parameters,stg,mmf)
%   F_PREP_SIM Prepare parameters for simulation This function prepares the
%   parameters for a simulation by setting them to the default values
%   defined in the SBTAB and then updating any parameters that are being
%   tested. The parameters are also adjusted according to any thermodynamic
%   constraints. 
%   Inputs parameters: parameters
%   stg: settings
%   mmf: main model folders
%   Outputs rst: results

% Save variables that need to be mantained over multiple function calls
persistent sbtab
persistent Data

data_model = mmf.model.data.data_model;

% Import the data on the first run
if isempty(sbtab)
    %Find correct path for loading depending on the platform
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

    % Check that a parameter should be changed from default
    if stg.partest(n) > 0

        % Set the parameters are being tested
        sim_par(n) = 10.^(parameters(stg.partest(n,1)));
    end

    if isfield(stg,'tci')

        % Check that there are thermodynamic constraints to implement
        if ~isempty(stg.tci)

            % Choose the parameters that need to be calculated with other
            % parameters due to thermodynamic constraints
            if ismember(n,stg.tci)

                % Check that a parameter should be changed from default
                if stg.partest(n) > 0

                    % Iterate over the parameters that need to be mutiplied
                    % for calculating the parameter that depends on the
                    % thermodynamic constraints
                    for m = 1:size(stg.tcm,2)

                        % Check that the parameter that is going to be used
                        % to calculate the parameter dependent on
                        % thermodynamic constraintsis is not the default
                        if stg.partest(stg.tcm(n,m),1) > 0

                            % Check if the parametrer needs to be set to
                            % the value relevant for Profile Likelihood
                            if isfield(stg,"PLind")
                                if stg.partest(stg.tcm(n,m),1) ==...
                                        stg.PLind
                                    parameters(stg.partest(...
                                        stg.tcm(n,m),1))...
                                        = stg.PLval;
                                end
                            end

                            % Make the appropriate multiplications to get
                            % the thermodinamicly constrained parameter
                            sim_par(n) = sim_par(n).*(10.^...
                                (parameters(stg.partest(...
                                stg.tcm(n,m),1))));
                        else

                            % Make the appropriate multiplications to get
                            % the thermodinamicly constrained parameter
                            sim_par(n) = sim_par(n).*...
                                (sbtab.defpar{stg.tcm(n,m),2});
                        end
                    end

                    % Iterate over the parameters that need to be divided
                    % for calculating the parameter that depends on the
                    % thermodynamic constraints
                    for m = 1:size(stg.tcd,2)

                        % Check that the parameter that is going to be used
                        % to calculate the parameter dependent on
                        % thermodynamic constraintsis is not the default
                        if stg.partest(stg.tcd(n,m),1) > 0

                            % Check if the parametrer needs to be set to
                            % the value relevant for Profile Likelihood
                            if isfield(stg,"PLind")
                                if stg.partest(stg.tcd(n,m),1) ==...
                                        stg.PLind
                                    parameters(stg.partest(...
                                        stg.tcd(n,m),1))...
                                        = stg.PLval;
                                end
                            end
                            % Make the appropriate divisions to get the
                            % thermodinamicly constrained parameter
                            sim_par(n) = sim_par(n)./(10.^...
                                (parameters(stg.partest(...
                                stg.tcd(n,m),1))));
                        else

                            % Make the appropriate divisions to get the
                            % thermodinamicly constrained parameter
                            sim_par(n) = sim_par(n)./...
                                (sbtab.defpar{stg.tcd(n,m),2});
                        end
                    end
                end
            end
        end
    end
end

%  Set the start amount for the species in the model to 0
ssa = zeros(size(sbtab.species,1),max(stg.exprun));

% Initialize the results variable
rst = [];
rst.parameters = sim_par;
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
                && rst.simd{n-1} ~= 0

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
            rst = f_sim(n+stg.expn,stg,sim_par,ssa,rst,mmf);

            for j = 1:size(sbtab.species,1)

                % Set the starting amount for species that after
                % equilibrium have very low values to zero

                if rst.simd{n+stg.expn}.Data(end,j) < 1.0e-15
                    ssa(j,n) = 0;

                    % Set the starting amount for the rest of the species
                else
                    ssa(j,n) =...
                        rst.simd{n+stg.expn}.Data(end,j);
                    if stg.simdetail
                        ssa(j,n+2*stg.expn) =...
                            rst.simd{n+stg.expn}.Data(end,j);
                    end
                end
            end
        end

        % Simulate the model
        rst = f_sim(n,stg,sim_par,ssa,rst,mmf);
        try
            if stg.simdetail
                rst = f_sim(n+2*stg.expn,stg,sim_par,ssa,rst,mmf);
            end
        catch
        end

        % Check If the times of the simultaion output and the simulation
        % data from SBTAB match, if they don't it means that the simulator
        % didn't had enough time to run the model (happens in some
        % unfavorable configurations of parameters, controlled by stg.maxt
        if size(Data(n).Experiment.t,1) ~=...
                size(rst.simd{n}.Data(:,end),1)
            disp("not enough time" + n)
            % Set the simulation output to be 0, this is a non function
            % value that the score function expects in simulations that did
            % not worked properly
            rst.simd{n} = 0;
        end
    catch ME
        disp(ME.identifier + " " + n)

        % Set the simulation output to be 0, this is a non function value
        % th3at the score function expects in simulations that did not
        % worked properly
        rst.simd{n} = 0;
    end
end
end