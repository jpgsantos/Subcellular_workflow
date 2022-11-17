function [fig_n,layout,plots] = f_get_subplot(plot_tn,plot_n,fig_n,fig_name,layout,plots)

size_t = 12;

% size_x = [1,1,1,2,3,3,4,4,3,4,4,4,5,5,5,4,5,5,5,5,6,6,6,6];
% size_y = [1,2,3,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4];

% size_x = [1,1,1,2,3,3,4,4,3,4,4,4,5,5,5,6,6,6,7,7,7,8,8,8];
% size_y = [1,2,3,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3];

size_x = [1,1,1,2,3,3,4,4,3,4,4,4];
size_y = [1,2,3,2,2,2,2,2,3,3,3,3];

if mod(plot_n,size_t) == 0
    fig_n = fig_n + 1;
    % If the amount of plots is bigger than the maximum amount of plots
    % per figure subdivide the plots to more than one figure
    if plot_tn > size_t
        fig_name = fig_name + " " + fig_n;
    end
    %Close previous instances of the figure and generates a new one
    figHandles = findobj('type', 'figure', 'name', fig_name);
    close(figHandles);
    plots{1} = fig_name;
    plots{2} = figure('WindowStyle', 'docked','Name', fig_name, 'NumberTitle', 'off');
    sgtitle(fig_name);
    
    if fig_n <= floor(plot_tn/size_t)
        layout = tiledlayout(...
            size_x(size_t),...
            size_y(size_t),...
            'Padding','none','TileSpacing','tight');
    else
        layout = tiledlayout(...
            size_x(plot_tn-(floor(plot_tn/size_t)*size_t)),...
            size_y(plot_tn-(floor(plot_tn/size_t)*size_t)),...
            'Padding','none','TileSpacing','tight');
    end
end
end