% Script to reproduce previously run analysis

clear
clc
% clear functions

%Get the date and time
date_stamp = string(year(datetime)) + "_" + ...
    string(month(datetime,'shortname')) + "_" + string(day(datetime))...
    + "__" + string(hour(datetime)) + "_" + string(minute(datetime))...
    + "_" + string(round(second(datetime)));

addpath(genpath(pwd));

% Choose relevant path

%Example diagnostics
load("Results/Analysis_diagnostics_example/Analysis.mat")
%Example Global sensitivitie analysis
% load("Results/Analysis_GSA_example/Analysis.mat")

[stg,sb] = f_import(stg);

addpath(genpath(pwd));

% Runs the Analysis chosen in settings
if stg.analysis ~= ""
    rst = f_analysis(stg,stg.analysis);
    
    % Save Analysis results if chosen in settings
    if stg.save_results
        f_save_analysis(stg,sb,rst,date_stamp)
    end
    
    % Plots the results of the analysis, this can be done independently after
    % loading the results of a previously run analysis
    if stg.plot
        f_plot(rst,stg)
        % Save plots results if chosen in settings
        if stg.save_results
            f_save_plots(stg,date_stamp)
        end
    end
end