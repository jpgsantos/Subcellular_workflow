function f_plot_opt(rst,stg)
% Generates a figure with optimization results

figHandles = findobj('type', 'figure', 'name', 'Optimization results');
close(figHandles);
figure('WindowStyle', 'docked','Name','Optimization results','NumberTitle', 'off');

n_opt_done = 0;
for n = 1:size(rst.opt,2)
    if ~isempty(rst.opt(n).x)
        for a = 1:size(rst.opt(n).x,1)
            n_opt_done = n_opt_done+1;
        end
    end
end

hold on
m = 0;
for n = 1:size(rst.opt,2)
    if ~isempty(rst.opt(n).x)
        for a = 1:size(rst.opt(n).x,1)
            m = m+1;
            scatter(rst.opt(n).x(a,:),[1:stg.parnum]+(0.05*m)-(0.05*(n_opt_done+1)/2),25,'filled','MarkerFaceAlpha',0.75)
            scatter(stg.bestpa,[1:stg.parnum],25,'filled','MarkerFaceAlpha',0.75)
            
            name{m} = char(string(rst.opt(n).name) + " ( Score = " + rst.opt(n).fval(a) + " )");
        end
    end
end
scatter(stg.lb,[1:stg.parnum],50,'x','k','MarkerFaceAlpha',0.75)
scatter(stg.ub,[1:stg.parnum],50,'x','k','MarkerFaceAlpha',0.75)
for n = 2:stg.parnum
    plot([min(stg.lb) max(stg.ub)],[n-0.5 n-0.5],'--k','Color', [0.5 0.5 0.5 0.5])
end
hold off

legend([name(:)' 'Previous best pa' 'Prior bounds'],'Fontweight','bold','location','best')
legend boxoff

xlabel('Log10 of parameter value','Fontweight','bold')
ylabel('Parameters','Fontweight','bold')

title("Best parameters after optimization",'FontSize', 18,'Fontweight','bold')

parNames = cell(1,stg.parnum);

for n = 1:stg.parnum
    parNames{n} = char("P" + find(stg.partest==n));
end

for n = 1:size(parNames,2)
    if size(parNames{n},1) > 1
        parNames{n} = parNames{n}(1,:);
    end
end

ax = gca;
set(gca,'ytick',[1:stg.parnum],'yticklabel',parNames)
ax.YAxis.Limits = [0.5, stg.parnum + 0.5];
ax.XAxis.Limits = [min(stg.lb) - 0.1, max(stg.ub) + 0.1];
end