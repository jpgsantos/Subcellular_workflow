function f_save_analysis(settings,sb,results,model_folders,plots)
% This function saves the analysis results to the specified folder.
%
% Inputs:
% - settings: The settings for the analysis.
% - sb: The subject data.
% - results: The results of the analysis.
% - model_folders: The structure containing folder paths for the model.
% - plots: The plots generated from the analysis.
%
% Outputs:
% - None. The function saves the analysis data to a .mat file in the
% specified folder.
%
% Used Functions:
% - mkdir: Create a new folder if it does not exist.
% - addpath: Add the analysis date folder to the MATLAB search path.
% - save: Save the variables to a .mat file.
%
% Variables
% Loaded:
% - None.
%
% Initialized:
% - Results_Folder: The main results folder path.
% - Analysis_folder: The main analysis folder path.
% - Analysis_date_folder: The folder path with the analysis date.
%
% Persistent:
% - None.

% Set the main results folder, analysis folder, and analysis date folder
Results_Folder = model_folders.model.results.main;
Analysis_folder = model_folders.model.results.analysis.main;
Analysis_date_folder = model_folders.model.results.analysis.date.main;

% Create the directories if they do not exist
[~,~] = mkdir(Results_Folder);
[~,~] = mkdir(Analysis_folder);
[~,~] = mkdir(Analysis_date_folder);

% Add the analysis date folder to the MATLAB path
addpath(Analysis_date_folder)

% Save the analysis data to the Analysis.mat file
try
    save (Analysis_date_folder + "Analysis.mat",'settings','sb','results','model_folders');
catch
    disp("failed to save analysis");
end
try
    save (Analysis_date_folder + "Plots.mat",'plots');
catch
    disp("failed to save plots");
end
end