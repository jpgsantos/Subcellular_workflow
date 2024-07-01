function [valid_outputs_plots,valid_outputs,sim_results,...
    sim_results_norm,sim_results_detailed] =...
    plot_sim_outputs(stg,rst,sbtab,mmf,Data,exp_idx,out_idx,is_norm,include_exp_n,do_norm)
% This subfunction handles the plotting of simulation outputs. It plots
% data based on the simulation success and whether normalization is
% applied.
%
% Inputs:
% - stg, rst, sbtab, mmf: Structures containing settings, results, table
% data, and model info.
% - exp_idx: Current experiment index.
% - out_idx: Current output index.
% - colors: Color array for plot elements.
% - is_norm: Flag indicating whether data should be normalized.
% Outputs:
% - valid_outputs_plots: Array of plots for valid outputs.
% - valid_outputs: Array of indices for valid outputs.
% - sim_results: Simulation results.
% - sim_results_norm: Normalized simulation results.
% - sim_results_detailed: Detailed simulation results, used if 'simdetail'
% is enabled.

% Initialize an empty list for storing indices of valid outputs.
valid_outputs = [];

% Apply font settings for the plot, ensuring consistency across all plots.
f_set_font_settings()

% Calculate the number of outputs for the current experiment.
n_outputs_exp = size(sbtab.datasets(exp_idx).output,2);

% Generate colors for plotting.
colors = generateRainbowGradient(length(stg.pat));
current_plot = 0;
% Iterate through each set of parameters to process simulation results.
for pa_idx = stg.pat
current_plot = current_plot + 1;
    % Check if the simulation was successful for the current parameter set
    % and experiment.
    if rst(pa_idx).simd{1,exp_idx} ~= 0

        % Fetch time and simulation results; normalize if applicable.
        time = rst(pa_idx).simd{1,exp_idx}.Time;
        data = Data(exp_idx).Experiment.x(:,out_idx);
        data_SD = Data(exp_idx).Experiment.x_SD(:,out_idx);
        [sim_results_norm{pa_idx},sim_results_detailed{pa_idx},sim_results{pa_idx}] =...
            f_normalize(rst(pa_idx),stg,exp_idx,out_idx,mmf);

        % Detailed simulation time series is used if detailed simulation
        % settings are enabled.
        if stg.simdetail
            time_detailed = rst(pa_idx).simd{1,exp_idx+2*stg.expn}.Time;
        end

        % Plot simulation data. Use detailed time and results if simdetail
        % is enabled, and color-code by parameter set.
        if stg.simdetail
            valid_outputs_plots(:,current_plot) = scatter(time_detailed,...
                sim_results_detailed{pa_idx},1,colors(current_plot,:),"o","filled",...
                "MarkerFaceAlpha",1,"MarkerEdgeAlpha",1,"DisplayName",...
                string("\theta_{"+pa_idx+ "}"));
            % Label the y-axis with the correct unit and apply pre-defined
            % font settings.
            ylabel(string(rst(pa_idx).simd{1,exp_idx}. ...
                DataInfo{end-n_outputs_exp+out_idx,1}.Units),...
                'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

            if do_norm == 2
                output_max = max([max(sim_results_detailed{pa_idx})]);
                output_min = min([min(sim_results_detailed{pa_idx})]);
            else
                output_max = max([max(sim_results_detailed{pa_idx}),...
                    max(data+data_SD),max(data)]);
                output_min = min([min(sim_results_detailed{pa_idx}),...
                    min(data+data_SD),min(data)]);
            end
        else
            % Select between normalized and raw results based on 'is_norm'
            % flag.
            if is_norm
                valid_outputs_plots(:,current_plot) = scatter(time(1:stg.out_plot_trim:end),...
                    sim_results_norm{pa_idx}(1:stg.out_plot_trim:end),1,colors(current_plot,:),"o","filled",...
                    "MarkerFaceAlpha",1,"MarkerEdgeAlpha",1,"DisplayName",...
                    string("\theta_{"+pa_idx+ "}"));
                % Label the y-axis as 'dimensionless' and apply pre-defined
                % font settings.
                ylabel("dimensionless",...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

                output_max = max([max(sim_results_norm{pa_idx}),...
                    max(data+data_SD),max(data)]);
                output_min = min([min(sim_results_norm{pa_idx}),...
                    min(data+data_SD),min(data)]);
            else



                valid_outputs_plots(:,current_plot) = scatter(time(1:stg.out_plot_trim:end),...:
                    sim_results{pa_idx}(1:stg.out_plot_trim:end),1,colors(current_plot,:),"o","filled",...
                    "MarkerFaceAlpha",1,"MarkerEdgeAlpha",1,"DisplayName",...
                    string("\theta_{"+pa_idx+ "}"));
                % Label the y-axis with the correct unit and apply
                % pre-defined font settings.
                ylabel(string(rst(pa_idx).simd{1,exp_idx}. ...
                    DataInfo{end-n_outputs_exp+out_idx,1}.Units),...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

                if do_norm == 2
                    output_max = max([max(sim_results{pa_idx})]);
                    output_min = min([min(sim_results{pa_idx})]);
                else
                    output_max = max([max(sim_results{pa_idx}),...
                        max(data+data_SD),max(data)]);
                     output_min = min([min(sim_results{pa_idx}),...
                        min(data+data_SD),min(data)]);
                end
            end
        end

        % Add the successful parameter index to the list of valid outputs.
        valid_outputs(current_plot) = current_plot;
    end
end





% Set the new y-tick values
% yticks(newYTicks);

% Label the x-axis as 'Seconds' and apply pre-defined font settings.
xlabel('Seconds','FontSize', Axis_FontSize,...
    'Fontweight',Axis_Fontweight)

% Choose the appropriate title based on the settings
if stg.plotoln == 1
    title_text = strrep(string(sbtab.datasets(exp_idx).output_name{1,out_idx}),'_','\_');
else
    title_text = string(sbtab.datasets(exp_idx).output{1,out_idx});
end

if include_exp_n == 1
    title_text = "E" + (exp_idx-1) + " " + title_text;
end

if is_norm
    title_text = title_text + " Norm";
end

% output_max
if output_max >= 10000 || output_max <= 0.01
% disp("y: " + output_max)
title_text = "      " + title_text;
end

[~,t2] = ...
    title(title_text, " " ,'FontSize',Minor_title_FontSize,...
    'Fontweight',Minor_title_Fontweight);
t2.FontSize = Minor_Title_Spacing;

% Set the number of decimal places for the y-axis
% ytickformat('%-3.1f')
end