function [settings_file,folder_model_name,folder_model_dir,Analysis] = f_prompt()

persistent folder_n_last
persistent settings_file_n_last
persistent settings_file_date_last
persistent Analysis_n_last

listing = dir('model');

for n = size(listing,1):-1:1
    if matches(listing(n).name,char("."))
        listing(n)= [];
    end
    if matches(listing(n).name,char(".."))
        listing(n)= [];
    end
end

prompt = "What model folder should be used?\n";

for n = 1:size(listing,1)
    prompt = prompt + "\n" + n + ": " + listing(n).name;
end

if ~isempty(folder_n_last)
    prompt = prompt + "\n\nPress enter to use "+ listing(folder_n_last).name;
end
prompt = prompt + "\n";

folder_n = input(prompt);

if isempty(folder_n)
    folder_n = folder_n_last;
else
    settings_file_n_last = [];
    folder_n_last = folder_n;
end

disp("Using " + listing(folder_n).name + " folder")

folder_model_name = listing(folder_n).name;
folder_model_dir = string(listing(folder_n).folder);

listing2 = dir(string(listing(folder_n).folder)+ "\"  + listing(folder_n).name + "\Settings");

for n = size(listing2,1):-1:1
    if matches(listing2(n).name,char("."))
        listing2(n)= [];
    end
    if matches(listing2(n).name,char(".."))
        listing2(n)= [];
    end
end

prompt = "\nWhat file should be used as settings?\n";

for n = 1:size(listing2,1)
    prompt = prompt + "\n" + n + ": " + listing2(n).name;
end

if ~isempty(settings_file_n_last)
    prompt = prompt + "\n\nPress enter to use "+ listing2(settings_file_n_last).name;
end

prompt = prompt + "\n";

settings_file_n = input(prompt);

if isempty(settings_file_n)
    settings_file_n = settings_file_n_last;
else
    settings_file_n_last = settings_file_n;
end

disp("Using " + listing2(settings_file_n).name + " file")

settings_file = strrep(listing2(settings_file_n).name,".m","");

settings_file_date = listing2(settings_file_n).datenum;

if settings_file_date ~= settings_file_date_last
    disp("Settings file changed, clearing functions")
    clear f_sim
    clear f_score
    clear f_prep_sim
    clear f_normalize
    clear f_build_model_exp
    clear f_setup_input
    clear f_get_outputs
end

settings_file_date_last = settings_file_date;

Analysis_options = ["Diagnostics","Optimization","Sensitivity Analysis","Profile Likelihood Analysis"];

prompt = "\nWhat analysis should be performed?\n";
prompt = prompt + "\n1: Diagnostics";
prompt = prompt + "\n2: Optimization";
prompt = prompt + "\n3: Sensitivity Analysis";
prompt = prompt + "\n4: Profile Likelihood Analysis";

if ~isempty(Analysis_n_last)
    prompt = prompt + "\n\nPress enter to run "+ Analysis_options(Analysis_n_last);
end

prompt = prompt + "\n";

Analysis_n = input(prompt);

if isempty(Analysis_n)
    Analysis_n = Analysis_n_last;
else
    Analysis_n_last = Analysis_n;
end

Analysis = Analysis_options(Analysis_n);

disp("Running " + Analysis_options(Analysis_n))
end