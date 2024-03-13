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

% Generate colors for plotting.
colors = generateRainbowGradient(length(stg.pat)); 

% Iterate over each experiment run to generate plots.
for exp_idx = stg.exprun
    sub_fig_number = 0;% Track subplot numbers within the same figure.

    % Calculate the number of outputs for the current experiment.
    n_outputs_exp = size(sbtab.datasets(exp_idx).output,2);

    % Initialize variable for figure management within the same experiment
    fig_number_same_exp = 1;
    % Increment counters for figure management.
    fig_number =fig_number+ 1;

    % Plot input data on the left side of the figure for the current
    % experiment.
    [layout,input_plot,plots] = ...
        f_plot_in_out_left(rst, stg, sbtab, fig_number_same_exp,...
        n_outputs_exp > 4, exp_idx, plots, fig_number);
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
                n_outputs_exp > 4, exp_idx, plots, fig_number);
            draw_legend = 1; % Reset flag for new subplot layout.
        end

        % Setup the next tile for output data plotting.
        nexttile(layout,[1 1]);

        hold on
        % Call function to plot simulation outputs.
        [valid_outputs_plots,valid_outputs,sim_results,...
            sim_results_norm,sim_results_detailed] = ...
            plot_sim_outputs(stg,rst,sbtab,mmf,exp_idx,out_idx,colors,0);

        if isempty(sim_results_norm)
            % Call function to plot simulation data.
            [plot_data,plot_data_SD,data,data_SD] = ...
                plot_data_with_SD(stg,rst,Data,exp_idx,out_idx);

            % Set the y-axis limits based on simulation detail setting and
            % data range.
            if stg.simdetail
                ylim([min([0,min(sim_results_detailed),min(sim_results),...
                    min(data-data_SD),min(data)]) inf])
            else
                ylim([min([0,min(sim_results),...
                    min(data-data_SD),min(data)]) inf])
            end

        else
             % Adjust y-axis limits if normalized simulation results are
             % available.
            if stg.simdetail
                ylim([min([0,min(sim_results_detailed),min(sim_results)])...
                    inf])
            else
                ylim([min([0,min(sim_results),]) inf])
            end
        end

        hold off

        if ~isempty(sim_results_norm)
            
            % Check if new subplot layout is needed based on output count.
            sub_fig_number = sub_fig_number +1;
            if sub_fig_number/4 > fig_number_same_exp
                fig_number_same_exp = fig_number_same_exp+1;
                fig_number = fig_number+ 1;

                % Plot input data on the left side of the figure for the
                % current experiment.
                [layout,input_plot,plots] = ...
                    f_plot_in_out_left(rst, stg,sbtab, fig_number_same_exp,...
                    n_outputs_exp > 4, exp_idx, plots, fig_number);
                draw_legend = 1;% Reset flag for new subplot layout.
            end

            % Setup the next tile for output data plotting.
            nexttile(layout,[1 1]);

            hold on
            
            % Call function to plot simulation outputs.
            [valid_outputs_plots,valid_outputs,~,~,sim_results_detailed] = ...
                plot_sim_outputs(stg,rst,sbtab,mmf,exp_idx,out_idx,colors,1);

            % Call function to plot simulation data.
            [plot_data,plot_data_SD,data,data_SD] =...
                plot_data_with_SD(stg,rst,Data,exp_idx,out_idx);

            hold off


            % Set ylim based on whether simdetail is enabled or not
            if stg.simdetail
                ylim([min([0,min(sim_results_detailed),...
                    min(sim_results_norm), min(data-data_SD),min(data)])...
                    inf])
            else
                ylim([min([0,min(sim_results_norm),...
                    min(data-data_SD),min(data)]) inf])
            end
        end

        % Check if legend needs to be drawn for the current subplot.
        if draw_legend == 1
            % Construct the legend with the correct formatting and
            % placement.
            leg = legend([valid_outputs_plots(:,valid_outputs),...
                input_plot,plot_data,plot_data_SD],...
                'FontSize', Legend_FontSize,...
                'Fontweight',Legend_Fontweight,'Location',...
                'layout',"Orientation","Horizontal");
            leg.Layout.Tile = 'South'; % Position legend at the bottom.
            % Set the size of legend markers.
            leg.ItemTokenSize = Legend_ItemTokenSize; 
            set(leg,'Box','off') % Remove the legend box boundary.
            draw_legend = 0; % Reset flag after drawing the legend.
        end
    end
end
end

