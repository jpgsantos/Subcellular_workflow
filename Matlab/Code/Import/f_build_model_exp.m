function f_build_model_exp(stg, sb, mmf)
% This function generates .mat files for equilibrium and proper simulation
% runs for a set of experiments. It reads experiment settings from an sbtab
% structure, configures the simulation settings, processes input and output
% species, and saves the resulting .mat files.
%
% Inputs:
% - stg: A structure containing settings for the simulations, including
% maximum wall clock time, stop times, dimensional analysis, unit
% conversion, tolerances, step sizes, and time units.
% - sb: An sbtab structure containing information about experiments, such
% as output values, output species, output units, input times, input
% values, and input species.
% - mmf: A model management framework structure containing the data and mat
% models, which include data_model, mat_model, model_exp_eq, 
% model_exp_default, and model_exp_detail.
%
% Outputs:
% - Equilibrium and proper simulation run .mat files for each experiment, 
% saved with filenames based on model_exp_eq, model_exp_default, and
% model_exp_detail.
%
% Called Functions:
% - getconfigset: Retrieves the configuration set object from a SimBiology
% model.
% - copyobj: Creates a copy of a SimBiology model object.
% - set: Sets properties of a SimBiology object.
% - load: Loads variables from .mat files.
% - save: Saves variables to .mat files.
% - addspecies: Adds species to a SimBiology model compartment.
% - addrule: Adds rules to a SimBiology model.
% - addparameter: Adds parameters to a SimBiology model.
% - addevent: Adds events to a SimBiology model.
% 
% Variables:
% Loaded:
% - data_model: File path of the data_model .mat file containing Data and
% sbtab.
% - mat_model: File path of the mat_model .mat file containing the
% SimBiology model object.
% - model_exp_eq: File path prefix for saving equilibrium simulation run
% .mat files.
% - model_exp_default: File path prefix for saving proper simulation run
% .mat files.
% - model_exp_detail: File path prefix for saving detailed simulation run
% .mat files.
% - Data: Data structure containing experiment time points.
% - sbtab: sbtab structure containing experiment settings and information.
% - modelobj: SimBiology model object loaded from the mat_model file.
%
% Initialized:
% - None
%
% Persistent:
% - None
%
% Notes:
% - The function iterates through all experiments, configuring simulation
% settings and processing species for each experiment, then saves the
% corresponding .mat files.

% Load data_model and mat_model files
data_model = mmf.model.data.data_model;
mat_model = mmf.model.data.mat_model;
model_exp_eq = mmf.model.data.model_exp.equilibration;
model_exp_default = mmf.model.data.model_exp.default;
model_exp_detail = mmf.model.data.model_exp.detail;

% Load Data and modelobj from data_model and mat_model files
load(data_model, 'Data', 'sbtab')
load(mat_model, 'modelobj');

% Initialize model_run and configsetObj arrays
model_run = cell(size(sb.Experiments.ID, 1), 1);
configsetObj = cell(size(sb.Experiments.ID, 1), 1);

