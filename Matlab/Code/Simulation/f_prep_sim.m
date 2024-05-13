function result = f_prep_sim(parameters,stg,model_folders,i,j)
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

% Save variables that need to be maintained over multiple function calls
persistent sbtab Data

% Import the data on the first run
if isempty(sbtab) || isempty(Data)
    data_model = model_folders.model.data.data_model;
    load(data_model,'Data','sbtab')
end

% Set the parameters that are going to be used for the simulation to the
% default ones as defined in the SBTAB
sim_par(:,1) = [sbtab.defpar{:,2}];

% Check if the parametrer needs to be set to the value relevant for Profile
% Likelihood
if isfield(stg,"PLind") && isfield(stg,"PLval")
    parameters = [parameters(1:stg.PLind-1) stg.PLval parameters(stg.PLind:end)];
end
% Update simulation parameters
sim_par = update_simulation_parameters(sim_par, parameters, stg,sbtab);

%  Set the start amount for the species in the model to 0
% ssa = zeros(size(sbtab.species,1),max(stg.exprun));

% Initialize the results variable
result = [];
result.parameters = sim_par;
result.simd{stg.exprun(1)} = [];

reltol_eq = stg.reltol;
reltol_eq_ini = stg.reltol;
reltol_min_eq = stg.reltol_min;
abstol_eq = stg.abstol;
abstol_eq_ini = stg.abstol;
abstol_min_eq = stg.abstol_min;

reltol_sim = stg.reltol;
reltol_sim_ini = stg.reltol;
reltol_min_sim = stg.reltol_min;
abstol_sim = stg.abstol;
abstol_sim_ini = stg.abstol;
abstol_min_sim = stg.abstol_min;
success_eq = zeros(1,length(stg.exprun));

