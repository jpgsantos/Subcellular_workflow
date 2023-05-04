function [settings, results, sb] = f_user_input(model_folders, analysis_options, user_choices)
% This function processes user input for model, analysis options, and
% settings files, and returns settings, results, and sbTab data structures.
% It utilizes helper functions to validate user input, apply settings, and
% manage persistent variables.
%
% Inputs:
% - model_folders: Model folders structure
% - analysis_options: Array of available analysis options
% - user_choices: Cell array of user input choices for model folder,
% analysis, and settings
%
% Outputs:
% - settings: Struct containing all settings for the chosen analysis
% - results: Struct containing the results of the analysis
% - sbTab: Struct containing SBtab data
%
% Used Functions:
% - getValidInput: Validates user input for model folder, analysis option,
% and settings file
% - apply_settings: Updates settings based on chosen settings file and
% checks for changes
% - choose_options: Helps user choose valid options from available choices
% - parse_choices: Presents list of choices to user and validates input
% - compare_and_update: Checks if current and previous values are different
% and clears functions if necessary
%
% Variables:
% Loaded:
% - None
%
% Initialized:
% - results: Empty struct for storing analysis results
% - settings: Empty struct for storing analysis settings
% - sbTab: Empty struct for storing SBtab data
%
% Persistent:
% - last_settings_file_text: Stores the last settings file text
% - last_settings_file_date: Stores the last settings file date
% - last_model_folder: Stores the last chosen model folder
% - last_analysis_text: Stores the last chosen analysis option
% - last_settings_file_text: Stores the last chosen settings file text
% - last_SBtab_date: Stores the last SBtab date
% - functions_cleared: Flag indicating if functions have been cleared or
% not



% Define persistent variables to store the last settings file text and
% date.
persistent last_settings_file_text
persistent last_settings_file_date

% Initialize the results, settings and sbTab variables.
results = [];
settings = [];
sb = [];
functions_cleared = 0;

% Set model folder paths
general_model_folder = model_folders.main + "Model/";

% Get the valid model folder based on user input.
model_folder =...
    getValidInput(general_model_folder, user_choices{1}, "model folder");
specific_model_folder = general_model_folder + model_folder;

% Get the valid analysis option based on user input.
analysis_text =...
    getValidInput(analysis_options, user_choices{2}, "analysis option");

% Store the name of the chosen analysis in the settings struct
settings.analysis = analysis_text;

% Process user input for analysis options 1-5 and 8
if any(contains(analysis_options([1:5, 8]), analysis_text))

    % Set settings folder path based on user input
    settings_folder = specific_model_folder + "/Matlab/Settings/";
    settings_file_text =...
        getValidInput(settings_folder, user_choices{3}, "settings file");

    % Apply settings and return the settings struct
    [settings,last_settings_file_text,last_settings_file_date] = ...
        apply_settings(settings, settings_folder, settings_file_text,...
        last_settings_file_date,last_settings_file_text, analysis_options,...
        analysis_text, specific_model_folder, functions_cleared);

    % Process user input for analysis options 6-7
elseif any(contains(analysis_options(6:7), analysis_text))

    % Set results folder path
    results_folder = specific_model_folder + "/Matlab/Results";

    % Get the analysis to be reproduced based on user input.
    last_choice = [];
    prompt = "\nWhat analysis should be reproduced?\n";

    [r_analysis_text,~] =...
        choose_options(results_folder,prompt,last_choice);

    specific_results_folder = results_folder + "/" + ...
        r_analysis_text;

    % Get the date of the original analysis based on user input.
    last_choice = [];
    prompt = "\nWhen was this analysis run originaly?\n";

    [r_analysis_date_text,~] =...
        choose_options(specific_results_folder,prompt,last_choice);

    specific_results_folder_date = specific_results_folder + "/" + ...
        r_analysis_date_text;

    % Load the settings file and the SBtab struct
    load(specific_results_folder_date + "/Analysis.mat","settings","sb")

    % Set inport to false since we don't want to overwrite anything
    settings.import = false;

    % If the reproduction of an analysis is chosen, clear the functions
    % because the settings most likely changed.
        f_functions_to_clear()

    % If the reproduction of the plots of an analysis is chosen, set the
    % code to produce plots and load the results that were previously
    % obtained.
    if contains(analysis_options(7),analysis_text)
        % Store the name of the chosen analysis in the settings struct
        settings.analysis = analysis_text;

        settings.plot = true;
        load(specific_results_folder_date + "/Analysis.mat","results")
    end
