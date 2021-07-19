function f_Reproduce_plot_sup_fig2(folder)
set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultAxesFontName', 'Times New Roman')

load(folder + "GSA_SiQ_sup_fig2.mat")
load(folder + "GSA_SiTQ_sup_fig2.mat")
% load(folder + "GSA_SiQ.mat")
% load(folder + "GSA_SiTQ.mat")

load(folder + "Analysis_sup_fig2_no_rst.mat")
% load(folder + "Analysis_without_rst.mat")

figHandles = findobj('type', 'figure', 'name', 'Paper supplementary Figure 2');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper supplementary Figure 2','NumberTitle',...
    'off');
layout = tiledlayout(2,1,'Padding','none','TileSpacing','tight');

layout.Units = 'inches';
layout.OuterPosition = [0 0 6.85 7];

parNames2 = cell(1,stg.parnum);

for n = 1:stg.parnum
    parNames{n} = char("K" + find(stg.partest==n));
end

for n = 1:size(parNames,2)
    parNames2{n} = string(parNames{n}(1,:));
    for m = 2:size(parNames{n},1)
        parNames2{n} = string(parNames2{n}) + ", " +...
            string(parNames{n}(m,:));
    end
end

for n = 1:size(parNames2,2)
    a{n} = char(parNames2{n});
end

% Supplementary figure 2A and B
layout2 = tiledlayout(layout,16,1,'TileSpacing','tight');
layout2.Layout.Tile = 1;
layout2.Layout.TileSpan = [1 1];

T1 = [];
T2 = [];
zeros = [4,6,7,8,9,10,11,16,17,19,20,24,26,28,29];
nonzeros = [1:29];

for n = 29:-1:1
    if ismember(n,zeros)
        nonzeros(n) = [];
    end
end

for n = 1:size(a,2)
    if ismember(n,zeros)
        for m = 1:size(SiQ.st(:,n),1)
            T2 = [T2;table(SiQ.st(m,n),categorical(a(n)),"Si")];
        end
    else
        for m = 1:size(SiQ.st(:,n),1)
            T1 = [T1;table(SiQ.st(m,n),categorical(a(n)),"Si")];
        end
    end
end
for n = 1:size(a,2)
    
end

% Supplementary figure 2A
nexttile(layout2,[10 1]);
hold on
boxchart(T1.Var2,T1.Var1,'GroupByColor',T1.Var3,'MarkerStyle','.')
b1 = bar (mean(SiQ.st(:,nonzeros)),0.5,'EdgeColor',[0 0.4470 0.7410],'FaceColor',[0 0.4470 0.7410]);
hold off
b1.FaceAlpha = 0.5;

title('S_i > 0','FontSize', 8,'Fontweight','bold')
ylabel('S_i','FontSize', 8,'Fontweight','bold')
set(gca,'FontSize',8, 'FontWeight', 'bold')
text(0.5-size(nonzeros,2)*0.045,max(ylim) + (max(ylim)-min(ylim))*0.1,'A','FontWeight','bold')
text(0.5-size(nonzeros,2)*0.045,min(ylim) - (max(ylim)-min(ylim))*0.15,'B','FontWeight','bold')

% Supplementary figure 2B
nexttile(layout2,[6 1]);

boxchart(T2.Var2,T2.Var1,'GroupByColor',T2.Var3,'MarkerStyle','.')

title('S_i ~ 0','FontSize', 8,'Fontweight','bold')
ylabel('S_i','FontSize', 8,'Fontweight','bold')
set(gca,'FontSize',8, 'FontWeight', 'bold')

% Supplementary figure 2C and D
layout3 = tiledlayout(layout,16,1,'TileSpacing','loose');
layout3.Layout.Tile = 2;
layout3.Layout.TileSpan = [1 1];

T3 = [];
T4 = [];

zeros = [4,6,7,8];
nonzeros = [1:29];

for n = 29:-1:1
    if ismember(n,zeros)
        nonzeros(n) = [];
    end
end

for n = 1:size(a,2)
    if ismember(n,zeros)
        for m = 1:size(SiTQ.st(:,n),1)
            T4 = [T4;table(SiTQ.st(m,n),categorical(a(n)),"SiT")];
        end
    else
        for m = 1:size(SiTQ.st(:,n),1)
            T3 = [T3;table(SiTQ.st(m,n),categorical(a(n)),"SiT")];
        end
    end
end

% Supplementary figure 2C
nexttile(layout3,[10 1]);

hold on
boxchart(T3.Var2,T3.Var1,'GroupByColor',T3.Var3,'MarkerStyle','.')
b1 = bar (mean(SiTQ.st(:,nonzeros)),0.5,'EdgeColor',[0 0.4470 0.7410],'FaceColor',[0 0.4470 0.7410]);
hold off
b1.FaceAlpha = 0.5;
title('S_T_i > 0','FontSize', 8,'Fontweight','bold')
ylabel('S_T_i','FontSize', 8,'Fontweight','bold')
ax = gca;

set(gca,'FontSize',8, 'FontWeight', 'bold')
text(0.5-size(nonzeros,2)*0.045,max(ylim) + (max(ylim)-min(ylim))*0.1,'C','FontWeight','bold')
text(0.5-size(nonzeros,2)*0.045,min(ylim) - (max(ylim)-min(ylim))*0.2,'D','FontWeight','bold')

% Supplementary figure 2D
nexttile(layout3,[6 1]);
hold on
boxchart(T4.Var2,T4.Var1,'GroupByColor',T4.Var3,'MarkerStyle','.')

title('S_T_i ~ 0','FontSize', 8,'Fontweight','bold')

ylabel('S_T_i','FontSize', 8,'Fontweight','bold')
ax = gca;
set(gca,'FontSize',8, 'FontWeight', 'bold')


exportgraphics(layout,...
    folder + "Supplementary figure 2.png",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "Supplementary figure 2.tiff",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "Supplementary figure 2.pdf",...
    'ContentType','vector')

end