error_list_n = "";
error_list_E = "";
error_type = "";
% tic
% Run simulations for each experiment
for n = stg.exprun
    % disp("n: " + n)
    % Try catch used because iterations errors can happen unexpectedly and
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

    % if is_not_first_experiment && start_values_equal && previous_simulation_valid
    %     % Set the start amounts based on the previous experiment
    %     ssa(:,n) = ssa(:,stg.exprun(find(stg.exprun==n)-1));
    %     if stg.simdetail
    %         ssa(:,n+2*stg.expn) = ssa(:,stg.exprun(find(stg.exprun==n)-1));
    %     end
    % else
    %     % disp(n + "1")
    %     % Set start amounts for species with non-zero values
    %     for j = 1:size(sbtab.datasets(n).start_amount,1)
    %
    %         % Set the start amount of the species to the number defined in
    %         % the sbtab for each experiment
    %         ssa(sbtab.datasets(n).start_amount{j,3},n+stg.expn) =...
    %             sbtab.datasets(n).start_amount{j,2};
    %     end
    %     while reltol_eq >= reltol_min_eq
    %         while abstol_eq >= abstol_min_eq
    %             try
    %                 stg.reltol = reltol_eq;
    %                 stg.abstol = abstol_eq;
    %                 success_eq = false;
    %                 ssa = equilibrate(n,stg,sim_par,result,model_folders,sbtab,ssa,success_eq);
    %                 success_eq = true;
    %             catch
    %                 disp("n:" + n + " abstol_eq:  " + abstol_eq + "  reltol_eq:  " + reltol_eq)
    %                 success_eq = false;
    %                 % disp("check your abstol_eq value")
    %             end
    %             if success_eq
    %                 break
    %             end
    %             abstol_eq = abstol_eq/10;
    %         end
    %         % end
    %         if success_eq
    %             break
    %         end
    %         abstol_eq = abstol_eq_ini;
    %         reltol_eq = reltol_eq/10;
    %     end
    %     abstol_eq = abstol_eq_ini;
    %     reltol_eq = reltol_eq_ini;
    % end

    if n == stg.exprun(1)
        [ssa,success_eq(n),error_type] = equilibrate_2(n,stg,sim_par,result,model_folders,sbtab,is_not_first_experiment,start_values_equal,previous_simulation_valid,reltol_eq,reltol_min_eq,reltol_eq_ini,abstol_eq,abstol_min_eq,abstol_eq_ini,0);
    else
        % disp(success_eq(n-1))
        [ssa,success_eq(n),error_type] = equilibrate_2(n,stg,sim_par,result,model_folders,sbtab,is_not_first_experiment,start_values_equal,previous_simulation_valid,reltol_eq,reltol_min_eq,reltol_eq_ini,abstol_eq,abstol_min_eq,abstol_eq_ini,success_eq(n-1));
    end

    % Run the main simulation
    if success_eq(n)
        % disp(n + "2")
        success_sim = true;
        while reltol_sim >= reltol_min_sim
            while abstol_sim >= abstol_min_sim
                % abstol_sim
                try

                    % try
                    %     [ssa,success_eq] = equilibrate_2(n,stg,sim_par,result,model_folders,sbtab,is_not_first_experiment,start_values_equal,previous_simulation_valid,reltol_sim,reltol_min_eq,reltol_sim,abstol_sim,abstol_min_eq,abstol_sim);
                    % catch ME
                    %     error(n + " fail_eq " + ME.identifier)
                    % end
                    stg.reltol = reltol_sim;
                    stg.abstol = abstol_sim;
                    
                    result = f_sim(n,stg,sim_par,ssa,result,model_folders,success_sim,0);
                    success_sim = true;
                catch ME
                    % disp("n:" + n + " abstol_sim: " + abstol_sim + "  reltol_sim: " + reltol_sim + " "+ ME.identifier)
                    success_sim = false;
                    % disp("check your abstol_sim value")
                end
                if success_sim
                    break
                end
                abstol_sim = abstol_sim/10;

            end
            % end
            if success_sim
                break
            end
            abstol_sim = abstol_sim_ini;
            reltol_sim = reltol_sim/10;

        end

        abstol_sim = abstol_sim_ini;
        reltol_sim = reltol_sim_ini;
        % if ~success_sim
        %     % disp("n: " + n + " E" + (n-1) + " fail_sim_1" + " last error: "+ ME.identifier)
        %     try
        %         ssa(:,n) = f_eq(n+stg.expn,stg,sim_par,ssa,result,model_folders,success_eq);
        %         while reltol_sim >= reltol_min_sim
        %             while abstol_sim >= abstol_min_sim
        %                 % abstol_sim
        %                 try
        % 
        %                     % try
        %                     %     [ssa,success_eq] = equilibrate_2(n,stg,sim_par,result,model_folders,sbtab,is_not_first_experiment,start_values_equal,previous_simulation_valid,reltol_sim,reltol_min_eq,reltol_sim,abstol_sim,abstol_min_eq,abstol_sim);
        %                     % catch ME
        %                     %     error(n + " fail_eq " + ME.identifier)
        %                     % end
        %                     stg.reltol = reltol_sim;
        %                     stg.abstol = abstol_sim;
        %                     result = f_sim(n,stg,sim_par,ssa,result,model_folders,success_sim,0);
        %                     success_sim = true;
        %                 catch ME
        %                     % disp("n:" + n + " abstol_sim: " + abstol_sim + "  reltol_sim: " + reltol_sim + " "+ ME.identifier)
        %                     success_sim = false;
        %                     % disp("check your abstol_sim value")
        %                 end
        %                 if success_sim
        %                     break
        %                 end
        %                 abstol_sim = abstol_sim/10;
        % 
        %             end
        %             % end
        %             if success_sim
        %                 break
        %             end
        %             abstol_sim = abstol_sim_ini;
        %             reltol_sim = reltol_sim/10;
        % 
        %         end
        % 
        %         abstol_sim = abstol_sim_ini;
        %         reltol_sim = reltol_sim_ini;
        %     catch
        %         % disp( "n: " + n + " E" + (n-1) +" Alt_eq failed"+ " last error: "+ ME.identifier)
        %     end
        % end
        if ~success_sim

            % disp("n: " + n + " E" + (n-1) + " fail_sim_2" + " last error: "+ ME.identifier)
            error_type = "s";
            % for fail = stg.exprun
            result.simd{n} = 0;
            % end
            % break
        end

        % Run detailed simulation if required
        if stg.simdetail
            result = f_sim(n+2*stg.expn,stg,sim_par,ssa,result,model_folders,success_eq(n));
        end

        % Check if the simulation output times match the SBTAB data times, if
        % they don't it means that the simulator didn't had enough time to run
        % the model (happens in some unfavorable configurations of parameters,
        % controlled by stg.maxt)
        % Handle cases where the simulation did not run properly
        if result.simd{n} ~= 0
            if ~(size(Data(n).Experiment.t,1) == size(result.simd{n}.Data(:,end),1))
                % disp("time_sim:  " + size(result.simd{n}.Data(:,end),1))
                % disp("data_time: " + size(Data(n).Experiment.t,1))

                % disp("n: " + n + " E" + (n-1) + " fail_sim_out_time" + " time_sim:  " + size(result.simd{n}.Data(:,end),1) + " data_time: " + size(Data(n).Experiment.t,1))

                % while reltol_sim >= reltol_min_sim
                %     while abstol_sim >= abstol_min_sim
                %         % abstol_sim
                %         try
                % 
                %             % try
                %             %     [ssa,success_eq] = equilibrate_2(n,stg,sim_par,result,model_folders,sbtab,is_not_first_experiment,start_values_equal,previous_simulation_valid,reltol_sim,reltol_min_eq,reltol_sim,abstol_sim,abstol_min_eq,abstol_sim);
                %             % catch ME
                %             %     error(n + " fail_eq " + ME.identifier)
                %             % end
                %             stg.reltol = reltol_sim;
                %             stg.abstol = abstol_sim;
                % 
                %             result = f_sim(n,stg,sim_par,ssa,result,model_folders,success_sim,1);
                %             success_sim = true;
                %         catch ME
                %             % disp("n:" + n + " abstol_sim: " + abstol_sim + "  reltol_sim: " + reltol_sim + " "+ ME.identifier)
                %             success_sim = false;
                %             % disp("check your abstol_sim value")
                %         end
                %         if success_sim
                %             break
                %         end
                %         abstol_sim = abstol_sim/10;
                % 
                %     end
                %     % end
                %     if success_sim
                %         break
                %     end
                %     abstol_sim = abstol_sim_ini;
                %     reltol_sim = reltol_sim/10;
                % 
                % end
                % 
                % abstol_sim = abstol_sim_ini;
                % reltol_sim = reltol_sim_ini;
                % if ~success_sim
                %     disp("n: " + n + " E" + (n-1) + " fail_sim_3" + " last error: "+ ME.identifier)
                %     try
                %         ssa(:,n) = f_eq(n+stg.expn,stg,sim_par,ssa,result,model_folders,success_eq);
                %         while reltol_sim >= reltol_min_sim
                %             while abstol_sim >= abstol_min_sim
                %                 % abstol_sim
                %                 try
                % 
                %                     % try
                %                     %     [ssa,success_eq] = equilibrate_2(n,stg,sim_par,result,model_folders,sbtab,is_not_first_experiment,start_values_equal,previous_simulation_valid,reltol_sim,reltol_min_eq,reltol_sim,abstol_sim,abstol_min_eq,abstol_sim);
                %                     % catch ME
                %                     %     error(n + " fail_eq " + ME.identifier)
                %                     % end
                %                     stg.reltol = reltol_sim;
                %                     stg.abstol = abstol_sim;
                %                     result = f_sim(n,stg,sim_par,ssa,result,model_folders,success_sim,1);
                %                     success_sim = true;
                %                 catch ME
                %                     disp("n:" + n + " abstol_sim: " + abstol_sim + "  reltol_sim: " + reltol_sim + " "+ ME.identifier)
                %                     success_sim = false;
                %                     % disp("check your abstol_sim value")
                %                 end
                %                 if success_sim
                %                     break
                %                 end
                %                 abstol_sim = abstol_sim/10;
                % 
                %             end
                %             % end
                %             if success_sim
                %                 break
                %             end
                %             abstol_sim = abstol_sim_ini;
                %             reltol_sim = reltol_sim/10;
                % 
                %         end
                % 
                %         abstol_sim = abstol_sim_ini;
                %         reltol_sim = reltol_sim_ini;
                %     catch
                %         disp( "n: " + n + " E" + (n-1) +" Alt_eq failed"+ " last error: "+ ME.identifier)
                %     end
                % end
                % 
                % if ~success_sim
                %     disp("n: " + n + " E" + (n-1) + " fail_sim_4" + " last error: "+ ME.identifier)
                %     % for fail = stg.exprun
                %     result.simd{n} = 0;
                %     % end
                %     % break
                % end
                % if result.simd{n} ~= 0
                %     if ~(size(Data(n).Experiment.t,1) == size(result.simd{n}.Data(:,end),1))
                %         % disp("time_sim:  " + size(result.simd{n}.Data(:,end),1))
                %         % disp("data_time: " + size(Data(n).Experiment.t,1))
                        % disp("n: " + n + " E" + (n-1) + " fail_sim_out_time_2" + " time_sim:  " + size(result.simd{n}.Data(:,end),1) + " data_time: " + size(Data(n).Experiment.t,1))
                        error_type = "t";
                        result.simd{n} = 0;
                %     end
                % end
            end
        end
    else

        % disp("n: " + n + " E" + (n-1) + " fail_eq")
        % error_type = "e";
        % for fail = stg.exprun
        result.simd{n} = 0;
        % end
        % break
    end
