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
% plots_1 = [];

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

    hold on

    [~,labelfig2] = f_plot_input(stg,rst,sbtab,exp_idx,layout);

    % Set x-axis label for the first plot in a row
    if mod(plot_n,12) == 1

        xlabel(layout,"Seconds", 'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

        % Create legend
        Lgnd = legend(labelfig2,'Orientation','vertical', ...
            'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
            'Location','layout','Box','off');
        Lgnd.Layout.Tile = 'East';
        Lgnd.ItemTokenSize = Legend_ItemTokenSize;
    end

    % Set y-axis limit and format
    ylim([0 inf])
    % ytickformat('%-4.1f')

    % Add a title to each plot
    title("E"+(exp_idx-1))

    hold off
end
end