function [figure_number,layout,plots] =...
    f_get_subplot(plot_total_n,plot_n,figure_number,fig_name,layout,plots)

size_total = 12;

size_x = [1,1,1,2,3,3,4,4,3,4,4,4];
size_y = [1,2,3,2,2,2,2,2,3,3,3,3];

if mod(plot_n,size_total) == 0
    figure_number = figure_number + 1;
    % If the amount of plots is bigger than the maximum amount of plots per
    % figure subdivide the plots to more than one figure
    if plot_total_n > size_total
        fig_name = fig_name + " " + figure_number;
    end
    %Close previous instances of the figure and generates a new one
    [plots{2}, plots{1}] = create_new_figure(fig_name);

    layout =...
        calculate_layout(figure_number, plot_total_n,...
        size_total, size_x, size_y);
end
end

function [fig_handle, fig_name] = create_new_figure(fig_name)
figHandles = findobj('type', 'figure', 'name', fig_name);
close(figHandles);
fig_handle = ...
    figure('WindowStyle', 'docked', 'Name', fig_name, 'NumberTitle', 'off');
sgtitle(fig_name);
end

function layout = ...
    calculate_layout(figure_number, plot_total_n,...
    size_total, size_x, size_y)

if figure_number <= floor(plot_total_n/size_total)

    layout = tiledlayout(size_x(size_total), size_y(size_total),...
        'Padding', 'none', 'TileSpacing', 'tight');
else

    remaining_plots =...
        plot_total_n - (floor(plot_total_n/size_total) * size_total);
    
    layout =...
        tiledlayout(size_x(remaining_plots), size_y(remaining_plots),...
        'Padding', 'none', 'TileSpacing', 'tight');
end
end