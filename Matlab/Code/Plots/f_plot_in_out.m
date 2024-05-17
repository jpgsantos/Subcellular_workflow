function plots = f_plot_in_out(rst,stg,sbtab,Data,mmf)
% This function generates a figure displaying input and output data for all
% experiments. The left side of the figure shows the inputs of the
% experiment, and the right side shows the outputs.
%
% Inputs:
% - rst: A structure containing the results of the simulations.
% - stg: A structure containing various settings for the experiments and
% simulations.
% - sbtab: A structure containing information about the input and output
% datasets.
% - Data: A structure containing experimental data and standard
% deviations.
% - mmf: A structure containing information about the model.
%
% Outputs:
% - plots: A cell array storing the names and figure handles of the
% generated plots.
%
% Used Functions :
% - f_plot_in_out_left: Plots the input data on the left side of the
% figure.
% - f_normalize: Normalizes the simulation results.
% - f_error_area: Plots the standard deviation of the output data as an
% error area.
% - f_set_font_settings: Sets font settings for the plot.
% - f_renew_plot: Closes any existing figures with the specified name and
% then creates a new figure with the given name and properties. It returns
% a 1x2 cell array containing the figure name and the figure handle.
%
% Variables
% Loaded:
% - time: Time array for simulations.
% - data: Experimental data array.
% - data_SD: Standard deviation array for experimental data.
%
% Initialized:
% - fig_number: Keeps track of the total number of figures generated.
% - fig_number_same_exp: Keeps track of the number of figures generated
% for the same experiment.
% - n_outputs_exp: The number of outputs for the current experiment.
% - layout: A tiled layout for the figure.
% - input_plot: A plot object for input data.
% - valid_outputs: A list of valid outputs.
% - valid_outputs_plots: A list of valid output plots.
% - line_width, Axis_FontSize, Axis_Fontweight, Minor_title_FontSize,
% Minor_title_Fontweight, Major_title_FontSize, Major_title_Fontweight,
% Minor_Title_Spacing, Legend_FontSize, Legend_Fontweight,
% Legend_ItemTokenSize: Font settings variables.

% Display a message indicating that the inputs outputs are being plotted
disp("Plotting Inputs Outputs")

% Set font settings for the plot
f_set_font_settings()

% Initialize variables for managing the figures and plot storage.
fig_number = 0;
plots = cell(1,2);

include_exp_n = 0;

for exp_idx = stg.exprun
    n_outputs_exp_1(exp_idx) = size(sbtab.datasets(exp_idx).output,2);
    for out_idx = 1:size(sbtab.datasets(exp_idx).output,2)
        if ~isempty(sbtab.datasets(exp_idx).Normalize)
            n_outputs_exp_1(exp_idx) = n_outputs_exp_1(exp_idx)+1;
        end
    end
end

