load('Reproduce paper figure 6/inputs')
load('Reproduce paper figure 6/copasi_data')
load('Reproduce paper figure 6/new_data')

figHandles = findobj('type', 'figure', 'name', 'Paper Figure 6');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper Figure 6','NumberTitle',...
    'off');
layout = tiledlayout(1,5,'Padding','none','TileSpacing','compact');

% Figure 4A
nexttile(layout,[1 2]);

hold on
plot (t,x,'LineWidth',1)
text(2.4,5300,'A','fontsize',10,'FontWeight','bold');
% title("\Deltat = 1 s",'FontSize', 8,'Fontweight','bold')
        set(gca,'FontSize',8,'Fontweight','bold')
        xlabel('time (s)','FontSize', 8,'Fontweight','bold')
        ylabel('nanomole/liter','FontSize', 8,'Fontweight','bold')
        % Add a legend to each plot
        legend(["Ca","Da"],'FontSize', 6.5,'Fontweight','bold')
        legend boxoff
        clear labelfig2
      
        ax = gca;
        ax.XLimSpec = 'Tight';
hold off
ylim([0 5000])
xlim([3 10])
%
        xticks([3,4,5,6,7,8,10])
        xticklabels({0,4,5,6,7,8,30})
        
text(9,50,'//','fontsize',12);
text(3.45,50,'//','fontsize',12);

layout2 = tiledlayout(layout,2,1,'TileSpacing','compact');
% fig4 = tiledlayout(1,2,'Padding','none','TileSpacing','compact');
layout2.Layout
layout2.Layout.Tile = 3;
layout2.Layout.TileSpan = [1,3];

nexttile(layout2);

hold on
plot(new_data{1}(:,1), new_data{1}(:,2)/max(new_data{1}(:,2)),...
    '-.k', 'LineWidth', 1)
plot(new_data{2}(:,1), new_data{2}(:,2)/max(new_data{1}(:,2)),...
    'k', 'LineWidth', 1)

plot(new_data{1}(:,1), new_data{1}(:,2)/max(new_data{1}(:,2)),...
    '-.r', 'LineWidth', 2)
plot(new_data{2}(:,1), new_data{2}(:,2)/max(new_data{1}(:,2)),...
    'r', 'LineWidth', 2)
plot(copasi_data{1}(:,1), copasi_data{1}(:,2)/max(copasi_data{1}(:,2)),...
    '-.','Color',[0 0 1], 'LineWidth', 1)
plot(copasi_data{2}(:,1), copasi_data{2}(:,2)/max(copasi_data{1}(:,2)),...
    'Color',[0 0 1], 'LineWidth', 1)
set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel('time (s)','FontSize',8);
ylabel('pSubstrate','FontSize',8);
legend({'Ca ',...
    'Ca + Da (\Deltat=1s)'},...
    'FontSize',6.5);
legend boxoff
text(-1.875,2.85,'B','fontsize',10,'FontWeight','bold');
% title('B','position',[-1.875 2.6])
hold off

ylim ([0 2.5])

nexttile(layout2);

hold on
plot(new_data{3}(:,1), new_data{3}(:,2),'r', 'LineWidth', 1.5)
plot(copasi_data{3}(:,1), copasi_data{3}(:,2),'b', 'LineWidth', 1)
plot([-4 4], [1 1], '--k', 'LineWidth', 1)
plot([0 0], [0 max(max(copasi_data{3}(:,2)),max(new_data{3}(:,2)))], '-.',...
    'LineWidth', 1, 'Color', [0.5 0.5 0.5])
set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel('\Deltat (s)','FontSize',8);
ylabel("pSubstrate",'FontSize',8);
% legend({'Ca + Da','Ca + Da'},'location','northwest','FontSize',6.5);
% legend boxoff
text(-4.5,3.42,'C','fontsize',10,'FontWeight','bold');
% title('C','position',[-4.5 3.12])
hold off

%Saves the graphs if running matlab 2020a or later
if f_check_minimum_version(9,8)
    layout.Units = 'inches';
    layout.OuterPosition = [0 0 6.85 3];
    
    pause (1)
     
    exportgraphics(layout,...
        'Reproduce paper figure 6/Figure 6 alt.png',...
        'Resolution',600)
%     
%     layout.Units = 'normalized';
%     layout.OuterPosition = [0 0 1 1];
end