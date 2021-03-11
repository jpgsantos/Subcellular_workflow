function f_Reproduce_sup__fig2_alt2(folder)
set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultAxesFontName', 'Times New Roman')

% load("Reproduce paper supplementary figure 2/GSA_Si.mat")
% load("Reproduce paper supplementary figure 2/GSA_SiT.mat")

load(folder + "GSA_SiQ.mat")
load(folder + "GSA_SiTQ.mat")
load(folder + "Analysis_without_rst.mat")

figHandles = findobj('type', 'figure', 'name', 'Paper supplementary Figure 2 Si and SiT');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper supplementary Figure 2 Si and SiT','NumberTitle',...
    'off');
layout = tiledlayout(2,1,'Padding','none','TileSpacing','none');

layout.Units = 'inches';
layout.OuterPosition = [0 0 6.85 7];
% layout.OuterPosition = [0 0 15 9];

% layout2 = tiledlayout(16,1,'Padding','none','TileSpacing','tight');

% layout2.Units = 'inches';
% layout2.OuterPosition = [0 0 6.85 7];


% nexttile(layout2);

% parNames = cell(1,stg.parnum);
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

% a = categorical(a,a);
layout2 = tiledlayout(layout,16,1,'TileSpacing','none');
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

% for n = 1:size(a,2)
%     for m = 1:size(SiTQ.st(:,n),1)
%  T = [T;table(SiTQ.st(m,n),a(n),"SiT")];
%     end
% end
% for n = 1:size(a,2)
%     for m = 1:size(SiTQ.st(:,n),1)
%  T = [T;table(SiTQ.st(m,n)-SiQ.st(m,n),a(n),"SiT-Si")];
%     end
% end


nexttile(layout2,[10 1]);
hold on
boxchart(T1.Var2,T1.Var1,'GroupByColor',T1.Var3,'MarkerStyle','.')
b1 = bar (mean(SiQ.st(:,nonzeros)),0.5,'EdgeColor',[0 0.4470 0.7410],'FaceColor',[0 0.4470 0.7410]);
hold off
b1.FaceAlpha = 0.5;

% legend({'Si'},'Location','best');
% legend boxoff
title('S_i > 0','FontSize', 8,'Fontweight','bold')
% xlabel('Importatnt parameters S_i > 0','FontSize', 8,'Fontweight','bold')
ylabel('S_i','FontSize', 8,'Fontweight','bold')
% ax = gca;
% ax.XAxis.FontSize = 8;
% ax.FontSize = 8;
set(gca,'FontSize',8, 'FontWeight', 'bold')
text(0.5-size(nonzeros,2)*0.045,max(ylim) + (max(ylim)-min(ylim))*0.1,'A','FontWeight','bold')
text(0.5-size(nonzeros,2)*0.045,min(ylim) - (max(ylim)-min(ylim))*0.15,'B','FontWeight','bold')

nexttile(layout2,[6 1]);

boxchart(T2.Var2,T2.Var1,'GroupByColor',T2.Var3,'MarkerStyle','.')


% legend({'Si'},'Location','best');
% legend boxoff
title('S_i ~ 0','FontSize', 8,'Fontweight','bold')
% xlabel('Unimportatnt parameters S_i ~ 0','FontSize', 8,'Fontweight','bold')
ylabel('S_i','FontSize', 8,'Fontweight','bold')
% ax = gca;
% ax.XAxis.FontSize = 8;
% ax.FontSize = 8;
set(gca,'FontSize',8, 'FontWeight', 'bold')
% text(0.5-size(zeros,2)*0.025,max(ylim) + (max(ylim)-min(ylim))*0.075,'B','FontWeight','bold')
% nexttile(layout3,);

% if f_check_minimum_version(9,8)
%     
%         exportgraphics(layout,...
%             'Reproduce paper supplementary figure 2/Supplementary figure 2 alt2_Si.png',...
%             'Resolution',600)
%     
%         exportgraphics(layout,...
%             'Reproduce paper supplementary figure 2/Supplementary figure 2 alt2_Si.tiff',...
%             'Resolution',600)
%     
%         exportgraphics(layout,...
%             'Reproduce paper supplementary figure 2/Supplementary figure 2 alt2_Si.pdf',...
%             'ContentType','vector')
% end

% figHandles = findobj('type', 'figure', 'name', 'Paper supplementary Figure 2 SiT');
% close(figHandles);
% figure('WindowStyle', 'docked','Name','Paper supplementary Figure 2 SiT','NumberTitle',...
%     'off');
% layout = tiledlayout(16,1,'Padding','none','TileSpacing','loose');
% layout.Units = 'inches';
% layout.OuterPosition = [0 0 6.85 4.5];


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

