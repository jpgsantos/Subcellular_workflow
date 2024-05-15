function f_sbtab_to_model(stg, sb, mmf)
% This function, f_sbtab_to_model, converts an SBtab data structure into a
% model format that can be used for simulations and analysis. It then saves
% the model in .mat, .sbproj, and .xml formats for future use. The function
% also processes experimental settings defined in the SBtab data structure, 
% adding compartments, species, parameters, reactions, expressions, inputs, 
% constants, and boundary conditions to the model.
% 
% Inputs:
% - stg: Settings structure containing configuration information
% - sb: SBtab data structure containing information about species, 
% reactions, compartments, and parameters
% - mmf: Model management files structure containing the paths to save the
% model
%
% Outputs:
% - No direct outputs, but the function saves the model in .mat, .sbproj, 
% and .xml formats
%
% Used Functions:
% - add_reactions_to_model: Adds reactions from the SBtab data structure to
% the model object
% - set_boundary_Condition: Sets boundary conditions for the model
% - add_expressions_to_model: Adds expressions from the SBtab data
% structure to the model object
% - add_inputs_to_model: Adds inputs from the SBtab data structure to the
% model object
% - add_constants_to_model: Adds constants from the SBtab data structure to
% the model object
% - process_experiments: Processes experimental data from the SBtab data
% structure
%
% Variables
% Loaded:
% - sbtab.species: Species related data from the SBtab data structure
% - sbtab.defpar: Default parameter related data from the SBtab data
% structure
% - sbtab.sim_time: Simulation time extracted from the SBtab data structure
%
% Initialized:
% - modelobj: Initialized model object
% - compobj: Initialized compartment object
%
% Persistent:
% - None

% Initialize the model object and compartment object
modelobj = sbiomodel(stg.name);
compobj = [];

% Combine species related data into sbtab.species
sbtab.species = ...
    [sb.Compound.Name, sb.Compound.InitialValue, sb.Compound.IsConstant, ...
    sb.Compound.Unit, sb.Compound.Location];
% Combine default parameter related data into sbtab.defpar
sbtab.defpar = ...
    [sb.Parameter.Comment, sb.Parameter.Value_linspace, sb.Parameter.Unit];

% Add compartments to the model Iterate through each compartment in the
% SBtab data structure and add it to the model
for n = 1:size(sb.Compartment.ID, 2)
    compobj{n} = addcompartment(modelobj, sb.Compartment.Name{n});
    set(compobj{n}, 'CapacityUnits', sb.Compartment.Unit{n});
    set(compobj{n}, 'Value', sb.Compartment.Size{n});
end

% Add species to the compartments Iterate through each species in the SBtab
% data structure and add it to the appropriate compartment
for n = 1:size(sbtab.species, 1)
    compartment_number_match = ...
        find_compartment_number(compobj, sb.Compound.Location{n});
    addspecies (compobj{compartment_number_match}, sb.Compound.Name{n}, ...
        sb.Compound.InitialValue{n}, ...
        'InitialAmountUnits', sb.Compound.Unit{n});
end

% Add species to the compartments Iterate through each species in the SBtab
% data structure and add it to the appropriate compartment
for n = 1:size(sbtab.defpar, 1)
    addparameter(modelobj, sb.Parameter.Name{n}, ...
        sb.Parameter.Value_linspace{n}, 'ValueUnits', ...
        sb.Parameter.Unit{n}, 'Notes', sb.Parameter.Comment{n});
end

% Add reactions, expressions, inputs, constants, and boundary conditions to
% the model
modelobj = add_reactions_to_model(sb, modelobj);
modelobj = set_boundary_Condition(sb, modelobj);
modelobj = add_expressions_to_model(sb, modelobj);
modelobj = add_inputs_to_model(sb, modelobj);
modelobj = add_constants_to_model(sb, modelobj);

% Extract simulation time from the SBtab data structure
sbtab.sim_time = [sb.Experiments.Sim_Time{:}];
% Process experimental data from the SBtab data structure
[sbtab, Data] = process_experiments(sb, sbtab);

% Save the model in .mat, .sbproj, and .xml formats
sbproj_model = mmf.model.data.sbproj_model;
matlab_model = mmf.model.data.mat_model;
data_model = mmf.model.data.data_model;
xml_model = mmf.model.data.xml_model;

