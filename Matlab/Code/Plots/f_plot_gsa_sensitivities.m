function plots = f_plot_gsa_sensitivities(rst,stg,sbtab,font_settings)
% Generates figures for Sensitivity Analysis

%Font settings
set_font_settings(font_settings)

% Get the total number of outputs
[~,outputNames.sd] = f_get_outputs(stg,sbtab);

for n = 1:size(outputNames.sd,2)
    outputNames.sd{n}{:} = strrep(outputNames.sd{n}{:},"_","\_");
end
for n = stg.exprun
    outputNames.se{n} = "E " + string(n-1);
end

outputNames.xfinal = outputNames.sd;

parNames = cell(1,stg.parnum);
parNames2 = cell(1,stg.parnum);

for n = 1:stg.parnum
    parNames{n} = char("\theta_{" + find(stg.partest==n) + "}");
end

for n = 1:size(parNames,2)
    parNames2{n} = string(parNames{n}(1,:));
    for m = 2:size(parNames{n},1)
        parNames2{n} = string(parNames2{n}) + ", " +...
            string(parNames{n}(m,:));
    end
end

plot_sections = {
    % Bootstrapping quartile mean of first order Sensitivity index for
    % score per Experimental Output
    "Si seo bm", ...
    ["First order Sensitivities","calculated using the Score of each Experimental Output","(Bootstrapping Mean)"],...
    "outputNames.sd",...
    "transpose(reshape(mean(rst.SiQ.sd(:,:,1:stg.parnum)),[size(rst.SiQ.sd,2),size(rst.SiQ.sd,3)]))";
    % Bootstrapping quartile mean of total order Sensitivity index for
    % score per Experimental Output
    "SiT seo bm",...
    ["Total order Sensitivities"," calculated using the Score of each Experimental Output "," (Bootstrapping Mean)"],...
    "outputNames.sd",...
    "transpose(reshape(mean(rst.SiTQ.sd(:,:,1:stg.parnum)),[size(rst.SiQ.sd,2),size(rst.SiQ.sd,3)]))";
    % Bootstrapping quartile mean of first order Sensitivity index for
    % score per Experiments
    "Si se bm",...
    ["First order Sensitivities"," calculated using the Score of each Experiment","(Bootstrapping Mean)"],...
    "outputNames.se",...
    "transpose(reshape(mean(rst.SiQ.se(:,:,1:stg.parnum)),[size(rst.SiQ.se,2),size(rst.SiQ.se,3)]))";
    % Bootstrapping quartile mean of total order Sensitivity index for
    % score per Experiments
    "SiT se bm",...
    ["Total order Sensitivities"," calculated using the Score of each Experiment","(Bootstrapping Mean)"],...
    "outputNames.se",...
    "transpose(reshape(mean(rst.SiTQ.se(:,:,1:stg.parnum)),[size(rst.SiQ.se,2),size(rst.SiQ.se,3)]))";
    % Bootstrapping quartile mean of first order Sensitivity index for the
    % final points of the simulations for the output beeing measured
    "Si xfinal bm",...
    ["First order Sensitivities"," calculated using the final value of each Experimental Output","(Bootstrapping Mean)"],...
    "outputNames.xfinal",...
    "transpose(reshape(mean(rst.SiQ.xfinal(:,:,1:stg.parnum)),[size(rst.SiQ.xfinal,2),size(rst.SiQ.xfinal,3)]))";
    % Bootstrapping quartile mean of total order Sensitivity index for the
    % final points of the simulations for the output beeing measured
    "SiT xfinal bm",...
    ["Total order Sensitivities"," calculated using the final value of each Experimental Output","(Bootstrapping Mean)"],...
    "outputNames.xfinal",...
    "transpose(reshape(mean(rst.SiTQ.xfinal(:,:,1:stg.parnum)),[size(rst.SiQ.xfinal,2),size(rst.SiQ.xfinal,3)]))"
    };

for i = 1:size(plot_sections, 1)
    [plots{i,1},plots{i,2}] = f_generate_plot(rst, stg, outputNames, parNames2, plot_sections{i, 1}, plot_sections{i, 2}, plot_sections{i, 3}, plot_sections{i, 4},font_settings);
