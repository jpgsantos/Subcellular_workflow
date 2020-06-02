clear
clc
% clear functions

addpath(genpath(pwd));

% Code for importing setting that supports setting divided in different
% parts, the inputs are in the format (model_name,folder_model,mode) mode
% can be either "all" or any combination of "import","analysis",...
% "simulation","model","diagnostics","plots","optimization".

[stg] = f_load_settings_part1("TW","D1_LTP_time_window","all");

% Create needed folders
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

% Creates a .mat and a tsvs from the sbtab file
if stg.import
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

% Plots the results of the analysis, this can be done independently after
% loading the results of a previously run analysis
if stg.plot
    f_plot(rst,stg)
end

% Save Analysis results if chosen in settings
if stg.save_results 
    f_save_analysis(stg,sb,rst)
end