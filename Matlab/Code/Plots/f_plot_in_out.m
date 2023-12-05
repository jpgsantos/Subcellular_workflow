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

% Initialize variables for plot management
fig_number = 0;
plots = cell(1,2);

% Loop through each experiment run
for n = stg.exprun

    % Get the number of outputs for the current experiment
    n_outputs_exp = size(sbtab.datasets(n).output,2);

    % Initialize variables for plot management within the same experiment
    fig_number_same_exp = 1;
    fig_number =fig_number+ 1;

    % Plot the left side of the figure with input data
    [layout,input_plot,plots] = ...
        f_plot_in_out_left(rst, stg, sbtab, fig_number_same_exp,...
        n_outputs_exp > 4, n, plots, fig_number);

    % Loop through each output of the current experiment
    for j = 1:n_outputs_exp

        % If the output number is greater than 4 times the figure number of
        % the same experiment, create a new layout for input data
        if j/4 > fig_number_same_exp
            fig_number_same_exp = fig_number_same_exp+1;
            fig_number = fig_number+ 1;

            % Plot the left side of the figure with input data
            [layout,input_plot,plots] = ...
                f_plot_in_out_left(rst, stg,sbtab, fig_number_same_exp,...
                n_outputs_exp > 4, n, plots, fig_number);
        end

        % Set up the layout for output data
        nexttile(layout,[1 1]);
        hold on
        valid_outputs = [];

        % Loop through each parameter array to test
        for m = stg.pat

            % Plot output data only if the simulation was successful
            if rst(m).simd{1,n} ~= 0

                % Retrieve time, data and standard deviation from the
                % experiment
                time = rst(m).simd{1,n}.Time;
                data = Data(n).Experiment.x(:,j);
                data_SD = Data(n).Experiment.x_SD(:,j);

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

            % Plot simulated output data only if the simulation was
            % successful
            if rst(m).simd{1,n} ~= 0

                % Retrieve time and normalized simulation results
                time = rst(m).simd{1,n}.Time;
                [~,~,sim_results] = f_normalize(rst(m),stg,n,j,mmf);

                % If simdetail is enabled, retrieve detailed time and
                % simulation results
                if stg.simdetail
                    time_detailed = rst(m).simd{1,n+2*stg.expn}.Time;
                    [~,sim_results_detailed] = ...
                        f_normalize(rst(m),stg,n,j,mmf);
                end

                % Plot the outputs to each dataset (new subplots) and
                % parameter array to test that are simulated using
                % Simbiology

                % Plot simulated output data
                if stg.simdetail
                    valid_outputs_plots(:,m) = plot(time_detailed,...
                        sim_results_detailed,'DisplayName',...
                        string("\theta_"+m),'LineWidth',line_width);
                else
                    valid_outputs_plots(:,m) = plot(time,...
                        sim_results,...
                        'DisplayName',string("\theta_"+m),...
                        'LineWidth',line_width);
                end

                % Set ylabel with the correct units
                ylabel(string(rst(m).simd{1,n}. ...
                    DataInfo{end-n_outputs_exp+j,1}.Units),...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
                valid_outputs = [valid_outputs,m];
            end

        end

        hold off

        % Set ylim based on whether simdetail is enabled or not
        if stg.simdetail
            ylim([min([0,min(sim_results_detailed),min(sim_results),...
                min(data-data_SD),min(data)]) inf])
        else
            ylim([min([0,min(sim_results),...
                min(data-data_SD),min(data)]) inf])
        end

        % Set xlabel with correct font settings
        xlabel('Seconds','FontSize', Axis_FontSize,...
            'Fontweight',Axis_Fontweight)

        % Set title according to settings
        if stg.plotoln == 1
            [~,t2] = ...
                title(strrep(string(sbtab.datasets(n).output_name{1,j}),...
                '_','\_')," ",'FontSize',Minor_title_FontSize,...
                'Fontweight',Minor_title_Fontweight);
        else
            [~,t2] = ...
                title(string(sbtab.datasets(n).output{1,j}),...
                " ",'FontSize',Minor_title_FontSize,...
                'Fontweight',Minor_title_Fontweight);
        end

        t2.FontSize = Minor_Title_Spacing;
        % Set the number of decimal places for the y-axis
        % ytickformat('%-3.1f')

        

        % Add a legend for the entire image
        leg = ...
            legend([input_plot,valid_outputs_plots(:,valid_outputs),...
            plot_data,plot_data_SD],'FontSize', Legend_FontSize,...
            'Fontweight',Legend_Fontweight,'Location',...
            'layout',"Orientation","Horizontal");
        leg.Layout.Tile = 'South';
        leg.ItemTokenSize = Legend_ItemTokenSize;
        set(leg,'Box','off')

    end
end
end

function [layout,input_plot,plots] = ...
    f_plot_in_out_left(rst,stg,sbtab,fig_number_same_exp,reuse,n,...
    plots,fig_number)
% Function to plot input data on the left side of the figure

% Set font settings for the plot
f_set_font_settings()

% Set figure names based on whether the same figure is reused or not
if reuse
    name_short = "E " + (n-1) + " " + fig_number_same_exp;
    name_long = ...
        "Experiment " + (n-1) + " " + fig_number_same_exp + "  (E " +...
        (n-1) + " " + fig_number_same_exp +")";
else
    name_short = "E " + (n-1);
    name_long = "Experiment " + (n-1) + "  (E " + (n-1) +")";
end

plots(fig_number,:) = f_renew_plot(name_short);

% Create a tiled layout for the figure
layout = tiledlayout(2,3,'Padding',"tight",'TileSpacing','tight');
nexttile(layout,[2 1]);


% Set title for the layout
title(layout,name_long,...
    'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight)

hold on

% Plot input data for each experiment
for o = 1:size(sbtab.datasets(n).input,2)
    for p = stg.pat

        % (Until a non broken simulation is found)
        if rst(p).simd{1,n} ~= 0
            input_species_ID =...
                str2double(strrep(sbtab.datasets(n).input(o),'S',''))+1;

            % Plot the inputs to each experiment
            input_plot = ...
                plot(rst(p).simd{1,n}.Time,rst(p).simd{1,n}.Data(1:end,...
                input_species_ID),'DisplayName',...
                string(rst(p).simd{1,n}.DataNames(input_species_ID)),...
                'LineWidth',line_width);

            % Set ylabel with the correct units
            ylabel(string(rst(p).simd{1,n}. ...
                DataInfo{input_species_ID,1}.Units), ...
                'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
            break
        end
    end
end

% Set xlabel with correct font settings
xlabel('Seconds','FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
ylim([0 inf])
% ytickformat('%-3.1f')

% Add a title to the plot
if size(sbtab.datasets(n).input,2) == 1
[~,t4] = ...
    title("Input"," ",'FontSize', Minor_title_FontSize,...
    'Fontweight',Minor_title_Fontweight);
else
[~,t4] = ...
    title("Inputs"," ",'FontSize', Minor_title_FontSize,...
    'Fontweight',Minor_title_Fontweight);
end
t4.FontSize = Minor_Title_Spacing;

hold off
end