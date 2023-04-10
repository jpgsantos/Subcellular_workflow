function plots = f_plot(rst, stg, mmf)
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
data_model = mmf.model.data.data_model;

% Load data and sbtab from the data model
load(data_model, 'Data', 'sbtab')

% Initialize an empty array to store generated plot handles
plots = [];

% Check if the 'diag' field exists in the rst structure
if isfield(rst, 'diag')
    % Generate and store figure with Scores
    plots{end+1} = f_plot_scores(rst.diag, stg, sbtab);
    % Generate and store figure with Inputs
    plots{end+1} = f_plot_inputs(rst.diag, stg, sbtab);
    % Generate and store figure with Outputs
    plots{end+1} = f_plot_outputs(rst.diag, stg, sbtab, Data, mmf);
    % Generate and store figure with Input and Output for all experiments
    plots{end+1} = f_plot_in_out(rst.diag, stg, sbtab, Data, mmf);
end

% Check if the 'opt' field exists in the rst structure
if isfield(rst, 'opt')
    % Generate and store figure with optimization results
    plots{end+1} = f_plot_opt(rst, stg);
end

% Check if the 'lsa' field exists in the rst structure
if isfield(rst, 'lsa')
    % Generate and store figures for Local Sensitivity Analysis
    plots{end+1} = f_plot_lsa(rst.lsa, stg);
end

% Check if the 'gsa' field exists in the rst structure
if isfield(rst, 'gsa')
    % Generate and store figures for Global Sensitivity Analysis
    plots{end+1} = f_plot_gsa_sensitivities(rst.gsa, stg, sbtab);
end

% Check if the 'PLA' field exists in the rst structure
if isfield(rst, 'PLA')
    % Generate and store figure for Profile Likelihood Analysis
    plots{end+1} = f_plot_PL(rst, stg, mmf);
end
end