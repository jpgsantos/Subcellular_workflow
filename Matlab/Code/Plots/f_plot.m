function plots = f_plot(results, settings, model_folder)
% This function generates plots for various analysis results based on the
% provided data and settings.
% 
% Inputs:
% - rst: A structure containing results from different types of analyses
% (diag, opt, lsa, gsa, PLA).
% - stg: A structure containing settings for the plots.
% - mmf: A ModelMappingFramework object containing the model and data
% information.
%
% Outputs:
% - plots: A cell array of generated plots.
%
% Used Functions:
% - f_plot_scores: Generates a figure with scores.
% - f_plot_inputs: Generates a figure with inputs.
% - f_plot_outputs: Generates a figure with outputs.
% - f_plot_in_out: Generates a figure with input and output for all
% experiments.
% - f_plot_opt: Generates a figure with optimization results.
% - f_plot_lsa: Generates figures for Local Sensitivity Analysis.
% - f_plot_gsa_sensitivities: Generates figures for Global Sensitivity
% Analysis.
% - f_plot_PL: Generates a figure for Profile Likelihood Analysis.
%
% Variables:
% Loaded:
% - data_model: A variable from mmf object containing the data model.
% - Data: A variable containing data for generating plots.
% - sbtab: A variable containing sbtab information for generating plots.
%
% Initialized:
% - plots: A cell array for storing generated plot handles.


% Set default font and size for plot axes
set(0, 'defaultAxesFontName', 'Arial')
set(0, 'defaultAxesFontSize', 10)

% Display a message to inform the user that the plotting process has started
disp("Plotting ...")

% Retrieve data model from mmf
data_model = model_folder.model.data.data_model;

% Load data and sbtab from the data model
load(data_model, 'Data', 'sbtab')

% Initialize an empty array to store generated plot handles
plots = [];

% Check if the 'diag' field exists in the rst structure
if isfield(results, 'diag')
    % Generate and store figure with Scores
    plots = [plots;f_plot_scores(results.diag, settings, sbtab)];

    plots = f_plot_diagnostics(plots,results,settings,sbtab,Data,model_folder);
    % % Generate and store figure with Inputs
    % plots = [plots;f_plot_inputs(results.diag, settings, sbtab)];
    % % Generate and store figure with Outputs
    % plots = [plots;f_plot_outputs(results.diag, settings, sbtab, Data, model_folder)];
    % % Generate and store figure with Input and Output for all experiments
    % plots = [plots;f_plot_in_out(results.diag, settings, sbtab, Data, model_folder)];
end

% Check if the 'opt' field exists in the rst structure
if isfield(results, 'opt')
    % Generate and store figure with optimization results
    plots = [plots;f_plot_opt(results, settings)];
end

% Check if the 'lsa' field exists in the rst structure
if isfield(results, 'lsa')
    % Generate and store figures for Local Sensitivity Analysis
    plots = [plots;f_plot_lsa(results.lsa, settings)];
end

% Check if the 'gsa' field exists in the rst structure
if isfield(results, 'gsa')
    % Generate and store figures for Global Sensitivity Analysis
    plots = [plots;f_plot_gsa_sensitivities(results.gsa, settings, sbtab)];
end

% Check if the 'PLA' field exists in the rst structure
if isfield(results, 'PLA')
    % Generate and store figure for Profile Likelihood Analysis
    plots = [plots;f_plot_PL(results, settings, model_folder)];
end
end