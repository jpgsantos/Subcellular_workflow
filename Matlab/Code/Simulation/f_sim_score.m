function [score,rst,rst_not_simd] = f_sim_score(parameters, stg, model_folders,i,j)
% This function calculates the total score of a given model by simulating
% its performance and scoring the results.
%
% Inputs:
% - parameters: A double containing the model's parameters necessary for
% the simulation.
% - stg: A structure containing the settings and configurations for the
% simulation and scoring process.
% - model_folders: A structure containing the paths to the folders where
% the model and other relevant files are stored.
%
% Outputs:
% - score: A scalar value representing the total score of the model's
% performance.
% - rst: A structure containing the results of the simulation and scoring
% process.
% - rst_not_simd: A structure containing the results of the simulation and
% scoring process with the 'simd' field removed.
%
% Used Functions:
% - f_prep_sim: Simulates the model using the provided parameters,
% settings, and model folders.
% - f_score: Calculates the score of the model based on the results of the
% simulation.
%
% Variables:
% Loaded:
% - None.
%
% Initialized:
% - None.
%
% Persistent:
% - None.
%

%Turn off Dimension analysis warning from SimBiology
warning('off','SimBiology:DimAnalysisNotDone_MatlabFcn_Dimensionless')

% Call the function that simulates the model
rst = f_prep_sim(parameters, stg, model_folders,i,j);

% Call the function that scores
rst = f_score(rst, stg, model_folders);

% Get the total score explicitly for optimization functions
score = rst.st;

rst_not_simd = rmfield( rst , 'simd');
end