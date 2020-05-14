function f_plot_SA_sensitivities(rst,stg)

% Get the total number of outputs
[~,outputNames] = f_get_outputs(stg);

parNames = cell(1,stg.ms.parnum);

for n = 1:stg.ms.parnum
    parNames{n} = char("P" + find(stg.ms.partest==n));
end

figHandles = findobj('type', 'figure', 'name', 'SA SI');
close(figHandles);
figure('WindowStyle', 'docked','Name','SA SI','NumberTitle', 'off');

% Workaround!!
for n = 1:size(parNames,2)
    if size(parNames{n},1) > 1 
        parNames{n} = parNames{n}(1,:);
    end
end

h1 = heatmap(outputNames,parNames,transpose(rst.SI(:,1:stg.ms.parnum)),...
    'Colormap',jet);

h1.Title = "SI";
h1.XLabel = 'Outputs';
h1.YLabel = 'Parameters';

figHandles = findobj('type', 'figure', 'name', 'SA SIT');
close(figHandles);
figure('WindowStyle', 'docked','Name','SA SIT','NumberTitle', 'off');

h2 = heatmap(outputNames,parNames,transpose(rst.SIT(:,1:stg.ms.parnum)),...
    'Colormap',jet);

h2.Title = "SIT";
h2.XLabel = 'Outputs';
h2.YLabel = 'Parameters';

figHandles = findobj('type', 'figure', 'name', 'SA SIT-SI');
close(figHandles);
figure('WindowStyle', 'docked','Name','SA SIT-SI','NumberTitle', 'off');

h3 = heatmap(outputNames,parNames,transpose(rst.SIT(:,1:stg.ms.parnum)-...
    rst.SI(:,1:stg.ms.parnum)),'Colormap',jet);

h3.Title = "SIT-SI";
h3.XLabel = 'Outputs';
h3.YLabel = 'Parameters';
end






