function f_plot_lsa(rst,stg)

figHandles = findobj('type', 'figure', 'name', 'Local SA');
close(figHandles);
figure('WindowStyle', 'docked','Name', 'Local SA', 'NumberTitle', 'off');
layout = tiledlayout(1,1,'Padding','none','TileSpacing','compact');

X = categorical(convertStringsToChars("\theta_{" + [1:12] + "}"));
X = reordercats(X,convertStringsToChars("\theta_{" + [1:12] + "}"));
h = bar(X,transpose([[rst.average_deviation];[rst.sigma_deviation]]) ...
    ,'EdgeColor','k','LineWidth',1,'FaceColor','w');
LineArray={ '-' , ':' };

for k=1:2
  set(h(k),'LineStyle',LineArray{k});
end

title(layout,"Local sensitivity Analysis",'FontSize', 12,'Fontweight','bold','Interpreter','latex');
legend({'\mu_{deviation}','\sigma_{deviation}'});
legend boxoff
end