function fig_n = f_get_subplot(plot_tn,plot_n,fig_n,fig_name)

size_x = 4;
size_y = 6;
size_t = 24;
ratio_1 = 2;
ratio_2 = 3;

% If the amount of plots is bigger thatn the maximum amount of plots per
% figure subdivide the plots to more than one figure
if plot_tn > 24
    
    % Generate a new figure for the first plot and each time the number of
    % plots is greater than figure number divided by max plot number per
    % figure
    if mod(plot_n-1,24) == 0
        
        fig_n = fig_n + 1;
        
        %Close previous instances of the figure and generates a new one
        figHandles = findobj('type', 'figure', 'name', fig_name + " " + fig_n);
        close(figHandles);
        figure('WindowStyle', 'docked','Name', fig_name + " " + fig_n,'NumberTitle', 'off');
        sgtitle(fig_name + " " + fig_n);
    end
    
    % Get the correct subploting position for each plot
    if plot_tn/24 < fig_n
        subplot(ceil(sqrt((plot_tn-(fig_n-1)*24)/6)*2),ceil(sqrt((plot_tn-(fig_n-1)*24)/6)*3),plot_n-(fig_n-1)*24)
    else
        subplot(ceil(sqrt(24/6)*2),ceil(sqrt(24/6)*3),plot_n-(fig_n-1)*24)
    end
    
else
    
    % Generate a new figure for the first plot
    if mod(plot_n-1,24) == 0
        
        %Close previous instances of the figure and generates a new one
        figHandles = findobj('type', 'figure', 'name', fig_name);
        close(figHandles);
        figure('WindowStyle', 'docked','Name', fig_name, 'NumberTitle', 'off');
        sgtitle(fig_name);
        
    end
    
    % Get the correct subploting position for each plot
    subplot(ceil(sqrt(plot_tn/6)*2),ceil(sqrt(plot_tn/6)*3),plot_n)
    
end
end