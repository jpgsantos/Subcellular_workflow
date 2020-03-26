function f_plot_scores(rst,stg,sbtab)

% Inform the user that fig1 is being ploted
disp("Plotting fig1")

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
        title("scores total (sum of log10 of datasets)")
    elseif stg.useLog == 2
        title("scores total (sum of log10 of experiments)")
    elseif stg.useLog == 3
        title("scores total log10")
    end
else
    
    % Plot the log base 10 of the total scores of each parameter array to
    % test
    scatter(stg.pat,log10([rst(stg.pat).st]),10,'filled')
    
    title("scores total log10")
end

% Choose the bounds for the x axis so it aligns with the bottom plot
xlim([min(stg.pat)-0.5 max(stg.pat)+0.5])

% Generate bottom plot of figure 1
subplot(4,1,[2,3,4])

% Generate labels for left of heatmap (Experiment number Dataset number)
label = [];
% Iterate over the number of experiments
for n = stg.ms.exprun
    
    % Iterate over the number of datasets in each experiment
    for j = 1:size(sbtab.datasets(n).output,2)
        label{size(label,2)+1} = {"E" + (n-1) + " " + ...
            string(rst(max(stg.pat)).simd{1,n}.DataNames(...
            end-size(sbtab.datasets(n).output,2)+j))};
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
        for n = stg.ms.exprun
            
            % Get the score of each dataset
            heatpoint{k} = [heatpoint{k},rst(k).sd{n,1}];
        end
        
        % Combine heatpoints in order to correctly display heatmap
        heatline = [heatline;heatpoint{k}];
    end
    
    % Plot the heatmap
    heatmap(transpose(heatline),'Colormap',jet,'YDisplayLabels',label);

    title("scores per experiment (sum of log10 of datasets)")
    
else
    heatline = [];
    
    % Iterate over the number of parameter arrays to test
    for k = stg.pat
        heatpoint{k} = [];
        
        % Iterate over the number of experiments
        for n = stg.ms.exprun
            
            % Get the log base 10 of the score of each dataset
            heatpoint{k} = [heatpoint{k},log10(rst(k).sd{n,1})];
        end
        
        % Combine heatpoints in order to correctly display heatmap
        heatline = [heatline;heatpoint{k}];
    end
    
    % Plot the heatmap
    heatmap(transpose(heatline),'Colormap',jet,'YDisplayLabels',label);
    
    title("scores per experiment log10")
end
end