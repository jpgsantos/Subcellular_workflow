function [settings, sb] = f_import(settings, model_folder)
% Function f_import: Import a model from an SBtab file, generate model
% files, and setup necessary inputs for experiments
%
% Inputs:
% - settings: A struct containing settings for the model import process
% - model_folder: A string specifying the folder where the model and
% related files should be saved
%
% Outputs:
% - settings: Updated struct with additional information about the number
% of experiments and outputs
% - sb: A struct containing data from the imported SBtab file
%
% Used Functions:
% - f_excel_sbtab_importer: Converts an SBtab file into a .mat file and tsv
% files
% - f_generate_sbtab_struct: Generates a struct based on the SBtab and
% updates settings with the number of experiments and outputs
% - f_sbtab_to_model: Saves the model in .mat, .sbproj, and .xml formats, 
% and creates a data file with required settings for running the model in
% various experimental settings
% - f_setup_input: Generates code to load inputs for each experiment into a
% .mat file and creates code to read these inputs during simulation
% - f_build_model_exp: Creates .mat files for each experiment containing
% rules, species, and parameters based on the SBtab for equilibrium, 
% default, and detailed simulation runs
%
% Variables:
% Loaded:
% - None
%
% Initialized:
% - None
%
% Persistent:
% - None

disp("Generating model files and folder from SBtab")

% Convert the SBtab file into a .mat file and tsv files
f_excel_sbtab_importer(model_folder);

% Creates a struct based on the SBtab that is used elswhere in the code and
% also adds the number of experiments and outputs to the settings struct
[settings, sb] = f_generate_sbtab_struct(settings, model_folder);

% Save the model in .mat, .sbproj, and .xml formats, and create a data file
% with the required settings for running the model in various  experimental
% settings defined in the SBtab
f_sbtab_to_model(settings, sb, model_folder)

% Generate code to load inputs for each experiment into a .mat file, and
% create code to read these inputs during simulation, stored in the Input
% functions folder
f_setup_input(settings, model_folder)

% Create three .mat files for each experiment containing the necessary
% rules, species, and parameters based on the SBtab, for equilibrium, 
% default, and detailed simulation runs
f_build_model_exp(settings, sb, model_folder)

disp("Model files and folders generated successfully")
end