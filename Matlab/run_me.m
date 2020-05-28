clear
clc
% clear functions

addpath(genpath(pwd));

% Code for importing setting that supports setting divided in different
% parts, the inputs are in the format (model_name,folder_model,mode) mode
% can be either "all" or any combination of "import","analysis",...
% "simulation","model","diagnostics","plots","optimization".

[stg] = f_load_settings_part1("TW","D1_LTP_time_window","all");

%Create needed folders
if ispc
    mkdir("Model\" + stg.folder_model,"Data");
    mkdir("Model\" + stg.folder_model,"Formulas");
    mkdir("Model\" + stg.folder_model,"tsv");
    mkdir("Model\" + stg.folder_model,"Data\Exp");
else
    mkdir("Model/" + stg.folder_model,"Data");
    mkdir("Model/" + stg.folder_model,"Formulas");
    mkdir("Model/" + stg.folder_model,"tsv");
    mkdir("Model/" + stg.folder_model,"Data/Exp");
end

if stg.import
% % Imports sbtab into a .mat file and exports the tsvs
disp("Reading SBtab Excel")
f_excel_sbtab_importer(stg);
end

[stg,sb] = f_load_settings_part2(stg);

addpath(genpath(pwd));

% Runs the import scripts if chosen in settings
if stg.import
    f_import(stg,sb)
end

% Runs the Analysis chosen in settings
if stg.analysis ~= ""
    rst = f_analysis(stg,stg.analysis);
end

% Save Analysis results if chosen in settings
if stg.save_results
    if ispc
        mkdir("Model\" + stg.folder_model,"Data");
    else
        mkdir("Model/" + stg.folder_model,"Data"); 
    end
    
    date_stamp = string(year(datetime)) + "_" + ...
        string(month(datetime,'shortname')) + "_" + string(day(datetime))...
        + "_" + string(hour(datetime)) + "_" + string(minute(datetime))...
        + "_" + string(round(second(datetime)));
    
    if ispc
        save ("Model\" +char(stg.folder_model+"\Results\Analysis_"+...
            string(date_stamp)+".mat"),'stg','sb','rst');
    else
        save ("Model/" +char(stg.folder_model+"/Results/Analysis_"+...
            string(date_stamp)+".mat"),'stg','sb','rst');
    end
end