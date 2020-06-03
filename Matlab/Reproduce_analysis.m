% Script to reproduce previously obtained plots
clear
clc

%Get the date and time
date_stamp = string(year(datetime)) + "_" + ...
    string(month(datetime,'shortname')) + "_" + string(day(datetime))...
    + "__" + string(hour(datetime)) + "_" + string(minute(datetime))...
    + "_" + string(round(second(datetime)));

addpath(genpath(pwd));

load("Results/Analysis_2020_Jun_3__12_50_29/Analysis.mat")

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

f_import(stg,sb)

% Runs the Analysis chosen in settings
if stg.analysis ~= ""
    rst = f_analysis(stg,stg.analysis);
end

% Plots the results of the analysis, this can be done independently after
% loading the results of a previously run analysis
if stg.plot
    f_plot(rst,stg)
end

% Save Analysis results and plots if chosen in settings
if stg.save_results 
    f_save_analysis(stg,sb,rst,date_stamp)
    f_save_plots(stg,date_stamp)
end