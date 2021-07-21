function f_Reproduce_plot_fig4(folder)
set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultAxesFontName', 'Times New Roman')

load(folder + "SA_results.mat",'rst')

set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultAxesFontName', 'Times New Roman')

figHandles = findobj('type', 'figure', 'name', 'Paper Figure 4');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper Figure 4','NumberTitle',...
    'off');
layout = tiledlayout(1,2,'Padding','none','TileSpacing','compact');

layout.Units = 'inches';
layout.OuterPosition = [0 0 6.85 3];

% Figure 4A
nexttile(layout);

bar(rst.gsa.Si.se(:,:),'stacked')

xticklabels({'E0','E1','E2','E3','E4','E5','E6','E7','E8','E9'})
set(gca,'FontSize',8,'Fontweight','bold')
xlabel('Outputs','FontSize', 8,'Fontweight','bold')
ylabel('S_I','FontSize', 8,'Fontweight','bold')
ylim([0 0.8])

text(min(xlim)-(max(xlim)-min(xlim))*3/30,...
    max(ylim)+(max(ylim)-min(ylim))*0.3/5,...
    'A','fontsize',10,'FontWeight','bold');

% Figure 4B
nexttile(layout);

bar(rst.gsa.SiT.se(:,:),'stacked')
legend(["k216, k222","k217, k223","k218, k224","k219, k225",...
    "k220, k226","k221, k227"],'FontSize', 7,'Fontweight','bold');
legend boxoff

xticklabels({'E0','E1','E2','E3','E4','E5','E6','E7','E8','E9'})
set(gca,'FontSize',8,'Fontweight','bold')
xlabel('Outputs','FontSize', 8,'Fontweight','bold')
ylabel('S_T_I','FontSize', 8,'Fontweight','bold')
ylim([0 2])

text(min(xlim)-(max(xlim)-min(xlim))*3/30,...
    max(ylim)+(max(ylim)-min(ylim))*0.3/5,...
    'B','fontsize',10,'FontWeight','bold');

%Saves the graphs
exportgraphics(layout,...
    folder + "Figure 4.png",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "Figure 4.tiff",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "Figure 4.pdf",...
    'ContentType','vector')
end