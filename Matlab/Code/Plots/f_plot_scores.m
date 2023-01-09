function plots =f_plot_scores(rst,stg,sbtab)


%Font settings
Letter_FontSize = 10;
Letter_Fontweight = 'bold';
Axis_FontSize = 8;
Axis_Fontweight = 'bold';
Minor_title_FontSize = 10;
Minor_title_Fontweight = 'bold';
Major_title_FontSize = 12;
Major_title_Fontweight = 'bold';
Legend_FontSize = 8;
Legend_Fontweight = 'bold';
Legend_ItemTokenSize = [20,18];
line_width = 1;

% Generates a figure with Scores

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
ylabel('Total Score (s_t)','FontSize',Axis_FontSize,'FontWeight',Axis_Fontweight)
set(gca,'xtick',[])
% set(gca,'FontSize',10,'Fontweight','bold')

% Choose correct title according to settings
if stg.useLog == 1
    title_text = "Sum of the Log base 10 of the Score of each Experimental Output";
elseif stg.useLog == 2
    title_text ="Sum of the Log base 10 of the Score of each Experiment";
elseif stg.useLog == 3
    title_text ="Log base 10 of sum of the Score of all Experiments";
elseif stg.useLog == 4 || stg.useLog == 0
    title_text ="Sum of the Score of all Experiments";
end
title(title_text,...
    "FontSize",Minor_title_FontSize,"FontWeight",Minor_title_Fontweight)

% Choose the bounds for the x axis so it aligns with the bottom plot
xlim([min(stg.pat)-0.5 max(stg.pat)+0.5])

% Generate bottom plot of figure 1
% subplot(4,1,[2,3,4])
nexttile(layout,[4 1]);
% Generate labels for left of heatmap (Experiment number Dataset number)
label = [];

% Iterate over the number of experiments
for n = stg.exprun

    % Iterate over the number of datasets in each experiment
    for j = 1:size(sbtab.datasets(n).output,2)
        label{size(label,2)+1} = {strrep("E" + (n-1) + " " + ...
            string(sbtab.datasets(n).output_name{j}),"_","\_")};
    end
end
% Choose wether to use the score of each dataset or its log base 10
% according to settings
% if stg.useLog == 1 || stg.useLog == 4
heatline = [];

% Iterate over the number of parameter arrays to test
for k = stg.pat
%     k
    heatpoint{k} = [];

    % Iterate over the number of experiments
    for n = stg.exprun

        % Get the score of each dataset
        heatpoint{k} = [heatpoint{k};rst(k).sd(:,n)];

    end
    % Combine heatpoints in order to correctly display heatmap
    heatline = [heatline,heatpoint{k}];
end
heatline( ~any(heatline,2), : ) = [];

% Plot the heatmap
h = heatmap(heatline,'Colormap',turbo,'YDisplayLabels',label,...
    'GridVisible','off','FontSize',7);
h.CellLabelFormat = '%.2e';

h.Title = "\fontsize{10} \bf Score of each Experimental Output (s_e)";
h.XLabel = '\fontsize{8} \bf Parameter sets (\theta)';
h.YLabel = '\fontsize{8} \bf Experimental Outputs';

% h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
% h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
% % h.NodeChildren(3).ZAxis.Label.Interpreter = 'latex';
% h.NodeChildren(3).Title.Interpreter = 'latex';
% h.NodeChildren(3).TickLabelInterpreter = 'latex';
% h.NodeChildren(2).TickLabelInterpreter = 'latex';
% % h.NodeChildren(1).TickLabelInterpreter = 'latex';
% % h.NodeChildren(1).Label.Interpreter = 'Latex';
% % h.NodeChildren(2).Label.Interpreter = 'Latex';

end