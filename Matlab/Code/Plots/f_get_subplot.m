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

size_x = [1,1,1,2,3,3,4,4,3,4,4,4];
size_y = [1,2,3,2,2,2,2,2,3,3,3,3];

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