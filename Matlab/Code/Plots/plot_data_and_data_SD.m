function [plot_data,plot_data_SD,data,data_SD] = ...
    plot_data_and_data_SD(stg,rst,Data,exp_idx,out_idx)
% Plot output data only if the simulation was successful. This is a
% subfunction to plot data and their standard deviation for a specific
% output.
%
% Inputs:
% - stg: Experiment settings.
% - rst: Results from simulations.
% - Data: Experimental data and standard deviations.
% - exp_idx: Index identifying the current experiment.
% - out_idx: Index identifying the current output.
% Outputs:
% - plot_data: Scatter plot of the experimental data points.
% - plot_data_SD: Area plot representing the standard deviation.

% Iterate through each set of parameters to process simulation results.
for pa_idx = stg.pat
    % Check if the simulation was successful for the current parameter set
    % and experiment.
    if rst(pa_idx).simd{1,exp_idx} ~= 0

        % Extract time, data, and standard deviation for the current
        % experiment
        time = rst(pa_idx).simd{1,exp_idx}.Time;
        data = Data(exp_idx).Experiment.x(:,out_idx);
        data_SD = Data(exp_idx).Experiment.x_SD(:,out_idx);

        % Create a scatter plot for the output data points.
        plot_data = scatter(time(1:10:end),data(1:10:end),2,'k',"o","filled",...
            "MarkerFaceAlpha",1,"MarkerEdgeAlpha",1,...
            "DisplayName","data");

        % Overlay the standard deviation of the output data as shaded
        % areas.
        plot_data_SD = f_error_area(transpose(time),...
            transpose([data-data_SD,data+data_SD]));

         % Only plot the first successful set of data for clarity.
        break
    end
end
end