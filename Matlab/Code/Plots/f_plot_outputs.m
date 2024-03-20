function plots = f_plot_outputs(rst,stg,sbtab,Data,mmf)
% Generates a figure containing multiple subplots representing experimental
% outputs for each experiment and dataset. The function loops through each
% experiment and dataset and plots the results based on specified settings.
% The font properties for plot elements are set using the
% `set_font_settings` function.
%
% Inputs:
% - rst: Results object containing simulation results and data information
% - stg: Settings object containing various settings, such as experiment
% run and parameter array
% - sbtab: SBtab object containing datasets and output information
% - Data: Data object containing experimental data and error information
% - mmf: A flag to determine whether to normalize the simulation results
% - font_settings: A structure containing font properties for plot elements
%
% Outputs:
% - plots: A cell array containing figures and layouts generated
% by the function
%
% Functions called:
% - f_get_outputs: Get the total number of outputs to set the total number
% of plots
% - set_font_settings: Set the font properties for plot elements using the
% provided font_settings
% - f_get_subplot: Generate the required number of figures for all plots
% and calculate proper subplot positioning
% - f_error_area: Plot the error area
% - f_normalize: Normalize simulation results
%
% Variables:
% Loaded:
% None
%
% Initialized:
% - plot_tn: Total number of plots
% - plot_n: Current plot number
% - fig_n: Current figure number
% - layout: TiledLayout object for subplots
% - plots_1: Cell array to store figures and layouts temporarily
%
% Persistent:
% None

% Display a message indicating that the outputs are being plotted
disp("Plotting Outputs")

% Get the total number of outputs to set the total number of plots
[plot_tn,~] = f_get_outputs(stg,sbtab);
plot_n = 0;
fig_n = 0;
layout = [];
plots = cell(1,2);
plot_tn = plot_tn *2;

% Set font settings using the provided font_settings
f_set_font_settings()

% Loop through each experiment
for exp_idx = stg.exprun

    % Loop through each dataset in the current experiment
    for out_idx = 1:size(sbtab.datasets(exp_idx).output,2)
        do_norm = 1;
        if ~isempty(sbtab.datasets(exp_idx).Normalize)
            do_norm = 2;
        end
        for k = 1:do_norm
            % Generate the required number of figures for all plots and calculate
            % proper subplot positioning
            if mod(plot_n,12) == 0
                [fig_n,layout,plots(fig_n,:)] =...
                    f_get_subplot(plot_tn,plot_n,fig_n,"Outputs",layout);

                if fig_n > 1
                    fig_name = "Outputs " + fig_n;
                else
                    fig_name = "Outputs";
                end
                title(layout,fig_name,...
                    'FontSize', Major_title_FontSize,...
                    'Fontweight',Major_title_Fontweight)
            end

            nexttile(layout);
            plot_n = plot_n + 1;

            include_exp_n = 1;

            hold on

            if k == 1
                [valid_outputs_plots,valid_outputs,sim_results,...
                    sim_results_norm,sim_results_detailed] =...
                    plot_sim_outputs(stg,rst,sbtab,mmf,Data,exp_idx,out_idx,~k,include_exp_n,do_norm);
                if do_norm == 1
                    [plot_data,plot_data_SD,data,data_SD] = ...
                        plot_data_and_data_SD(stg,rst,Data,exp_idx,out_idx);
                end
            else
                [valid_outputs_plots,valid_outputs,sim_results,...
                    sim_results_norm,sim_results_detailed] =...
                    plot_sim_outputs(stg,rst,sbtab,mmf,Data,exp_idx,out_idx,k,include_exp_n,do_norm);
                [plot_data,plot_data_SD,data,data_SD] = ...
                    plot_data_and_data_SD(stg,rst,Data,exp_idx,out_idx);
            end

            hold off

            % Add a legend to the plot
            if mod(plot_n,12) == do_norm 
                Lgnd = legend([valid_outputs_plots(:,valid_outputs),...
                    plot_data,plot_data_SD],'Orientation','vertical',...
                    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
                    'Location','layout');
                Lgnd.Layout.Tile = 'East';
                Lgnd.ItemTokenSize = Legend_ItemTokenSize;
                xlabel(layout,"Seconds",...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
                % Remove the legend box
                set(Lgnd,'Box','off')
            end
        end
    end
end
end