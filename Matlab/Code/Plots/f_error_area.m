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
end