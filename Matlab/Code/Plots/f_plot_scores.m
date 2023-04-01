function plots =f_plot_scores(rst,stg,sbtab,font_settings)
% Generates a figure with Scores

%Font settings
set_font_settings(font_settings)

% Inform the user that fig1 is being ploted
disp("Plotting Scores")

%Closes previous instances of the figure and generates a new one
figHandles = findobj('type', 'figure', 'name', 'Scores');
close(figHandles);
plots{1} = 'Scores';
plots{2} = figure('WindowStyle', 'docked','Name','Scores','NumberTitle', 'off');

layout = tiledlayout(5,1,'Padding','tight','TileSpacing','tight');

% Generate top plot of Scores figure
nexttile(layout,[1 1]);
% Plot the total scores of each parameter array to test
scatter(stg.pat,[rst(stg.pat).st],20,'filled')
ylabel('Total Score (s_t)', 'FontSize', Axis_FontSize, 'FontWeight', Axis_Fontweight)
set(gca,'xtick',[])
% set(gca,'FontSize',10,'Fontweight','bold')

% Choose correct title according to settings
title_texts = ["Sum of the Log base 10 of the Score of each Experimental Output", ...
               "Sum of the Log base 10 of the Score of each Experiment", ...
               "Log base 10 of sum of the Score of all Experiments", ...
               "Sum of the Score of all Experiments"];
title_text = title_texts(min(max(stg.useLog, 1), 4));
title(title_text,...
    "FontSize",Minor_title_FontSize,"FontWeight",Minor_title_Fontweight)

% Choose the bounds for the x axis so it aligns with the bottom plot
xlim([min(stg.pat)-0.5 max(stg.pat)+0.5])

% Generate bottom plot of figure 1
nexttile(layout,[4 1]);

% Generate labels for left of heatmap (Experiment number Dataset number)
label = arrayfun(@(n) strcat("E", num2str(n-1), " ", ...
    strrep(string(sbtab.datasets(n).output_name), "_", "\_")), ...
    stg.exprun, 'UniformOutput', false);
label = horzcat(label{:});

heatline = cell2mat(arrayfun(@(k) cell2mat(arrayfun(@(n) rst(k).sd(:, n)', ...
    stg.exprun, 'UniformOutput', false))', stg.pat, 'UniformOutput', false));

heatline( ~any(heatline,2), : ) = [];

% Plot the heatmap
h = heatmap(heatline,'Colormap',turbo,'YDisplayLabels',label,...
    'GridVisible','off','FontSize',7);
h.CellLabelFormat = '%.2e';

h.Title = "\fontsize{10} \bf Score of each Experimental Output (s_e)";
h.XLabel = '\fontsize{8} \bf Parameter sets (\theta)';
h.YLabel = '\fontsize{8} \bf Experimental Outputs';
end

function set_font_settings(font_settings)
font_settings_fields = fieldnames(font_settings);
for i = 1:numel(font_settings_fields)
    assignin('caller', font_settings_fields{i}, font_settings.(font_settings_fields{i}))
end
end