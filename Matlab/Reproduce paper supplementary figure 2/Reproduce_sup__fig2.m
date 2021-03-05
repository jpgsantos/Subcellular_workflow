clear
set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultAxesFontName', 'Times New Roman')

load("Reproduce paper supplementary figure 2/GSA_SI.mat")
load("Reproduce paper supplementary figure 2/GSA_SIT.mat")

figHandles = findobj('type', 'figure', 'name', 'Paper supplementary Figure 2');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper supplementary Figure 2','NumberTitle',...
    'off');
layout = tiledlayout(1,5,'Padding','none','TileSpacing','compact');

layout.Units = 'inches';
layout.OuterPosition = [0 0 6.85 3];

layout2 = tiledlayout(layout,1,1,'TileSpacing','compact');
layout2.Layout.Tile = 1;
layout2.Layout.TileSpan = [1 4];

nexttile(layout2);

bar([transpose(SI.se),transpose(SIT.se)])
xlabel('Parameter')
ylabel('Sensitivities','FontSize', 8,'Fontweight','bold')
legend({'SI','SIT'},'Location','North');
legend boxoff
ylim([0 0.8])
xlim([0 30])

text(-1,...
    max(ylim)+(max(ylim)-min(ylim))*0.3/5,...
    'A','fontsize',10,'FontWeight','bold');

ax = gca; 
ax.XAxis.FontSize = 10;
ax.FontSize = 10; 


xtickangle(45)
xticks([1:29])
xticklabels({'k34','k35','k36','k37','k38','k93','k94','k95','k99','k100',...
    'k101','k102','k103','k104','k105','k106','k107','k108','k109','k110',...
    'k111','k112','k113','k114','k115','k116','k117','k118','k119'})

layout3 = tiledlayout(layout,1,1,'TileSpacing','compact');
layout3.Layout.Tile = 5;
layout3.Layout.TileSpan = [1 1];

nexttile(layout3);

bar([sum(SI.st),sum(SIT.st)],'stacked')
xticklabels({'S_I','S_I_T'})
xtickangle(45)
ylabel('Sum of sensitivities','FontSize', 8,'Fontweight','bold')
ax = gca;
ax.XAxis.FontSize = 10;
ax.FontSize = 10;

text(min(xlim)-(max(xlim)-min(xlim))*3/30,...
    max(ylim)+(max(ylim)-min(ylim))*0.3/5,...
    'B','fontsize',10,'FontWeight','bold');

%Saves the graphs if running matlab 2020a or later
if f_check_minimum_version(9,8)
    
    exportgraphics(layout,...
        'Reproduce paper supplementary figure 2/Supplementary figure 2.png',...
        'Resolution',600)
    
    exportgraphics(layout,...
        'Reproduce paper supplementary figure 2/Supplementary figure 2.tiff',...
        'Resolution',600)
    
    exportgraphics(layout,...
        'Reproduce paper supplementary figure 2/Supplementary figure 2.pdf',...
        'ContentType','vector')
end