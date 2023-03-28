function [settings, results, sbTab] = f_user_input(mmf, analysis_options, user_choices)

persistent last_settings_file_text
persistent last_settings_file_date

results = [];
settings = [];
sbTab = [];
functions_cleared = 0;

general_model_folder = mmf.main + "Model/";

model_folder = getValidInput(general_model_folder, user_choices{1}, "model folder");
specific_model_folder = general_model_folder + "/" + model_folder;

analysis_text = getValidInput(analysis_options, user_choices{2}, "analysis option");

% settings_folder = specific_model_folder + "/Matlab/Settings";
% settings_file_text = getValidInput(settings_folder, user_choices{3}, "settings file");

% ... (Rest of the primary function code) ...

% % Apply settings and return the settings struct
% [settings, last_settings_file_text, last_settings_file_date] = ...
%     apply_settings(settings, settings_folder, settings_file_text, ...
%     last_settings_file_date, last_settings_file_text, analysis_options, ...
%     analysis_text, specific_model_folder, functions_cleared);

if any(contains(analysis_options([1:5, 8]), analysis_text))
   
settings_folder = specific_model_folder + "/Matlab/Settings";
settings_file_text = getValidInput(settings_folder, user_choices{3}, "settings file");

% Apply settings and return the settings struct
[settings,last_settings_file_text,last_settings_file_date] = ...
    apply_settings(settings, settings_folder, settings_file_text,...
    last_settings_file_date,last_settings_file_text, analysis_options,...
 analysis_text, specific_model_folder, functions_cleared);

elseif any(contains(analysis_options(6:7), analysis_text))

       % Get the folder of the Analysis that should be reproduced
    results_folder = specific_model_folder + "/Matlab/Results";

    last_choice = [];
    prompt = "\nWhat analysis should be reproduced?\n";

    [r_analysis_text,~] =...
        choose_options(results_folder,prompt,last_choice);

    specific_results_folder = results_folder + "/" + ...
        r_analysis_text;

    last_choice = [];
    prompt = "\nWhen was this analysis run originaly?\n";

    [r_analysis_date_text,~] =...
        choose_options(specific_results_folder,prompt,last_choice);

    specific_results_folder_date = specific_results_folder + "/" + ...
        r_analysis_date_text;

    % Load the settings file and the SBtab struct
    load(specific_results_folder_date + "/Analysis.mat","settings","sbTab")

    % Set inport to false since we don't want to overwrite anything
    settings.import = false;

    % If the reproduction of an analysis is chosen clear the functions
    % because the settings most likely changed
    if contains(analysis_options(6),analysis_text)
        f_functions_to_clear()
    end

    % If the reproduction of the plots of an analyis is chosen make sure
    % we tell the code to produce plots and also load the results that were
    % previously obtained
    if contains(analysis_options(7),analysis_text)
        settings.plot = true;
        load(specific_results_folder_date + "/Analysis.mat","results")
    end

end

% Set the chosen model folder in the settings struct
settings.folder_model = model_folder;
end


function [settings, last_settings_file_text, last_settings_file_date] = ...
    apply_settings(settings, settings_folder, settings_file_text, ...
    last_settings_file_date, last_settings_file_text, analysis_options, ...
    analysis_text, specific_model_folder, functions_cleared)

persistent last_SBtab_date

settings_file = strrep(settings_file_text, ".m", "");
% Add the default settings to the struct
stg_add_default = eval("default_settings()");

f = fieldnames(stg_add_default);
for i = 1:length(f)
    settings.(f{i}) = stg_add_default.(f{i});
end

% Add chosen settings to the struct overwriting defaults when appropriate
[stg_add] = eval(settings_file + "()");

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

% Store the name of the chosen analysis in the settings struct
settings.analysis = analysis_text;

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

persistent last_model_folder
persistent last_analysis_text
persistent last_settings_file_text

valid_input = user_choice;

switch input_type
    case "model folder"
        if isstring(user_choice) && isfolder(options + valid_input)
            disp("The " + input_type + " chosen was: " + valid_input)
            return;
        else
            disp("The chosen " + input_type + " is not valid, please choose a valid " + input_type)
            prompt = "What " + input_type + " should be used?\n";
            [valid_input, last_model_folder] = chooseOptions(options, prompt, last_model_folder);
        end
    case "settings file"
        if isstring(user_choice) && isfolder(options + valid_input)
            disp("The " + input_type + " chosen was: " + valid_input)
            return;
        else
            disp("The chosen " + input_type + " is not valid, please choose a valid " + input_type)
            prompt = "What " + input_type + " should be used?\n";
            [valid_input, last_settings_file_text] = chooseOptions(options, prompt, last_settings_file_text);
        end
    case "analysis option"

        if isstring(user_choice) || ~(user_choice >= 1) || ~(user_choice <= 8)
            disp("The chosen " + input_type + " is not valid, please choose a valid " + input_type)
            prompt = "What " + input_type + " should be used?\n";
            [valid_input, last_analysis_text] = parseChoices(prompt, options, last_analysis_text);
        else
            valid_input = options(user_choice);
            disp("The " + input_type + " chosen was: " + valid_input)
        end
end

end

function [choice, lastChoice] = chooseOptions(folder, prompt, lastChoice)

listing = dir(folder);

for n = size(listing, 1):-1:1
    if any(matches(listing(n).name, [".", "..", "Place models here.txt"]))
        listing(n) = [];
    end
end

for n = 1:size(listing, 1)
    options(n) = string(listing(n).name);
end

[choice, lastChoice] = parseChoices(prompt, options, lastChoice);
end

function [choice, lastChoice] = parseChoices(prompt, options, lastChoice)

for n = 1:size(options, 2)
    prompt = prompt + "\n" + n + ": " + options(n);
end

if ~isempty(lastChoice)
    if any(contains(options, lastChoice))
        prompt = prompt + "\n\nPress enter to use " + lastChoice;
    else
        lastChoice = [];
    end
end

prompt = prompt + "\n";

i = input(prompt);

if isempty(i)
    choice = [];
elseif i > 0 && i < size(options, 2) + 1
    choice = options(i);
    disp("The option chosen was: " + choice)
else
    prompt = "Please choose from the provided options";
    [choice, lastChoice] = parseChoices(prompt, options, lastChoice);
end

if isempty(choice)
    if ~isempty(lastChoice)
        choice = lastChoice;
        disp("The option chosen was: " + lastChoice)
    else
        prompt = "Please choose from the provided options";
        [choice, lastChoice] = parseChoices(prompt, options, lastChoice);
    end
else
    lastChoice = choice;
end
end

function [previous, isCleared] = compare_and_update(current, previous, isCleared)

if ~isempty(previous)
    if ~contains(current, previous)
        if isCleared == false
            disp("Settings file changed, clearing functions")
            f_functions_to_clear()
            isCleared = true;
        end
    end
end
previous = current;
end