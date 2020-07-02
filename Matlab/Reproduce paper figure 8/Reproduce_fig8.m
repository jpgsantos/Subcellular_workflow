load('Reproduce paper figure 8/auc')
load('Reproduce paper figure 8/inputs')


figHandles = findobj('type', 'figure', 'name', 'Paper Figure 8');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper Figure 8','NumberTitle',...
    'off');
layout = tiledlayout(2,2,'Padding','none','TileSpacing','compact');

layout.Units = 'inches';
layout.OuterPosition = [0 0 4.567 3];

nexttile(layout);

hold on
plot (t,Ca,'LineWidth',1)
plot (t,Da,'LineWidth',1)
% plot([11 11], [0 5000], '--',...
%     'LineWidth', 1, 'Color', [0.5 0.5 0.5])

xticks([3,4,5,6,8])
xticklabels({0,4,5,6,50})
% xticks([3,4,6,8,10,11,13])
% xticklabels({0,4,6,8,10,11,50})


yticks([0,1000,3000,5000])

% text(3,5200,'A','fontsize',12);
% title("\Deltat = 1 s",'FontSize', 8,'Fontweight','bold')

text(7.25,50,'//','fontsize',12);
% text(11.75,50,'//','fontsize',12);


text(3.4,50,'//','fontsize',12);
% text(3.25,50,'//','fontsize',12);

set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (s)','FontSize', 8,'Fontweight','bold')
ylabel('nanomole/liter','FontSize', 8,'Fontweight','bold')
% Add a legend to each plot

leg = legend(["Ca","DA"],'FontSize', 6.5,'Fontweight','bold');
% leg = legend(["Ca","Da"],'FontSize', 6.5,'Fontweight','bold','Location','north');
leg.ItemTokenSize = [20,18];
legend boxoff
clear labelfig2


hold off
xlim ([3 8])
% xlim ([3 13])
ylim ([0 5000])

text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'B','fontsize',10,'FontWeight','bold');

nexttile(layout);

hold on
plot (DA_start,integral/integral0,'Color',[1 0 0], 'LineWidth',1)

% annotation('textarrow',[0.7 0.7], [0.8 0.75],'String','Soma','FontSize',8)
% title('A','position',[-1.875 5200])
set(gca,'FontSize',8,'Fontweight','bold')

xlabel('\Deltat (s)','FontSize', 8,'Fontweight','bold')
ylabel('pSubstrate area','FontSize', 8,'Fontweight','bold')
% Add a legend to each plot
% clear labelfig2
plot([-4 4], [1 1], '--', 'LineWidth', 1,'Color', [0.5 0.5 0.5])
plot([0 0], [0 5], '-.',...
    'LineWidth', 1, 'Color', [0.5 0.5 0.5])
hold off
ylim ([0 5])
yticks([0,1,3,5])
% legend('Ca','FontSize', 6.5,'Fontweight','bold')
% legend boxoff

text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'C','fontsize',10,'FontWeight','bold');

load('Reproduce paper figure 8/spine')

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


load('Reproduce paper figure 8/soma')

nexttile(layout);

hold on
plot (t,Ca,'Color',[0.7 0 0], 'LineWidth',1)
plot (t,DaCa,'Color',[0 0 0.7], 'LineWidth',1)
plot (t,CaDa,'Color',[0 0.7 0], 'LineWidth',1)
% title
% t1=text(5,5,'A','fontsize',12);
% title('Soma')
set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (ms)','FontSize', 8,'Fontweight','bold')
ylabel('Vsoma (mV)','FontSize', 8,'Fontweight','bold')
hold off
xlim ([0 50])
leg = legend({'Ca','Ca + DA (\Deltat=-1s)','Ca + DA (\Deltat=1s)'},'FontSize', 6.5,'Fontweight','bold');
leg.ItemTokenSize = [20,18];
legend boxoff
text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'E','fontsize',10,'FontWeight','bold');

exportgraphics(layout,...
    'Reproduce paper figure 8/Figure 8.png',...
    'Resolution',600)