sbiosaveproject(sbproj_model, 'modelobj')
save(matlab_model, 'modelobj')
save(data_model, 'Data', 'sbtab', 'sb')
sbmlexport(modelobj, xml_model)
end

function modelobj = add_constants_to_model(sb, modelobj)
% This function adds constants from sb to the given model object. This
% function checks if the sb structure has a "Constant" field, and if so, 
% iterates through the constants and adds them as parameters to the model
% object.

% Check if the sb object has a "Constant" field
if isfield(sb, "Constant")
    % Iterate through the constants and add them to the model object
    for m = 1:size(sb.Constant.ID, 1)
        addparameter(modelobj, char(sb.Constant.Name(m)), ...
            str2double(string(sb.Constant.Value{m})), ...
            'ValueUnits', sb.Constant.Unit{m});
    end
end
end

function modelobj = add_inputs_to_model(sb, modelobj)
% This function adds inputs from sb to the given model object. This
% function checks if the sb structure has an "Input" field, and if so, 
% iterates through the inputs and adds them as parameters, species, and
% rules to the model object according to the input properties.

% Check if the sb structure contains the 'Input' field
if isfield(sb, "Input")
    % Iterate through all inputs
    for m = 1:size(sb.Input.ID, 1)
        % Check if the input contains the 'Formula' field
        if isfield(sb.Input, 'Formula')
            % If the input formula is a double, add it as a species
            if isa(sb.Input.Formula{m}, 'double')
                addspecies (modelobj, char(sb.Input.Name(m)), ...
                    str2double(string(sb.Input.DefaultValue{m})), ...
                    'InitialAmountUnits', sb.Input.Unit{m});
                % Otherwise, try adding it as a species with initial amount
                % 0
            else
                try
                    addspecies (modelobj, char(sb.Input.Name(m)), 0, ...
                        'InitialAmountUnits', sb.Input.Unit{m});
                catch
                end
                % Add a rule for the species using the input formula
                addrule(modelobj, char({convertStringsToChars(...
                    string(sb.Input.Location{m}) + "." + ...
                    string(sb.Input.Name{m}) + " = " + ...
                    string(sb.Input.DefaultValue{m}))}), ...
                    'repeatedAssignment');
            end
        else
            % If no 'Formula' field, add the input as a parameter
            addparameter(modelobj, char(sb.Input.Name(m)), ...
                str2double(string(sb.Input.DefaultValue{m})), ...
                'ValueUnits', sb.Input.Unit{m});
        end
    end
end
end

function compartment_number = find_compartment_number(compobj, location)
% This function finds the compartment number in compobj corresponding to
% the given location. This function iterates through all compartments in
% compobj and returns the index of the compartment whose name matches the
% given location.

% Iterate through all compartments
for m = 1:size(compobj, 2)
    % Check if the current compartment's name matches the given location
    if strcmp(compobj{m}.Name, location)
        % If it matches, return the index and break the loop
        compartment_number = m;
        break;
    end
end
end

function [sbtab, Data] = process_experiments(sb, sbtab)
% This function processes experiments from sb and stores data in sbtab and
% Data. This function extracts relevant data from sb, a structured
% representation of an SBML model, and stores it in sbtab, a structured
% representation of an SBtab file, and Data structures, used for further
% analysis and processing.

% Initialize species_inp_indices to store the indices of species present in
% sb.Experiments
species_inp_indices = {};
% Iterate through sb.Compound.ID to find species present in sb.Experiments
for n = 1:size(sb.Compound.ID, 1)
    field_name = "S" + (n - 1);
    % Check if sb.Experiments has the field specified in field_name
    if isfield(sb.Experiments, field_name)
        species_inp_indices{end + 1, 1} = n;
    end
