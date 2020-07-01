load('Reproduce paper figure 4/old_data')
load('Reproduce paper figure 4/new_data')

figHandles = findobj('type', 'figure', 'name', 'Paper Figure 4');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper Figure 4','NumberTitle',...
    'off');
fig4 = tiledlayout(1,2,'Padding','none','TileSpacing','compact');

% Figure 4A
nexttile;
hold on
plot(new_data{1}(:,1), new_data{1}(:,2)/max(new_data{1}(:,2)),...
    '-.k', 'LineWidth', 1)
plot(old_data{1}(:,1), old_data{1}(:,2)/max(old_data{1}(:,2)),...
    '-.r', 'LineWidth', 1)
plot(new_data{2}(:,1), new_data{2}(:,2)/max(new_data{1}(:,2)),...
    'k', 'LineWidth', 1)
plot(old_data{2}(:,1), old_data{2}(:,2)/max(old_data{1}(:,2)),...
    'r', 'LineWidth', 1)
set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
legend({'Ca only (new)', 'Ca only (original)',...
    'Ca + Da (\Deltat=1s) (new)','Ca + Da (\Deltat=1s) (original)'},...
    'FontSize',6.5);
legend boxoff
title('A','position',[-1.875 3.04])

% Figure 4B
nexttile;
hold on
plot(new_data{3}(:,1), new_data{3}(:,2),'k', 'LineWidth', 1)
plot(old_data{3}(:,1), old_data{3}(:,2),'r', 'LineWidth', 1)
plot([-4 4], [1 1], '--k', 'LineWidth', 1)
plot([0 0], [0 max(max(new_data{3}(:,2)),max(old_data{3}(:,2)))], '-.',...
    'LineWidth', 1, 'Color', [0.5 0.5 0.5])
set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel('\Deltat (s)');
ylabel(" Substrate phosphorylation");
legend({'Ca + Da (new)','Ca + Da (original)'},'location','northwest',...
    'FontSize',6.5);
legend boxoff
title('B','position',[-4.5 4.06])

%Saves the graphs if running matlab 2020a or later
if f_check_minimum_version(9,8)
    fig4.Units = 'inches';
    fig4.OuterPosition = [0 0 6.5 2.15];
    
    exportgraphics(fig4,...
        'Reproduce paper figure 4/Figure 4.png',...
        'Resolution',600)
    
    fig4.Units = 'normalized';
    fig4.OuterPosition = [0 0 1 1];
end