if result.simd{n} == 0
    % disp(error_list_E)
    % error_list_n = append(error_list_n,n+" ");
    error_list_E = append(error_list_E,((n-1)+error_type+" "));
    % disp(error_list_E)
end
end
% disp("i: " + i + " j: " + j + " E: " + error_list_E + " time: " + toc)
end

function [ssa1,success_eq,error_type] = equilibrate_2(n,stg,sim_par,result,model_folders,sbtab,is_not_first_experiment,start_values_equal,previous_simulation_valid,reltol_eq,reltol_min_eq,reltol_eq_ini,abstol_eq,abstol_min_eq,abstol_eq_ini,success_eq)
persistent ssa
error_type = "";
if is_not_first_experiment && start_values_equal && previous_simulation_valid && success_eq
    % Set the start amounts based on the previous experiment
    ssa(:,n) = ssa(:,stg.exprun(find(stg.exprun==n)-1));
    if stg.simdetail
        ssa(:,n+2*stg.expn) = ssa(:,stg.exprun(find(stg.exprun==n)-1));
    end
    success_eq = true;
else
    % disp(n + "1")
    % Set start amounts for species with non-zero values
    for j = 1:size(sbtab.datasets(n).start_amount,1)

        % Set the start amount of the species to the number defined in
        % the sbtab for each experiment
        ssa(sbtab.datasets(n).start_amount{j,3},n+stg.expn) =...
            sbtab.datasets(n).start_amount{j,2};
    end
    % reltol_min_eq
    success_eq = true;
    while reltol_eq >= reltol_min_eq
        % reltol_eq
        while abstol_eq >= abstol_min_eq
            try
                stg.reltol = reltol_eq;
                stg.abstol = abstol_eq;
                
                [ssa,error_type] = equilibrate(n,stg,sim_par,result,model_folders,sbtab,ssa,success_eq);
                success_eq = true;
            catch ME
                error_type = "e1";
                % disp("n:" + n + " abstol_eq:  " + abstol_eq + "  reltol_eq:  " + reltol_eq + " " + ME.message)
                success_eq = false;

                % disp("check your abstol_eq value")
            end
            if success_eq
                break
            end
            abstol_eq = abstol_eq/10;
        end
        % end
        if success_eq
            break
        end
        abstol_eq = abstol_eq_ini;
        reltol_eq = reltol_eq/10;
    end
    % abstol_eq = abstol_eq_ini;
    % reltol_eq = reltol_eq_ini;
    % if ~success_eq
    %     % reltol_min_eq
    %     % reltol_eq
    %     try
    %     ssa(:,n) = f_eq(n+stg.expn,stg,sim_par,ssa,result,model_folders,success_eq);
    %     % disp("sucess!!!  n: " + n + " E" + (n-1) + " abstol_eq:  " + abstol_eq + "  reltol_eq:  " + reltol_eq)
    %     success_eq = true;
    %     catch ME
    %         % disp("n:" + n + " abstol_eq:  " + abstol_eq + "  reltol_eq:  " + reltol_eq + " " + ME.identifier)
    %     end
    % end
