function f_import(stg,sb)

% % Create the model and input output structure from sbtab.mat
disp("Creating the model, input and output")

% Saves the model in .mat, .sbproj and .xml format, while also creating a
% file whith the data to run the model in all different experimental
% settings defined in the sbtab
f_sbtab_to_model(stg,sb)

% Creates code that loads the inputs of each experiment into a .mat file, 
% "Data_D1_LTP_time_window_input" in this case, and creates the code to
% read this inputs at runtime when the experiments are being simulated, all
% this generated code is stored on the formulas folder
f_setup_input(stg)

%Creates two a .mat files for each experimetn, with all the added rules,
%species and parameters needed depending on the inputs and outputs
%specified on the sbtab, one for the equilibrium simulation run and one for
%the proper run
f_build_model_exp(stg,sb)
end
