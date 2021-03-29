function f_plot(rst,stg)

% Inform the user that the plots are being done
disp("Plotting ...")

% Import the data on the first run
load("Model/" +stg.folder_model + "/Data/data_"+stg.name+".mat",'Data','sbtab')

% Generate figure with Scores
if isfield(rst,'diag')
    f_plot_scores(rst.diag,stg,sbtab)
end

% Generate figure with Inputs
if isfield(rst,'diag')
    f_plot_inputs(rst.diag,stg,sbtab)
end

% Generate figure with Outputs
if isfield(rst,'diag')
    f_plot_outputs(rst.diag,stg,sbtab,Data)
end
% Generate figure with input and Output of all experiments
if isfield(rst,'diag')
    f_plot_in_out(rst.diag,stg,sbtab,Data)
end

% Generate figure with optimization results
if isfield(rst,'opt')
    f_plot_opt(rst,stg)
end

% Generate figures for Sensitivity Analysis
if isfield(rst,'SA')
    f_plot_SA_sensitivities(rst.SA,stg);
end
end