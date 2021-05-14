% Script to import sbtab and run the analyis

%Get the date and time
date_stamp = string(year(datetime)) + "_" + ...
    string(month(datetime,'shortname')) + "_" + string(day(datetime))...
    + "__" + string(hour(datetime)) + "_" + string(minute(datetime))...
    + "_" + string(round(second(datetime)));

addpath(genpath(pwd));

% Code for choosing the model and loading the settings files
[stg,rst,sb,Analysis_n] = f_load_settings();

% Runs the import scripts if chosen in settings
if stg.import
    [stg,sb] = f_import(stg,sb);
else
    % Creates a struct based on the sbtab that is used elswhere in the code
    % and also adds the number of experiments and outputs to the settings
    % variable
    if isempty(sb)
        [stg,sb] = f_generate_sbtab_struct(stg);
    end
end

% Runs the Analysis chosen in settings
if stg.analysis ~= "" && Analysis_n ~= 5
    rst = f_analysis(stg,stg.analysis);
end
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