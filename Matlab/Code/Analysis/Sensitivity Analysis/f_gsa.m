function results = f_gsa(settings,model_folders)
% f_gsa - Performs global sensitivity analysis (GSA) using the
% Sobol-Saltelli method on a given model
%
% This function conducts a GSA based on the Sobol-Saltelli method for a
% given model, as inspired by Geir Halnes et al.'s 2009 paper (J. comp.
% neuroscience 27.3 (2009): 471). The function takes two inputs:
% 'settings', a structure containing various settings for the analysis, and
% 'model_folders', the model folders structure. The function returns
% 'results', a structure containing the GSA results, including sensitivity
% indices (Si) and total sensitivity indices (SiT) for each score type.
%
% Syntax:  results = f_gsa(settings,model_folders)
%
% Inputs:
% - settings: A structure containing settings for the GSA, such as
% parameter bounds, sampling mode, and random seed.
% - model_folders: A structure containing the necessary model folder paths.
%
% Outputs:
% - results: A structure containing the GSA results, including sensitivity
% indices (Si) and total sensitivity indices (SiT) for each score type.
%
% Functions called:
% 1. f_make_par_samples(settings): Generates sample matrices of model
% parameters.
% 2. f_make_output_sample(results, settings, model_folders): Calculates the
% outputs for three different matrices (GSA M1, GSA M2, and GSA N) based on
% the input parameters, settings, and mathematical model.
% 3. f_calc_sensitivities(results, settings): Removes simulation errors
% from the data and calculates Si and SiT using the bootstrap method.
%
% Loaded variables:
% - M1, M2, and N: Matrices containing samples of model parameters.
% - fM1, fM2, and fN: Matrices containing model outputs for GSA M1, GSA M2,
% and GSA N methods.
% - Si and SiT: Sensitivity indices (Si) and total sensitivity indices
% (SiT) for each score type.


results = f_make_par_samples(settings);

results = f_make_output_sample(results,settings,model_folders);

results = f_calc_sensitivities(results,settings);
end