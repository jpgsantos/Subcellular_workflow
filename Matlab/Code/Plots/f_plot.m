function f_plot(rst,stg)

% Inform the user that the plots are being done
disp("Plotting ...")

% Import the data on the first run
load("data_"+stg.name+".mat",'Data','sbtab')

% Generate Diagnostics figure 1
if isfield(rst,'diag')
    f_plot_scores(rst.diag,stg,sbtab)
end

% Generate Diagnostics figure 2
if isfield(rst,'diag')
    f_plot_inputs(rst.diag,stg,sbtab)
end

% Generate Diagnostics figure 3
if isfield(rst,'diag')
    f_plot_outputs(rst.diag,stg,sbtab,Data)
end
end