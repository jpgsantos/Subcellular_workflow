function [settings,sb,results,model_folders,plots] = Run_main(Folder,Analysis,settings)
% Main function to perform various analyses on a selected model
% using a given settings file.
%
% Syntax: [stg, sb, rst, mmf, plots] = Run_main(Folder, Analysis, settings)
%
% Inputs:
%   - Folder: Name of the model folder located at
%       "Repository_name"/Matlab/Model/
%   - Analysis: Integer code representing the desired analysis to run:
%       1 = Diagnostics
%       2 = Parameter Estimation
%       3 = Local Sensitivity Analysis
%       4 = Global Sensitivity Analysis
%       5 = Profile Likelihood Analysis
%       6 = Reproduce a previous analysis
%       7 = Reproduce the plots of a previous analysis
%       8 = Import model files
%   - Settings: Name of the settings file located at
%       "Repository_name"/Matlab/Model/"Folder"/Matlab/Settings
%
% Outputs:
%   - stg: Structure containing the settings used for the analysis
%   - sb: Structure containing the sbtab data
%   - rst: Structure containing the results of the analysis
%   - mmf: Structure containing folder paths
%   - plots: Structure containing plot data (if applicable)
%
% This function performs the following steps:
%   1. Collect user inputs and create a timestamp
%   2. Get the main MATLAB folder and add it to the path if needed
%   3. Load settings and data based on user choices
%   4. Create the folder structure for model files
%   5. Import or generate sbtab data if needed
%   6. Re-Run the selected analysis
%   7. Plot results (if applicable)
%   ?? 8. Save analysis results and plots (if specified in settings)


user_choices = {Folder,Analysis,settings};

%Get the date and time
date_stamp = string(year(datetime)) + "_" + ...
    string(month(datetime)) + "_" + string(day(datetime))...
    + "__" + string(hour(datetime)) + "_" + string(minute(datetime))...
    + "_" + string(round(second(datetime)));

% Get the folder where the MATLAB code and models are located
Matlab_main_folder = fileparts(mfilename('fullpath')) + "/";
Matlab_main_folder = strrep(Matlab_main_folder,"\","/");

if ~contains(strrep(path,"\","/"),...
        extractAfter(Matlab_main_folder,strlength(Matlab_main_folder)-1))
    % If the folder is not in the path, add it
    addpath(genpath(Matlab_main_folder));
end

model_folders.main = Matlab_main_folder ;

% Name of the various analysis that can be run with this code
analysis_options = ["Diagnostics","Parameter Estimation",...
    "Local Sensitivity Analysis","Global Sensitivity Analysis",...
    "Profile Likelihood Analysis","Reproduce a previous analysis",...
    "Reproduce the plots of a previous analysis","Import model files"];

% Code for choosing the model and loading the settings files
[settings,results,sb] = f_user_input(model_folders,analysis_options,user_choices);

% Get the folder structure used for the model files
[model_folders] = default_folders(settings,model_folders,date_stamp);

% Runs the import scripts if chosen in settings
if settings.import
    [settings,sb] = f_import(settings,model_folders);
else
    % Creates a struct based on the sbtab that is used elswhere in the code
    % and also adds the number of experiments and outputs to the settings
    % variable
    if isempty(sb)% check needed for plot reproduction
        [settings,sb] = f_generate_sbtab_struct(settings,model_folders);
    end
end

% analysis_options
% Runs the Analysis chosen by the user input
%     [results,settings] = f_analysis(settings,settings.analysis,model_folders,analysis_options,results);

% Plots the results of the analysis, this can be done independently after
% loading the results of a previously run analysis
plots = [];
if settings.plot
    plots = f_plot(results,settings,model_folders);
    % Save plots results if chosen in settings
%     if stg.save_results
%          f_save_plots(mmf)
%     end
end

% Save Analysis results if chosen in settings
if settings.save_results
    f_save_analysis(settings,sb,results,model_folders,plots)
end

end