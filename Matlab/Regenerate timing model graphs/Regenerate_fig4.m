load('Regenerate timing model graphs\old_data')
load('Regenerate timing model graphs\new_data')

figHandles = findobj('type', 'figure', 'name', 'Paper Figure 4');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper Figure 4','NumberTitle', 'off');
fig4 = tiledlayout(1,2,'Padding','none','TileSpacing','compact');

nexttile;
% subplot(1,2,1)
hold on
plot(new_data{1}(:,1), new_data{1}(:,2)/max(new_data{1}(:,2)), '-.k', 'LineWidth', 1)
plot(old_data{1}(:,1), old_data{1}(:,2)/max(old_data{1}(:,2)), '-.r', 'LineWidth', 1)
plot(new_data{2}(:,1), new_data{2}(:,2)/max(new_data{1}(:,2)),'k', 'LineWidth', 1)
plot(old_data{2}(:,1), old_data{2}(:,2)/max(old_data{1}(:,2)),'r', 'LineWidth', 1)
set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
legend({'Ca only (new)', 'Ca only (original)','Ca + Da (\Deltat=1s) (new)','Ca + Da (\Deltat=1s) (original)'},'FontSize',6.5);
legend boxoff
title('A','position',[-1.875 3.04])

nexttile;
% subplot(1,2,2)
hold on
plot(new_data{3}(:,1), new_data{3}(:,2),'k', 'LineWidth', 1)
plot(old_data{3}(:,1), old_data{3}(:,2),'r', 'LineWidth', 1)
plot([-4 4], [1 1], '--k', 'LineWidth', 1)
plot([0 0], [0 max(max(new_data{3}(:,2)),max(old_data{3}(:,2)))], '-.', 'LineWidth', 1, 'Color', [0.5 0.5 0.5])
set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel('\Deltat (s)');
ylabel(" Substrate phosphorylation");
legend({'Ca + Da (new)','Ca + Da (original)'},'location','northwest','FontSize',6.5);
legend boxoff
title('B','position',[-4.5 4.06])

%Only saves the graph if running matlab 2020a or later
[majorversion, minorversion] = mcrversion;
if majorversion >= 9
    if minorversion >= 8
        
        fig4.Units = 'inches';
        fig4.OuterPosition = [0 0 6.5 2.15];
        
        if ispc
            exportgraphics(fig4,'Regenerate timing model graphs\Figure 4.png','Resolution',600)
        else
            exportgraphics(fig4,'Regenerate timing model graphs/Figure 4.png','Resolution',600)
        end
        
        fig4.Units = 'normalized';
        fig4.OuterPosition = [0 0 1 1];
    end
end