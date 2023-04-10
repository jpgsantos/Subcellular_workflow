function plots = f_plot_opt(results,settings)
% This function generates two figures to visualize optimization results for
% multiple optimization methods. The first figure displays the best
% parameters found after optimization for each optimization method, along
% with the best parameter set and prior bounds. The second figure shows the
% scores of parameter sets after optimization for each optimization method.
%
% Inputs:
% - results: A structure containing optimization results
% - settings: A structure containing settings for optimization
%
% Outputs:
% - plots: A cell array containing two plot names and their handles
%
% Functions called:
% - f_set_font_settings: A helper function to set font settings
% - f_renew_plot: Closes any existing figures with the specified name and
% then creates a new figure with the given name and properties. It returns
% a 1x2 cell array containing the figure name and the figure handle.
% 
% Variables:
% Loaded:
% - None
%
% Initialized:
% - colour: A cell array defining the color map for the plots
% - layout: A tiled layout object for organizing the plots
% - n_opt_methods: The number of optimization methods used
% - name: A cell array containing method names and scores for the legend
% - Lgnd: A legend object for the plots
% - parNames: A cell array containing parameter names for axis labels
% - ax: The current axes object
% - n_opts: A vector storing the number of optimization results
%
% Persistent:
% - None

% Display a message indicating that the optimization results are being
% plotted
disp("Plotting Optimization results")

% Set font settings
f_set_font_settings()

% Define color map for the plots
colour = {[1 0 0],[0 1 0],[0 0 1],[1 0.75 0],[1 0 1],[0 0.75 1]};

% Create the first plot and delete any existing plot with the same name
plots(1,:) = f_renew_plot('Optimization results');

% Set up the tiled layout for the first plot
layout = tiledlayout(1,1,'Padding','tight','TileSpacing','tight');
nexttile(layout,[1 1]);

% Determine the number of optimization methods used
n_opt_methods = size(settings.pat,2);

% Create scatter plots for each optimization method and add them to the legend
hold on
m = 0;
for n = settings.pat
    % Sort optimization results by score
    [~,I] = sort(results.opt(n).fval);
    m = m+1;
    % Create a scatter plot for the optimization method
    scatter((1:settings.parnum)+((0.5/n_opt_methods)*m)-...
        ((0.5/n_opt_methods)*(n_opt_methods+1)/2),results.opt(n).x(I(1),:),...
        20,'filled','MarkerFaceAlpha',1,'MarkerFaceColor',colour{n})
    % Add the method's name and score to the legend
    name{m} = ...
        sprintf('%s (Score = %.2f)', results.opt(n).name, results.opt(n).fval(I(1)));
end

% Add best parameter set, prior bounds, and vertical lines to the first
% plot
scatter(1:settings.parnum,settings.bestpa(1:settings.parnum),20,...
    'k','filled','MarkerFaceAlpha',0.5)
scatter(1:settings.parnum,settings.lb(1:settings.parnum),50,'x',...
    'k','MarkerFaceAlpha',0.75)
scatter(1:settings.parnum,settings.ub(1:settings.parnum),50,'x',...
    'k','MarkerFaceAlpha',0.75)
for n = 2:settings.parnum
    plot([n-0.5 n-0.5],[min(settings.lb) max(settings.ub)],...
        '--k','Color', [0.5 0.5 0.5 0.5])
end

hold off

% Create the legend, set its properties, and display the labels
Lgnd = legend([name(:)' 'Previous best parameter set' 'Prior bounds'],...
    'Orientation','horizontal', ...
    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
    'Location','layout','Box','off');
Lgnd.Layout.Tile = 'South';
Lgnd.ItemTokenSize = Legend_ItemTokenSize;
Lgnd.NumColumns = 2;

% Set the limits for the axes
ylabel('Log10 of parameter value','Fontweight',...
    Axis_Fontweight,'FontSize',Axis_FontSize)
xlabel('Parameters','Fontweight',Axis_Fontweight,'FontSize',Axis_FontSize)

[~,t2] = title({"Best parameters after optimization", ...
    "  Seconds: " + settings.optt + "  Pop Size: " + settings.popsize + ...
    "  Multiple starts: " + settings.msts}," ",...
    'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight);
t2.FontSize = Major_Title_Spacing;
parNames = cell(1,settings.parnum);

for n = 1:settings.parnum
    parNames{n} = char("P" + find(settings.partest==n));
end

for n = 1:size(parNames,2)
    if size(parNames{n},1) > 1
        parNames{n} = parNames{n}(1,:);
    end
end

ax = gca;
set(gca,'xtick',1:settings.parnum,'xticklabel',parNames)
ax.XAxis.Limits = [0.5, settings.parnum + 0.5];
ax.YAxis.Limits = [min(settings.lb) - 0.1, max(settings.ub) + 0.1];

% Create the second plot and delete any existing plot with the same name
plots(2,:) = f_renew_plot('Optimization results 2');

% Set up the tiled layout for the second plot
layout = tiledlayout(1,1,'Padding','compact','TileSpacing','tight');

nexttile(layout,[1 1]);

% Create scatter plots for each optimization method's scores
hold on
m = 0;
for n = settings.pat
    % Sort optimization results by score
    B = sort(results.opt(n).fval);
    m = m +1;
    fval_number = 1:size(results.opt(n).x,1);

    % Create a scatter plot for the optimization method
    scatter(fval_number+(0.5/n_opt_methods*m)-...
        (0.5/n_opt_methods*(n_opt_methods+1)/2),log10(B(fval_number)),20,...
        'filled','MarkerFaceAlpha',1,'MarkerFaceColor',colour{n})

    % Add the method's name to the legend
    name{m} = sprintf('%s', results.opt(n).name);

    % Store the number of optimization results
    n_opts(n) = size(results.opt(n).x,1);
end

hold off
% Add labels and set the limits for the axes
ylabel('Log_{10}(Score)','Fontweight',...
    Axis_Fontweight,'FontSize',Axis_FontSize)
xlabel('Ordered Scores','Fontweight',...
    Axis_Fontweight,'FontSize',Axis_FontSize)
[~,t2] = title({"Scores of parameter sets after optimization", ...
    "  Seconds: " + settings.optt + "  Pop Size: " + settings.popsize}," ",...
    'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight);

t2.FontSize = Major_Title_Spacing;
set(gca,'xtick',1:max(n_opts))
xlim([0 max(n_opts) + 1])

% Create the legend, set its properties
Lgnd = legend(name,'Orientation','horizontal', ...
    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
    'Location','layout','Box','off');
Lgnd.Layout.Tile = 'South';
Lgnd.ItemTokenSize = Legend_ItemTokenSize;
Lgnd.NumColumns = 3;
end