% Loop through all experiments
for number_exp = 1:size(sb.Experiments.ID, 1)
    
    % Load sbtab dataset information
    output_value = sbtab.datasets(number_exp).output_value;
    output = sbtab.datasets(number_exp).output;
    output_unit = sbtab.datasets(number_exp).output_unit;
    input_time = sbtab.datasets(number_exp).input_time;
    input_value = sbtab.datasets(number_exp).input_value;
    input_species = sbtab.datasets(number_exp).input;
    
    % Initialize model and configuration set objects for the current
    % experiment
    model_run{number_exp} = copyobj(modelobj);
    configsetObj{number_exp} = getconfigset(model_run{number_exp});
    
    % Configure simulation settings for the equilibrium simulation run
    set(configsetObj{number_exp}, 'MaximumWallClock', 0.2);
    set(configsetObj{number_exp}, 'StopTime', stg.eqt);
    set(configsetObj{number_exp}.CompileOptions, ...
        'DimensionalAnalysis', stg.dimenanal);
    set(configsetObj{number_exp}.CompileOptions, ...
        'UnitConversion', stg.UnitConversion);
    set(configsetObj{number_exp}.SolverOptions, ...
        'AbsoluteToleranceScaling', stg.abstolscale);
    set(configsetObj{number_exp}.SolverOptions, ...
        'RelativeTolerance', stg.reltol);
    set(configsetObj{number_exp}.SolverOptions, ...
        'AbsoluteTolerance', stg.abstol);
    set(configsetObj{number_exp}.SolverOptions, ...
        'AbsoluteToleranceStepSize', stg.abstolstepsize_eq);
    helper = [0,10 .^ (-20: 0.01: log10(stg.eqt))];
    if helper(end) ~= stg.eqt
        helper = [helper,stg.eqt];
    end

    set(configsetObj{number_exp}.SolverOptions, 'OutputTimes', ...
        helper);
    set(configsetObj{number_exp}, 'TimeUnits', stg.simtime);
    set(configsetObj{number_exp}.SolverOptions, 'MaxStep', stg.maxstepeq);

    % Save equilibrium simulation run .mat file
    model_exp = model_run{number_exp};
    config_exp = configsetObj{number_exp};
    save(model_exp_eq + number_exp + ".mat", 'model_exp', 'config_exp')
    sbiosaveproject(model_exp_eq + number_exp, 'modelobj')

    % Update simulation settings for the proper simulation run
    set(configsetObj{number_exp}, 'MaximumWallClock', stg.maxt);
    set(configsetObj{number_exp}, 'StopTime', sbtab.sim_time(number_exp));
    set(configsetObj{number_exp}.SolverOptions, 'OutputTimes', ...
        Data(number_exp).Experiment.t);
    set(configsetObj{number_exp}.SolverOptions, 'MaxStep', stg.maxstep);
    
    % Process output species. Adds output species and rules
    for n = 1:size(output, 2)
        % Check if output species exist in the model
        m = 0;
        for k = 1:size(model_run{number_exp}.species, 1)
            if model_run{number_exp}.species(k).name == ...
                    string(output{1, n})
                model_run{number_exp}.species(k).BoundaryCondition = 1;
                m = 1;
            end
        end
        % If output species does not exist, add it to the model
        if m == 0
            if strcmp( output_unit{1, n}, 'dimensionless' )
                warning('off', 'SimBiology:InvalidSpeciesInitAmtUnits')
            else
                warning('on', 'SimBiology:InvalidSpeciesInitAmtUnits')
            end
            addspecies (model_run{number_exp}.Compartments(1), ...
                char(output{1, n}), 0, ...
                'InitialAmountUnits', output_unit{1, n});
        end
        % Add repeated assignment rule for output species
        addrule(model_run{number_exp}, char(output_value{1, n}), ...
            'repeatedAssignment');
    end
    
    % Process input species. Adds input species and rules, either as events
    % or repeated assignments
    for j = 1:size(input_species, 2)
        
        input_indexcode = str2double(strrep(input_species(j), 'S', ''));
        input_name = string(model_run{number_exp}.species(1 + ...
                input_indexcode).name);
        
        % If the input time is less than 100, add events
        if size(input_time{j}, 2) < 100
            
            model_run{number_exp}.species(...
                1 + input_indexcode).BoundaryCondition = 1;
            for n = 1:size(input_time{j}, 2)
                if ~isnan(input_time{j}(n))

                    % Add parameters for time and input values
                    addparameter(model_run{number_exp}, ...
                        char("time_event_t_" + j + "_" +  n), ...
                        str2double(string(input_time{j}(n))), ...
                        'ValueUnits', char(stg.simtime));
                    
                    addparameter(model_run{number_exp}, ...
                        char("time_event_r_" + j + "_" +  n), ...
                        str2double(string(input_value{j}(n))), ...
                        'ValueUnits', ...
                        char(model_run{number_exp}.species(1 + ...
                        input_indexcode).InitialAmountUnits));

                    % Add event for input species
                    addevent(model_run{number_exp}, ...
                        char("time>=time_event_t_" + j + "_" +  n), ...
                        cellstr( ...
                        sbtab.datasets(number_exp).output_location{1} + ...
                        "." + input_name + ...
                        " = time_event_r_" + j + "_" +  n));
                end
            end
        else
            % If the input time is greater than or equal to 100, add
            % repeated assignment rule
            addrule(model_run{number_exp}, char(sbtab.datasets(...
                number_exp).output_location{1} + "." + input_name + ...
                "=" + string(model_run{number_exp}.name) + "_input" + ...
                number_exp + "_" + input_name + "(time)"), ...
                'repeatedAssignment');
        end
    end

    % Save proper simulation run .mat file (default)
    model_exp = model_run{number_exp};
    config_exp = configsetObj{number_exp};
    save(model_exp_default + number_exp + ".mat", ...
        'model_exp', 'config_exp')
    sbiosaveproject(model_exp_default + number_exp, 'model_exp')


    % Update simulation settings for detailed simulation run
    set(configsetObj{number_exp}.SolverOptions, 'OutputTimes', []);
    set(configsetObj{number_exp}.SolverOptions, ...
        'MaxStep', stg.maxstepdetail);

    % Save detailed simulation run .mat file
    model_exp = model_run{number_exp};
    config_exp = configsetObj{number_exp};
    save(model_exp_detail + number_exp + ".mat", 'model_exp', 'config_exp')
    
end
end