end
% Iterate through sb.Experiments.ID to process each experiment
for n = 1:size(sb.Experiments.ID, 1)
    start_amount = cell(1, size(species_inp_indices, 1));
    n_start_amount = 0;
    n_input_time = 0;
    n_input = 0;
    n_output = 0;

    % Check if sb.Experiments has a Normalize field, and store it in
    % sbtab.datasets(n).Normalize
    if isfield(sb.Experiments, "Normalize")
        sbtab.datasets(n).Normalize = sb.Experiments.Normalize{n};
    else
        sbtab.datasets(n).Normalize = [];
    end

    % Retrieve the Time data for the current experiment and store it in
    % Data(n).Experiment.t
    experiment_field_name = "E" + (n - 1);
    if isfield(sb.(experiment_field_name), "Time")
        Data(n).Experiment.t = ...
            transpose([sb.(experiment_field_name).Time{:}]);
    end

    % Process input species data for the current experiment
    experiment_input_field_name = "E" + (n - 1) + "I";
    start_amount_name = cell(1, size(species_inp_indices, 1));
    for m = 1:size(sb.Compound.ID, 1)
        field_name = "S" + (m - 1);
        if isfield(sb.Experiments, field_name)
            n_start_amount = n_start_amount + 1;
            start_amount{n_start_amount} = sb.Experiments.(field_name)(n);
            start_amount_name{n_start_amount} = sb.Compound.Name(m);
        end
        % Retrieve input time data for the current experiment and species
        if isfield(sb.(experiment_input_field_name), ...
                "Input_Time_S" + (m - 1))
            n_input_time = n_input_time + 1;
            sbtab.datasets(n).input_time{1, n_input_time} = ...
                [sb.(experiment_input_field_name).("Input_Time_S" + ...
                (m - 1)){:}];
        end
        % Retrieve input value data for the current experiment and species
        if isfield(sb.(experiment_input_field_name), "S" + (m - 1))
            n_input = n_input + 1;
            sbtab.datasets(n).input_value{1, n_input} = ...
                [sb.(experiment_input_field_name).("S" + (m - 1)){:}];
            sbtab.datasets(n).input{n_input} = char("S" + (m - 1));
        end
    end

    % Process output data for the current experiment
    for m = 1:size(sb.Output.ID, 1)
        if isfield(sb.(experiment_field_name), "Y" + (m - 1))
            n_output = n_output + 1;
            % Retrieve output values for the current experiment and output
            Data(n).Experiment.x(:, n_output) = ...
                [sb.(experiment_field_name).("Y" + (m - 1)){:}];
            % Retrieve standard deviation of output values for the current
            % experiment and output
            Data(n).Experiment.x_SD(:, n_output) = ....
                [sb.(experiment_field_name).("SD_Y" + (m - 1)){:}];
            % Store output related information in sbtab.datasets(n)
            sbtab.datasets(n).output{n_output} = sb.Output.Name(m);
            sbtab.datasets(n).output_value{n_output} = ...
                {convertStringsToChars(...
                strrep(string(sb.Output.Location{m}) + "." + ...
                string(sb.Output.Name{m}) + " = " + ...
                string(sb.Output.Formula{m}), 'eps', '0.0001'))};
            sbtab.datasets(n).output_unit{n_output} = sb.Output.Unit{m};
            sbtab.datasets(n).output_name{n_output} = sb.Output.Name(m);
            sbtab.datasets(n).output_ID{n_output} = sb.Output.ID(m);
            sbtab.datasets(n).output_location{n_output} = ...
            sb.Output.Location(m);
        end
    end
    % Store output count and start amount information in sbtab.datasets(n)
    sbtab.datasets(n).stg.outnumber = n_output;
    sbtab.datasets(n).start_amount = cat(2, start_amount_name(:), ...
        transpose([start_amount{:}]), species_inp_indices);
end
end


function model_obj = add_expressions_to_model(sb, model_obj)
% This function adds expressions to the given model object by iterating
% through sb.Expression fields and populating the model object with
% parameters, species, and rules according to the expression properties

% Check if the sb structure contains the 'Expression' field
if isfield(sb, "Expression")
    % Iterate through all expressions
    for m = 1:size(sb.Expression.ID, 1)
        % Check if the expression contains the 'Formula' field
        if isfield(sb.Expression, 'Formula')
            % If the expression formula is a double, add it as a species
            if isa(sb.Expression.Formula{m}, 'double')
                addspecies (model_obj, char(sb.Expression.Name(m)), ...
                    str2double(string(sb.Expression.Formula{m})), ...
                    'InitialAmountUnits', sb.Expression.Unit{m});
                % Otherwise, try adding it as a species with initial amount
                % 0
            else
                try
                    addspecies (model_obj, char(sb.Expression.Name(m)), 0, ...
                        'InitialAmountUnits', sb.Expression.Unit{m});
                catch
                end
                % Add a rule for the species using the expression formula
                addrule(model_obj, char({convertStringsToChars(...
                    string(sb.Expression.Location{m}) + "." + ...
                    string(sb.Expression.Name{m}) + " = " + ...
                    string(sb.Expression.Formula{m}))}), ...
                    'repeatedAssignment');
            end
        else
            % If no 'Formula' field, add the expression as a parameter
            addparameter(model_obj, char(sb.Expression.Name(m)), ...
                str2double(string(sb.Expression.DefaultValue{m})), ...
                'ValueUnits', sb.Expression.Unit{m});
        end
    end
