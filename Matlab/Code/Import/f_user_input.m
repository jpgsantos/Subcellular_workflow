function [stg,rst, sb] = f_user_input(mmf, analysis_options, user_choices)

persistent last_settings_file_text
persistent last_settings_file_date

rst = [];
stg = [];
sb = [];
functions_cleared = 0;

general_model_folder = mmf.main + "Model/";

model_folder = get_model_folder(general_model_folder, user_choices{1});

specific_model_name = model_folder;
specific_model_folder = general_model_folder + "/" + specific_model_name;


analysis_text = get_analysis(analysis_options, user_choices{2});

if any(contains(analysis_options([1:5,8]),...
        analysis_text))

settings_folder = specific_model_folder + "/Matlab/Settings";
[settings_file_text,last_settings_file_text] = get_settings_file(settings_folder, user_choices{3}, last_settings_file_text);

[stg,last_settings_file_text,last_settings_file_date] = ...
    apply_settings(stg, settings_folder, settings_file_text,...
    last_settings_file_date,last_settings_file_text, analysis_options,...
 analysis_text, specific_model_folder, specific_model_name, functions_cleared);

elseif any(contains(analysis_options(6:7),analysis_text))

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
    load(specific_results_folder_date + "/Analysis.mat","stg","sb")

    % Set inport to false since we don't want to overwrite anything
    stg.import = false;

    % If the reproduction of an analysis is chosen clear the functions
    % because the settings most likely changed
    if contains(analysis_options(6),analysis_text)
        f_functions_to_clear()
    end

    % If the reproduction of the plots of an analyis is chosen make sure
    % we tell the code to produce plots and also load the results that were
    % previously obtained
    if contains(analysis_options(7),analysis_text)
        stg.plot = true;
        load(specific_results_folder_date + "/Analysis.mat","rst")
    end
end


% Set the chosen model folder in the settings struct
stg.folder_model = specific_model_name;
end


function model_folder = get_model_folder(general_model_folder, user_choice)

persistent last_model_folder

if isstring(user_choice)
    model_folder = user_choice;
    last_model_folder = model_folder;
    disp("The model folder chosen was: " + model_folder)
    if not(isfolder(general_model_folder + model_folder))
        disp("This folder does not exist, please choose a valid folder")
        last_choice = last_model_folder;
        prompt = "What model folder should be used?\n";
        [model_folder,last_model_folder] =...
            choose_options(general_model_folder, prompt, last_choice);
    end
else
    last_choice = last_model_folder;
    prompt = "What model folder should be used?\n";
    [model_folder,last_model_folder] =...
        choose_options(general_model_folder, prompt, last_choice);
end
end

function analysis_text = get_analysis(analysis_options, user_choice)

persistent last_analysis_text

if user_choice >= 1 && user_choice <= 8
    analysis_text = analysis_options(user_choice);
    last_analysis_text = analysis_text;
    disp("The analysis chosen was: " + analysis_text)
else
    disp("The analysis chosen does not exist, please choose a valid analysis")
    prompt = "\nWhat analysis should be performed?\n";
    last_choice = last_analysis_text;
    [analysis_text,last_analysis_text] =...
        parse_choices(prompt, analysis_options, last_choice);
end
end

function [settings_file_text,last_settings_file_text] = get_settings_file(settings_folder, user_choice, last_settings_file_text)

if isstring(user_choice)
    settings_file_text = user_choice;
    disp("The model settings file chosen was: " + settings_file_text)
    if not(isfile(settings_folder + "/"+ settings_file_text))
        disp("This file does not exist, please choose a valid file")
        last_choice = last_settings_file_text;
        prompt = "\nWhat file should be used as settings?\n";
        [settings_file_text,last_settings_file_text] = choose_options(settings_folder, prompt, last_choice);
    end
else
    last_choice = last_settings_file_text;
    prompt = "\nWhat file should be used as settings?\n";
    [settings_file_text,last_settings_file_text] = choose_options(settings_folder, prompt, last_choice);
