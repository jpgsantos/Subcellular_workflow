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

% Set font settings using the provided font_settings
f_set_font_settings()

% Loop through each experiment
for n = stg.exprun

    % Generate the required number of figures for all plots and calculate
    % proper subplot positioning
    if mod(plot_n,12) == 0
        [fig_n,layout,plots(fig_n,:)] =...
            f_get_subplot(plot_tn,plot_n,fig_n,"Outputs",layout,plots_1);

        if fig_n > 1
            fig_name = "Outputs " + fig_n;
        else
            fig_name = "Outputs";
        end
        title(layout,fig_name,...
            'FontSize', Major_title_FontSize,...
            'Fontweight',Major_title_Fontweight)
    end

    % Loop through each dataset in the current experiment
    for j = 1:size(sbtab.datasets(n).output,2)

        nexttile(layout);
        plot_n = plot_n + 1;

        hold on

        error_area_plotted = false;

        % Loop through each parameter array to test
        for m = stg.pat

            % Plot only if the simulation was successful
            if rst(m).simd{1,n} ~= 0

                data = Data(n).Experiment.x(:,j);

                data_SD = Data(n).Experiment.x_SD(:,j);

                time = rst(m).simd{1,n}.Time;

                % Plot the error area if it hasn't been plotted yet
                if ~error_area_plotted
                    f_error_area(transpose(time), transpose([data-data_SD, data+data_SD]));
                    error_area_plotted = true;
                end

                % Normalize simulation results
                [sim_results,~] = f_normalize(rst(m),stg,n,j,mmf);
                sim_results_detailed =[];

                % Plot detailed simulation results if enabled in settings
                if stg.simdetail
                    time_detailed = rst(m).simd{1,n+2*stg.expn}.Time;
                    [~,sim_results_detailed]= f_normalize(rst(m),stg,n,j,mmf);

                    plot(time_detailed,sim_results_detailed,'DisplayName',...
                        string("\theta_"+m),'LineWidth',line_width)

                else
                    plot(time,sim_results,'DisplayName',...
                        string("\theta_"+m),'LineWidth',line_width)
                end

                % Set the y-axis label
                ylabel(string(rst(m).simd{1,n}.DataInfo{end-...
                    size(sbtab.datasets(n).output,2)+j,1}.Units),...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
            end
        end

        hold off

        % Set the y-axis limits
        min_y = min([0, min(sim_results), min(data - data_SD), min(data),...
            stg.simdetail * min(sim_results_detailed)]);
        ylim([min_y, inf]);

        % Choose the appropriate title based on the settings
        if stg.plotoln == 1
            title_text = "E" + (n-1) + " " +...
                strrep(string(sbtab.datasets(n).output_name{1,j}),'_','\_');
        else
            title_text = "E" + (n-1) + " " +...
                string(sbtab.datasets(n).output{1,j});
        end

        % Set the title for the subplot
        title(title_text, 'FontSize', Minor_title_FontSize,...
            'Fontweight', Minor_title_Fontweight);

        % Set the number of decimal places for the y-axis
        ytickformat('%-4.1f')
        % Add a legend to the plot
        if mod(plot_n,12) == 1

            Lgnd = legend('show','Orientation','vertical',...
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