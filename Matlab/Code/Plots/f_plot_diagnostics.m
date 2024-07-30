function plots = f_plot_diagnostics(plots,results,settings,sbtab,Data,model_folder)
% Generate and store figure with Inputs
plots = [plots;f_plot_inputs(results.diag, settings, sbtab)];
% Generate and store figure with Outputs
plots = [plots;f_plot_outputs(results.diag, settings, sbtab, Data, model_folder)];
% Generate and store figure with Input and Output for all experiments
plots = [plots;f_plot_in_out(results.diag, settings, sbtab, Data, model_folder)];
end

function plots = f_plot_inputs(rst,stg,sbtab)
% This function generates a figure containing a series of subplots, with
% each subplot representing the inputs of an individual experiment. The
% function also adjusts the layout and formatting of the figure according
% to the given font settings.
%
% Inputs:
% - rst: A structure containing the results of the experiments
% - stg: A structure containing experiment settings (e.g., exprun, pat)
% - sbtab: A structure containing datasets and their associated information
% - font_settings: A structure containing font settings for the plots
%
% Outputs:
% - plots: A cell array containing the generated plots
%
% Functions called:
% - set_font_settings: Apply font settings to the current function scope
% - f_get_subplot: Calculate subplot positions and generate figures
%
% Variables
% Loaded:
% None
%
% Initialized:
% - plot_n: Counter for the number of plots
% - fig_n: Counter for the number of figures
% - layout: The layout of the plots in the figure
% - plots_1: Temporary storage for the generated plots
% - labelfig2: Labels for each input in the experiment
% - Lgnd: Legend for the plots
%
% Persistent:
% None

% Inform the user that diagnosis inputs are beeing ploted
disp("Plotting Inputs")

plot_n = 0;
fig_n = 0;
layout = [];
plots = cell(1,2);
% Set font settings
f_set_font_settings()