end
end

function [stg,last_settings_file_text,last_settings_file_date] =...
    apply_settings(stg, settings_folder, settings_file_text,...
    last_settings_file_date,last_settings_file_text, analysis_options,...
    analysis_text, specific_model_folder, functions_cleared)
persistent last_SBtab_date

settings_file = strrep(settings_file_text, ".m", "");
% Add the default settings to the struct
stg_add_default = eval("default_settings()");

f = fieldnames(stg_add_default);
for i = 1:length(f)
    stg.(f{i}) = stg_add_default.(f{i});
end

% Add chosen settings to the struct overwriting defaults when appropriate
[stg_add] = eval(settings_file + "()");

f = fieldnames(stg_add);
for i = 1:length(f)
    stg.(f{i}) = stg_add.(f{i});
end

% Check if the date of the settings file changed, if so clear functions
listing = dir(settings_folder);
for n = 1:size(listing, 1)
    if matches(settings_file_text, listing(n).name, "IgnoreCase", true)
        settings_file_date = listing(n).date;
    end
end

if isempty(last_settings_file_date)
    stg.import = true;
else
    stg.import = false;
end

% Check if the date of the settings file changed, if so clear functions
[last_settings_file_date, functions_cleared] =...
    compare_last(settings_file_date, last_settings_file_date, functions_cleared);

% Check if the name of the settings file changed, if so clear functions
[last_settings_file_text, functions_cleared] =...
    compare_last(settings_file_text, last_settings_file_text, functions_cleared);

% Check if the date of the SBtab changed, if so clear functions
listing = dir(specific_model_folder);

for n = 1:size(listing, 1)
    if matches(stg.sbtab_excel_name, listing(n).name, "IgnoreCase", true)
        sbtab_date = listing(n).date;
    end
end

[last_SBtab_date, functions_cleared] = ...
    compare_last(sbtab_date, last_SBtab_date, functions_cleared);

% Store the name of the chosen analysis in the settings struct
stg.analysis = analysis_text;

if functions_cleared == 1
    stg.import = true;
end

if contains(analysis_options(8), analysis_text)
    stg.import = true;
    stg.save_results = false;
    stg.plot = false;
end
end

function [choice,last_choice] = choose_options(folder,prompt,last_choice)

listing = dir(folder);

for n = size(listing,1):-1:1
    if any(matches(listing(n).name,[".","..","Place models here.txt"]))
        listing(n)= [];
    end
end

for n = 1:size(listing,1)
    options(n) = string(listing(n).name);
end

[choice,last_choice] = parse_choices(prompt,options,last_choice);
end

function [choice,last_choice] = parse_choices(prompt,options,last_choice)

for n = 1:size(options,2)
    prompt = prompt + "\n" + n + ": " + options(n);
end

if ~isempty(last_choice)
    if any(contains(options,last_choice))
        prompt = prompt + "\n\nPress enter to use " + last_choice;
    else
        last_choice = [];
    end
end

prompt = prompt + "\n";

i = input(prompt);

if isempty(i)
    choice = [];
elseif i > 0 && i < size(options,2)+1
    choice = options(i);
    disp("The option chosen was: " + choice)
else
    prompt = "Please choose from the provided options";
    [choice,last_choice] = parse_choices(prompt,options,last_choice);
end

if isempty(choice)
    if ~isempty(last_choice)
        choice = last_choice;
        disp("The option chosen was: " + last_choice)
    else
        prompt = "Please choose from the provided options";
        [choice,last_choice] = parse_choices(prompt,options,last_choice);
    end
else
    last_choice = choice;
end
end

function [previous,f_cleared] = compare_last(current,previous,f_cleared)

if ~isempty(previous)
    if ~contains(current,previous)
        if f_cleared == false
            disp("Settings file changed, clearing functions")
            f_functions_to_clear()
            f_cleared = true;
        end
    end
end
previous = current;
end