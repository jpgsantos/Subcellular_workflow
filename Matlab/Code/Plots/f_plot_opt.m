function f_plot_opt(rst,stg)

figHandles = findobj('type', 'figure', 'name', 'Optimization results');
close(figHandles);
figure('WindowStyle', 'docked','Name','Optimization results','NumberTitle', 'off');

hold on
for n = 1:size(rst.opt,2)
scatter(rst.opt(n).x,[1:stg.ms.parnum]+(0.05*n)-(0.05*(size(rst.opt,2)+1)/2),25,'filled','MarkerFaceAlpha',0.75)
end
scatter(stg.lb,[1:stg.ms.parnum],50,'x','k','MarkerFaceAlpha',0.75)
scatter(stg.ub,[1:stg.ms.parnum],50,'x','k','MarkerFaceAlpha',0.75)
for n = 2:size(rst.opt,2)
plot([min(stg.lb) max(stg.ub)],[n-0.5 n-0.5],'--k','Color', [0.5 0.5 0.5 0.5])
end
hold off

for n= 1:size(rst.opt,2)
    name{n} = char(string(rst.opt(n).name) + " ( Log10 of score = " + log10(rst.opt(n).fval) + " )");
end

legend({name{:},'Prior bounds'},'Fontweight','bold','location','best')
legend boxoff

xlabel('Log10 of parameter value','Fontweight','bold')
ylabel('Parameters','Fontweight','bold')

title("Best parameters after optimization",'FontSize', 18,'Fontweight','bold')

parNames = cell(1,stg.ms.parnum);

for n = 1:stg.ms.parnum
    parNames{n} = char("P" + find(stg.ms.partest==n));
end

for n = 1:size(parNames,2)
    if size(parNames{n},1) > 1 
        parNames{n} = parNames{n}(1,:);
    end
end

ax = gca;
set(gca,'ytick',[1:stg.ms.parnum],'yticklabel',parNames)
ax.YAxis.Limits = [0.5, stg.ms.parnum + 0.5];
ax.XAxis.Limits = [min(stg.lb) - 0.1, max(stg.ub) + 0.1];
end