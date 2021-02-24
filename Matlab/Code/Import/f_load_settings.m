function [stg,rst,Analysis_n] = f_load_settings()

persistent sbtab_date_last
persistent folder_n_last
persistent settings_file_n_last
persistent settings_file_date_last
persistent Analysis_n_last

rst = [];

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


Analysis_options = ["Diagnostics","Optimization","Sensitivity Analysis",...
    "Profile Likelihood Analysis","",""];

prompt = "\nWhat analysis should be performed?\n";
prompt = prompt + "\n1: Diagnostics";
prompt = prompt + "\n2: Optimization";
prompt = prompt + "\n3: Sensitivity Analysis";
prompt = prompt + "\n4: Profile Likelihood Analysis";
prompt = prompt + "\n5: Reproduce a previous Analysis";
prompt = prompt + "\n6: Reproduce the plots of a previous Analysis";

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



if Analysis_n <=4
    
    listing2 = dir(string(listing(folder_n).folder)+ "/"  + listing(folder_n).name + "/Settings");
    
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
        f_functions_to_clear()
    end
    
    settings_file_date_last = settings_file_date;
    
    
    
    
    % end
    
    
    % [settings_file,folder_model_name,folder_model_dir,Analysis,Analysis_n] = f_prompt();
    
    
    % if Analysis_n <= 4
    stg_add_default = eval("default_settings()");
    
    f = fieldnames(stg_add_default);
    for i = 1:length(f)
        stg.(f{i}) = stg_add_default.(f{i});
    end
    
    [stg_add] = eval(settings_file + "()");
    
    f = fieldnames(stg_add);
    for i = 1:length(f)
        stg.(f{i}) = stg_add.(f{i});
    end
    
    listing = dir(string(folder_model_dir+ "/"  + folder_model_name));
    
    for n = 1:size(listing,1)
        if matches(stg.sbtab_excel_name,listing(n).name,"IgnoreCase",true)
            sbtab_date = listing(n).datenum;
        end
    end
    
    if sbtab_date ~= sbtab_date_last
        disp("Excel SBtab file changed, clearing functions")
        f_functions_to_clear()
    end
    
    sbtab_date_last = sbtab_date;
    
    %  Get the working folder
    stg.folder_model = folder_model_name;
%     stg.folder_main = pwd;
%     stg.folder_main = strrep(stg.folder_main,"\","/");
    stg.analysis = Analysis;
    
else
    listing3 = dir(string(listing(folder_n).folder)+ "/"  + listing(folder_n).name + "/Results");
    
    for n = size(listing3,1):-1:1
        if matches(listing3(n).name,char("."))
            listing3(n)= [];
        end
        if matches(listing3(n).name,char(".."))
            listing3(n)= [];
        end
    end
    
%     listing3
    
    prompt = "What Analysis should be reproduced?\n";
    
    for n = 1:size(listing3,1)
        prompt = prompt + "\n" + n + ": " + listing3(n).name;
    end
    
    prompt = prompt + "\n";
    
    folder_n_2 = input(prompt);
    
    listing4 = dir(string(listing(folder_n).folder)+ "/"  + listing(folder_n).name + "/Results/"+ listing3(folder_n_2).name);
    
    for n = size(listing4,1):-1:1
        if matches(listing4(n).name,char("."))
            listing4(n)= [];
        end
        if matches(listing4(n).name,char(".."))
            listing4(n)= [];
        end
    end
    
    prompt = "";
    
    for n = 1:size(listing4,1)
        prompt = prompt + "\n" + n + ": " + listing4(n).name;
    end
    
    prompt = prompt + "\n";
    
    folder_n_3 = input(prompt);
    
    load(string(listing(folder_n).folder)+ "/"  + listing(folder_n).name +...
        "/Results/"+ listing3(folder_n_2).name+ "/" +...
        listing4(folder_n_3).name + "/Analysis.mat","stg")
%     listing4
   
    
    if Analysis_n == 5
    end
    if Analysis_n == 6
        stg.plot = true;
%         stg.analysis = "";
            load(string(listing(folder_n).folder)+ "/"  + listing(folder_n).name +...
        "/Results/"+ listing3(folder_n_2).name+ "/" +...
        listing4(folder_n_3).name + "/Analysis.mat","rst")
    end
    
end

end