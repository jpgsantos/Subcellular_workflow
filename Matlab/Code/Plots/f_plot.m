function f_plot(rst,stg,mmf)
set(0,'defaultAxesFontName','Arial')
set(0,'defaultAxesFontSize',10)

% Inform the user that the plots are being done
disp("Plotting ...")

data_model = mmf.model.data.data_model;

% Import the data on the first run
load(data_model,'Data','sbtab')

if isfield(rst,'diag')
    % Generate figure with Scores
    f_plot_scores(rst.diag,stg,sbtab)
    % Generate figure with Inputs
    f_plot_inputs(rst.diag,stg,sbtab)
    % Generate figure with Outputs
    f_plot_outputs(rst.diag,stg,sbtab,Data,mmf)
    % Generate figure with input and Output of all experiments
    f_plot_in_out(rst.diag,stg,sbtab,Data)
end

% Generate figure with optimization results
if isfield(rst,'opt')
    f_plot_opt(rst,stg)
end

% Generate figures for Local Sensitivity Analysis
if isfield(rst,'lsa')
    f_plot_lsa(rst.lsa,stg);
end

% Generate figures for Global Sensitivity Analysis
if isfield(rst,'gsa')
    f_plot_gsa_sensitivities(rst.gsa,stg,sbtab);
end

% Generate figure for Profile Likelihood Analysis
if isfield(rst,'PLA')
    f_plot_PL(rst,stg,mmf)
end
end