function results = f_gsa(settings, model_folders)
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

% settings.sansamples = 50000;
% 
% settings.lb = [-3.10000000000000	1.08750000000000	-7	-0.925000000000000	-7	-7 -7	-0.0999999999999995	-6	-7	-3.55000000000000	-7	-7	-3.05000000000000	-5.05000000000000	-1.10000000000000	-7	-7	-3.80000000000000	0.775000000000001	-7	0.100000000000001	-7	-3.72500000000000	-7	-2.41250000000000	-7	-2.45000000000000	-7	-7	-1.01250000000000	-7	-1.45000000000000	-7	-7	-1.25000000000000	-3.65000000000000	-3.75000000000000	-7];
% 
% settings.ub = [1.22500000000000	5.00000000000000	0.950000000000000	4.02500000000000	4.33750000000000	5.00000000000000	4.00000000000000	5.00000000000000	0.500000000000000	5.00000000000000	4.36250000000000	4.95000000000000	0.650000000000001	5.00000000000000	4.85000000000000	5.00000000000000	5.00000000000000	5.00000000000000	3.15000000000000	4.63750000000000	-1.43750000000000	4.93750000000000	4.92500000000000	2.10000000000000	4.62500000000000	0.250000000000000	4.35000000000000	-1.20000000000000	4.81250000000000	2.25000000000000	5.00000000000000	2.50000000000000	5.00000000000000	4.85000000000000	5.00000000000000	1.20000000000000	5.00000000000000	5.00000000000000	5.00000000000000];

% % Value of Relative tolerance
% % (Relative tolerance)
% stg.reltol = 1.0E-6;
% 
% % Value of Relative tolerance minimum
% % (Relative tolerance minimum)
% stg.reltol_min = 1.0E-6;
% 
% % Value of Absolute tolerance
% % (Absolute tolerance)
% stg.abstol = 1.0E-6;
% 
% % Value of Absolute tolerance minimum
% % (Absolute tolerance minimum)
% stg.abstol_min = 1.0E-6;

results = f_make_par_samples(settings);

results = f_make_output_sample(results,settings,model_folders);

results = f_calc_sensitivities(results,settings);
end