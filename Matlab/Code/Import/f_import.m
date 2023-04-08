function [stg,sb] = f_import(stg,mmf)

Model_folder = mmf.model.main;

disp("Generating model files and folder from SBtab")

% Convert the SBtab file into a .mat file and tsv files
f_excel_sbtab_importer(mmf);

% Check if the Model_folder exists, if not, add it to the path

% Creates a struct based on the SBtab that is used elswhere in the code and
% also adds the number of experiments and outputs to the settings struct
[stg,sb] = f_generate_sbtab_struct(stg,mmf);

%Create the model and input output structure from sbtab.mat

% Save the model in .mat, .sbproj, and .xml formats, and create a data file
% with the required settings for running the model in various  experimental
% settings defined in the SBtab
f_sbtab_to_model(stg,sb,mmf)

% Generate code to load inputs for each experiment into a .mat file, and
% create code to read these inputs during simulation, stored in the Input
% functions folder
f_setup_input(stg,mmf)

% Create three .mat files for each experiment containing the necessary
% rules, species, and parameters based on the SBtab, for equilibrium,
% default, and detailed simulation runs
f_build_model_exp(stg,sb,mmf)
disp("Model files and folders generated successfully")
end
