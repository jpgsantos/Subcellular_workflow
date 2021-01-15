function [stg,sb] = f_import(stg)

% Create needed folders
    mkdir(stg.folder_main + "/Model/" + stg.folder_model,"Data");
    mkdir(stg.folder_main + "/Model/" + stg.folder_model,"Formulas");
    mkdir(stg.folder_main + "/Model/" + stg.folder_model,"tsv");
    mkdir(stg.folder_main + "/Model/" + stg.folder_model,"Data/Exp");

% Creates a .mat and a tsvs from the sbtab file
disp("Reading SBtab Excel")
f_excel_sbtab_importer(stg);

addpath(genpath(pwd));

% Creates a struct based on the sbtab that is used elswhere in the code and
% also adds the number of experiments and outputs to the settings variable.
[stg,sb] = f_generate_sbtab_struct(stg);

% % Create the model and input output structure from sbtab.mat
disp("Creating the model, input and output")

% Saves the model in .mat, .sbproj and .xml format, while also creating a
% file whith the data to run the model in all different experimental
% settings defined in the SBtab.
f_sbtab_to_model(stg,sb)

%Creates code that loads the inputs of each experiment into a .mat file and
%the code to read this inputs at runtime when the experiments are being 
%simulated. 
%All this generated code is stored on the 
%"Matlab/Model/"model folder name"/Formulas" folder.
f_setup_input(stg)

%Creates two .mat files for each experiment, one for the equilibrium 
%simulation and one for the proper simulation.
%This files have all the added rules, species and parameters needed 
%depending on the inputs and outputs specified on the SBtab.
f_build_model_exp(stg,sb)
end
