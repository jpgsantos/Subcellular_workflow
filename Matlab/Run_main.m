function [stg,sb,rst,mmf,plots] = Run_main(Folder,Analysis,settings)
% Function that runs one of the selected analysis on the selected model
% given a settings file.
%
% It takes three inputs, in order:
% 
% 1) Folder - The name of the folder present at
% "Repository_name"/Matlab/Model/
% 
% 2) Analysis - One of the numbered codes
%   1 = Diagnostics 
%   2 = Parameter Estimation 
%   3 = Local Sensitivity Analysis
%   4 = Global Sensitivity Analysis 
%   5 = Profile Likelihood Analysis 
%   6 = Reproduce a previous analysis 
%   7 = Reproduce the plots of a previous analysis 
%   8 = Import model files
% 
% 3) Settings - The name of the file present at
% "Repository_name"/Matlab/Model/"Folder"/Matlab/Settings

% clear functions

user_choices = {Folder,Analysis,settings};

%Get the date and time
date_stamp = string(year(datetime)) + "_" + ...
    string(month(datetime)) + "_" + string(day(datetime))...
    + "__" + string(hour(datetime)) + "_" + string(minute(datetime))...
    + "_" + string(round(second(datetime)));

% Get the folder where the MATLAB code and models are located
Matlab_main_folder = fileparts(mfilename('fullpath'))+"/";
Matlab_main_folder = strrep(Matlab_main_folder,"\","/");

if exist(Matlab_main_folder, 'dir') ~= 7
    % If the folder is not in the path, add it
    addpath(genpath(Matlab_main_folder));
end

% addpath(genpath(Matlab_main_folder));

mmf.main = Matlab_main_folder;

% Name of the various analysis that can be run with this code
analysis_options = ["Diagnostics","Parameter Estimation",...
    "Local Sensitivity Analysis","Global Sensitivity Analysis",...
    "Profile Likelihood Analysis","Reproduce a previous analysis",...
    "Reproduce the plots of a previous analysis","Import model files"];

% Code for choosing the model and loading the settings files
[stg,rst,sb] = f_user_input(mmf,analysis_options,user_choices);

% stg.import

% Get the folder structure used for the model files
[mmf] = default_folders(stg,mmf,date_stamp);

% Runs the import scripts if chosen in settings
if stg.import
    [stg,sb] = f_import(stg,mmf);
else
    % Creates a struct based on the sbtab that is used elswhere in the code
    % and also adds the number of experiments and outputs to the settings
    % variable
    if isempty(sb)% check needed for plot reproduction
        [stg,sb] = f_generate_sbtab_struct(stg,mmf);
    end
end

% Runs the Analysis chosen by the user input
    [rst,stg] = f_analysis(stg,stg.analysis,mmf,analysis_options,rst);

% % Save Analysis results if chosen in settings
% if stg.save_results
%     f_save_analysis(stg,sb,rst,mmf,plots)
% end

% Plots the results of the analysis, this can be done independently after
% loading the results of a previously run analysis
plots = [];
if stg.plot
    plots = f_plot(rst,stg,mmf);
    % Save plots results if chosen in settings
%     if stg.save_results
%          f_save_plots(mmf)
%     end
end

% Save Analysis results if chosen in settings
if stg.save_results
    f_save_analysis(stg,sb,rst,mmf,plots)
end

end