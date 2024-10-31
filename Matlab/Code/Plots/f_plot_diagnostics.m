function plots = f_plot_diagnostics(plots,results,settings,sbtab,Data,model_folder)
clc
% Generate and store figure with Inputs
plots = [plots; f_plot_inputs(results.diag, settings, sbtab)];
% Generate and store figure with Outputs
plots = [plots; ...
    f_plot_outputs(results.diag, settings, sbtab, Data, model_folder)];

% Generate and store figure with Input and Output for all experiments
plots = [plots; ...
    f_plot_in_out(results.diag, settings, sbtab, Data, model_folder)];

 % plots = [plots; ...
 % f_plot_in_out_predict(results.diag, settings, sbtab, Data, model_folder)];

% plots = [plots;f_plot_outputs_2(results.diag, settings, sbtab, Data, model_folder)];
end

function list_inputs = f_list_inputs(sbtab, list_inputs, exp_idx)
    % Update the list of input species IDs and names for a given experiment
    % Extract input IDs from the current experiment and convert them to
    % numbers more efficiently
    input_ids = cellfun(@(x) sscanf(x, 'S%d') + 1, ...
        sbtab.datasets(exp_idx).input);
    % Get the names of the input species based on their IDs
    input_names = sbtab.species(input_ids, 1);
    % Find new input IDs and names that are not already in the list
    new_ids = input_ids(~ismember(input_ids, [list_inputs{1, :}]));
    new_names = input_names(~ismember(input_ids, [list_inputs{1, :}]));
    % Append the new input IDs and names to the list
    list_inputs = [list_inputs, [num2cell(new_ids); new_names']];
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

% Inform the user that inputs are being plotted
disp("Plotting Inputs")
% Initialize counters for the number of plots and figures
plot_n = 0;
fig_n = 0;
% Set font settings for the plots
f_set_font_settings()
% Get the number of experiments to plot
num_experiments = length(stg.exprun);
% Initialize a list of all inputs across experiments
all_list_inputs = cell(2, 0);
% Collect all input species IDs and names for each experiment
for exp_idx = 1:num_experiments
    all_list_inputs = ...
        f_list_inputs(sbtab, all_list_inputs, stg.exprun(exp_idx));
end
% Initialize list of inputs for the current figure
list_inputs = cell(2, 0);
% Determine the number of different inputs across all experiments
different_input_number = size(all_list_inputs, 2);
% Generate colors for plotting each input
colors = generateRainbowGradient(different_input_number);
% Prepare the first figure and layout
[fig_n, layout, plots, outer_layout] = ...
    f_get_subplot(num_experiments, plot_n, fig_n, "Inputs");
% Set the figure name based on the number of experiments
if num_experiments > 12
    fig_name = strrep(stg.plot_name, "_", "\_") + "  Inputs " + fig_n;
elseif num_experiments <= 12 && num_experiments ~= 1
    fig_name = strrep(stg.plot_name, "_", "\_") + "  Inputs";
else
    fig_name = strrep(stg.plot_name, "_", "\_") + "  Input";
end
% Set the title for the layout
title(layout, fig_name, 'FontSize', Major_title_FontSize, 'Fontweight', ...
    Major_title_Fontweight)
% Iterate over each experiment to create subplots
for exp_idx = 1:num_experiments
    % Create a new figure if needed after every 12 experiments
    if mod(exp_idx - 1, 12) == 0 && exp_idx > 1
        % Plot legend for the previous figure
        plot_input_legend(outer_layout, list_inputs, ...
            all_list_inputs, colors);
        % Reset list of inputs for the next figure
        list_inputs = cell(2, 0);
        % Label the x-axis of the previous figure
        xlabel(layout, "Seconds", 'FontSize', Axis_FontSize, ...
            'Fontweight', Axis_Fontweight)
        % Prepare a new figure and layout
        [fig_n, layout, plots, outer_layout] = ...
        f_get_subplot(num_experiments, plot_n, fig_n, "Inputs");
        % Update the figure name
        fig_name = strrep(stg.plot_name, "_", "\_") + "  Inputs " + fig_n;
        title(layout, fig_name, 'FontSize', Major_title_FontSize, ...
            'Fontweight', Major_title_Fontweight)
    end
    % Update the list of inputs for the current figure
    list_inputs = f_list_inputs(sbtab, list_inputs, stg.exprun(exp_idx));
    % Increment the plot counter
    plot_n = plot_n + 1;
    % Create a new subplot for the current experiment
    nexttile(layout);
    % Plot the input data for the current experiment
    f_plot_input(stg, rst, sbtab, stg.exprun(exp_idx), ...
        all_list_inputs, colors);
    % Set the title for the current subplot
    title("E" + (stg.exprun(exp_idx) - 1), 'FontSize', ...
        Minor_title_FontSize, 'Fontweight', Minor_title_Fontweight)
end
% Plot legend for the last figure
plot_input_legend(outer_layout, list_inputs, all_list_inputs, colors);
% Label the x-axis of the last figure
xlabel(layout, "Seconds", 'FontSize', Axis_FontSize, ...
    'Fontweight', Axis_Fontweight)
end

function plot_input_legend(outer_layout, list_inputs, ...
    all_list_inputs, colors)
    % Set font settings for the legend
    f_set_font_settings()
    % Create an invisible axis for the legend
    ax = axes(outer_layout, 'Visible', 'off');
    % Initialize an array to store valid legend items
    legend_items = []; % Initialize as empty array to store valid handles
    % Iterate over each input to create legend entries
    hold(ax, 'on');
    for n = 1:size(list_inputs, 2)
        % Find the index of the current input in the list of all inputs
        input_Index = find(strcmp([all_list_inputs(2, :)], ...
            list_inputs{2, n}));
        % Create a scatter plot for the legend entry and store it in the
        % array if it is valid
        scatter_handle = scatter(ax, NaN, NaN, 2, "o", "filled", ...
            "MarkerFaceAlpha", 1, "MarkerEdgeAlpha", 1, "DisplayName", ...
            list_inputs{2, n}, 'MarkerFaceColor', colors(input_Index, :));
        if isvalid(scatter_handle)
            % Add valid handle to the array
            legend_items = [legend_items scatter_handle]; 
        end
    end
    hold(ax, 'off');
    % Create the legend using the generated legend items
    Lgnd = legend(legend_items, 'Orientation', 'horizontal', 'FontSize', ...
        Legend_FontSize, 'Fontweight', Legend_Fontweight, 'Location', ...
        'layout', 'Box', 'off');
    % Set the layout and item token size for the legend
    Lgnd.Layout.Tile = 'South';
    Lgnd.ItemTokenSize = Legend_ItemTokenSize;
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

% Count number of outputs (including normalized outputs if applicable)
n_outputs_exp_plus_norm = zeros(1, 1);
for exp_idx = stg.exprun
    for out_idx = 1:size(sbtab.datasets(exp_idx).output, 2)
        n_outputs_exp_plus_norm = ...
            n_outputs_exp_plus_norm + 1;
        % Add one more if normalization is applied
        if ~isempty(sbtab.datasets(exp_idx).Normalize)
            n_outputs_exp_plus_norm = ...
                n_outputs_exp_plus_norm + 1;
        end
    end
end

% Counter for the number of plots created
plot_n = 0; 
% Counter for the number of figures created
fig_n = 0; 
% Initialize layout as empty
layout = []; 
% Initialize plots cell array
plots = cell(1,2); 
% Generate colors for plotting
colors = generateRainbowGradient(length(stg.pat)); 
max_number_subplots_output = 12;


% Set font settings using the provided font_settings
f_set_font_settings()

% Loop through each experiment
for exp_idx = stg.exprun

    % Loop through each dataset in the current experiment
    for out_idx = 1:size(sbtab.datasets(exp_idx).output, 2)
        % Determine whether to perform normalization based on dataset
        if ~isempty(sbtab.datasets(exp_idx).Normalize)
            do_norm = contains(sbtab.datasets(exp_idx).Normalize,sbtab.datasets(exp_idx).output_ID{out_idx}) + 1;
        else
            do_norm = 1;
        end

        for k = 1:do_norm

            % Generate a new figure after every 12 plots or if layout is
            % empty
            if mod(plot_n, max_number_subplots_output) == 0 || ...
                    isempty(layout)
                % Create new subplot layout
                [fig_n, layout, plots(fig_n,:), outer_layout] =...
                    f_get_subplot(n_outputs_exp_plus_norm, plot_n, fig_n, ...
                    "Outputs", layout);
                % Set the figure name
                fig_name = strrep(stg.plot_name, "_", "\_") + " Outputs";
                if fig_n > 1
                    fig_name = fig_name + " " + num2str(fig_n);
                end
                % Add title to the layout
                title(layout,fig_name, 'FontSize', Major_title_FontSize,...
                    'Fontweight', Major_title_Fontweight)
            end

            % Create a new tile in the current figure
            nexttile(layout);
            % Increment plot counter
            plot_n = plot_n + 1;
            % Flag to include experiment number in the title
            include_exp_n = 1;

            hold on

            if k == 1
                % Plot the simulation outputs for the first normalization
                % state
                [output_min,output_max] =...
                    plot_sim_outputs(stg, rst, sbtab, mmf, exp_idx, ...
                    out_idx, ~k, include_exp_n, colors,0);
                ylim([output_min output_max])
                % If no normalization, also plot the experimental data with
                % SD
                if do_norm == 1
                    [min_data,max_data] = ...
                        plot_data_and_data_SD(stg, rst, Data, exp_idx, ...
                        out_idx);
                    ylim([min(output_min, min_data) ...
                        max(output_max, max_data)])
                end
                
            else
                % Plot the experimental data and simulation outputs for
                % normalized data
                [min_data,max_data] = ...
                    plot_data_and_data_SD(stg, rst, Data, exp_idx, out_idx);
                [output_min,output_max] = ...
                    plot_sim_outputs(stg, rst, sbtab, mmf, exp_idx, ...
                    out_idx, k, include_exp_n, colors,0);
                ylim([min( output_min, min_data) ...
                    max( output_max, max_data)])
            end
            hold off

            % Add a legend to the plot after every 12 plots or at the end
            if mod(plot_n,max_number_subplots_output) == 0 || ...
                plot_n == n_outputs_exp_plus_norm
                % Create an invisible axis for the legend
                ax = axes(outer_layout, 'Visible', 'off');
                hold(ax, 'on');
                % Create legend entries for data and data SD
                plot_data_lgd = scatter(ax, NaN, NaN, 2, 'k', "o", "filled", ...
                    "MarkerFaceAlpha", 1, "MarkerEdgeAlpha", 1, ...
                    "DisplayName", "data");
                plot_data_SD_lgd = ...
                    patch(ax, NaN, NaN, zeros(1,1), 'DisplayName', ...
                    "Data\_SD", 'EdgeColor', 'none', 'FaceColor', [0 0 0], ...
                    'FaceAlpha', 0.25, 'HandleVisibility', 'off');

                % Create legend entries for valid outputs
                valid_outputs_plots_lgd = ...
                    arrayfun(@(i) scatter(ax, NaN, NaN, 2, colors(i, :), ...
                    "o", "filled", "MarkerFaceAlpha", 1, ...
                    "MarkerEdgeAlpha", 1, "DisplayName", ...
                    "\theta_{" + stg.pat(i) + "}"), 1:length(stg.pat));
                hold(ax, 'off');

                % Create and configure the legend
                Lgnd = ...
                legend([plot_data_lgd, plot_data_SD_lgd, ...
                valid_outputs_plots_lgd(1,:)], 'Orientation', 'horizontal', ...
                    'FontSize', Legend_FontSize, 'Fontweight', ...
                    Legend_Fontweight, 'Location', 'layout', 'Box', 'off');
                Lgnd.Layout.Tile = 'South';
                Lgnd.ItemTokenSize = Legend_ItemTokenSize;

                % Label x-axis
                xlabel(layout,"Seconds", 'FontSize', Axis_FontSize, ...
                    'Fontweight', Axis_Fontweight)
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
plots = cell(1, 2);
include_exp_n = 0; % Flag to include experiment number

if isfield(stg, 'exp_train')
exp = stg.exp_train;
else
exp = stg.exprun;
end

% Count number of outputs (including normalized outputs if applicable)
n_outputs_exp_plus_norm = zeros(exp(end), 1);
for exp_idx = exp
    for out_idx = 1:size(sbtab.datasets(exp_idx).output, 2)
        n_outputs_exp_plus_norm(exp_idx) = ...
            n_outputs_exp_plus_norm(exp_idx) + 1;
        % Add one more if normalization is applied
        if ~isempty(sbtab.datasets(exp_idx).Normalize)
            n_outputs_exp_plus_norm(exp_idx) = ...
                n_outputs_exp_plus_norm(exp_idx) + 1;
        end
    end
end

% Get a list of all inputs across experiments
all_list_inputs = cell(2, 0);
for exp_idx = 1:length(exp)
    all_list_inputs = ...
        f_list_inputs(sbtab, all_list_inputs, exp(exp_idx));
end

% Determine the number of unique inputs across all experiments
different_input_number = size(all_list_inputs, 2);
% Generate colors for all inputs and parameters
colors = generateRainbowGradient(length(stg.pat) + different_input_number);

% Set the maximum number of subplots allowed per figure
max_right_subplots = 6;
row_length = [1, 1, 2, 2, 3, 3];
column_length = [1, 2, 2, 2, 2, 2];
outer_layout_rows = 1;
outer_layout_cols = 3;
innerLayout_output_TileSpan = [1 2];

% Loop through each experiment to create figures for input and output data
for exp_idx = exp
   
    sub_fig_number = 0; % Track subplot numbers within the same figure
    % Initialize counter for figure management within the same experiment
    fig_number_same_exp = 1; 
    

long_name = "Experiment " + (exp_idx - 1);
short_name = "E" + (exp_idx - 1);

    % Create a new figure for each experiment
    [plots, innerLayout_input, innerLayout_output, ax, fig_number] = ...
        create_new_figure(stg, fig_number_same_exp, ...
        sub_fig_number, max_right_subplots, exp_idx, fig_number, ...
        n_outputs_exp_plus_norm, row_length, column_length, plots, ...
        outer_layout_rows, outer_layout_cols, innerLayout_output_TileSpan, ...
        long_name,  short_name);

    % Loop through each output dataset in the current experiment
    for out_idx = 1:size(sbtab.datasets(exp_idx).output,2)
        sub_fig_number = sub_fig_number + 1;
        
        % Create a new figure if the number of subplots exceeds the maximum
        % per figure
        if sub_fig_number / max_right_subplots > fig_number_same_exp
            % Plot the input data in the current figure before creating a
            % new one
            nexttile(innerLayout_input, 1, [1 1]);
            f_plot_in_out_inputs(rst, stg, sbtab, exp_idx, ...
                all_list_inputs, colors);
            plot_in_out_legend(ax, sbtab, rst, stg, exp_idx, ...
                all_list_inputs, colors, different_input_number);

            % Label the x-axis for both input and output layouts
            xlabel(innerLayout_output, 'Seconds', 'FontSize', ...
                Axis_FontSize, 'Fontweight', Axis_Fontweight);
            xlabel(innerLayout_input, 'Seconds', 'FontSize', ...
                Axis_FontSize, 'Fontweight', Axis_Fontweight);

            % Increment the figure counter for the same experiment
            fig_number_same_exp = fig_number_same_exp + 1;

            % Create a new figure for the remaining plots in the current
            % experiment
            [plots, innerLayout_input, innerLayout_output, ax, fig_number] = ...
                create_new_figure(stg, fig_number_same_exp, ...
                sub_fig_number, max_right_subplots, exp_idx, fig_number, ...
                n_outputs_exp_plus_norm, row_length, column_length, plots, ...
        outer_layout_rows, outer_layout_cols, innerLayout_output_TileSpan, ...
        long_name,  short_name);
        end

        % Plot the simulation output data
        nexttile(innerLayout_output);

        hold on
        % Plot unnormalized simulation results
        [output_min, output_max] = plot_sim_outputs(stg, rst, sbtab, mmf, ...
            exp_idx, out_idx, 0, include_exp_n, ...
            colors(different_input_number + 1:end, :),0);
        ylim([output_min output_max]);

        % If normalization is not applied, plot the experimental data with
        % standard deviation
        if isempty(sbtab.datasets(exp_idx).Normalize)
            [min_data, max_data] = plot_data_and_data_SD(stg, rst, Data, ...
                exp_idx, out_idx);
            ylim([min(output_min, min_data) max(output_max, max_data)]);
        end
        hold off

       % Plot normalized outputs if applicable
        if ~isempty(sbtab.datasets(exp_idx).Normalize)
            if contains(sbtab.datasets(exp_idx).Normalize,sbtab.datasets(exp_idx).output_ID{out_idx})
                sub_fig_number = sub_fig_number + 1;
                if sub_fig_number / max_right_subplots > fig_number_same_exp
                    % Plot the input data in the current figure before creating a
                    % new one
                    nexttile(innerLayout_input, 1, [1 1]);
                    f_plot_in_out_inputs(rst, stg, sbtab, exp_idx, ...
                        all_list_inputs, colors);
                    plot_in_out_legend(ax, sbtab, rst, stg, exp_idx, ...
                        all_list_inputs, colors, different_input_number);

                    % Label the x-axis for both input and output layouts
                    xlabel(innerLayout_output, 'Seconds', 'FontSize', ...
                        Axis_FontSize, 'Fontweight', Axis_Fontweight);
                    xlabel(innerLayout_input, 'Seconds', 'FontSize', ...
                        Axis_FontSize, 'Fontweight', Axis_Fontweight);

                    % Increment the figure counter for the same experiment
                    fig_number_same_exp = fig_number_same_exp + 1;

                    % Create a new figure for the remaining plots in the current
                    % experiment
                    [plots, innerLayout_input, innerLayout_output, ax, fig_number] = ...
                        create_new_figure(stg, fig_number_same_exp, ...
                        sub_fig_number, max_right_subplots, exp_idx, fig_number, ...
                        n_outputs_exp_plus_norm, row_length, column_length, plots, ...
                        outer_layout_rows, outer_layout_cols, innerLayout_output_TileSpan, ...
        long_name,  short_name);
                end

                nexttile(innerLayout_output);
                hold on

                % Plot experimental data with standard deviation
                [min_data, max_data] = plot_data_and_data_SD(stg, rst, Data, ...
                    exp_idx, out_idx);

                % Plot normalized simulation outputs
                [output_min, output_max] = plot_sim_outputs(stg, rst, sbtab, ...
                    mmf, exp_idx, out_idx, 1, include_exp_n, ...
                    colors(different_input_number + 1:end, :),0);
                ylim([min(output_min, min_data) max(output_max, max_data)]);
                hold off
            end
        end
    end

    % Plot the input data on the left side of the figure
    nexttile(innerLayout_input, 1, [1 1]);
    f_plot_in_out_inputs(rst, stg, sbtab, exp_idx, all_list_inputs, colors);
    plot_in_out_legend(ax, sbtab, rst, stg, exp_idx, all_list_inputs, ...
        colors, different_input_number);

    % Label the x-axis for both input and output layouts
    xlabel(innerLayout_output, 'Seconds', 'FontSize', Axis_FontSize, ...
        'Fontweight', Axis_Fontweight);
    xlabel(innerLayout_input, 'Seconds', 'FontSize', Axis_FontSize, ...
        'Fontweight', Axis_Fontweight);

end
end

function plots = f_plot_in_out_predict(rst,stg,sbtab,Data,mmf)
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
plots = cell(1, 2);
include_exp_n = 0; % Flag to include experiment number

% Count number of outputs (including normalized outputs if applicable)
n_outputs_exp_plus_norm = zeros(stg.exp_predict(end), 1);
for exp_idx = stg.exp_predict
    for out_idx = 1:size(sbtab.datasets(exp_idx).output, 2)
        n_outputs_exp_plus_norm(exp_idx) = ...
            n_outputs_exp_plus_norm(exp_idx) + 1;
        % Add one more if normalization is applied
        if ~isempty(sbtab.datasets(exp_idx).Normalize)
            if contains(sbtab.datasets(exp_idx).Normalize,sbtab.datasets(exp_idx).output_ID{out_idx})
                n_outputs_exp_plus_norm(exp_idx) = ...
                    n_outputs_exp_plus_norm(exp_idx) + 1;
            end
        end
    end
end

% Get a list of all inputs across experiments
all_list_inputs = cell(2, 0);
for exp_idx = 1:length(stg.exp_predict)
    all_list_inputs = ...
        f_list_inputs(sbtab, all_list_inputs, stg.exp_predict(exp_idx));
end

% Determine the number of unique inputs across all experiments
different_input_number = size(all_list_inputs, 2);
% Generate colors for all inputs and parameters
colors = generateRainbowGradient(2 + different_input_number);

% Set the maximum number of subplots allowed per figure
max_right_subplots = 16;
row_length = [1, 1, 2, 2, 3, 3, 4, 4, 3, 4, 4, 4, 4, 4, 4, 4];
column_length = [1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4];
outer_layout_rows = 5;
outer_layout_cols = 1;
innerLayout_output_TileSpan = [4 1];

name_idx = 0;
% Loop through each experiment to create figures for input and output data
for exp_idx = stg.exp_predict(1:2:end)
name_idx = name_idx + 1;
    sub_fig_number = 0; % Track subplot numbers within the same figure
    % Initialize counter for figure management within the same experiment
    fig_number_same_exp = 1;

    long_name_array = ["Basal Acetylcholine ", "Acetylcholine Peak", ...
        "Acetylcholine Dip", "Basal Acetylcholine and Glutamate Peak", ...
        "Acetylcholine Peak and Glutamate Peak", ...
        "Acetylcholine Dip and Glutamate Peak"];
    short_name_array = ["basal ACh", "ACh+", "ACh-", ...
        "basal ACh Glu+", "ACh+ Glu+", "ACh- Glu+"];

    long_name = long_name_array(name_idx);
    short_name = short_name_array(name_idx);

    % Create a new figure for each experiment
    [plots, innerLayout_input, innerLayout_output, ax, fig_number] = ...
        create_new_figure(stg, fig_number_same_exp, ...
        sub_fig_number, max_right_subplots, exp_idx, fig_number, ...
        n_outputs_exp_plus_norm, row_length, column_length, plots, ...
        outer_layout_rows, outer_layout_cols, innerLayout_output_TileSpan, ...
        long_name,  short_name);

    % Loop through each output dataset in the current experiment
    for out_idx = 1:size(sbtab.datasets(exp_idx).output,2)
        sub_fig_number = sub_fig_number + 1;
        
        % Create a new figure if the number of subplots exceeds the maximum
        % per figure
        if sub_fig_number / max_right_subplots > fig_number_same_exp
            % Plot the input data in the current figure before creating a
            % new one
            nexttile(innerLayout_input, 1, [1 1]);
            f_plot_in_out_inputs(rst, stg, sbtab, exp_idx, ...
                all_list_inputs, colors);
            plot_in_out_predict_legend(ax, sbtab, rst, stg, exp_idx, ...
                all_list_inputs, colors, different_input_number);

            % Label the x-axis for both input and output layouts
            xlabel(innerLayout_output, 'Seconds', 'FontSize', ...
                Axis_FontSize, 'Fontweight', Axis_Fontweight);
            xlabel(innerLayout_input, 'Seconds', 'FontSize', ...
                Axis_FontSize, 'Fontweight', Axis_Fontweight);

            % Increment the figure counter for the same experiment
            fig_number_same_exp = fig_number_same_exp + 1;

            % Create a new figure for the remaining plots in the current
            % experiment
            [plots, innerLayout_input, innerLayout_output, ax, fig_number] = ...
                create_new_figure(stg, fig_number_same_exp, ...
                sub_fig_number, max_right_subplots, exp_idx, fig_number, ...
                n_outputs_exp_plus_norm, row_length, column_length, plots, ...
        outer_layout_rows, outer_layout_cols, innerLayout_output_TileSpan, ...
        long_name,  short_name);
        end

        % Plot the simulation output data
        nexttile(innerLayout_output);

        hold on
        % Plot unnormalized simulation results
        [output_min, output_max] = plot_sim_outputs(stg, rst, sbtab, mmf, ...
            exp_idx, out_idx, 0, include_exp_n, ...
            colors(different_input_number + 1, :),1);
        [output_min_2, output_max_2] = plot_sim_outputs(stg, rst, sbtab, mmf, ...
            exp_idx+1, out_idx, 0, include_exp_n, ...
            colors(different_input_number + 2, :),1);
        ylim([min(output_min,output_min_2) max(output_max,output_max_2)]);
        hold off

       
        % Plot normalized outputs if applicable
        if ~isempty(sbtab.datasets(exp_idx).Normalize)
            if contains(sbtab.datasets(exp_idx).Normalize,sbtab.datasets(exp_idx).output_ID{out_idx})
                sub_fig_number = sub_fig_number + 1;
                if sub_fig_number / max_right_subplots > fig_number_same_exp
                    % Plot the input data in the current figure before creating a
                    % new one
                    nexttile(innerLayout_input, 1, [1 1]);
                    f_plot_in_out_inputs(rst, stg, sbtab, exp_idx, ...
                        all_list_inputs, colors);
                    plot_in_out_predict_legend(ax, sbtab, rst, stg, exp_idx, ...
                        all_list_inputs, colors, different_input_number);

                    % Label the x-axis for both input and output layouts
                    xlabel(innerLayout_output, 'Seconds', 'FontSize', ...
                        Axis_FontSize, 'Fontweight', Axis_Fontweight);
                    xlabel(innerLayout_input, 'Seconds', 'FontSize', ...
                        Axis_FontSize, 'Fontweight', Axis_Fontweight);

                    % Increment the figure counter for the same experiment
                    fig_number_same_exp = fig_number_same_exp + 1;

                    % Create a new figure for the remaining plots in the current
                    % experiment
                    [plots, innerLayout_input, innerLayout_output, ax, fig_number] = ...
                        create_new_figure(stg, fig_number_same_exp, ...
                        sub_fig_number, max_right_subplots, exp_idx, fig_number, ...
                        n_outputs_exp_plus_norm, row_length, column_length, plots, ...
                        outer_layout_rows, outer_layout_cols, innerLayout_output_TileSpan,  ...
        long_name,  short_name);
                end
                nexttile(innerLayout_output);
                hold on

                % Plot normalized simulation outputs
                [output_min, output_max] = plot_sim_outputs(stg, rst, sbtab, ...
                    mmf, exp_idx, out_idx, 1, include_exp_n, ...
                    colors(different_input_number + 1, :),1);
                [output_min_2, output_max_2] = plot_sim_outputs(stg, rst, sbtab, mmf, ...
                    exp_idx+1, out_idx, 1, include_exp_n, ...
                    colors(different_input_number + 2, :),1);
                ylim([min(output_min,output_min_2) max(output_max,output_max_2)]);
                hold off
            end
        end
    end

    % Plot the input data on the left side of the figure
    nexttile(innerLayout_input, 1, [1 1]);
    f_plot_in_out_inputs(rst, stg, sbtab, exp_idx, all_list_inputs, colors);
    plot_in_out_predict_legend(ax, sbtab, rst, stg, exp_idx, all_list_inputs, ...
        colors, different_input_number);

    % Label the x-axis for both input and output layouts
    xlabel(innerLayout_output, 'Seconds', 'FontSize', Axis_FontSize, ...
        'Fontweight', Axis_Fontweight);
    xlabel(innerLayout_input, 'Seconds', 'FontSize', Axis_FontSize, ...
        'Fontweight', Axis_Fontweight);
end
end

function [plots, innerLayout_input, innerLayout_output, ax, fig_number] = ...
    create_new_figure(stg, fig_number_same_exp, sub_fig_number, ...
    max_right_subplots, exp_idx, fig_number, n_outputs_exp_plus_norm, ...
    row_length, column_length, plots, ...
        outer_layout_rows, outer_layout_cols, innerLayout_output_TileSpan, ...
        long_name,  short_name)
% Helper function to create a new figure or reuse an existing one Set the
% font settings for consistent appearance across all plots.
f_set_font_settings();

% Increment figure counter for each new figure created
fig_number = fig_number + 1;

% Determine if a new figure should be created or reused based on the number
% of subplots
if fig_number_same_exp == 1
    reuse = n_outputs_exp_plus_norm(exp_idx) > max_right_subplots;
else
    reuse = mod(sub_fig_number, max_right_subplots) == 1;
end

if reuse
    % Append sequence number to the figure name if reusing.
    name_short = short_name + " " + fig_number_same_exp;
    name_long = ...
        strrep(stg.plot_name, "_", "\_") + "  " + long_name ...
        + " " + fig_number_same_exp + "  (" + short_name + " " + ...
    fig_number_same_exp + ")";
else
    % Use a simpler name if not reusing.
    name_short = short_name;
    name_long = ...
        strrep(stg.plot_name, "_", "\_") + "  " + long_name + "  (" + ...
        short_name + ")";
end

% Refresh or create a plot with the new naming convention. This function
% ensures that the figure with the specified name is either refreshed or
% newly created.
plots(fig_number, :) = f_renew_plot(name_short);

% Set up the layout of the plot, preparing for input and output data
% display. The layout is configured to have 1 row and 3 columns with tight
% padding and spacing for better visualization.
outerLayout = ...
    tiledlayout(outer_layout_rows, outer_layout_cols, 'Padding', "tight", 'TileSpacing', 'tight');


% Assign a title to the overall layout, enhancing readability and providing
% context for the plot.
title(outerLayout, name_long, 'FontSize', Major_title_FontSize, ...
    'Fontweight', Major_title_Fontweight);

% Create an invisible axis for adding legends, which is essential for plots
% readability
ax = axes(outerLayout, 'Visible', 'off');

% Create layout for input subplots (single subplot for inputs) The
% innerLayout_input will hold a single input-related plot, with tight
% padding and spacing
innerLayout_input = ...
    tiledlayout(outerLayout, 1, 1, 'Padding', 'tight', ...
    'TileSpacing', 'tight');

% Calculate row and column indices for output subplots Determine the number
% of remaining outputs for current figure
remaining_outputs = ...
    n_outputs_exp_plus_norm(exp_idx) - max_right_subplots * ...
(fig_number_same_exp - 1);
% Use the minimum value between max_right_subplots and the number of
% remaining outputs
row_column_idx = min(max_right_subplots, remaining_outputs);

% Create layout for output subplots (multiple subplots) This layout is
% determined based on the calculated row and column indices to fit the
% outputs
innerLayout_output = ...
    tiledlayout(outerLayout, row_length(row_column_idx), ...
    column_length(row_column_idx), 'Padding', 'tight', ...
    'TileSpacing', 'tight');
% Position the output layout in the second tile of the figure
innerLayout_output.Layout.Tile = 2; 
% Span the output layout across two tiles for better visibility and
% organization
innerLayout_output.Layout.TileSpan = innerLayout_output_TileSpan; 

end

function plot_in_out_legend(ax, sbtab, rst, stg, exp_idx, ...
    all_list_inputs, colors, different_input_number)
% Function to create a legend for input and output plots. This function
% adds legend entries for input species, experimental data, and model
% outputs.

% Set font settings for the legend to ensure consistency in appearance
f_set_font_settings();

% Hold the axis to add multiple plot elements for the legend
hold(ax, 'on');

% Iterate over each input species to create legend entries
for ipt_idx = 1:size(sbtab.datasets(exp_idx).input, 2)
    % Extract input species ID from the current experiment and convert it
    % to a numerical value The ID is extracted by removing the 'S'
    % character and converting the remainder to a number. Adding 1 to match
    % MATLAB's 1-based indexing.
    input_species_ID = ...
        str2double(strrep(sbtab.datasets(exp_idx).input(ipt_idx), ...
        'S', '')) + 1;
    
    % Get the input species name from the species table using the extracted
    % ID
    input_species_name = ...
        convertCharsToStrings(sbtab.species{input_species_ID, 1});
    
    % Find the index of the input species in the list of all inputs to
    % match the color This ensures that the correct color is used for the
    % legend entry.
    input_Index = contains([all_list_inputs(2, :)], input_species_name);
    
    % Create a scatter plot handle for the input species to be used in the
    % legend The plot is invisible (NaN coordinates), but it serves the
    % purpose of creating a legend entry
    input_plot_lgd(ipt_idx) = scatter(ax, NaN, NaN, 2, "o", "filled", ...
        "MarkerFaceAlpha", 1, "MarkerEdgeAlpha", 1, "DisplayName", ...
        rst(stg.pat(1)).simd{1, exp_idx}.DataNames{input_species_ID}, ...
        'MarkerFaceColor', colors(input_Index, :));
end

% Create scatter plot handle for the experimental data to be used in the
% legend This handle is also invisible and serves to add an entry for
% experimental data
plot_data_lgd = scatter(ax, NaN, NaN, 2, 'k', "o", "filled", ...
    "MarkerFaceAlpha", 1, "MarkerEdgeAlpha", 1, "DisplayName", "data");

% Create a patch handle for data standard deviation (SD) to be used in the
% legend The patch is invisible and is used to represent the data SD in the
% legend The patch settings include no edge color and a semi-transparent
% face color to indicate variability.
plot_data_SD_lgd = ...
    patch(ax, NaN, NaN, zeros(1, 1), "DisplayName", "Data_{SD}", ...
    'EdgeColor', 'none', 'FaceColor', [0 0 0], 'FaceAlpha', 0.25, ...
    'HandleVisibility', 'off');

% Iterate over each parameter set to create legend entries for the outputs
current_plot = 0;
for pa_idx = stg.pat
    current_plot = current_plot + 1;
    % Create a scatter plot handle for each output to be used in the legend
    % The plot is invisible (NaN coordinates), but it is used to create a
    % legend entry for each parameter set
    valid_outputs_plots_lgd(1, current_plot) = scatter(ax, NaN, NaN, 2, ...
        colors(current_plot + different_input_number, :), "o", "filled", ...
        "MarkerFaceAlpha", 1, "MarkerEdgeAlpha", 1, "DisplayName", ...
        "\theta_{" + string(pa_idx) + "}");
end

% Release the hold on the axis after adding all plot elements
hold(ax, 'off');

% Combine all plot handles to create the legend
plots_leg = ...
    [input_plot_lgd, plot_data_lgd, plot_data_SD_lgd, ...
    valid_outputs_plots_lgd];


% Create the legend with the specified properties Set properties like font
% size, weight, and orientation to maintain a consistent appearance
lgd = ...
    legend(plots_leg, 'FontSize', Legend_FontSize, ...
    'Fontweight', Legend_Fontweight, "Orientation", "horizontal");
    

% Position the legend at the bottom of the layout to keep the figure
% uncluttered
lgd.Layout.Tile = 'south';

% Set the size of the legend tokens for better readability
lgd.ItemTokenSize = Legend_ItemTokenSize;

% Remove the box around the legend to improve aesthetics
set(lgd, 'Box', 'off');
end

function plot_in_out_predict_legend(ax, sbtab, rst, stg, exp_idx, ...
    all_list_inputs, colors, different_input_number)
% Function to create a legend for input and output plots. This function
% adds legend entries for input species, experimental data, and model
% outputs.

% Set font settings for the legend to ensure consistency in appearance
f_set_font_settings();

% Hold the axis to add multiple plot elements for the legend
hold(ax, 'on');

% Iterate over each input species to create legend entries
for ipt_idx = 1:size(sbtab.datasets(exp_idx).input, 2)
    % Extract input species ID from the current experiment and convert it
    % to a numerical value The ID is extracted by removing the 'S'
    % character and converting the remainder to a number. Adding 1 to match
    % MATLAB's 1-based indexing.
    input_species_ID = ...
        str2double(strrep(sbtab.datasets(exp_idx).input(ipt_idx), ...
        'S', '')) + 1;
    
    % Get the input species name from the species table using the extracted
    % ID
    input_species_name = ...
        convertCharsToStrings(sbtab.species{input_species_ID, 1});
    
    % Find the index of the input species in the list of all inputs to
    % match the color This ensures that the correct color is used for the
    % legend entry.
    input_Index = contains([all_list_inputs(2, :)], input_species_name);
    
    % Create a scatter plot handle for the input species to be used in the
    % legend The plot is invisible (NaN coordinates), but it serves the
    % purpose of creating a legend entry
    input_plot_lgd(ipt_idx) = scatter(ax, NaN, NaN, 2, "o", "filled", ...
        "MarkerFaceAlpha", 1, "MarkerEdgeAlpha", 1, "DisplayName", ...
        rst(stg.pat(1)).simd{1, exp_idx}.DataNames{input_species_ID}, ...
        'MarkerFaceColor', colors(input_Index, :));
end

% Iterate over each parameter set to create legend entries for the outputs
current_plot = 0;
name = ["cell","spine"];
for pa_idx = 1:2
    current_plot = current_plot + 1;
    % Create a scatter plot handle for each output to be used in the legend
    % The plot is invisible (NaN coordinates), but it is used to create a
    % legend entry for each parameter set
    valid_outputs_plots_lgd(1, current_plot) = scatter(ax, NaN, NaN, 2, ...
        colors(current_plot + different_input_number, :), "o", "filled", ...
        "MarkerFaceAlpha", 1, "MarkerEdgeAlpha", 1, "DisplayName", ...
        name(pa_idx));
end

% Release the hold on the axis after adding all plot elements
hold(ax, 'off');

% Combine all plot handles to create the legend
plots_leg = ...
    [input_plot_lgd, valid_outputs_plots_lgd];


% Create the legend with the specified properties Set properties like font
% size, weight, and orientation to maintain a consistent appearance
lgd = ...
    legend(plots_leg, 'FontSize', Legend_FontSize, ...
    'Fontweight', Legend_Fontweight, "Orientation", "horizontal");
    

% Position the legend at the bottom of the layout to keep the figure
% uncluttered
lgd.Layout.Tile = 'south';

% Set the size of the legend tokens for better readability
lgd.ItemTokenSize = Legend_ItemTokenSize;

% Remove the box around the legend to improve aesthetics
set(lgd, 'Box', 'off');
end

function [input_plot] = ...
    f_plot_in_out_inputs(rst,stg,sbtab,exp_idx,all_list_imputs,colors)
% Set the font settings for consistent appearance across all plots.
f_set_font_settings()

% Begin plotting the input data for the specified experiment.
hold on % Keep the plot active to overlay multiple inputs if necessary.

[input_plot] = f_plot_input(stg,rst,sbtab,exp_idx,all_list_imputs,colors);

% Finish plotting to ensure all input data is displayed properly.
hold off

% Assign a title to differentiate between single or multiple inputs
% visually.
if size(sbtab.datasets(exp_idx).input,2) == 1
    title("Input",'FontSize', Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight);
else
    title("Inputs",'FontSize', Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight);
end
end

function [input_plot] = ...
    f_plot_input(stg, rst, sbtab, exp_idx, all_list_imputs, colors)
% Function to plot the input data for a specific experiment. This function
% generates scatter plots of input data points for visualization.
%
% Inputs:
% - stg: Structure containing experiment settings (e.g., run parameters).
% - rst: Structure containing the results of the simulations.
% - sbtab: Structure containing datasets and their associated information.
% - exp_idx: Index of the current experiment being plotted.
% - all_list_imputs: Cell array containing all input species across 
% experiments.
% - colors: Array containing colors to use for each input.
%
% Output:
% - input_plot: Handles to the scatter plot objects created.

% Set font settings for consistent appearance across all plots.
f_set_font_settings();

% Flag to decide whether to apply log10 transformation to the data.
log_10 = 0;

% Preallocate input_plot array for efficiency, especially for large
% datasets.
num_inputs = size(sbtab.datasets(exp_idx).input, 2);
% Preallocate with NaN to handle conditional plotting cases.
input_plot = NaN(1, num_inputs); 

% Begin plotting the input data for the specified experiment.
hold on; % Keep the plot active to overlay multiple inputs if necessary.

% Iterate through each input species for the current experiment.
for ipt_idx = 1:num_inputs
    % Iterate through each set of parameters to process simulation results.
    for pa_idx = stg.pat
        % Check if the simulation was successful for the current parameter
        % set and experiment.
        if rst(pa_idx).simd{1, exp_idx} ~= 0
            % Extract the input species ID from the current experiment and
            % convert it to a numerical value. The ID is extracted by
            % removing the 'S' character and converting the remainder to a
            % number.
            input_species_str = ...
                strrep(sbtab.datasets(exp_idx).input(ipt_idx), 'S', '');
            if isempty(regexp(input_species_str, '^\d+$', 'once'))
                warning(['Invalid input species ID format for ' ...
                    'experiment %d, input %d: %s'], ...
                    exp_idx, ipt_idx, ...
                    sbtab.datasets(exp_idx).input(ipt_idx));
                continue; % Skip this input if the format is invalid.
            end
            input_species_ID = str2double(input_species_str) + 1;
            
            % Error handling for invalid input species ID conversion.
            if isnan(input_species_ID)
                warning(['Invalid input species ID for experiment %d,' ...
                    ' input %d: %s'], exp_idx, ipt_idx, ...
                    sbtab.datasets(exp_idx).input(ipt_idx));
                continue; % Skip this input if the conversion fails.
            end
            
            % Get the name of the input species from the species table
            % using the extracted ID.
            input_species_name = ...
                convertCharsToStrings(sbtab.species{input_species_ID, 1});
            
            % Find the index of the current input species in the list of
            % all inputs. This ensures that the correct color is used for
            % the legend entry.
            input_Index = ...
                contains([all_list_imputs(2, :)], input_species_name);
            
            result = rst(pa_idx).simd{1, exp_idx};

            % Extract the input data for the current experiment.
            if log_10 == 0
                % Use raw data if log transformation is not applied.
                input_y = result.Data(1:end, input_species_ID);
                label_y = ...
                    string(result.DataInfo{ input_species_ID, 1}.Units);
            else
                % Apply log10 transformation if specified.
                input_y = log10(result.Data(1:end, input_species_ID));
                label_y = "Log10 " + ...
                string(result.DataInfo{ input_species_ID, 1}.Units);
            end
            
            % Create a scatter plot for the input species data points. Only
            % a subset of data points is plotted based on the
            % 'in_plot_trim' setting to reduce clutter.
            input_plot(ipt_idx) = ...
                scatter(result.Time(1:stg.in_plot_trim:end), ...
                input_y(1:stg.in_plot_trim:end), 2, "o", "filled", ...
                "MarkerFaceAlpha", 1, "MarkerEdgeAlpha", 1, "DisplayName", ...
                result.DataNames{input_species_ID}, ...
                'MarkerFaceColor', colors(input_Index, :));

            % Label the y-axis with the correct unit and apply pre-defined
            % font settings.
            ylabel(label_y, 'FontSize', Axis_FontSize, ...
                'Fontweight', Axis_Fontweight);

            adjust_y_ticks()

            % Set y-axis limit to start from zero and extend to positive
            % infinity.
            ylim([0 inf]);

            % Break after plotting the first available set to avoid
            % clutter.
            break;
        end
    end
end

% Release the hold on the axis after all input data has been plotted.
hold off;
end

function adjust_y_ticks()
% Get the current y-axis tick values to format precision if needed.
yticks = get(gca, 'YTick');

% Convert the tick values to strings with high precision.
tickStrings = ...
    arrayfun(@(v) convertStringsToChars(string(v)), yticks, ...
    'UniformOutput', false);

% Check the number of decimal places for each tick value.
for n = 1:length(tickStrings)
    % Use regular expressions to find the number of decimal places.
    countDecimals{n} = regexp(tickStrings{n}, '(?<=\.)\d+');
    matches{n} = regexp(tickStrings{n}, '(?<=\.)\d+', 'match');
    if ~isempty(matches{n})
        countDecimals{n} = length(matches{n});
    else
        countDecimals{n} = 0;
    end
end
% If there are too many decimal places, limit the precision to two decimal
% places.
if max([countDecimals{:}]) > 2
    % Limit y-axis tick labels to two decimal places for better
    % readability.
    ytickformat('%.2f'); 
end
end


function [output_min,output_max] = ...
    plot_sim_outputs(stg, rst, sbtab, mmf, exp_idx, out_idx, is_norm, ...
    include_exp_n, colors, is_double)
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

% Apply font settings for the plot, ensuring consistency across all plots.
f_set_font_settings()

% Preallocate output_max_idx and output_min_idx for better performance.
output_max_idx = -inf(1, length(stg.pat));
output_min_idx = inf(1, length(stg.pat));

% Calculate the number of outputs for the current experiment.
n_outputs_exp = size(sbtab.datasets(exp_idx).output,2);

current_plot = 0;

% Iterate through each set of parameters to process simulation results.
for pa_idx = stg.pat
    current_plot = current_plot + 1;
    % Check if the simulation was successful for the current parameter set
    % and experiment.
    if rst(pa_idx).simd{1, exp_idx} ~= 0

        % Fetch time and simulation results; normalize if applicable.
        [sim_results_norm, sim_results_detailed, sim_results] = ...
            f_normalize(rst(pa_idx), stg, exp_idx, out_idx, mmf);

        % Determine which results to use based on the "simdetail" flag.
        if stg.simdetail
            % If detailed simulation results are required, use the detailed
            % results and appropriate time vector.
            time = rst(pa_idx).simd{1, exp_idx + 2 * stg.expn}.Time;
            results = sim_results_detailed;
            % Set y-axis label using the units from the data info.
            results_y_label = ...
                string(rst(pa_idx).simd{1, exp_idx}.DataInfo{end - ...
                n_outputs_exp + out_idx, 1}.Units);
        else
            % Otherwise, use trimmed results and time vector.
            time = ...
                rst(pa_idx).simd{1, exp_idx}.Time(1:stg.out_plot_trim:end);
            if is_norm
                % If normalization is applied, use normalized results.
                results = sim_results_norm(1:stg.out_plot_trim:end);
                results_y_label = "dimensionless";
            else
                % If not normalized, use the original results.
                results = sim_results(1:stg.out_plot_trim:end);
                results_y_label = ...
                    string(rst(pa_idx).simd{1, exp_idx}.DataInfo{end - ...
                    n_outputs_exp + out_idx, 1}.Units);
            end
        end
        if ~is_double
        % Create scatter plot for simulation results.
            scatter(time, results, 2, colors(current_plot, :), "o", ...
            "filled", "MarkerFaceAlpha", 1, "MarkerEdgeAlpha", 1, ...
             "DisplayName", "\theta_{" + pa_idx + "}");
        else
        % Create scatter plot for simulation results.
            scatter(time, results, 2, colors, "o", ...
            "filled", "MarkerFaceAlpha", 1, "MarkerEdgeAlpha", 1, ...
             "DisplayName", "\theta_{" + pa_idx + "}");
        end
        % Set y-axis label with appropriate unit.
        ylabel(results_y_label, 'FontSize', Axis_FontSize, ...
            'Fontweight', Axis_Fontweight);

        % Store the min and max values of the results for axis limits.
        output_max_idx(pa_idx) = max(results);
        output_min_idx(pa_idx) = min(results);
    end
end

% Determine overall min and max values across all parameter sets.
output_max = max(output_max_idx);
output_min = min(output_min_idx);

adjust_y_ticks()

% Determine the plot title based on settings.
if stg.plotoln == 1
    % Use the output name if the plotoln flag is set.
    title_text = ...
        strrep(string(sbtab.datasets(exp_idx).output_name{1, out_idx}), ...
        '_', '\_');
else
    % Use the output ID if the plotoln flag is not set.
    title_text = string(sbtab.datasets(exp_idx).output{1, out_idx});
end

% Add experiment number to title if flag is set.
if include_exp_n == 1
    title_text = "E" + (exp_idx - 1) + " " + title_text;
end

% Add "Norm" to title if the results are normalized.
if is_norm
    title_text = title_text + " Norm";
end

% Adjust title alignment if the output range is very large or very small.
if output_max >= 10000 || output_max <= 0.01
    % Add leading spaces for better alignment.
    title_text = "      " + title_text; 
end

% Set the plot title with appropriate font size and weight.
title(title_text, 'FontSize', Minor_title_FontSize, ...
    'Fontweight', Minor_title_Fontweight);
end

function [min_data, max_data] = ...
    plot_data_and_data_SD(stg, rst, Data, exp_idx, out_idx)
% Function to plot experimental data and its standard deviation (SD). This
% function generates a scatter plot for the experimental data and a shaded
% area representing the standard deviation.
% Inputs:
% - stg: Structure containing experiment settings.
% - rst: Structure containing the results of the simulations.
% - Data: Structure containing experimental data and standard deviations.
% - exp_idx: Index of the current experiment being plotted.
% - out_idx: Index of the current output being plotted.
%
% Outputs:
% - min_data: Minimum value of the experimental data minus standard
% deviation.
% - max_data: Maximum value of the experimental data plus standard
% deviation.

% Iterate through each set of parameters to process simulation results.
for pa_idx = stg.pat
    % Check if the simulation was successful for the current parameter set
    % and experiment.
    if rst(pa_idx).simd{1, exp_idx} ~= 0

        % Extract time, data, and standard deviation for the current
        % experiment and output. The `time` variable represents the time
        % points, while `data` represents the measured output values.
        % `data_SD` represents the standard deviation of the data,
        % indicating the variability.
        time = rst(pa_idx).simd{1, exp_idx}.Time;
        data = Data(exp_idx).Experiment.x(:, out_idx);
        data_SD = Data(exp_idx).Experiment.x_SD(:, out_idx);

        % Create a scatter plot for the output data points. Only a subset
        % of the data points is plotted based on the 'out_plot_trim'
        % setting to reduce clutter.
        scatter(time(1:stg.out_plot_trim:end), ...
            data(1:stg.out_plot_trim:end), 2, 'k', "o", "filled", ...
            "MarkerFaceAlpha", 1, "MarkerEdgeAlpha", 1, ...
            "DisplayName", "data");

        % Overlay the standard deviation of the output data as shaded
        % areas. The shaded area represents the range of data values within
        % one standard deviation above and below the mean.
        f_error_area(transpose(time), ...
            transpose([data - data_SD, data + data_SD]));

        % Only plot the first successful set of data for clarity to avoid
        % overlapping plots from different parameter sets.
        break;
    end
end

% Calculate and return the minimum and maximum values of the data including
% the standard deviation. These values are used to set axis limits when
% plotting the data.
min_data = min(data - data_SD);
max_data = max(data + data_SD);

end

function plot = f_error_area(X, Y_SD)
% Function to create a shaded area plot representing the standard deviation
% (SD) of given data. This function takes two inputs: X is a vector of data
% points on the x-axis, and Y_SD is a 2xN matrix where the first row
% contains the lower bounds, and the second row contains the upper bounds
% of the shaded area.
% 
% Inputs:
% - X: A vector of x-axis data points (e.g., time points).
% - Y_SD: A 2xN matrix, where the first row contains the lower bounds and
% the second row contains the upper bounds of the shaded area.
%
% Outputs:
% - plot: Handle to the created shaded area plot.

% Prepare x coordinates for the shaded area, creating a "patch" that will
% represent the standard deviation. The patch is constructed by defining
% four points for each segment between consecutive x-values.
Xh = [X(1:end-1); X(1:end-1); X(2:end); X(2:end)];

% Prepare y coordinates for the shaded area by specifying the lower and
% upper bounds. Each segment is defined by the lower bound and upper bound
% for the y-values corresponding to the x-coordinates.
Yh = [Y_SD(1, 1:end-1); Y_SD(2, 1:end-1); Y_SD(2, 2:end); Y_SD(1, 2:end)];

% Create the shaded area plot by using the `patch` function. The patch
% represents the variability of the data, shown as a shaded region between
% the upper and lower bounds. The 'FaceColor' is set to black with a
% transparency ('FaceAlpha') of 0.25 to indicate the variability clearly.
plot = patch(Xh, Yh, zeros(size(Xh)), 'DisplayName', "Data_{SD}", ...
    'EdgeColor', 'none', 'FaceColor', [0 0 0], 'FaceAlpha', 0.25, ...
    'HandleVisibility', 'off');

% Conditionally reduce the number of patches for improved performance,
% especially for large datasets. The `reducepatch` function is applied only
% if the size of `X` is large to enhance performance.
% Adjust the threshold as appropriate for your dataset size.
if length(X) > 100
    reducepatch(plot, 0.2);
end

end

function [figure_number, inner_layout, plots, outer_layout] = ...
    f_get_subplot(plot_total_n, plot_n, figure_number, fig_name, plots)
% Function to determine the layout for subplots, create new figures if
% needed, and manage figure settings. This function helps organize subplots
% into figures, ensuring that each figure is correctly named and formatted.
%
% Inputs:
% - plot_total_n: Total number of plots that need to be displayed.
% - plot_n: Current number of plots that have been created so far.
% - figure_number: Current figure number being processed.
% - fig_name: String representing the name of the figure.
% - plots: Cell array containing information on previous plots.
%
% Outputs:
% - figure_number: Updated figure number.
% - inner_layout: Layout object for subplots within the current figure.
% - plots: Updated cell array containing figure handles and names.
% - outer_layout: Layout for the entire figure, containing `inner_layout`.

% Define the maximum number of subplots allowed per figure.
size_total = 12;

% Define possible layout configurations for subplot rows and columns.
% Number of columns for each layout size
size_x = [1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3];
% Number of rows for each layout size
size_y = [1, 2, 3, 2, 3, 3, 3, 3, 3, 4, 4, 4];

% Determine whether a new figure is required based on the number of
% existing plots. A new figure is created every time `plot_n` is a multiple
% of `size_total`, meaning the current figure has reached its capacity.
if mod(plot_n, size_total) == 0
    % Increment the figure number for the next new figure.
    figure_number = figure_number + 1;

    % If the total number of plots exceeds the maximum allowed per figure,
    % append the figure number to the figure name to differentiate it.
    if plot_total_n > size_total
        fig_name = fig_name + " " + figure_number;
    end

    % Create a new figure or refresh an existing one. `f_renew_plot`
    % ensures that a figure with the specified name is created or
    % refreshed. This prevents duplicate figures with outdated content.
    plots = f_renew_plot(fig_name);

    % Set up an outer layout for the entire figure to manage spacing and
    % padding between components. The outer layout contains the inner
    % layout where the subplots will be arranged.
    outer_layout = tiledlayout(1, 1, 'Padding', 'tight', 'TileSpacing', 'none');

    % Determine if the current figure should use the maximum layout size or
    % a smaller one for the remaining plots.
    if figure_number <= floor(plot_total_n / size_total)
        % If the figure is not the last one, use the maximum size
        % dimensions for the layout. This ensures that each figure (except
        % the last one) has the full number of subplots possible.
        inner_layout = ...
            tiledlayout(outer_layout, size_x(size_total), ...
            size_y(size_total), 'Padding', 'none', 'TileSpacing', 'tight');
    else
        % For the last figure, calculate the number of remaining plots and
        % adjust layout dimensions accordingly. The remaining plots are
        % arranged in a smaller layout based on how many are left.
        remaining_plots = ...
            plot_total_n - (floor(plot_total_n / size_total) * size_total);
        inner_layout = ...
            tiledlayout(outer_layout, size_x(remaining_plots), ...
            size_y(remaining_plots), 'Padding', 'none', ...
            'TileSpacing', 'tight');
    end
end
end