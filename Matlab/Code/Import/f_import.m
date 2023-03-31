function [stg,sb] = f_import(stg,mmf)

Model_folder = mmf.model.main;

disp("Generating model files and folder from SBtab")

% Create needed folders
[~,~] = mkdir(mmf.model.data.main);
[~,~] = mkdir(mmf.model.input_functions.main);
[~,~] = mkdir(mmf.model.tsv.model_name);
[~,~] = mkdir(mmf.model.data.model_exp.main);

% Creates a .mat and a tsvs from the SBtab file
f_excel_sbtab_importer(mmf);

if exist(Model_folder, 'dir') ~= 7
    % If the folder is not in the path, add it
    addpath(genpath(Model_folder));
end
% addpath(genpath(Model_folder));

% Creates a struct based on the SBtab that is used elswhere in the code and
% also adds the number of experiments and outputs to the settings struct
[stg,sb] = f_generate_sbtab_struct(stg,mmf);

%Create the model and input output structure from sbtab.mat

% Saves the model in .mat, .sbproj and .xml format, while also creating a
% file whith the data to run the model in all different experimental
% settings defined in the SBtab
f_sbtab_to_model(stg,sb,mmf)

% Creates code that loads the inputs of each experiment into a .mat file,
% and creates the code to read this inputs at runtime when the experiments
% are being simulated, all this generated code is stored on the Input
% functions folder
f_setup_input(stg,mmf)

%Creates three .mat files for each experiment, with all the added rules,
%species and parameters needed depending on the inputs and outputs
%specified on the SBtab, one for the equilibrium simulation run, one for
%the deffault run, and one for a more detailed run.
f_build_model_exp(stg,sb,mmf)
disp("Model files and folders generated successfully")
end