end

% % Store the name of the chosen analysis in the settings struct
% settings.analysis = analysis_text;

% Set the chosen model folder in the settings struct
settings.folder_model = model_folder;
end

function [settings, last_settings_file_text, last_settings_file_date] = ...
    apply_settings(settings, settings_folder, settings_file_text, ...
    last_settings_file_date, last_settings_file_text, analysis_options, ...
    analysis_text, specific_model_folder, functions_cleared)
% Function apply_settings updates the settings based on the chosen settings
% file and checks if any changes have been made to the settings file or the
% SBtab since the last analysis

persistent last_SBtab_date

settings_file = strrep(settings_file_text, ".m", "");

% Add the default settings to the struct
stg_add_default = eval("default_settings()");

% Iterate through the fields of the default settings struct and add them to
% the settings struct
f = fieldnames(stg_add_default);
for i = 1:length(f)
    settings.(f{i}) = stg_add_default.(f{i});
end

% Add chosen settings to the struct overwriting defaults when appropriate
[stg_add] = eval(settings_file + "()");

% Iterate through the fields of the chosen settings struct and add them to
% the settings struct, overwriting the default values if necessary
f = fieldnames(stg_add);
for i = 1:length(f)
    settings.(f{i}) = stg_add.(f{i});
end

% Check if the date of the settings file changed, if so clear functions
listing = dir(settings_folder);
for n = 1:size(listing, 1)
    if matches(settings_file_text, listing(n).name, "IgnoreCase", true)
        settings_file_date = listing(n).date;
    end
end

if isempty(last_settings_file_date)
    settings.import = true;
else
    settings.import = false;
end

% Check if the date of the settings file changed, if so clear functions
[last_settings_file_date, functions_cleared] = ...
    compare_and_update(settings_file_date, last_settings_file_date, functions_cleared);

% Check if the name of the settings file changed, if so clear functions
[last_settings_file_text, functions_cleared] = ...
    compare_and_update(settings_file_text, last_settings_file_text, functions_cleared);

% Check if the date of the SBtab changed, if so clear functions
listing = dir(specific_model_folder);

for n = 1:size(listing, 1)
    if matches(settings.sbtab_excel_name, listing(n).name, "IgnoreCase", true)
        sbtab_date = listing(n).date;
    end
end

[last_SBtab_date, functions_cleared] = ...
    compare_and_update(sbtab_date, last_SBtab_date, functions_cleared);

if functions_cleared == 1
    settings.import = true;
end

if contains(analysis_options(8), analysis_text)
    settings.import = true;
    settings.save_results = false;
    settings.plot = false;
end
end

function valid_input = getValidInput(options, user_choice, input_type)
% Function getValidInput validates the user input for the model folder,
% settings file, and analysis option

persistent last_model_folder
persistent last_analysis_text
persistent last_settings_file_text

valid_input = user_choice;

