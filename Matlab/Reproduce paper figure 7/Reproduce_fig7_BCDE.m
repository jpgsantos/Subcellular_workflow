load('Reproduce paper figure 7/auc')
load('Reproduce paper figure 7/inputs')

figHandles = findobj('type', 'figure', 'name', 'Paper Figure 7');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper Figure 7','NumberTitle',...
    'off');
layout = tiledlayout(2,2,'Padding','none','TileSpacing','compact');

layout.Units = 'inches';
layout.OuterPosition = [0 0 4.567 3];

% Figure 7A
nexttile(layout);

hold on
plot (t,Ca,'LineWidth',1)
plot (t,Da,'LineWidth',1)

xticks([3,4,5,6,8])
xticklabels({0,4,5,6,50})

yticks([0,1000,3000,5000])

text(7.25,50,'//','fontsize',12);

text(3.4,50,'//','fontsize',12);

set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (s)','FontSize', 8,'Fontweight','bold')
ylabel('nanomole/liter','FontSize', 8,'Fontweight','bold')

leg = legend(["Ca","DA"],'FontSize', 6.5,'Fontweight','bold');
leg.ItemTokenSize = [20,18];
legend boxoff
clear labelfig2

hold off
xlim ([3 8])
ylim ([0 5000])

text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'B','fontsize',10,'FontWeight','bold');

% Figure 7B
nexttile(layout);

hold on
plot (DA_start,integral/integral0,'Color',[1 0 0], 'LineWidth',1)

set(gca,'FontSize',8,'Fontweight','bold')

xlabel('\Deltat (s)','FontSize', 8,'Fontweight','bold')
ylabel('pSubstrate area','FontSize', 8,'Fontweight','bold')
plot([-4 4], [1 1], '--', 'LineWidth', 1,'Color', [0.5 0.5 0.5])
plot([0 0], [0 5], '-.',...
    'LineWidth', 1, 'Color', [0.5 0.5 0.5])
hold off
ylim ([0 5])
yticks([0,1,3,5])

text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'C','fontsize',10,'FontWeight','bold');

load('Reproduce paper figure 7/spine')

% Figure 7C
nexttile(layout);

hold on
plot (t,Ca,'Color',[0.7 0 0], 'LineWidth',1)
plot (t,DaCa,'Color',[0 0 0.7], 'LineWidth',1)
plot (t,CaDa,'Color',[0 0.7 0], 'LineWidth',1)
% title('Spine')
set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (ms)','FontSize', 8,'Fontweight','bold')
ylabel('Vspine (mV)','FontSize', 8,'Fontweight','bold')
hold off

xlim ([0 50])
leg = legend({'Ca','Ca + DA (\Deltat=-1s)','Ca + DA (\Deltat=1s)'},'FontSize', 6.5,'Fontweight','bold');
leg.ItemTokenSize = [20,18];
legend boxoff
text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'D','fontsize',10,'FontWeight','bold');

load('Reproduce paper figure 7/soma')

% Figure 7D
nexttile(layout);

hold on
plot (t,Ca,'Color',[0.7 0 0], 'LineWidth',1)
plot (t,DaCa,'Color',[0 0 0.7], 'LineWidth',1)
plot (t,CaDa,'Color',[0 0.7 0], 'LineWidth',1)
set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (ms)','FontSize', 8,'Fontweight','bold')
ylabel('Vsoma (mV)','FontSize', 8,'Fontweight','bold')
hold off
xlim ([0 50])
leg = legend({'Ca','Ca + DA (\Deltat=-1s)','Ca + DA (\Deltat=1s)'},'FontSize', 6.5,'Fontweight','bold');
leg.ItemTokenSize = [20,18];
legend boxoff
text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'E','fontsize',10,'FontWeight','bold');

%Saves the graphs if running matlab 2020a or later
if f_check_minimum_version(9,8)
    
    exportgraphics(layout,...
        'Reproduce paper figure 7/Figure 7_BCDE.png',...
        'Resolution',600)
    
    exportgraphics(layout,...
        'Reproduce paper figure 7/Figure 7_BCDE.tiff',...
        'Resolution',600)
    
    exportgraphics(layout,...
        'Reproduce paper figure 7/Figure 7_BCDE.pdf',...
        'ContentType','vector')  
end