end
ssa1=ssa;
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
        sim_par = update_thermo_constrained(sim_par, parameters,settings, n,sbtab);
    end
end
end

function sim_par = update_thermo_constrained(sim_par, parameters, settings, n,sbtab)

key_1 = ["tcm","tcd"];
key_2 = ["*","/"];
for k=1:2

    count = 0;
    for m = 1:size(settings.(key_1(k)), 2)
        if settings.(key_1(k))(n, m) ~= 0
            count = count +1;
        end
    end
    % Iterate over the parameters that need to be multiplied for calculating the
    % parameter that depends on the thermodynamic constraints
    for m = 1:count
        % Check that the parameter that is going to be used to calculate the
        % parameter dependent on thermodynamic constraints is not the default
        if settings.partest(settings.(key_1(k))(n, m), 1) > 0
            % Check if the parameter needs to be set to the value relevant for
            % Profile Likelihood
            if isfield(settings, "PLind") && settings.partest(settings.(key_1(k))(n, m), 1) == settings.PLind
                parameters(settings.partest(settings.(key_1(k))(n, m), 1)) = settings.PLval;
            end
            % Make the appropriate multiplications to get the thermodynamically
            % constrained parameter
            eval("sim_par(n) = sim_par(n) " + key_2(k) + " (10 ^ (parameters(settings.partest(settings.(key_1(k))(n, m), 1))));");
        else
            % Make the appropriate multiplications to get the thermodynamically
            % constrained parameter

            eval("sim_par(n) = sim_par(n) " + key_2(k) + "(sbtab.defpar{settings.(key_1(k))(n, m), 2});");
        end
    end
end
end

function [ssa,error_type] = equilibrate(n,stg,sim_par,result,model_folders,sbtab,ssa,success)
% Equilibrate the model
result = f_sim(n+stg.expn,stg,sim_par,ssa,result,model_folders,success,0);
error_type = "";
if result.simd{n+stg.expn}.Time(end,1) ~= stg.eqt
    % disp("n: " + n + " E" + (n-1) + " time_eq: " + result.simd{n+stg.expn}.Time(end,1) + " stg.eqt: " + stg.eqt)
    error("E" + (n-1) + " fail_eq_out_time")
    error_type = "et";
end
% Update the start amounts based on equilibrium results
for j = 1:size(sbtab.species,1)

    final_amount = result.simd{n+stg.expn}.Data(end,j);
    if final_amount < 1.0e-10
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
% ssa
% result = f_eq(n+stg.expn,stg,sim_par,ssa,result,model_folders,success);
% disp(ssa(:,n)')
% ssa(:,n) = result;
% disp(ssa(:,n)')
% if stg.simdetail
% ssa(j,n+2*stg.expn) = result;
% end
% ssa
end