end
end

function model_obj = add_reactions_to_model(sb, model_obj)

num_reactions = size(sb.Reaction.ID, 1);
num_compounds = size(sb.Compound.Name, 1);

% Add reactions to the model
for reaction_idx = 1:num_reactions

    is_reversible = sb.Reaction.IsReversible{reaction_idx};
    reaction_formula = sb.Reaction.ReactionFormula{reaction_idx};
    location = sb.Reaction.Location{reaction_idx};

    % Determine reaction reversibility and modify reaction_name accordingly
    if ischar(is_reversible)
        if contains(is_reversible, "true", 'IgnoreCase', true)
            arrow = ' <-> ';
        else
            arrow = ' -> ';
        end
    else
        if is_reversible
            arrow = ' <-> ';
        else
            arrow = ' -> ';
        end
    end
    reaction = strrep(reaction_formula, '<=>', arrow);
    % Add compartment location to the reaction name
    for compound_idx = 1:num_compounds
        compound_name = string(sb.Compound.Name{compound_idx});
        reaction = insertBefore(string(reaction), " " + compound_name, ...
            " " + location);
    end

    % Remove extra locations that were added when patterns get recognized
    % twice because we are not matching properly
    while contains(reaction, location + " " + location)
        reaction = strrep(reaction, location + " " + location, " " + ...
            location);
    end

    % Remove unnecessary spaces and characters
    while contains(reaction, "  ")
        reaction = strrep(reaction, "  ", " ");
    end

    % Replace the space between the location and the species with a dot
    reaction = strrep(reaction, ...
        location + " ", location + ".");

    % Add the location to the first species of the reaction
    reaction = location + "." + reaction;

    % Add the reaction to the model
    reaction_object = addreaction(model_obj, reaction);
    set(reaction_object, 'ReactionRate', ...
        sb.Reaction.KineticLaw{reaction_idx});
end
end

function model_obj = set_boundary_Condition(sb, model_obj)
% This function sets the boundary conditions for the species in a model
% object based on information in the sb structure.

% Loop over each compound in the sb structure
for n = 1:size(sb.Compound.ID, 1)

    % Extract information about the boundary condition for the current
    % compound
    assignment = sb.Compound.Assignment{n};
    interpolation = sb.Compound.Interpolation{n};
    is_constant = sb.Compound.IsConstant{n};

    % Determine whether the current compound has a boundary condition set
    if ischar(assignment) && contains(lower(assignment), "true")
        % If the assignment field is the string "true", set the boundary
        % condition to 1
        Boundary_Condition = 1;
    elseif isnumeric(assignment) && assignment == 1
        % If the assignment field is the number 1, set the boundary
        % condition to 1
        Boundary_Condition = 1;
    elseif assignment
        Boundary_Condition = 1;
    elseif ischar(interpolation) && contains(lower(interpolation), "true")
        % If the interpolation field is the string "true", set the boundary
        % condition to 1
        Boundary_Condition = 1;
    elseif isnumeric(interpolation) && interpolation == 1
        % If the interpolation field is the number 1, set the boundary
        % condition to 1
        Boundary_Condition = 1;
    elseif interpolation
        Boundary_Condition = 1;
    elseif ischar(is_constant) && contains(lower(is_constant), "true")
        % If the is_constant field is the string "true", set the boundary
        % condition to 1
        Boundary_Condition = 1;
    elseif isnumeric(is_constant) && is_constant == 1
        % If the is_constant field is the number 1, set the boundary
        % condition to 1
        Boundary_Condition = 1;
    elseif is_constant
        Boundary_Condition = 1;
    else
        % If none of the fields indicate a boundary condition, set the
        % boundary condition to 0
        Boundary_Condition = 0;
    end

    model_obj.species(n).BoundaryCondition = Boundary_Condition;
end
end