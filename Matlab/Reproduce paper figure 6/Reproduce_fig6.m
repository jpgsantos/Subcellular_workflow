load('Reproduce paper figure 6/inputs')
load('Reproduce paper figure 6/copasi_data')
load('Reproduce paper figure 6/new_data')

figHandles = findobj('type', 'figure', 'name', 'Paper Figure 6');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper Figure 6','NumberTitle',...
    'off');
layout = tiledlayout(4,1,'Padding','none','TileSpacing','compact');

% Figure 4A
nexttile(layout);

hold on
plot (t,x,'LineWidth',1)
title('A','position',[-1.875 5200])
        set(gca,'FontSize',8,'Fontweight','bold')
        xlabel('time (s)','FontSize', 8,'Fontweight','bold')
        ylabel('nanomole/liter','FontSize', 8,'Fontweight','bold')
        % Add a legend to each plot
        legend(["Ca","Da"],'FontSize', 6.5,'Fontweight','bold')
        legend boxoff
        clear labelfig2
hold off


layout2 = tiledlayout(layout,2,1,'TileSpacing','none');
% fig4 = tiledlayout(1,2,'Padding','none','TileSpacing','compact');
layout2.Layout
layout2.Layout.Tile = 2;
layout2.Layout.TileSpan = [3,1];

nexttile(layout2);

hold on
plot(new_data{1}(:,1), new_data{1}(:,2)/max(new_data{1}(:,2)),...
    '-.r', 'LineWidth', 2)
plot(copasi_data{1}(:,1), copasi_data{1}(:,2)/max(copasi_data{1}(:,2)),...
    '-.b', 'LineWidth', 1)
plot(new_data{2}(:,1), new_data{2}(:,2)/max(new_data{1}(:,2)),...
    'r', 'LineWidth', 2)
plot(copasi_data{2}(:,1), copasi_data{2}(:,2)/max(copasi_data{1}(:,2)),...
    'b', 'LineWidth', 1)
set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel('time (s)','FontSize',8);
ylabel('pSubstrate','FontSize',8);
legend({'Ca only', 'Ca only',...
    'Ca + Da (\Deltat=1s)','Ca + Da (\Deltat=1s)'},...
    'FontSize',6.5);
legend boxoff
title('B','position',[-1.875 2.6])
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
legend({'Ca + Da','Ca + Da'},'location','northwest','FontSize',6.5);
legend boxoff
title('C','position',[-4.5 3.12])
hold off

%Saves the graphs if running matlab 2020a or later
if f_check_minimum_version(9,8)
    layout.Units = 'inches';
    layout.OuterPosition = [0 0 3 4.5];
    
    pause (1)
     
    exportgraphics(layout,...
        'Reproduce paper figure 6/Figure 6.png',...
        'Resolution',600)
%     
%     layout.Units = 'normalized';
%     layout.OuterPosition = [0 0 1 1];
end
