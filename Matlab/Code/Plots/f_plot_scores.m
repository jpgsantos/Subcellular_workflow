function plots =f_plot_scores(rst,stg,sbtab)
% Generates a figure with scores for different experimental outputs and
% parameter sets
%
% Inputs:
% - rst: A struct array containing results of the simulations
% - stg: A struct containing settings for the simulations
% - sbtab: A struct containing information about the datasets used
% 
% Outputs:
% - plots: A cell array containing the generated plots
%
% Functions Called:
% - f_set_font_settings: A function to set the font settings for the plot
% - f_renew_plot: Closes any existing figures with the specified name and
% then creates a new figure with the given name and properties. It returns
% a 1x2 cell array containing the figure name and the figure handle.
%
% Variables
% Loaded:
% - None
%
% Initialized:
% - layout: A tiled layout object for arranging plots within the figure
% - diag_idx: Indices for the different parameter sets
% - score_diag: Total scores for each parameter set
% - title_texts: Different title texts based on the settings
% - title_text: The chosen title text for the top plot
% - label: Labels for the heatmap rows
% - heatline: Data matrix for the heatmap
% - h: A heatmap object
%
% Persistent:
% - None

%Font settings
f_set_font_settings()

% Inform the user that fig1 is being ploted
disp("Plotting Scores")

% Closes previous instances of the figure and generates a new one
plots = f_renew_plot('Scores');

layout = tiledlayout(5,1,'Padding','tight','TileSpacing','tight');

% Generate top plot of Scores figure
nexttile(layout,[1 1]);

diag_idx = stg.pat;
score_diag = [rst(stg.pat).st];

% Plot the total scores of each parameter array to test
scatter(diag_idx,score_diag,20,'filled')
ylabel('Total Score (s_t)', 'FontSize', Axis_FontSize, 'FontWeight', Axis_Fontweight)
set(gca,'xtick',[])
% set(gca,'FontSize',10,'Fontweight','bold')

% Choose correct title according to settings
title_texts = ["Sum of the Score of all Experiments (s_t)",...
    "Sum of the Log base 10 of the Score of each Experimental Output", ...
    "Sum of the Log base 10 of the Score of each Experiment", ...
    "Log base 10 of sum of the Score of all Experiments", ...
    "Sum of the Score of all Experiments (s_t)"];
title_text = title_texts(stg.useLog+1);

title(layout,strrep(stg.plot_name, "_", "\_"),'FontSize', Major_title_FontSize,...
    'Fontweight',Major_title_Fontweight);
title(title_text,...
    "FontSize", Minor_title_FontSize, "FontWeight", Minor_title_Fontweight)

% Choose the bounds for the x axis so it aligns with the bottom plot
xlim([min(diag_idx)-0.5 max(diag_idx)+0.5])

% Generate bottom plot of figure 1
nexttile(layout,[4 1]);

% Generate labels for left of heatmap (Experiment number Dataset number)
label_y = arrayfun(@(n) strcat("E", num2str(n-1), " ", ...
    strrep(string(sbtab.datasets(n).output_name), "_", "\_")), ...
    stg.exprun, 'UniformOutput', false);
label_y = horzcat(label_y{:});

for n = stg.pat
label_x{n} = "\theta_{" + n + "}";
end
label_x = horzcat(label_x{:});

heatline = cell2mat(arrayfun(@(k) cell2mat(arrayfun(@(n) rst(k).sd(:, n)', ...
    stg.exprun, 'UniformOutput', false))', stg.pat, 'UniformOutput', false));

heatline( ~any(heatline,2), : ) = [];

% Plot the heatmap
h = heatmap(heatline,'Colormap',turbo,'YDisplayLabels',label_y, ...
    'XDisplayLabels',label_x, 'GridVisible','off','FontSize',7);
h.CellLabelFormat = '%.2e';

h.Title = "\fontsize{10} \bf Score of each Experimental Output (s_d)";
h.XLabel = '\fontsize{8} \bf Parameter sets (\theta)';
h.YLabel = '\fontsize{8} \bf Experimental Outputs';
end