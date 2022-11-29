function plots = f_plot(rst,stg,mmf)
set(0,'defaultAxesFontName','Arial')
set(0,'defaultAxesFontSize',10)

% Inform the user that the plots are being done
disp("Plotting ...")

data_model = mmf.model.data.data_model;

% Import the data on the first run
load(data_model,'Data','sbtab')

if isfield(rst,'diag')
    % Generate figure with Scores
    plots1 = f_plot_scores(rst.diag,stg,sbtab);
    % Generate figure with Inputs
    plots2 = f_plot_inputs(rst.diag,stg,sbtab);
    % Generate figure with Outputs
    plots3 = f_plot_outputs(rst.diag,stg,sbtab,Data,mmf);
    % Generate figure with input and Output of all experiments
    plots4 = f_plot_in_out(rst.diag,stg,sbtab,Data,mmf);
    plots = [plots1;plots2;plots3;plots4];
    
end

% Generate figure with optimization results
if isfield(rst,'opt')
    plots5 = f_plot_opt(rst,stg);
    plots = [plots1;plots2;plots3;plots4;plots5];
end

% Generate figures for Local Sensitivity Analysis
if isfield(rst,'lsa')
    f_plot_lsa(rst.lsa,stg);
    plots = [];
end

% Generate figures for Global Sensitivity Analysis
if isfield(rst,'gsa')
    f_plot_gsa_sensitivities(rst.gsa,stg,sbtab);
    plots = [];
end

% Generate figure for Profile Likelihood Analysis
if isfield(rst,'PLA')
    f_plot_PL(rst,stg,mmf)
end
end