% Iterate over each experiment run to generate plots.
for exp_idx = stg.exprun
    sub_fig_number = 0;% Track subplot numbers within the same figure.

    % Calculate the number of outputs for the current experiment.
    n_outputs_exp = size(sbtab.datasets(exp_idx).output,2);

    n_outputs_exp_norm = n_outputs_exp;

    % Initialize variable for figure management within the same experiment
    fig_number_same_exp = 1;
    % Increment counters for figure management.
    fig_number =fig_number + 1;

    % Plot input data on the left side of the figure for the current
    % experiment.
    [layout,input_plot,plots] = ...
        f_plot_in_out_left(rst, stg, sbtab, fig_number_same_exp,...
        n_outputs_exp_norm > 4, exp_idx, plots, fig_number);
    draw_legend = 1;% Initialize flag to draw legend.

    % Loop through each output of the current experiment
    for out_idx = 1:n_outputs_exp

        % Check if new subplot layout is needed based on output count.
        sub_fig_number = sub_fig_number +1;
        if sub_fig_number/4 > fig_number_same_exp
            fig_number_same_exp = fig_number_same_exp+1;
            fig_number = fig_number+ 1;

            % Plot input data on the left side of the figure for the
            % current experiment.
            [layout,input_plot,plots] = ...
                f_plot_in_out_left(rst, stg,sbtab, fig_number_same_exp,...
                n_outputs_exp_norm > 4, exp_idx, plots, fig_number);
            draw_legend = 1; % Reset flag for new subplot layout.
        end

        % Setup the next tile for output data plotting.
        if n_outputs_exp_1(exp_idx)-(fig_number_same_exp-1)*4 == 1
            nexttile(layout,[2 2]);
        elseif n_outputs_exp_1(exp_idx)-(fig_number_same_exp-1)*4 == 2
            nexttile(layout,[2 1]);
        else
            nexttile(layout,[1 1]);
        end

        for pa_idx = stg.pat
            [sim_results_norm{pa_idx},sim_results_detailed{pa_idx},sim_results{pa_idx}] =...
                f_normalize(rst(pa_idx),stg,exp_idx,out_idx,mmf);
        end
       
        hold on
       
        if isempty(sim_results_norm{stg.pat(1)})
            % Call function to plot simulation data.
            [plot_data,plot_data_SD,data,data_SD] = ...
                plot_data_and_data_SD(stg,rst,Data,exp_idx,out_idx);

            % Call function to plot simulation outputs.
            [valid_outputs_plots,valid_outputs,sim_results,...
                sim_results_norm,sim_results_detailed] = ...
                plot_sim_outputs(stg,rst,sbtab,mmf,Data,exp_idx,out_idx,0,include_exp_n,2);

            % Set the y-axis limits based on simulation detail setting and
            % data range.
            if stg.simdetail
                min_noSD = min(min(min([sim_results_detailed{:}])),min(data));
                max_noSD = max(max(max([sim_results_detailed{:}])),max(data));
            else
                min_noSD = min(min(min([sim_results{:}])),min(data));
                max_noSD = max(max(max([sim_results{:}])),max(data));
            end
            y_range = max_noSD - min_noSD;

            min_SD = (max(min(data-data_SD),min(data)-y_range*0.05));
            max_SD = (min(max(data-data_SD),max(data)-y_range*0.05));
        else
            % Adjust y-axis limits if normalized simulation results are
            % available.
            if stg.simdetail
                min_noSD = min(min([sim_results_detailed{:}]));
                max_noSD = max(max([sim_results_detailed{:}]));
            else
                min_noSD = min(min([sim_results{:}]));
                max_noSD = max(max([sim_results{:}]));
            end
            min_SD = min_noSD;
            max_SD = max_noSD;
        end
        ylim([0 max(max_noSD,max_SD)])

        % Get the current y-axis tick values
        % currentYTicks = get(gca, 'YTick');

        % Limit the number of y-ticks
        % numDesiredYTicks = 4; % Set the desired number of y-ticks
        % currentYTicks

        % if min(min_noSD,min_SD) < 1
        % min_tick = 0
        % else
        % min_tick = min(min_noSD,min_SD)
        % end
        % newYTicks = linspace(min(min_noSD,min_SD), max(max_noSD,max_SD), numDesiredYTicks);

        % newYTicks

        % set(gca, 'YTick', newYTicks)

        % Get the current y-axis tick values
        yticks = get(gca, 'YTick');

        % yticks

        % Convert the tick values to strings with high precision
        tickStrings = arrayfun(@(v) convertStringsToChars(string(v)), yticks, 'UniformOutput', false);

        % tickStrings

        for n = 1:length(tickStrings)
            % Count the number of decimal places
            countDecimals{n} = regexp(tickStrings{n}, '(?<=\.)\d+');
            matches{n} = regexp(tickStrings{n}, '(?<=\.)\d+', 'match');
            if ~isempty(matches{n})
                countDecimals{n} = length(matches{n});
            else
                countDecimals{n} = 0;
            end

        end

        % [countDecimals{:}]

        if max([countDecimals{:}]) > 2
            ytickformat('%.2f');
        end

        hold off
        if ~isempty(sim_results_norm{stg.pat(1)})

            % Check if new subplot layout is needed based on output count.
            sub_fig_number = sub_fig_number +1;
            if sub_fig_number/4 > fig_number_same_exp
                fig_number_same_exp = fig_number_same_exp+1;
                fig_number = fig_number+ 1;

                % Plot input data on the left side of the figure for the
                % current experiment.
                [layout,input_plot,plots] = ...
                    f_plot_in_out_left(rst, stg,sbtab, fig_number_same_exp,...
                    n_outputs_exp_norm > 4, exp_idx, plots, fig_number);
                draw_legend = 1;% Reset flag for new subplot layout.
            end

            % Setup the next tile for output data plotting.
            if n_outputs_exp_1(exp_idx)-(fig_number_same_exp-1)*4 == 1
                nexttile(layout,[2 2]);
            elseif n_outputs_exp_1(exp_idx)-(fig_number_same_exp-1)*4 == 2
                nexttile(layout,[2 1]);
            else
                nexttile(layout,[1 1]);
            end

            hold on

            % Call function to plot simulation data.
            [plot_data,plot_data_SD,data,data_SD] =...
                plot_data_and_data_SD(stg,rst,Data,exp_idx,out_idx);

            % Call function to plot simulation outputs.
            [valid_outputs_plots,valid_outputs,~,~,sim_results_detailed] = ...
                plot_sim_outputs(stg,rst,sbtab,mmf,Data,exp_idx,out_idx,1,include_exp_n,1);

            hold off



            % Set ylim based on whether simdetail is enabled or not
           if stg.simdetail
                min_noSD = min(min(min([sim_results_detailed{:}])),min(data));
                max_noSD = max(max(max([sim_results_detailed{:}])),max(data));
            else
                min_noSD = min(min(min([sim_results_norm{:}])),min(data));
                max_noSD = max(max(max([sim_results_norm{:}])),max(data));
           end
            y_range = max_noSD - min_noSD;

            min_SD = min(data-data_SD);
            max_SD = max(data+data_SD);

            ylim([max(0,min(min_noSD,min_SD)) max(max_noSD,max_SD)])

            % Get the current y-axis tick values
            % currentYTicks = get(gca, 'YTick');

            % Limit the number of y-ticks
            % numDesiredYTicks = 4; % Set the desired number of y-ticks
            % currentYTicks

            % newYTicks = linspace(min(min_noSD,min_SD), max(max_noSD,max_SD), numDesiredYTicks);

            % newYTicks

            % set(gca, 'YTick', newYTicks)

            % Get the current y-axis tick values
            yticks = get(gca, 'YTick');

            % yticks

            % Convert the tick values to strings with high precision
            tickStrings = arrayfun(@(v) convertStringsToChars(string(v)), yticks, 'UniformOutput', false);

            % tickStrings

            for n = 1:length(tickStrings)
                % Count the number of decimal places
                countDecimals{n} = regexp(tickStrings{n}, '(?<=\.)\d+');
                matches{n} = regexp(tickStrings{n}, '(?<=\.)\d+', 'match');
                if ~isempty(matches{n})
                    countDecimals{n} = length(matches{n});
                else
                    countDecimals{n} = 0;
                end

            end

            % [countDecimals{:}]

            if max([countDecimals{:}]) > 2
                ytickformat('%.2f');
            end


        end

        % Check if legend needs to be drawn for the current subplot.
        if draw_legend == 1
