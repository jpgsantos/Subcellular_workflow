load("Reproduce paper figure 5/Analysis.mat")

rst = rst.SA;

% Get the total number of outputs
[~,outputNames.sd] = f_get_outputs(stg);

for n = 1:size(outputNames.sd,2)
    outputNames.sd{n}{:} = strrep(outputNames.sd{n}{:},"_","\_");
end
for n = stg.exprun
    outputNames.se{n} = "E " + string(n);
end

outputNames.xfinal = outputNames.sd;

parNames = cell(1,stg.parnum);
parNames2 = cell(1,stg.parnum);

for n = 1:stg.parnum
    parNames{n} = char("P" + find(stg.partest==n));
end

for n = 1:size(parNames,2)
    parNames2{n} = string(parNames{n}(1,:));
    for m = 2:size(parNames{n},1)
        parNames2{n} = string(parNames2{n}) + ", " +...
            string(parNames{n}(m,:));
    end
end

figHandles = findobj('type', 'figure', 'name', 'SA SI');
close(figHandles);
figure('WindowStyle', 'docked','Name','SA SI','NumberTitle', 'off');

h1 = heatmap(outputNames.se,parNames2,transpose(rst.SI.se(:,1:stg.parnum)),...
    'Colormap',jet,'FontSize',8);

h1.Title = "SI";
h1.XLabel = 'Outputs';
h1.YLabel = 'Parameters';

% Saves the graphs if running matlab 2020a or later
if f_check_minimum_version(9,8)
    h1.Units = 'inches';
    h1.OuterPosition = [0 0 3.55 2.5];

    exportgraphics(h1,...
        'Reproduce paper figure 5/Figure 5_1.png',...
        'Resolution',600)
end

figHandles = findobj('type', 'figure', 'name', 'SA SIT');
close(figHandles);
figure('WindowStyle', 'docked','Name','SA SIT','NumberTitle', 'off');

h2 = heatmap(outputNames.se,parNames2,transpose(rst.SIT.se(:,1:stg.parnum)),...
    'Colormap',jet,'FontSize',8);

Ax = gca;
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));

h2.Title = "SIT";
h2.XLabel = 'Outputs';

% Saves the graphs if running matlab 2020a or later
if f_check_minimum_version(9,8)
    h2.Units = 'inches';
    h2.OuterPosition = [0 0 3.55 2.5];

    exportgraphics(h2,...
        'Reproduce paper figure 5/Figure 5_2.png',...
        'Resolution',600)
end

pause(5)
h1.Units = 'normalized';
h1.OuterPosition = [0 0 1 1];
h2.Units = 'normalized';
h2.OuterPosition = [0 0 1 1];


