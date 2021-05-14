function f_plot_scores(rst,stg,sbtab)
% Generates a figure with Scores

% Inform the user that fig1 is being ploted
disp("Plotting Scores")

%Closes previous instances of the figure and generates a new one
figHandles = findobj('type', 'figure', 'name', 'Scores');
close(figHandles);
figure('WindowStyle', 'docked','Name','Scores','NumberTitle', 'off');

% Generate top plot of figure 1
subplot(4,1,1)

% Choose wether to use the total score or its log base 10 according to
% settings
if stg.useLog ~= 0
    
    % Plot the total scores of each parameter array to test
    scatter(stg.pat,[rst(stg.pat).st],10,'filled')
    
    % Choose correct title according to settings
    if stg.useLog == 1
        title("Total scores  (sum of log10 of scores per experimental output)")
    elseif stg.useLog == 2
        title("Total scores (sum of log10 of scores per experiments)")
    elseif stg.useLog == 3
        title("Log 10 of total scores")
    end
else
    
    % Plot the log base 10 of the total scores of each parameter array to
    scatter(stg.pat,[rst(stg.pat).st],10,'filled')

    title("Log 10 of total scores")
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
if stg.useLog == 1
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
    h = heatmap(transpose(heatline),'Colormap',jet,'YDisplayLabels',label);
    
    title("Log10 of scores per experimental output")
    h.XLabel = 'Parameter arrays being tested';
    h.YLabel = 'Outputs';
    
else
    heatline = [];
    
    % Iterate over the number of parameter arrays to test
    for k = stg.pat
        heatpoint{k} = [];
        
        % Iterate over the number of experiments
        for n = stg.exprun
            
            % Get the log base 10 of the score of each dataset
            heatpoint{k} = [heatpoint{k},rst(k).sd{n,1}];
        end
        
        % Combine heatpoints in order to correctly display heatmap
        heatline = [heatline;heatpoint{k}];
    end
    
    % Plot the heatmap
    h = heatmap(transpose(heatline),'Colormap',jet,'YDisplayLabels',label);
    
    title("Log10 of scores per experimental output")
    h.XLabel = 'Parameter arrays being tested';
    h.YLabel = 'Outputs';
end
end