% input_plot
% plot_data
% plot_data_SD
% valid_outputs_plots(:,1)
% valid_outputs_plots(:,2)
% valid_outputs_plots(:,3)
% valid_outputs_plots(:,4)
            % Construct the legend with the correct formatting and
            % placement.

            leg = legend([input_plot,plot_data,plot_data_SD, ...
                valid_outputs_plots(:,valid_outputs)],...
                'FontSize', Legend_FontSize,...
                'Fontweight',Legend_Fontweight,'Location','layout', ...
                "Orientation","horizontal");
            leg.Layout.Tile = 'south'; % Position legend at the bottom.
            % Set the size of legend markers.
            leg.ItemTokenSize = Legend_ItemTokenSize;
            set(leg,'Box','off') % Remove the legend box boundary.
            draw_legend = 0; % Reset flag after drawing the legend.

            % input_plot,plot_data,plot_data_SD,valid_outputs_plots(:,valid_outputs)
        end
    end
end
end

function [layout,input_plot,plots] = ...
    f_plot_in_out_left(rst,stg,sbtab,fig_number_same_exp,reuse,exp_idx,...
    plots,fig_number)
% Plots input data on the left side of the figure for a specific
% experiment. This function sets up the plot layout and titles and performs
% the data plotting.
%
% Inputs:
% - rst, stg, sbtab: Structures containing simulation results, settings,
% and dataset info.
% - fig_number_same_exp: Number of figures generated for the same
% experiment.
% - reuse: Flag indicating whether the same figure should be reused for
% multiple inputs.
% - exp_idx: Index of the current experiment.
% - plots: Existing plots data structure.
% - fig_number: Total figure count.
% Outputs:
% - layout: Configured layout for the figure.
% - input_plot: Plot object for the input data.
% - plots: Updated plots data structure with new figure information.

% Set the font settings for consistent appearance across all plots.
f_set_font_settings()

% Determine figure naming based on reuse parameter: If reusing a figure
% (for multiple outputs in the same experiment), append a sequence number
% to distinguish between them.
if reuse
    name_short = "E " + (exp_idx-1) + " " + fig_number_same_exp;
    name_long = ...
        strrep(stg.plot_name, "_", "\_") + "  Experiment " + (exp_idx-1) + " " + ...
        fig_number_same_exp + "  (E " + (exp_idx-1) + " " + ...
        fig_number_same_exp +")";
else
    name_short = "E " + (exp_idx-1);
    name_long = strrep(stg.plot_name, "_", "\_") + "  Experiment " + (exp_idx-1) + ...
        "  (E " + (exp_idx-1) +")";
end

% Refresh or create a plot with the new naming convention.
plots(fig_number,:) = f_renew_plot(name_short);

% Set up the layout of the plot, preparing for input and output data
% display.
layout = tiledlayout(2,3,'Padding',"tight",'TileSpacing','tight');
% Use a 2x3 grid layout with tight spacing.

nexttile(layout,[2 1]);
% Span the input data plot across two rows for better visibility.

% Assign a title to the overall layout, enhancing readability and context.
title(layout,name_long,...
    'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight)

% Begin plotting the input data for the specified experiment.
hold on % Keep the plot active to overlay multiple inputs if necessary.

[input_plot,~] = f_plot_input(stg,rst,sbtab,exp_idx,layout);

% Finish plotting to ensure all input data is displayed properly.
hold off

% Label the x-axis as 'Seconds' and apply pre-defined font settings.
xlabel('Seconds','FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

% Ensure the y-axis starts from zero to provide a clear baseline for all
% input data.
ylim([0 inf])

% Assign a title to differentiate between single or multiple inputs
% visually.
if size(sbtab.datasets(exp_idx).input,2) == 1
    [~,t4] = ...
        title("Input"," ",'FontSize', Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight);
else
    [~,t4] = ...
        title("Inputs"," ",'FontSize', Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight);
end
t4.FontSize = Minor_Title_Spacing;
end