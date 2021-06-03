function f_plot_scores(rst,stg,sbtab)
set(0,'defaultTextFontName', 'Helvetica')
set(0,'defaultAxesFontName', 'Helvetica')

% Generates a figure with Scores

% Inform the user that fig1 is being ploted
disp("Plotting Scores")

%Closes previous instances of the figure and generates a new one
figHandles = findobj('type', 'figure', 'name', 'Scores');
close(figHandles);
figure('WindowStyle', 'docked','Name','Scores','NumberTitle', 'off');

% Generate top plot of figure 1
subplot(4,1,1)

% Plot the total scores of each parameter array to test
scatter(stg.pat,[rst(stg.pat).st],20,'filled')
ylabel('Total Score')
set(gca,'xtick',[])
set(gca,'FontSize',10,'Fontweight','bold')

% Choose correct title according to settings
if stg.useLog == 1
    title("Sum of the Log base 10 of the Score of each Experimental Output")
elseif stg.useLog == 2
    title("Sum of the Log base 10 of the Score of each Experiment")
elseif stg.useLog == 3
    title("Log base 10 of sum of the Score of all Experiments")
elseif stg.useLog == 4 || stg.useLog == 0
    title("Sum of the Score of all Experiments")
end

% Choose the bounds for the x axis so it aligns with the bottom plot
xlim([min(stg.pat)-0.5 max(stg.pat)+0.5])

% Generate bottom plot of figure 1
subplot(4,1,[2,3,4])

% Generate labels for left of heatmap (Experiment number Dataset number)
label = [];

% Iterate over the number of experiments
for n = stg.exprun
    
    % Iterate over the number of datasets in each experiment
    for j = 1:size(sbtab.datasets(n).output,2)
        label{size(label,2)+1} = {strrep("E" + (n-1) + " " + ...
            string(rst(max(stg.pat)).simd{1,n}.DataNames(...
            end-size(sbtab.datasets(n).output,2)+j)),"_","\_")};
    end
end

% Choose wether to use the score of each dataset or its log base 10
% according to settings
% if stg.useLog == 1 || stg.useLog == 4
heatline = [];

% Iterate over the number of parameter arrays to test
for k = stg.pat
    heatpoint{k} = [];
    
    % Iterate over the number of experiments
    for n = stg.exprun
        
        % Get the score of each dataset
        heatpoint{k} = [heatpoint{k},rst(k).sd{n,1}];
    end
    
    % Combine heatpoints in order to correctly display heatmap
    heatline = [heatline;heatpoint{k}];
end

% Plot the heatmap
h = heatmap(transpose(heatline),'Colormap',turbo,'YDisplayLabels',label,...
    'GridVisible','off','FontSize',10);
h.CellLabelFormat = '%.2e';

title("Score of each Experimental Output")
h.XLabel = 'Parameter arrays being tested';
h.YLabel = 'Experimental Outputs';

end