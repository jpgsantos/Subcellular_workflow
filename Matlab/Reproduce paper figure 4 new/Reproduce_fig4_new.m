load("Reproduce paper figure 4 new/Analysis.mat")

figHandles = findobj('type', 'figure', 'name', 'Paper Figure 4');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper Figure 4','NumberTitle',...
    'off');
layout = tiledlayout(1,2,'Padding','none','TileSpacing','compact');

layout.Units = 'inches';
layout.OuterPosition = [0 0 6.85 3];

nexttile(layout);

bar(rst.SA.SI.se,'stacked')
% legend(["k216,k222","k217,k223","k218,k224","k219,k225",...
%     "k220,k226","k221,k227"],'FontSize', 6.5,'Fontweight','bold');
% legend boxoff

xticklabels({'E0','E1','E2','E3','E4','E5','E6','E7','E8','E9'})
xlabel('Outputs')

text(min(xlim)-(max(xlim)-min(xlim))*2/30,...
    max(ylim)+(max(ylim)-min(ylim))*0.3/5,...
    'A','fontsize',10,'FontWeight','bold');


nexttile(layout);

bar(rst.SA.SIT.se,'stacked')
legend(["k216, k222","k217, k223","k218, k224","k219, k225",...
    "k220, k226","k221, k227"],'FontSize', 7,'Fontweight','bold');
legend boxoff

xticklabels({'E0','E1','E2','E3','E4','E5','E6','E7','E8','E9'})
xlabel('Outputs')

text(min(xlim)-(max(xlim)-min(xlim))*2/30,...
    max(ylim)+(max(ylim)-min(ylim))*0.3/5,...
    'B','fontsize',10,'FontWeight','bold');

exportgraphics(layout,...
    'Reproduce paper figure 4 new/Figure 4.png',...
    'Resolution',600)