function [stg,rst,sb] = f_user_input(mmf,analysis_options)

persistent last_SBtab_date
persistent last_model_folder
persistent last_settings_file_text
persistent last_settings_file_date
persistent last_analysis_text

Matlab_main_folder = mmf.main;

rst = [];
sb = [];
functions_cleared = false;

% Get the folder of the model
model_folder_general = Matlab_main_folder + "Model/";
last_choice = last_model_folder;
prompt = "What model folder should be used?\n";
[model_folder,last_model_folder] =...
    choose_options(model_folder_general,prompt,last_choice);

model_name_specific = string(model_folder);
folder_model_specific = model_folder_general + "/" + model_name_specific;

prompt = "\nWhat analysis should be performed?\n";
last_choice = last_analysis_text;
[analysis_text,last_analysis_text] =...
    parse_choices(prompt,analysis_options,last_choice);

% analysis_n = find(contains(analysis_options,analysis_text));
    
% Check if an analysis was chosen
if any(contains(analysis_options([1:3,6]),...
        analysis_text))
    
    %Get the Setting file to be used
    settings_folder = folder_model_specific + "/Matlab/Settings";
    last_choice = last_settings_file_text;
    prompt = "\nWhat file should be used as settings?\n";
    [settings_file_text,last_settings_file_text] =...
        choose_options(settings_folder,prompt,last_choice);
    
    settings_file = strrep(settings_file_text,".m","");
    
    % Add the default settings to the struct
    stg_add_default = eval("default_settings()");
    
    f = fieldnames(stg_add_default);
    for i = 1:length(f)
        stg.(f{i}) = stg_add_default.(f{i});
    end
    
    % Add chosen settings to the struct overwriting defaults when
    % appropriate
    [stg_add] = eval(settings_file + "()");
    
    f = fieldnames(stg_add);
    for i = 1:length(f)
        stg.(f{i}) = stg_add.(f{i});
    end
    
    % Check if the date of the settings file changed, if so clear functions
    listing = dir(settings_folder);
    for n = 1:size(listing,1)
        if matches(settings_file_text,listing(n).name,"IgnoreCase",true)
            settings_file_date = listing(n).date;
        end
    end
    
    [last_settings_file_date,functions_cleared] =...
        compare_last(settings_file_date,last_settings_file_date,...
        functions_cleared);
    
    % Check if the name of the settings file changed, if so clear functions
    [last_settings_file_text,functions_cleared] =...
        compare_last(settings_file_text,last_settings_file_text,...
        functions_cleared);
    
    % Check if the date of the SBtab changed, if so clear functions
    listing = dir(folder_model_specific);
    
    for n = 1:size(listing,1)
        if matches(stg.sbtab_excel_name,listing(n).name,"IgnoreCase",true)
            sbtab_date = listing(n).date;
        end
    end
    [last_SBtab_date,~] =...
        compare_last(sbtab_date,last_SBtab_date,functions_cleared);
    
    % Store the name of the chosen analysis in the settings struct
    stg.analysis = analysis_text;

    if contains(analysis_options(6),analysis_text)
        stg.import = true;
        stg.save_results = false;
        stg.plot = false;
    end
elseif any(contains(analysis_options(4:5),analysis_text))
    
    % Get the folder of the Analysis that should be reproduced
    folder_results = folder_model_specific + "/Matlab/Results";
    
    last_choice = [];
    prompt = "\nWhat analysis should be reproduced?\n";

    [r_analysis_text,~] =...
        choose_options(folder_results,prompt,last_choice);
    
    folder_results_specific = folder_results + "/" + ...
        r_analysis_text;
    
    last_choice = [];
    prompt = "\nWhen was this analysis run originaly?\n";
  
    [r_analysis_date_text,~] =...
        choose_options(folder_results_specific,prompt,last_choice);
    
    folder_results_specific_date = folder_results_specific + "/" + ...
        r_analysis_date_text;
    
    % Load the settings file and the SBtab struct
    load(folder_results_specific_date + "/Analysis.mat","stg","sb")
    
    % Set inport to false since we don't want to overwrite anything
    stg.import = false;
    
    % If the reproduction of an analysis is chosen clear the functions
    % because the settings most likely changed
    if contains(analysis_options(4),analysis_text)
        f_functions_to_clear()
    end
    
    % I the reproduction of the plots of an analyis is chosen make sure
    % we tell the code to produce plots and also load the results that were
    % previously obtained
    if contains(analysis_options(5),analysis_text)
        stg.plot = true;
        load(folder_results_specific_date + "/Analysis.mat","rst")
    end
end

% Set the chosen model folder in the settings struct
stg.folder_model = model_name_specific;
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