function [fig_n,layout] = f_get_subplot(plot_tn,plot_n,fig_n,fig_name,layout)

% size_x = 4;
% size_y = 6;
size_t = 24;
% ratio_1 = 3;
% ratio_2 = 4;


size_x = [1,2,3,2,3,3,4,4,3,4,4,4,5,5,5,4,5,5,5,5,6,6,6,6];
size_y = [1,1,1,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4];

% If the amount of plots is bigger thatn the maximum amount of plots per
% figure subdivide the plots to more than one figure
% if plot_tn > 24
%     
%     % Generate a new figure for the first plot and each time the number of
%     % plots is greater than figure number divided by max plot number per
%     % figure
%     if mod(plot_n-1,24) == 0
%         
%         fig_n = fig_n + 1;
%         
%         %Close previous instances of the figure and generates a new one
%         figHandles = findobj('type', 'figure', 'name', fig_name + " " + fig_n);
%         close(figHandles);
%         figure('WindowStyle', 'docked','Name', fig_name + " " + fig_n,'NumberTitle', 'off');
%         sgtitle(fig_name + " " + fig_n);
%         layout = tiledlayout(ceil(sqrt(24/6)*2),ceil(sqrt(24/6)*3),'Padding','none','TileSpacing','compact');
%     end
%     
%     % Get the correct subploting position for each plot
% %     if plot_tn/24 < fig_n
% %         subplot(ceil(sqrt((plot_tn-(fig_n-1)*24)/6)*2),ceil(sqrt((plot_tn-(fig_n-1)*24)/6)*3),plot_n-(fig_n-1)*24)
% %     else
% %         subplot(ceil(sqrt(24/6)*2),ceil(sqrt(24/6)*3),plot_n-(fig_n-1)*24)
% %     end
%     
% else
    
    % Generate a new figure for the first plot
    if mod(plot_n-1,size_t) == 0
        
        %Close previous instances of the figure and generates a new one
        figHandles = findobj('type', 'figure', 'name', fig_name);
        close(figHandles);
        figure('WindowStyle', 'docked','Name', fig_name, 'NumberTitle', 'off');
        sgtitle(fig_name);
%         layout = tiledlayout(...
%             ceil(sqrt((plot_tn-fig_n*size_t)/(ratio_1*ratio_2))*ratio_1),...
%             ceil(sqrt((plot_tn-fig_n*size_t)/(ratio_1*ratio_2))*ratio_2),...
%             'Padding','none','TileSpacing','compact');
        layout = tiledlayout(...
            size_x(plot_tn-(floor(plot_tn/size_t)*size_t)),...
            size_y(plot_tn-(floor(plot_tn/size_t)*size_t)),...
            'Padding','none','TileSpacing','compact');
        
        title(layout,fig_name, 'FontSize', 16,'Fontweight','bold')
        fig_n = fig_n + 1;
         
    end
    
    % Get the correct subploting position for each plot
%     subplot(ceil(sqrt(plot_tn/6)*2),ceil(sqrt(plot_tn/6)*3),plot_n)
    
% end
end