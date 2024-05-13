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
% - f_make_par_samples(settings): Generates sample matrices of model
% parameters.
% - f_make_output_sample(results, settings, model_folders): Calculates the
% outputs for three different matrices (GSA M1, GSA M2, and GSA N) based on
% the input parameters, settings, and mathematical model.
% - f_calc_sensitivities(results, settings): Removes simulation errors
% from the data and calculates Si and SiT using the bootstrap method.

settings.sansamples = 2000;

settings.lb = [-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-1.30000000000000	-7	-7	-7	-7	-5.20000000000000	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7	-7];

settings.ub = [3.80000000000000	5.00000000000000	5.00000000000000	5.00000000000000	3.50000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	3.80000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	4.40000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	-1.90000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000	5.00000000000000];


results = f_make_par_samples(settings);

results = f_make_output_sample(results,settings,model_folders);

results = f_calc_sensitivities(results,settings);
end