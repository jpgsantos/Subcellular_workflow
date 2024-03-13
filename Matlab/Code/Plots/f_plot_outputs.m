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
% plots_1 = [];
plots = cell(1,2);
plot_tn = plot_tn *2;

% Set font settings using the provided font_settings
f_set_font_settings()

% Loop through each experiment
for exp_idx = stg.exprun

    % Loop through each dataset in the current experiment
    for j = 1:size(sbtab.datasets(exp_idx).output,2)
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

        hold on

        error_area_plotted = false;
        valid_outputs = [];

        % Loop through each parameter array to test
        for m = stg.pat

            % Plot output data only if the simulation was successful
            if rst(m).simd{1,exp_idx} ~= 0

                % Retrieve time, data and standard deviation from the
                % experiment
                time = rst(m).simd{1,exp_idx}.Time;
                data = Data(exp_idx).Experiment.x(:,j);
                data_SD = Data(exp_idx).Experiment.x_SD(:,j);

                % Plot the output data
                plot_data = plot(time,data,'LineWidth',0.5,...
                    'DisplayName','data','Color','k');

                % Plot the standard deviation of the output data
                plot_data_SD = f_error_area(transpose(time),...
                    transpose([data-data_SD,data+data_SD]));
                break
            end
        end

        % Loop through each parameter array to test
        for m = stg.pat

            % Plot only if the simulation was successful
            if rst(m).simd{1,exp_idx} ~= 0

                if k == 1
                % Plot the error area if it hasn't been plotted yet
                if ~error_area_plotted
                    f_error_area(transpose(time), transpose([data-data_SD, data+data_SD]));
                    error_area_plotted = true;
                end
                end
                % Normalize simulation results
                % [sim_results,~,sim_results] = f_normalize(rst(m),stg,n,j,mmf);
                % sim_results_detailed =[];
                if k == 1
                    [~,~,sim_results] = f_normalize(rst(m),stg,exp_idx,j,mmf);
                    sim_results_detailed =[];
                else
                    [sim_results,~,~] = f_normalize(rst(m),stg,exp_idx,j,mmf);
                    sim_results_detailed =[];
                end
                

                % Plot detailed simulation results if enabled in settings
                if stg.simdetail
                    time_detailed = rst(m).simd{1,exp_idx+2*stg.expn}.Time;
                    [~,sim_results_detailed]= f_normalize(rst(m),stg,exp_idx,j,mmf);

                    valid_outputs_plots(:,m) = plot(time_detailed,sim_results_detailed,'DisplayName',...
                        string("\theta_"+m),'LineWidth',line_width);

                else
                    valid_outputs_plots(:,m) = plot(time,sim_results,'DisplayName',...
                        string("\theta_"+m),'LineWidth',line_width);
                end

                % Set the y-axis label
                ylabel(string(rst(m).simd{1,exp_idx}.DataInfo{end-...
                    size(sbtab.datasets(exp_idx).output,2)+j,1}.Units),...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
                valid_outputs = [valid_outputs,m];
            end
        end

        hold off

        % Set the y-axis limits
        min_y = min([0, min(sim_results), min(data - data_SD), min(data),...
            stg.simdetail * min(sim_results_detailed)]);
        ylim([min_y, inf]);

        % Choose the appropriate title based on the settings
        if stg.plotoln == 1
            title_text = "E" + (exp_idx-1) + " " +...
                strrep(string(sbtab.datasets(exp_idx).output_name{1,j}),'_','\_');
        else
            title_text = "E" + (exp_idx-1) + " " +...
                string(sbtab.datasets(exp_idx).output{1,j});
        end

        % if stg.simdetail
            output_max = max([max(sim_results_detailed),max(sim_results),...
                max(data-data_SD),max(data)]);
        % else
        %     output_max = max([max(sim_results),...
        %         max(data-data_SD),max(data)]);
        % end

        % if output_max <= 10
        %     ytickformat('%-3.1f')
        % else
        %     ytickformat('%-4.0f')
        % end

if output_max < 10000
        % Set the title for the subplot
        title(title_text, 'FontSize', Minor_title_FontSize,...
            'Fontweight', Minor_title_Fontweight);
else
        title("      " + title_text, 'FontSize', Minor_title_FontSize,...
            'Fontweight', Minor_title_Fontweight);
end



        % Set the number of decimal places for the y-axis
        % ytickformat('%-4.1f')
        % Add a legend to the plot
        if mod(plot_n,12) == 1

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