% Iterate over the number of experiments
for exp_idx = stg.exprun

    % Generate the right amount of figures for all plots and calculates
    % proper subploting position
    if mod(plot_n,12) == 0
        [fig_n,layout,plots(fig_n,:)] = f_get_subplot(size(stg.exprun,2),plot_n,fig_n,"Inputs",layout);

        % Set figure name based on its order
        if fig_n > 1
            fig_name = strrep(stg.plot_name, "_", "\_") + "  Inputs " + fig_n;
        else
            fig_name = strrep(stg.plot_name, "_", "\_") + "  Inputs";
        end
        title(layout,fig_name,...
            'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight)
    end

    nexttile(layout);

    plot_n = plot_n +1;

    [input_plot,labelfig2] = f_plot_input(stg,rst,sbtab,exp_idx);

    % Set x-axis label for the first plot in a row
    if mod(plot_n,12) == 1

        xlabel(layout,"Seconds", 'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

        % Create legend
        Lgnd = legend(input_plot,'Orientation','horizontal', ...
            'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
            'Location','layout','Box','off');
        Lgnd.Layout.Tile = 'North';
        Lgnd.ItemTokenSize = Legend_ItemTokenSize;
    end

    % Add a title to each plot
    title("E"+(exp_idx-1))
end
end

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
plot_tn = plot_tn*stg.plot_norm;

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
                    fig_name = strrep(stg.plot_name, "_", "\_") + "  Outputs " + fig_n;
                else
                    fig_name = strrep(stg.plot_name, "_", "\_") + "  Outputs";
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
                if do_norm == 1
                    [plot_data,plot_data_SD,data,data_SD] = ...
                        plot_data_and_data_SD(stg,rst,Data,exp_idx,out_idx);
                end
                [valid_outputs_plots,valid_outputs,output_max,output_min] =...
                    plot_sim_outputs(stg,rst,sbtab,mmf,exp_idx,out_idx,~k,include_exp_n);
            else
                [plot_data,plot_data_SD,data,data_SD] = ...
                    plot_data_and_data_SD(stg,rst,Data,exp_idx,out_idx);
                [valid_outputs_plots,valid_outputs,output_max,output_min] =...
                    plot_sim_outputs(stg,rst,sbtab,mmf,exp_idx,out_idx,k,include_exp_n);
            end

            hold off

            % Add a legend to the plot
            if mod(plot_n,12) == do_norm
                Lgnd = legend([valid_outputs_plots(:,valid_outputs),...
                    plot_data,plot_data_SD],'Orientation','horizontal',...
                    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
                    'Location','layout');
                Lgnd.Layout.Tile = 'South';
                Lgnd.ItemTokenSize = Legend_ItemTokenSize;
                % Remove the legend box
                set(Lgnd,'Box','off')
            end
        end
    end
end
end

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

helper_var = 4/stg.plot_norm;
% Iterate over each experiment run to generate plots.
for exp_idx = stg.exprun
    sub_fig_number = 0;% Track subplot numbers within the same figure.

    % Calculate the number of outputs for the current experiment.
    n_outputs_exp = size(sbtab.datasets(exp_idx).output,2);

    n_outputs_exp_norm = n_outputs_exp;

    % Initialize variable for figure management within the same experiment
    fig_number_same_exp = 1;
    % Increment counters for figure management.
    fig_number = fig_number + 1;

    % Plot input data on the left side of the figure for the current
    % experiment.
    1
    [layout,plots] = ...
        f_plot_in_out_left(rst, stg, sbtab, fig_number_same_exp,...
        n_outputs_exp_norm > helper_var, exp_idx, plots, fig_number);

% % Span the input data plot across two rows for better visibility.
% nexttile(layout(1,1),[2 1]);
% 
%     [input_plot,labelfig2] = ...
%         f_plot_in_out_left_2(rst,stg,sbtab,exp_idx);
    % draw_legend = 1;% Initialize flag to draw legend.

    % Loop through each output of the current experiment
    for out_idx = 1:n_outputs_exp

        % Check if new subplot layout is needed based on output count.
        sub_fig_number = sub_fig_number +1;

        if sub_fig_number/4 > fig_number_same_exp
            2
            fig_number_same_exp = fig_number_same_exp+1;
            fig_number = fig_number+ 1;

            % Plot input data on the left side of the figure for the
            % current experiment.
            [layout,plots] = ...
                f_plot_in_out_left(rst, stg,sbtab, fig_number_same_exp,...
                n_outputs_exp_norm > helper_var, exp_idx, plots, fig_number);
            % draw_legend = 1; % Reset flag for new subplot layout.

% Span the input data plot across two rows for better visibility.
nexttile(layout,[2 1]);


            [input_plot,labelfig2] = ...
                f_plot_in_out_left_2(rst,stg,sbtab,exp_idx);
        end

        % Setup the next tile for output data plotting.
        if n_outputs_exp_1(exp_idx)-(fig_number_same_exp-1)*4 == 1
            nexttile(2,[2 2]);
        elseif n_outputs_exp_1(exp_idx)-(fig_number_same_exp-1)*4 == 2
            nexttile(2,[2 1]);
        else
            nexttile(2,[1 1]);
        end

        hold on
        % if isempty(sim_results_norm{stg.pat(1)})

        if stg.plot_norm == 1
            % Call function to plot simulation data.
            [plot_data,plot_data_SD,data,data_SD] = ...
                plot_data_and_data_SD(stg,rst,Data,exp_idx,out_idx);
            % draw_legend = 1; % Reset flag for new subplot layout.
        end
        % Call function to plot simulation outputs.
        [valid_outputs_plots,valid_outputs,output_max,output_min] = ...
            plot_sim_outputs(stg,rst,sbtab,mmf,exp_idx,out_idx,0,include_exp_n);
        hold off

        % Set the y-axis limits based on simulation detail setting and
        % data range.
        if stg.plot_norm == 1

            min_noSD = min(output_min,min(data));
            max_noSD = max(output_max,max(data));

            y_range = max_noSD - min_noSD;

            min_SD = (max(min(data-data_SD),min(data)-y_range*0.05));
            max_SD = (min(max(data+data_SD),max(data)+y_range*0.05));
        else
            % Adjust y-axis limits if normalized simulation results are
            % available.
            min_noSD = output_min;
            max_noSD = output_max;

            min_SD = min_noSD;
            max_SD = max_noSD;
        end

        if ~isempty(sbtab.datasets(exp_idx).Normalize)

            % Check if new subplot layout is needed based on output count.
            sub_fig_number = sub_fig_number +1;
            if sub_fig_number/4 > fig_number_same_exp
                3
                fig_number_same_exp = fig_number_same_exp+1;
                fig_number = fig_number + 1;

                % Plot input data on the left side of the figure for the
                % current experiment.
                [layout,plots] = ...
                    f_plot_in_out_left(rst, stg,sbtab, fig_number_same_exp,...
                    n_outputs_exp_norm > helper_var, exp_idx, plots, fig_number);
                % draw_legend = 1;% Reset flag for new subplot layout.

                % Span the input data plot across two rows for better visibility.
                nexttile(layout,[2 1]);

                [input_plot,labelfig2] = ...
                    f_plot_in_out_left_2(rst,stg,sbtab,exp_idx);
            end

            % Setup the next tile for output data plotting.
            if n_outputs_exp_1(exp_idx)-(fig_number_same_exp-1)*4 == 1
                nexttile(3,[2 2]);
            elseif n_outputs_exp_1(exp_idx)-(fig_number_same_exp-1)*4 == 2
                nexttile(3,[2 1]);
            else
                nexttile(3,[1 1]);
            end

            hold on

            % Call function to plot simulation data.
            [plot_data,plot_data_SD,data,data_SD] =...
                plot_data_and_data_SD(stg,rst,Data,exp_idx,out_idx);

            % Call function to plot simulation outputs.
            [valid_outputs_plots,valid_outputs,output_max,output_min] = ...
                plot_sim_outputs(stg,rst,sbtab,mmf,exp_idx,out_idx,1,include_exp_n);

            hold off
            % draw_legend = 1; % Reset flag for new subplot layout.

            % Set ylim
            min_noSD = min(output_min,min(data));
            max_noSD = max(output_max,max(data));

            y_range = max_noSD - min_noSD;

            min_SD = (max(min(data-data_SD),min(data)-y_range*0.05));
            max_SD = (min(max(data+data_SD),max(data)+y_range*0.05));


        end

        ylim([min_SD max_SD])

        % Span the input data plot across two rows for better visibility.
        nexttile(1,[2 1]);

        [input_plot,labelfig2] = ...
            f_plot_in_out_left_2(rst,stg,sbtab,exp_idx);

        plots_leg = [input_plot,valid_outputs_plots(:,valid_outputs),...
            plot_data,plot_data_SD]
        save("plots_leg.mat","plots_leg")
        leg = legend(plots_leg,...
            'FontSize', Legend_FontSize,...
            'Fontweight',Legend_Fontweight, ...
            "Orientation","horizontal");
        leg.Layout.Tile = 'south'; % Position legend at the bottom.
        % % Set the size of legend markers.
        leg.ItemTokenSize = Legend_ItemTokenSize;
        set(leg,'Box','off') % Remove the legend box boundary.

        % Check if legend needs to be drawn for the current subplot.
        % if draw_legend == 1
        % Construct the legend with the correct formatting and
        % placement.

        % leg = legend([input_plot,valid_osutputs_plots(:,valid_outputs),...
        %     plot_data,plot_data_SD],...
        %     'FontSize', Legend_FontSize,...
        %     'Fontweight',Legend_Fontweight,'Location','layout', ...
        %     "Orientation","horizontal");
        % leg.Layout.Tile = 'south'; % Position legend at the bottom.
        % % Set the size of legend markers.
        % leg.ItemTokenSize = Legend_ItemTokenSize;
        % set(leg,'Box','off') % Remove the legend box boundary.
        % draw_legend = 0; % Reset flag after drawing the legend.
        % end
    end
end
end

function [layout,plots] = ...
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



% Assign a title to the overall layout, enhancing readability and context.
title(layout, name_long,...
    'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight)


end
function [input_plot,labelfig2] = ...
    f_plot_in_out_left_2(rst,stg,sbtab,exp_idx)
% Set the font settings for consistent appearance across all plots.
f_set_font_settings()

% Begin plotting the input data for the specified experiment.
hold on % Keep the plot active to overlay multiple inputs if necessary.

[input_plot,labelfig2] = f_plot_input(stg,rst,sbtab,exp_idx);

% Finish plotting to ensure all input data is displayed properly.
hold off

% Label the x-axis as 'Seconds' and apply pre-defined font settings.
xlabel('Seconds','FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

% Assign a title to differentiate between single or multiple inputs
% visually.
if size(sbtab.datasets(exp_idx).input,2) == 1
    title("Input"," ",'FontSize', Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight);
else
    title("Inputs"," ",'FontSize', Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight);
end
end


function [input_plot,labelfig2] = f_plot_input(stg,rst,sbtab,exp_idx)

% Set font settings
f_set_font_settings()
log_10 = 0;
% Iterate through each input species for the current experiment.
for ipt_idx = 1:size(sbtab.datasets(exp_idx).input,2)
    % Iterate through each set of parameters to process simulation results.
    for pa_idx = stg.pat
        % Check if the simulation was successful for the current parameter
        % set and experiment.
        if rst(pa_idx).simd{1,exp_idx} ~= 0
            % Convert species identifier from string to number.
            input_species_ID =...
                str2double(strrep(sbtab.datasets(exp_idx).input(ipt_idx),'S',''))+1;
            if log_10 == 0
                input_y = rst(pa_idx).simd{1,exp_idx}.Data(1:end,input_species_ID);
                label_y = string(rst(pa_idx).simd{1,exp_idx}. ...
                    DataInfo{input_species_ID,1}.Units);

            else
                input_y = log10(rst(pa_idx).simd{1,exp_idx}.Data(1:end,input_species_ID));
                label_y = "Log10 " + string(rst(pa_idx).simd{1,exp_idx}. ...
                    DataInfo{input_species_ID,1}.Units);
            end

            % Create a scatter plot for the input species data points.
            input_plot(ipt_idx) = ...
                scatter(rst(pa_idx).simd{1,exp_idx}.Time(1:stg.in_plot_trim:end),...
                input_y(1:stg.in_plot_trim:end),...
                2,"o","filled","MarkerFaceAlpha",1,...
                "MarkerEdgeAlpha",1,"DisplayName",...
                rst(pa_idx).simd{1,exp_idx}.DataNames{input_species_ID});

            % Get the correct label for each input of the experiment
            labelfig2(ipt_idx) = string(rst(pa_idx).simd{1,exp_idx}.DataNames{input_species_ID});

            % Label the y-axis with the correct unit and apply pre-defined
            % font settings.
            ylabel(string(rst(pa_idx).simd{1,exp_idx}. ...
                DataInfo{input_species_ID,1}.Units), ...
                'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

            % Get the current y-axis tick values
            yticks = get(gca, 'YTick');

            % Convert the tick values to strings with high precision
            tickStrings = arrayfun(@(v) convertStringsToChars(string(v)), yticks, 'UniformOutput', false);

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
            if max([countDecimals{:}]) > 2
                ytickformat('%.2f');
            end

            % Set y-axis limit and format
            ylim([0 inf])

            % Break after plotting the first available set to avoid clutter.
            break
        end
    end
end
end

function [valid_outputs_plots,valid_outputs,output_max,output_min] =...
    plot_sim_outputs(stg,rst,sbtab,mmf,exp_idx,out_idx,is_norm,include_exp_n)
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
        [sim_results_norm{pa_idx},sim_results_detailed{pa_idx},sim_results{pa_idx}] =...
            f_normalize(rst(pa_idx),stg,exp_idx,out_idx,mmf);

        if stg.simdetail
            time = rst(pa_idx).simd{1,exp_idx+2*stg.expn}.Time;
            results = sim_results_detailed{pa_idx};
            results_y_label = string(rst(pa_idx).simd{1,exp_idx}. ...
                DataInfo{end-n_outputs_exp+out_idx,1}.Units);
        else
            time = rst(pa_idx).simd{1,exp_idx}.Time;
            if is_norm
                results = sim_results_norm{pa_idx}(1:stg.out_plot_trim:end);
                results_y_label = "dimensionless";
            else
                results = sim_results{pa_idx}(1:stg.out_plot_trim:end);
                results_y_label = string(rst(pa_idx).simd{1,exp_idx}. ...
                    DataInfo{end-n_outputs_exp+out_idx,1}.Units);
            end
        end

        valid_outputs_plots(current_plot) = scatter(time,...
            results,2,colors(current_plot,:),"o","filled","MarkerFaceAlpha",1,...
                "MarkerEdgeAlpha",1,"DisplayName","\theta_{"+pa_idx+ "}");

        ylabel(results_y_label,...
            'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

        output_max = max(results);
        output_min = min(results);

        % Add the successful parameter index to the list of valid outputs.
        valid_outputs(current_plot) = current_plot;
    end
end

% Get the current y-axis tick values
yticks = get(gca, 'YTick');

% Convert the tick values to strings with high precision
tickStrings = arrayfun(@(v) convertStringsToChars(string(v)), yticks, 'UniformOutput', false);

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
if max([countDecimals{:}]) > 2
    ytickformat('%.2f');
end


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
        plot_data = scatter(time(1:stg.out_plot_trim:end),data(1:stg.out_plot_trim:end),2,'k',"o","filled",...
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

function plot = f_error_area(X,Y_SD)
% This function is used to create a shaded area plot representing the
% standard deviation (SD) of given data. It takes two inputs: X is a vector
% of data points on the x-axis, and Y_SD is a 2xN matrix where the first
% row contains the lower bounds, and the second row contains the upper
% bounds of the shaded area.

% Prepare x coordinates for the shaded area
Xh=[X(1:end-1); X(1:end-1); X(2:end); X(2:end);];
% Prepare y coordinates for the shaded area
Yh=[Y_SD(1,1:end-1); Y_SD(2,1:end-1); Y_SD(2,2:end); Y_SD(1,2:end); ];
% Create the shaded area plot
plot = patch(Xh,Yh,zeros(size(Xh)),'DisplayName',"Data\_SD",'EdgeColor',...
    'none','FaceColor',[0 0 0],'FaceAlpha',0.25,'HandleVisibility','off');
reducepatch(plot,0.05)
end

function [figure_number,layout,plots] =...
    f_get_subplot(plot_total_n,plot_n,figure_number,fig_name,layout,plots)
% Determines the layout for subplots, creates a new figure when needed, and
% closes previous instances of the figure.
%
% Inputs:
% - plot_total_n: Total number of plots to display
% - plot_n: Current plot number
% - figure_number: Current figure number
% - fig_name: Figure name as a string
% - layout: Layout object to be updated with new configuration
% - plots: Cell array containing figure handles and names
%
% Outputs:
% - figure_number: Updated figure number
% - layout: Updated layout object
% - plots: Updated cell array with figure handles and names
%
% Functions called:
% - create_new_figure: Closes any existing figure with the same name,
% then creates a new docked figure with the given name
% - calculate_layout: Calculates the layout for the current figure based
% on the figure number, total number of plots, maximum size, and subplot
% dimensions
% - f_renew_plot: Closes any existing figures with the specified name and
% then creates a new figure with the given name and properties. It returns
% a 1x2 cell array containing the figure name and the figure handle.
%
% Variables:
% Loaded:
% None
%
% Initialized:
% - size_total: Maximum number of plots per figure
% - size_x: Array of subplot layout column counts
% - size_y: Array of subplot layout row counts
%
% Persistent:
% None

size_total = 12;

size_x = [1,1,1,2,2,2,2,2,3,3,3,3];
size_y = [1,2,3,2,3,3,4,4,3,4,4,4];

if mod(plot_n,size_total) == 0
    figure_number = figure_number + 1;
    % If the total number of plots exceeds the maximum per figure, create
    % additional figures and update the figure name.
    if plot_total_n > size_total
        fig_name = fig_name + " " + figure_number;
    end

    % Close previous instances of the figure and create a new one.
    plots = f_renew_plot(fig_name);

    % Calculate the layout for the current figure based on the total number
    % of plots, maximum size, and the dimensions of the subplot.
    layout =...
        calculate_layout(figure_number, plot_total_n,...
        size_total, size_x, size_y);
end
end

function layout = ...
    calculate_layout(figure_number, plot_total_n,...
    size_total, size_x, size_y)
% This function calculates the layout for the current figure based on the
% figure number, total number of plots, maximum size, and subplot
% dimensions.

if figure_number <= floor(plot_total_n/size_total)
    % If the current figure is not the last one, use the maximum size
    % dimensions for the layout.
    layout = tiledlayout(size_x(size_total), size_y(size_total),...
        'Padding', 'none', 'TileSpacing', 'tight');
else
    % If the current figure is the last one, calculate the remaining number
    % of plots and use the corresponding dimensions for the layout.
    remaining_plots =...
        plot_total_n - (floor(plot_total_n/size_total) * size_total);

    layout =...
        tiledlayout(size_x(remaining_plots), size_y(remaining_plots),...
        'Padding', 'none', 'TileSpacing', 'tight');
end
end

function colors = generateRainbowGradient(n)
% Define the base colors for the rainbow gradient
baseColors = [
    % 0.15196, 0.05741, 0.18574;  % Dark Indigo
    0, 0, 0.8;                  % Blue
    0, 0.4, 0.8;                % Light Blue
    0, 0.8, 0.8;                % Cyan
    0, 0.8, 0;                  % Green
    0.4, 0.8, 0;                % Light Green
    0.8, 0.8, 0;                % Yellow
    0.8, 0.4, 0;                % Orange
    0.8, 0, 0;                  % Red
    % 0.51765, 0.04706, 0.06588;  % Dark Red
    ];

% Number of base colors
numBaseColors = size(baseColors, 1);
if n >= numBaseColors
    % Interpolation case (same as before)
    colors = zeros(n, 3);
    for i = 1:n
        ratio = (i - 1) / (n - 1) * (numBaseColors - 1);
        baseIndex = floor(ratio) + 1;
        if baseIndex < numBaseColors
            nextIndex = baseIndex + 1;
            alpha = ratio - floor(ratio);
            colors(i, :) = (1 - alpha) * baseColors(baseIndex, :) + alpha * baseColors(nextIndex, :);
        else
            colors(i, :) = baseColors(end, :);
        end
    end
else
    % Selection case
    indices = round(linspace(1, numBaseColors, n));
    colors = baseColors(indices, :);
end
end