function [score,rst,rst_not_simd] = f_sim_score(parameters, stg, model_folders)
% This function, f_sim_score, calculates the total score of a given model
% by simulating the model and scoring its performance. The function takes
% three input arguments: parameters, stg, and model_folders. The output of
% the function includes the total score (score), the result of the
% simulation and scoring (rst), and the result of the simulation and
% scoring without the 'simd' field (rst_not_simd).
% Inputs:
% 
% parameters: Double containing the model's parameters that are necessary
% for the simulation.
% stg: Structure containing the settings and configurations for the
% simulation and scoring process.
% model_folders: Structure containing the paths to the folders where the
% model and other relevant files are stored.
% 
% Outputs:
% 
% score: Scalar value representing the total score of the model's
% performance.
% rst: Structure containing the results of the simulation and scoring
% process.
% rst_not_simd: Structure containing the results of the simulation and
% scoring process with the 'simd' field removed.
% 
% Functions called:
% 
% f_prep_sim: This function simulates the model using the provided
% parameters, settings, and model folders.
% f_score: This function calculates the score of the model based on the
% results of the simulation.

%Turn off Dimension analysis warning from simbiology
warning('off','SimBiology:DimAnalysisNotDone_MatlabFcn_Dimensionless')

% Call the function that simulates the model
rst = f_prep_sim(parameters, stg, model_folders);

% Call the function that scores
rst = f_score(rst, stg, model_folders);

% Get the total score explicitly for optimization functions
score = rst.st;

rst_not_simd = rmfield( rst , 'simd');
end