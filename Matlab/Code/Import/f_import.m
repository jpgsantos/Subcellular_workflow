function [stg,sb] = f_import(stg,sb,script_folder)

% Create needed folders
mkdir(script_folder + "/Model/" + stg.folder_model,"Data");
mkdir(script_folder + "/Model/" + stg.folder_model,"Input_functions");
mkdir(script_folder + "/Model/" + stg.folder_model,"tsv/" + stg.name + "/");
mkdir(script_folder + "/Model/" + stg.folder_model,"Data/Exp");

% Creates a .mat and a tsvs from the sbtab file
disp("Reading SBtab Excel")
f_excel_sbtab_importer(stg,script_folder);

addpath(genpath(script_folder));

% Creates a struct based on the sbtab that is used elswhere in the code and
% also adds the number of experiments and outputs to the settings variable
if isempty(sb)
    [stg,sb] = f_generate_sbtab_struct(stg,script_folder);
end

% % Create the model and input output structure from sbtab.mat
disp("Creating the model, input and output")

% Saves the model in .mat, .sbproj and .xml format, while also creating a
% file whith the data to run the model in all different experimental
% settings defined in the sbtab
f_sbtab_to_model(stg,sb,script_folder)

% Creates code that loads the inputs of each experiment into a .mat file,
% "Data_D1_LTP_time_window_input" in this case, and creates the code to
% read this inputs at runtime when the experiments are being simulated, all
% this generated code is stored on the formulas folder
f_setup_input(stg,script_folder)

%Creates two a .mat files for each experimetn, with all the added rules,
%species and parameters needed depending on the inputs and outputs
%specified on the sbtab, one for the equilibrium simulation run and one for
%the proper run
f_build_model_exp(stg,sb,script_folder)
end
