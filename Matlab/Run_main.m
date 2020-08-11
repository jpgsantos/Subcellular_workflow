% Script to import sbtab and run the analyis for the first time

clear
clc
% clear functions

%Get the date and time
date_stamp = string(year(datetime)) + "_" + ...
    string(month(datetime,'shortname')) + "_" + string(day(datetime))...
    + "__" + string(hour(datetime)) + "_" + string(minute(datetime))...
    + "_" + string(round(second(datetime)));

addpath(genpath(pwd));

% Loads the settings file. It supports a settings file divided in different
% parts, the inputs are in the format (model_name,folder_model,mode) mode
% can be either "all" or any combination of "import","analysis",...
% "simulation","model","diagnostics","plots","optimization".
[stg] = f_load_settings("TW","D1_LTP_time_window","all");

% Runs the import scripts if chosen in settings
if stg.import
    [stg,sb] = f_import(stg);
else
    % Creates a struct based on the sbtab that is used elswhere in the code and
    % also adds the number of experiments and outputs to the settings variable
    [stg,sb] = f_generate_sbtab_struct(stg);
end

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