nexttile(layout3,[10 1]);

hold on
boxchart(T3.Var2,T3.Var1,'GroupByColor',T3.Var3,'MarkerStyle','.')
b1 = bar (mean(SiTQ.st(:,nonzeros)),0.5,'EdgeColor',[0 0.4470 0.7410],'FaceColor',[0 0.4470 0.7410]);
hold off
b1.FaceAlpha = 0.5;
% legend({'SiT'},'Location','best');
% legend boxoff
title('S_T_i > 0','FontSize', 8,'Fontweight','bold')
% xlabel('Important parameters S_T_i > 0','FontSize', 8,'Fontweight','bold')
ylabel('S_T_i','FontSize', 8,'Fontweight','bold')
ax = gca;
% ax.XAxis.FontSize = 8;
% ax.FontSize = 8;
set(gca,'FontSize',8, 'FontWeight', 'bold')
% 1-(1/size(nonzeros,2))*1
% max(ylim)
% max(ylim) + (max(ylim)-min(ylim))*0.075
text(0.5-size(nonzeros,2)*0.045,max(ylim) + (max(ylim)-min(ylim))*0.1,'C','FontWeight','bold')
text(0.5-size(nonzeros,2)*0.045,min(ylim) - (max(ylim)-min(ylim))*0.2,'D','FontWeight','bold')

nexttile(layout3,[6 1]);
hold on
boxchart(T4.Var2,T4.Var1,'GroupByColor',T4.Var3,'MarkerStyle','.')

% legend({'SiT'},'Location','best');
% legend boxoff
title('S_T_i ~ 0','FontSize', 8,'Fontweight','bold')
% xlabel('Unimportatnt parameters S_T_i ~ 0','FontSize', 8,'Fontweight','bold')
ylabel('S_T_i','FontSize', 8,'Fontweight','bold')
ax = gca;
% ax.XAxis.FontSize = 8;
% ax.FontSize = 8;
set(gca,'FontSize',8, 'FontWeight', 'bold')
% max(ylim)
% max(ylim) + (max(ylim)-min(ylim))*0.075
% 1-(1/size(zeros,2))*1
% text(0.5-size(zeros,2)*0.025,max(ylim) + (max(ylim)-min(ylim))*0.075,'D','FontWeight','bold')

% bar([transpose(Si.se),transpose(SiT.se)])
% % bar([transpose(SI.se)])
% xlabel('Parameter')
% ylabel('Sensitivities','FontSize', 8,'Fontweight','bold')
% legend({'S_i','S_i_T'},'Location','North');
% legend boxoff
% ylim([-inf 0.8])
% xlim([0 30])
%
% text(-1,...
%     max(ylim)+(max(ylim)-min(ylim))*0.3/5,...
%     'A','fontsize',10,'FontWeight','bold');
%
% ax = gca;
% ax.XAxis.FontSize = 10;
% ax.FontSize = 10;
%
%
% xtickangle(45)
% xticks([1:29])
% xticklabels({'k34','k35','k36','k37','k38','k93','k94','k95','k99','k100',...
%     'k101','k102','k103','k104','k105','k106','k107','k108','k109','k110',...
%     'k111','k112','k113','k114','k115','k116','k117','k118','k119'})
%
% layout3 = tiledlayout(layout,1,1,'TileSpacing','compact');
% layout3.Layout.Tile = 5;
% layout3.Layout.TileSpan = [1 1];
%
% nexttile(layout3);
%
% bar([sum(Si.st),sum(SiT.st)],'stacked')
% xticklabels({'S_i','S_i_T'})
% xtickangle(45)
% ylabel('Sum of sensitivities','FontSize', 8,'Fontweight','bold')
% ax = gca;
% ax.XAxis.FontSize = 10;
% ax.FontSize = 10;
%
% text(min(xlim)-(max(xlim)-min(xlim))*3/30,...
%     max(ylim)+(max(ylim)-min(ylim))*0.3/5,...
%     'B','fontsize',10,'FontWeight','bold');



%Saves the graphs if running matlab 2020a or later
% if f_check_minimum_version(9,8)
    
        exportgraphics(layout,...
            folder + "Supplementary figure 2 alt2_Si and SiT.png",...
            'Resolution',600)
    
        exportgraphics(layout,...
            folder + "Supplementary figure 2 alt2_Si and SiT.tiff",...
            'Resolution',600)
    
        exportgraphics(layout,...
            folder + "Supplementary figure 2 alt2_Si and SiT.pdf",...
            'ContentType','vector')
% end
end