function [plot_data,plot_data_SD,data,data_SD] = ...
    plot_data_with_SD(stg,rst,Data,exp_idx,out_idx)
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
        plot_data = scatter(time,data,2,'k',"o","filled",...
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

function [valid_outputs_plots,valid_outputs,sim_results,...
    sim_results_norm,sim_results_detailed] =...
    plot_sim_outputs(stg,rst,sbtab,mmf,exp_idx,out_idx,colors,is_norm)
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

% Iterate through each set of parameters to process simulation results.
for pa_idx = stg.pat
    % Check if the simulation was successful for the current parameter set
    % and experiment.
    if rst(pa_idx).simd{1,exp_idx} ~= 0

        % Fetch time and simulation results; normalize if applicable.
        time = rst(pa_idx).simd{1,exp_idx}.Time;
        [sim_results_norm,sim_results_detailed,sim_results] =...
        f_normalize(rst(pa_idx),stg,exp_idx,out_idx,mmf);

        % Detailed simulation time series is used if detailed simulation
        % settings are enabled.
        if stg.simdetail
            time_detailed = rst(pa_idx).simd{1,exp_idx+2*stg.expn}.Time;
        end

        % Plot simulation data. Use detailed time and results if simdetail
        % is enabled, and color-code by parameter set.
        if stg.simdetail
            valid_outputs_plots(:,pa_idx) = scatter(time_detailed,...
                sim_results_detailed,1,colors(pa_idx,:),"o","filled",...
                "MarkerFaceAlpha",1,"MarkerEdgeAlpha",1,"DisplayName",...
                string("\theta_"+pa_idx));
            % Label the y-axis with the correct unit and apply pre-defined
            % font settings.
            ylabel(string(rst(pa_idx).simd{1,exp_idx}. ...
                DataInfo{end-n_outputs_exp+out_idx,1}.Units),...
                'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
        else
            % Select between normalized and raw results based on 'is_norm'
            % flag.
            if is_norm
                valid_outputs_plots(:,pa_idx) = scatter(time,...
                    sim_results_norm,1,colors(pa_idx,:),"o","filled",...
                    "MarkerFaceAlpha",1,"MarkerEdgeAlpha",1,"DisplayName",...
                    string("\theta_"+pa_idx));
                % Label the y-axis as 'dimensionless' and apply pre-defined
                % font settings.
                ylabel("dimensionless",...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
            else
                valid_outputs_plots(:,pa_idx) = scatter(time,...
                    sim_results,1,colors(pa_idx,:),"o","filled",...
                    "MarkerFaceAlpha",1,"MarkerEdgeAlpha",1,"DisplayName",...
                    string("\theta_"+pa_idx));
                % Label the y-axis with the correct unit and apply
                % pre-defined font settings.
                ylabel(string(rst(pa_idx).simd{1,exp_idx}. ...
                    DataInfo{end-n_outputs_exp+out_idx,1}.Units),...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
            end
        end

        % Add the successful parameter index to the list of valid outputs.
        valid_outputs(pa_idx) = pa_idx;
    end
end

% Label the x-axis as 'Seconds' and apply pre-defined font settings.
xlabel('Seconds','FontSize', Axis_FontSize,...
    'Fontweight',Axis_Fontweight)

% Determine the title based on whether the setting plot option long names
% is set. Replace underscores in dataset names for proper formatting in
% titles.
if stg.plotoln == 1
    [~,t2] = ...
        title(strrep(string(sbtab.datasets(exp_idx).output_name{1,out_idx}),...
        '_','\_')+ " Norm"," " ,'FontSize',Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight);
else
    [~,t2] = ...
        title(string(sbtab.datasets(exp_idx).output{1,out_idx})+ " Norm",...
        " " ,'FontSize',Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight);
end

t2.FontSize = Minor_Title_Spacing;

% Set the number of decimal places for the y-axis
% ytickformat('%-3.1f')
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
        "Experiment " + (exp_idx-1) + " " + fig_number_same_exp + "  (E " +...
        (exp_idx-1) + " " + fig_number_same_exp +")";
else
    name_short = "E " + (exp_idx-1);
    name_long = "Experiment " + (exp_idx-1) + "  (E " + (exp_idx-1) +")";
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

% Iterate through each input species for the current experiment.
for inpt_idx = 1:size(sbtab.datasets(exp_idx).input,2)
    % Iterate through each set of parameters to process simulation results.
    for pa_idx = stg.pat
        % Check if the simulation was successful for the current parameter
        % set and experiment.
        if rst(pa_idx).simd{1,exp_idx} ~= 0
            % Convert species identifier from string to number.
            input_species_ID =...
                str2double(strrep(sbtab.datasets(exp_idx).input(inpt_idx),'S',''))+1;

            % Create a scatter plot for the input species data points.
            input_plot = ...
                scatter(rst(pa_idx).simd{1,exp_idx}.Time,...
                rst(pa_idx).simd{1,exp_idx}.Data(1:end,input_species_ID),...
                2,[0.5,0.5,0.5],"o","filled","MarkerFaceAlpha",1,...
                "MarkerEdgeAlpha",1,"DisplayName",...
                string(rst(pa_idx).simd{1,exp_idx}.DataNames(input_species_ID)));

            % Label the y-axis with the correct unit and apply pre-defined
            % font settings.
            ylabel(string(rst(pa_idx).simd{1,exp_idx}. ...
                DataInfo{input_species_ID,1}.Units), ...
                'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

            % Break after plotting the first available set to avoid clutter.
            break
        end
    end
end

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

% Finish plotting to ensure all input data is displayed properly.
hold off
end