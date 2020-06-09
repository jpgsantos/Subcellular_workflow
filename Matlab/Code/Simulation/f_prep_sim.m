function rst = f_prep_sim(parameters,stg)

% Save variables that need to be mantained over multiple function calls
% persistent modelobj
persistent sbtab
persistent Data

% Import the data on the first run
if isempty(sbtab)
    
    %Find correct path for loading depending on the platform
        load("Model/" +stg.folder_model +"/Data/" + "data_"+stg.name+".mat",'Data','sbtab')
end

% Set the parameters that are going to be used for the simulation to the
% default ones as definded in the SBTAB
rt.par(:,1) = [sbtab.defpar{:,2}];

% Iterate over all the parameters of the model
for n = 1:size(rt.par,1)
    
    % Check if the parametrer needs to be set to the value relevant for
    % Profile Likelihood
    if isfield(stg,"PLind")
        if stg.partest(n,1) == stg.PLind
            parameters(stg.partest(n,1)) = stg.PLval;
        end
    end
    % Check that a parameter should be changed from default
    if stg.partest(n) > 0
        
        % Set the parameters are being tested
        rt.par(n) = 10.^(parameters(stg.partest(n,1)));
    end
    
    % Check that there are thermodynamic constraints to implement
    if ~isempty(stg.tci)
        
        % Choose the parameters that need to be calculated with other
        % parameters due to thermodynamic constraints
        if ismember(n,stg.tci)
            
            % Check that a parameter should be changed from default
            if stg.partest(n) > 0
                
                % Iterate over the parameters that need to be mutiplied for
                % calculating the parameter that depends on the
                % thermodynamic constraints
                for m = 1:size(stg.tcm,2)
                    
                    % Check that the parameter that is going to be used to
                    % calculate the parameter dependent on thermodynamic
                    % constraintsis is not the default
                    if stg.partest(stg.tcm(n,m),1) > 0
                        
                        % Check if the parametrer needs to be tset to the
                        % value relevant for Profile Likelihood
                        if stg.partest(stg.tcm(n,m),1) ==...
                                stg.PLind
                            parameters(stg.partest(...
                                stg.tcm(n,m),1))...
                                = stg.PLval;
                        end
                        
                        % Make the appropriate multiplications to get the
                        % thermodinamicly constrained parameter
                        rt.par(n) = rt.par(n).*(10.^...
                            (parameters(stg.partest(...
                            stg.tcm(n,m),1))));
                    else
                        
                        % Make the appropriate multiplications to get the
                        % thermodinamicly constrained parameter
                        rt.par(n) = rt.par(n).*...
                            (sbtab.defpar{stg.tcm(n,m),2});
                    end
                end
                
                % Iterate over the parameters that need to be divided for
                % calculating the parameter that depends on the
                % thermodynamic constraints
                for m = 1:size(stg.tcd,2)
                    
                    % Check that the parameter that is going to be used to
                    % calculate the parameter dependent on thermodynamic
                    % constraintsis is not the default
                    if stg.partest(stg.tcd(n,m),1) > 0
                        
                        % Check if the parametrer needs to be tset to the
                        % value relevant for Profile Likelihood
                        if stg.partest(stg.tcd(n,m),1) ==...
                                stg.PLind
                            parameters(stg.partest(...
                                stg.tcd(n,m),1))...
                                = stg.PLval;
                        end
                        
                        % Make the appropriate divisions to get the
                        % thermodinamicly constrained parameter
                        rt.par(n) = rt.par(n)./(10.^...
                            (parameters(stg.partest(...
                            stg.tcd(n,m),1))));
                    else
                        
                        % Make the appropriate divisions to get the
                        % thermodinamicly constrained parameter
                        rt.par(n) = rt.par(n)./...
                            (sbtab.defpar{stg.tcd(n,m),2});
                    end
                end
            end
        end
    end
end

%  Set the strat amount for the species in the model to 0
rt.ssa = zeros(size(sbtab.species,1),max(stg.exprun));

% Initialize the results variable
rst = [];

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
        % run and that the start values for the species are different
        % fromthe previous experiment
        if n ~= stg.exprun(1) && ...
            min([sbtab.datasets(n).start_amount{:,2}] ==...
            [sbtab.datasets(max(1,stg.exprun(...
            find(stg.exprun==n)-1))).start_amount{:,2}])
            
            % Set the values of the start amounts to the values obtained
            % after the first equilibration
            rt.ssa(:,n) =...
                rt.ssa(:,stg.exprun(find(stg.exprun==n)-1));
        else
            
            % Iterate over the numbre of species that need a starting value
            % different than 0
            for j = 1:size(sbtab.datasets(n).start_amount,1)
                
                % Set the start amount of the species to the number defined
                % in the sbtab for each experiment
                rt.ssa(sbtab.datasets(n...
                    ).start_amount{j,3},n+stg.expn) =...
                    sbtab.datasets(n).start_amount{j,2};
            end
            
            % Equilibrate the model
            rst = f_sim(n+stg.expn,stg,rt,rst);
            
            for j = 1:size(sbtab.species,1)
                
                % Set the starting amount for species that after
                % equilibrium have very low values to zero
                if rst.simd{n+stg.expn}.Data(end,j) < 1.0e-15
                    rt.ssa(j,n) = 0;
                    
                % Set the starting amount for the rest of the species
                else
                    rt.ssa(j,n) =...
                        rst.simd{n+stg.expn}.Data(end,j);
                end
            end
        end
        
        % Simulate the model
        rst = f_sim(n,stg,rt,rst);
        
        % Check If the times of the simultaion output and the simulation
        % data from SBTAB match, if they don't it means that the simulator
        % didn't had enough time to run the model (happens in some
        % unfavorable configurations of parameters, controlled by
        % stg.maxt
        if size(Data(n).Experiment.t,1) ~=...
                size(rst.simd{n}.Data(:,end),1)
            
            % Set the simulation output to be 0, this is a non function
            % value that the score function expects in simulations that did
            % not worked properly
            rst.simd{n} = 0;
        end
    catch
        
        % Set the simulation output to be 0, this is a non function
        % value that the score function expects in simulations that did
        % not worked properly
        rst.simd{n} = 0;
    end
end
end