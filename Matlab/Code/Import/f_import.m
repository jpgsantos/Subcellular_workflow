function f_import(stg,sb)

% % Create the model and input output structure from sbtab.mat
disp("Creating the model, input and output")

f_sbtab_to_model(stg,sb)

f_setup_input(stg)

f_build_model_exp(stg,sb)
end
