function plots = f_plot_lsa(rst,stg,font_settings)

%Font settings
set_font_settings(font_settings)

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

Lgnd = legend({'\mu_{deviation}','\sigma_{deviation}'},'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
    'Location','best','Box','off');

Lgnd.ItemTokenSize = Legend_ItemTokenSize;
end

function set_font_settings(font_settings)
fields = fieldnames(font_settings);
for i = 1:numel(fields)
    assignin('caller', fields{i}, font_settings.(fields{i}))
end
end