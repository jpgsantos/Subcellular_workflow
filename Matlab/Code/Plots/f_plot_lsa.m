function plots = f_plot_lsa(results,settings)
% This function takes in two input arguments, rst and settings, and generates a
% bar plot displaying the average deviation and sigma deviation with
% different line styles. It applies the desired font settings, closes any
% existing figures with the same name, creates a new one, and adds a title
% and legend to the plot.
%
% Inputs:
% - rst: A structure containing the average and sigma deviation data
% - settings: A structure containing the parnum (parameter number) field
%
% Outputs:
% - plots: A cell array containing the name of the plot and the plot
% figure handle
%
% Functions called:
% - f_set_font_settings: A function that sets the font settings for the
% plot
% - f_renew_plot: Closes any existing figures with the specified name and
% then creates a new figure with the given name and properties. It returns
% a 1x2 cell array containing the figure name and the figure handle.
% Variables:
% Loaded (font settings):
% - Axis_FontSize: Font size for axis labels
% - Major_title_FontSize: Font size for the main title
% - Major_title_Fontweight: Font weight for the main title
% - Legend_FontSize: Font size for the legend
% - Legend_Fontweight: Font weight for the legend
% - Legend_ItemTokenSize: Size of the legend item token
%
% Initialized:
%
% Persistent:

% Inform the user that LSA figure is being ploted
disp("Plotting LSA")

%Set font settings
f_set_font_settings()

% Close any existing figures with the same name and create a new one
plots = f_renew_plot('Local SA');

layout = tiledlayout(1,1,'Padding','compact','TileSpacing','tight');
nexttile(layout)

% Create a bar plot with different line styles for average and sigma
% deviations
X = categorical(convertStringsToChars("P" + [1:settings.parnum]));
X = reordercats(X,convertStringsToChars("P" + [1:settings.parnum]));
h = bar(X,transpose([[results.average_deviation];[results.sigma_deviation]]) ...
    ,'EdgeColor','k','LineWidth',1,'FaceColor','w');
LineArray={ '-' , ':' };

for k=1:2
    set(h(k),'LineStyle',LineArray{k});
end
set(gca,'FontSize',Axis_FontSize);

% Add a title and legend to the plot
title(layout,strrep(settings.plot_name, "_", "\_") + "  Local sensitivity Analysis",'FontSize',...
    Major_title_FontSize,'Fontweight',Major_title_Fontweight);

Lgnd = legend({'\mu^*_{d_p}','\sigma_{d_p}'},...
    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
    'Location','best','Box','off');

Lgnd.ItemTokenSize = Legend_ItemTokenSize;
end