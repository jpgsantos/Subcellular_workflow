function plots = f_plot_lsa(rst,stg)

%Font settings
Letter_FontSize = 10;
Letter_Fontweight = 'bold';
Axis_FontSize = 8;
Axis_Fontweight = 'bold';
Minor_title_FontSize = 10;
Minor_title_Fontweight = 'bold';
Major_title_FontSize = 12;
Major_title_Fontweight = 'bold';
Major_Title_Spacing = 2;
Legend_FontSize = 8;
Legend_Fontweight = 'bold';
Legend_ItemTokenSize = [20,18];
line_width = 1;

figHandles = findobj('type', 'figure', 'name', 'Local SA');
close(figHandles);
plots{1} = 'Local SA';
plots{2} = figure('WindowStyle', 'docked','Name', 'Local SA', 'NumberTitle', 'off');
layout = tiledlayout(1,1,'Padding','compact','TileSpacing','tight');
nexttile(layout)

X = categorical(convertStringsToChars("\theta_{" + [1:stg.parnum] + "}"));
X = reordercats(X,convertStringsToChars("\theta_{" + [1:stg.parnum] + "}"));
h = bar(X,transpose([[rst.average_deviation];[rst.sigma_deviation]]) ...
    ,'EdgeColor','k','LineWidth',1,'FaceColor','w');
LineArray={ '-' , ':' };

for k=1:2
  set(h(k),'LineStyle',LineArray{k});
end
set(gca,'FontSize',Axis_FontSize);

title(layout,"Local sensitivity Analysis",'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight);
% t2.FontSize = Major_Title_Spacing;

Lgnd = legend({'\mu_{deviation}','\sigma_{deviation}'},'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
    'Location','best','Box','off');
% legend boxoff

% Lgnd = legend(p1,...
%     'Orientation','horizontal', ...
%     'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
%     'Location','layout','Box','off');
% Lgnd.Layout.Tile = 'South';
Lgnd.ItemTokenSize = Legend_ItemTokenSize;
end