% Check the validity of the input based on the input_type
switch input_type
    case "model folder"

        % If the input is a valid model folder, return it
        if isstring(user_choice) && isfolder(options + valid_input)
            disp("The " + input_type + " chosen was: " + valid_input)
            return;
            % Otherwise, prompt the user to choose a valid one
        else
            disp("The chosen " + input_type + " is not valid, please choose a valid " + input_type)
            prompt = "What " + input_type + " should be used?\n";
            [valid_input, last_model_folder] = choose_options(options, prompt, last_model_folder);
        end

    case "settings file"
        % If the input is a valid settings file, return it
        if isstring(user_choice) && isfile(options + valid_input)
            disp("The " + input_type + " chosen was: " + valid_input)
            return;
            % Otherwise, prompt the user to choose a valid one
        else
            disp("The chosen " + input_type + " is not valid, please choose a valid " + input_type)
            prompt = "What " + input_type + " should be used?\n";
            [valid_input, last_settings_file_text] = choose_options(options, prompt, last_settings_file_text);
        end
    case "analysis option"
        % If the input is not a valid analysis, prompt the user to choose a
        % valid analysis
        if isstring(user_choice) || ~(user_choice >= 1) || ~(user_choice <= 8)
            disp("The chosen " + input_type + " is not valid, please choose a valid " + input_type)
            prompt = "What " + input_type + " should be used?\n";
            [valid_input, last_analysis_text] = parse_choices(prompt, options, last_analysis_text);
            % Otherwise, if the analysis is valid, return it
        else
            valid_input = options(user_choice);
            disp("The " + input_type + " chosen was: " + valid_input)
        end
end
end

function [choice, last_choice] = choose_options(folder, prompt, last_choice)
% Function choose_options helps user to choose valid options from available
% choices

listing = dir(folder);

% Remove unnecessary entries from the listing
for n = size(listing, 1):-1:1
    if any(matches(listing(n).name, [".", "..", "Place models here.txt"]))
        listing(n) = [];
    end
end

% Create an options array containing the names of the valid choices
for n = 1:size(listing, 1)
    folder(n) = string(listing(n).name);
end

% Call parse_choices to handle user input
[choice, last_choice] = parse_choices(prompt, folder, last_choice);
end

function [choice, last_choice] = parse_choices(prompt, options, last_choice)
% Function parse_choices presents a list of choices to the user and
% validates their input, then returns the chosen option

% Build the prompt string with the available options
for n = 1:size(options, 2)
    prompt = prompt + "\n" + n + ": " + options(n);
end

% If there's a last_choice, include it in the prompt as the default
if ~isempty(last_choice)
    if any(contains(options, last_choice))
        prompt = prompt + "\n\nPress enter to use " + last_choice;
    else
        last_choice = [];
    end
end

prompt = prompt + "\n";

% Get userinput and handle it accordingly
i = input(prompt);

% If the user input is empty, set the choice to an empty array
if isempty(i)
    choice = [];
    % If the user input is a valid index, set the choice to the
    % corresponding option
elseif i > 0 && i < size(options, 2) + 1
    choice = options(i);
    disp("The option chosen was: " + choice)
    % If the user input is invalid, call parse_choices recursively with an
    % updated prompt
else
    prompt = "Please choose from the provided options";
    [choice, last_choice] = parse_choices(prompt, options, last_choice);
end

% If the choice is empty and there's a last_choice, set the choice to
% last_choice
if isempty(choice)
    if ~isempty(last_choice)
        choice = last_choice;
        disp("The option chosen was: " + last_choice)
    else
        prompt = "Please choose from the provided options";
        [choice, last_choice] = parse_choices(prompt, options, last_choice);
    end
else
    last_choice = choice;
end
end

function [previous, is_cleared] = compare_and_update(current, previous, is_cleared)
% Function compare_and_update checks if the current and previous values are
% different and clears the functions if necessary

% If there's a previous value, compare it with the current value
if ~isempty(previous)
    % If the current and previous values are different, clear functions if
    % not already cleared
    if ~contains(current, previous)
        if is_cleared == false
            disp("Settings file changed, clearing functions")
            f_functions_to_clear()
            is_cleared = true;
        end
    end
end
% Update the previous value to the current value
previous = current;
end