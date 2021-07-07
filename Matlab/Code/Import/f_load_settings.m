function [stg,rst,Analysis_n] = f_load_settings(mmf)

    persistent sbtab_date_last

    persistent last_model_folder
    persistent last_model_folder_n

    persistent settings_file_text_last
    persistent settings_file_n_last
    
    persistent settings_file_date_last
    
    persistent Analysis_text_last
    persistent Analysis_n_last

    Matlab_main_folder = mmf.main;

    rst = [];

    % Get the folder of the model
    model_folder_general = Matlab_main_folder + "Model/";
    last_used = last_model_folder;
    last_chosen_n = last_model_folder_n;
    prompt = "What model folder should be used?\n";
    [listing,folder_n,last_model_folder_n,model_folder,last_model_folder] = f_choose(model_folder_general,prompt,last_chosen_n,last_used);

    model_name_specific = string(listing(folder_n).name);
    folder_model_specific = model_folder_general + "/" + model_name_specific;

    %Get the Analysis to be run
    Analysis_options = ["Diagnostics","Optimization","Sensitivity Analysis",...
        "Reproduce a previous Analysis",...
        "Reproduce the plots of a previous Analysis"];

    prompt = "\nWhat analysis should be performed?\n";
    last_chosen_text = Analysis_text_last;
    last_chosen_n = Analysis_n_last;
        [Analysis_n,Analysis_n_last,Analysis_text,Analysis_text_last] =...
        prompt_parser(prompt,Analysis_options,last_chosen_n,last_chosen_text);

    % Check if an analysis was chosen
    if any(contains(["Diagnostics","Optimization","Sensitivity Analysis"],...
            Analysis_text))

        %Get the Setting file to be used
        settings_folder = folder_model_specific + "/Matlab/Settings";
        last_used = settings_file_text_last;
        last_chosen_n = settings_file_n_last;
        prompt = "\nWhat file should be used as settings?\n";
        [listing2,settings_file_n,settings_file_n_last,...
            settings_file_text,settings_file_text_last] =...
            f_choose(settings_folder,prompt,last_chosen_n,last_used);

        % Generate the settings struct to be used
        settings_file = strrep(listing2(settings_file_n).name,".m","");
        
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
        
        % Check if the date of the settings file changed, if so clear
        % functions
        functions_cleared = false;
        settings_file_date = listing2(settings_file_n).date;
        
        [settings_file_date_last,functions_cleared] =...
            compare_choices(settings_file_date,settings_file_date_last,...
            functions_cleared);
        
        % Check if the name of the settings file changed, if so clear
        % functions
        [settings_file_text_last,functions_cleared] =...
            compare_choices(settings_file_text,settings_file_text_last,...
            functions_cleared);

        % Check if the date of the SBtab changed, if so clear functions
        listing = dir(folder_model_specific);

        for n = 1:size(listing,1)
            if matches(stg.sbtab_excel_name,listing(n).name,"IgnoreCase",true)
                sbtab_date = listing(n).date;
            end
        end
        [sbtab_date_last,~] = compare_choices(sbtab_date,...
            sbtab_date_last,functions_cleared);
        
        % Store the name of the chosen analysis in the settings struct
        stg.analysis = Analysis_options(Analysis_n);
    else

        %Get the folder of the Analysis that should be reproduced
        folder_results = folder_model_specific + "/Matlab/Results";
        last_used = [];
        last_chosen_n = [];
        prompt = "What Analysis should be reproduced?\n";
        [listing3,folder_n_2,~,~,~] =...
            f_choose(folder_results,prompt,last_chosen_n,last_used);

        folder_results_specific = folder_results +...
            string(listing3(folder_n_2).name);

        last_used = [];
        last_chosen_n = [];
        prompt = "";
        [listing4,folder_n_3,~,~,~] =...
            f_choose(folder_results_specific,prompt,last_chosen_n,last_used);

        folder_results_specific_date = folder_results_specific +...
            string(listing4(folder_n_3).name);

        load(folder_results_specific_date + "/Analysis.mat","stg","sb")

        if Analysis_n == 4
        end
        if Analysis_n == 5
            stg.plot = true;
            load(folder_results_specific_date + "/Analysis.mat","rst")
        end
    end
    % Set the chosen model folder in the settings struct
    stg.folder_model = model_name_specific;
end

function [listing,chosen_n,last_chosen_n,chosen_text,last_chosen_text] =...
        f_choose(folder,prompt,last_chosen_n,last_chosen_text)

    listing = dir(folder);

    for n = size(listing,1):-1:1
        if matches(listing(n).name,char("."))
            listing(n)= [];
        end
        if matches(listing(n).name,char(".."))
            listing(n)= [];
        end
        if matches(listing(n).name,char("Place models here.txt"))
            listing(n)= [];
        end
    end

    for n = 1:size(listing,1)
        possible_choice(n) = string(listing(n).name);
    end

    [chosen_n,last_chosen_n,chosen_text,last_chosen_text] =...
        prompt_parser(prompt,possible_choice,last_chosen_n,last_chosen_text);
end

function [chosen_n,last_chosen_n,chosen_text,last_chosen_text] =...
    prompt_parser(prompt,possible_choice,last_chosen_n,last_chosen_text)

    for n = 1:size(possible_choice,2)
        prompt = prompt + "\n" + n + ": " + possible_choice(n);
    end

    if ~isempty(last_chosen_text)
        if any(contains(possible_choice,last_chosen_text))
            prompt = prompt + "\n\nPress enter to use " + last_chosen_text;
        else
            last_chosen_text = [];
        end
    end

    prompt = prompt + "\n";

    chosen_n = input(prompt);

    if isempty(chosen_n)
        chosen_text = [];
    elseif chosen_n > 0 && chosen_n < size(possible_choice,2)+1
        chosen_text = possible_choice(chosen_n);
        disp("The choice was: " + chosen_text)
    else
        prompt = "Please choose from the provided options";
        [chosen_n,last_chosen_n,chosen_text,last_chosen_text] =...
            prompt_parser(prompt,possible_choice,last_chosen_n,last_chosen_text);
    end

    if isempty(chosen_text)
        if ~isempty(last_chosen_text)
            chosen_text = last_chosen_text;
            chosen_n = last_chosen_n;
            disp("The choice was: " + last_chosen_text)
        else
            prompt = "Please choose from the provided options";
            [chosen_n,last_chosen_n,chosen_text,last_chosen_text] =...
                prompt_parser(prompt,possible_choice,last_chosen_n,last_chosen_text);
        end
    else
        last_chosen_text = chosen_text;
        last_chosen_n = chosen_n;
    end
end
function [previous_choice,functions_cleared] = compare_choices(current_choice,previous_choice,functions_cleared)
        
        if ~isempty(previous_choice)
            if ~contains(current_choice,previous_choice)
                if functions_cleared == false
                    disp("Settings file changed, clearing functions")
                    f_functions_to_clear()
                    functions_cleared = true;
                end
            end
        end
        previous_choice = current_choice;
end