end

figHandles = findobj('type', 'figure', 'name', 'Si,SiT');
close(figHandles);
plots{7,1} = 'Si,SiT';
plots{7,2} = figure('WindowStyle', 'docked','Name','Si,SiT', 'NumberTitle', 'off');

layout = tiledlayout(1,1,'Padding','compact','TileSpacing','tight');
nexttile(layout)

for n = 1:size(parNames2,2)
    a{n} = char(parNames2{n});
end

a = categorical(a,a);

bar(a,[transpose(rst.Si.st(:,1:stg.parnum)),...
    transpose(rst.SiT.st(:,1:stg.parnum))])
set(gca,'FontSize', Axis_FontSize);
xlabel('Parameters','FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight);
ylabel('Sensitivity','FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight);
title(layout,['Sensitivities calculated using the sum of the Score of all Experiments'],'FontSize',Major_title_FontSize,'Fontweight',Major_title_Fontweight);
leg = legend({'Si','SiT'},'Location','best',...
    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight);
leg.ItemTokenSize = Legend_ItemTokenSize;
legend boxoff

figHandles = findobj('type', 'figure', 'name', 'Si,SiT b');
close(figHandles);
plots{8,1} = 'Si,SiT b';
plots{8,2} = figure('WindowStyle', 'docked','Name','Si,SiT b', 'NumberTitle', 'off');

layout = tiledlayout(1,1,'Padding','compact','TileSpacing','tight');
nexttile(layout)

T = [];

for n = 1:size(a,2)
    for m = 1:size(rst.SiQ.st(:,n),1)
        T = [T;table(rst.SiQ.st(m,n),a(n),"Si")];
    end
end
for n = 1:size(a,2)
    for m = 1:size(rst.SiTQ.st(:,n),1)
        T = [T;table(rst.SiTQ.st(m,n),a(n),"SiT")];
    end
end

boxchart(T.Var2,T.Var1,'GroupByColor',T.Var3,'MarkerStyle','.','JitterOutliers','on')
set(gca,'FontSize', Axis_FontSize);
xlabel('Parameters','FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight);
ylabel('Sensitivity','FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight);
title(layout,{'Sensitivities calculated using the sum of the Score of all Experiments ','(Bootstrapping)'},'FontSize',Major_title_FontSize,'Fontweight',Major_title_Fontweight);
leg = legend({'Si','SiT'},'Location','best',...
    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight);
leg.ItemTokenSize = Legend_ItemTokenSize;
legend boxoff
end

function [plots1,plots2] = f_generate_plot(rst,stg,outputNames,parNames2,name,major_title,...
    helprer1,helprer2,font_settings)
set_font_settings(font_settings)
figHandles = findobj('type', 'figure', 'name', name);
close(figHandles);
plots1 = name;
plots2 = figure('WindowStyle', 'docked','Name',name,'NumberTitle', 'off');

layout = tiledlayout(1,1,'Padding','compact','TileSpacing','tight');
nexttile(layout)

heatmap_fixer = eval(helprer1);
heatmap_fixer=heatmap_fixer(~cellfun('isempty',heatmap_fixer));

heatmap_fixer2 = eval(helprer2);
heatmap_fixer2 = heatmap_fixer2(:,all(~isnan(heatmap_fixer2)));

h = heatmap(heatmap_fixer,parNames2,heatmap_fixer2,'Colormap',turbo,...
    'ColorLimits',[0 1],'GridVisible','off',FontSize=Axis_FontSize);
h.CellLabelFormat = '%.2f';

title(layout,major_title,'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight);

% h.Title = title;
h.XLabel = '\fontsize{8} \bf Outputs';
h.YLabel = '\fontsize{8} \bf Parameters';
end
function set_font_settings(font_settings)
font_settings_fields = fieldnames(font_settings);
for i = 1:numel(font_settings_fields)
    assignin('caller', font_settings_fields{i}, font_settings.(font_settings_fields{i}))
end
end