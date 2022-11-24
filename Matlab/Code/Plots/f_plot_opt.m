function plots = f_plot_opt(rst,stg)
% Generates a figure with optimization results

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
colour = {[1 0 0],[0 1 0],[0 0 1],[1 0.75 0],[1 0 1],[0 0.75 1]};


figHandles = findobj('type', 'figure', 'name', 'Optimization results');
close(figHandles);
plots{1,1} = 'Optimization results';
plots{1,2} = figure('WindowStyle', 'docked','Name','Optimization results','NumberTitle', 'off');

layout = tiledlayout(1,1,'Padding','tight','TileSpacing','tight');

nexttile(layout,[1 1]);

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
        [B,I] = sort(rst.opt(n).fval);
%         for a = 1:size(rst.opt(n).x,1)
            m = m+1;
%             scatter([1:stg.parnum]+((0.8/n_opt_done)*m)-((0.8/n_opt_done)*(n_opt_done+1)/2),rst.opt(n).x(I(1),:),...
%                 20,'filled','MarkerFaceAlpha',0.5,'MarkerFaceColor',colour{n})
            scatter([1:stg.parnum]+((0.5/size(rst.opt,2))*m)-((0.5/size(rst.opt,2))*(size(rst.opt,2)+1)/2),rst.opt(n).x(I(1),:),...
                20,'filled','MarkerFaceAlpha',1,'MarkerFaceColor',colour{n})        
            name{m} = char(string(rst.opt(n).name) + " ( Score = " + rst.opt(n).fval(I(1)) + " )");
%         end
    end
end

scatter([1:stg.parnum],stg.bestpa,20,'k','filled','MarkerFaceAlpha',0.5)
scatter([1:stg.parnum],stg.lb,50,'x','k','MarkerFaceAlpha',0.75)
scatter([1:stg.parnum],stg.ub,50,'x','k','MarkerFaceAlpha',0.75)
for n = 2:stg.parnum
    plot([n-0.5 n-0.5],[min(stg.lb) max(stg.ub)],'--k','Color', [0.5 0.5 0.5 0.5])
end

hold off
% legend([name(:)' 'Previous best parameter set' 'Prior bounds'],'Fontweight','bold','location','best')
% legend boxoff

Lgnd = legend([name(:)' 'Previous best parameter set' 'Prior bounds'],...
    'Orientation','horizontal', ...
    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
    'Location','layout','Box','off');
Lgnd.Layout.Tile = 'South';
Lgnd.ItemTokenSize = Legend_ItemTokenSize;
Lgnd.NumColumns = 2;

ylabel('Log10 of parameter value','Fontweight',Axis_Fontweight,'FontSize',Axis_FontSize)
xlabel('Parameters','Fontweight',Axis_Fontweight,'FontSize',Axis_FontSize)

[~,t2] = title({"Best parameters after optimization", ...
    "  Seconds: " + stg.optt + "  Pop Size: " + stg.popsize + ...
    "  Multiple starts: " + stg.msts}," ",...
    'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight);
t2.FontSize = Major_Title_Spacing;
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
set(gca,'xtick',[1:stg.parnum],'xticklabel',parNames)
ax.XAxis.Limits = [0.5, stg.parnum + 0.5];
ax.YAxis.Limits = [min(stg.lb) - 0.1, max(stg.ub) + 0.1];


figHandles = findobj('type', 'figure', 'name', 'Optimization results 2');
close(figHandles);
plots{2,1} = 'Optimization results 2';
plots{2,2} = figure('WindowStyle', 'docked','Name','Optimization results 2','NumberTitle', 'off');

layout = tiledlayout(1,1,'Padding','compact','TileSpacing','tight');

nexttile(layout,[1 1]);

hold on
m = 0;

for n = 1:size(rst.opt,2)
    if ~isempty(rst.opt(n).x)
        B = sort(rst.opt(n).fval);
        for a = 1:size(rst.opt(n).x,1)
            %             m = m+1;
            if a == 1
                p1(n) = scatter(a+(0.5/size(rst.opt,2)*n)-(0.5/size(rst.opt,2)*(size(rst.opt,2)+1)/2),log10(B(a)),20,...
                    'filled','MarkerFaceAlpha',1,'MarkerFaceColor',colour{n},...
                    'DisplayName',char(string(rst.opt(n).name)));
                %            name{n} = char(string(rst.opt(n).name));

            else
                scatter(a+(0.5/size(rst.opt,2)*n)-(0.5/size(rst.opt,2)*(size(rst.opt,2)+1)/2),log10(B(a)),20,...
                    'filled','MarkerFaceAlpha',1,'MarkerFaceColor',colour{n})
            end
        end
    end

end

hold off
ylabel('Log_{10}(Score)','Fontweight',Axis_Fontweight,'FontSize',Axis_FontSize)
xlabel('Ordered Scores','Fontweight',Axis_Fontweight,'FontSize',Axis_FontSize)
[~,t2] = title({"Scores of parameter sets after optimization", ...
    "  Seconds: " + stg.optt + "  Pop Size: " + stg.popsize}," ",...
    'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight);
% t.Position(1)
% t.Position(2)
% t.Position(3)
% t.Position(2)= t.Position(2)
% t2.Position(2)= t2.Position(2)
% t.Position(2) = t.Position(2) + 0
t2.FontSize = Major_Title_Spacing;
% t.Margin
% t.Extent
% t.VerticalAlignment
% t.VerticalAlignment = 'middle'
ax = gca;
set(gca,'xtick',[1:size(rst.opt,2)])
Lgnd = legend(p1,...
    'Orientation','horizontal', ...
    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
    'Location','layout','Box','off');
Lgnd.Layout.Tile = 'South';
Lgnd.ItemTokenSize = Legend_ItemTokenSize;
Lgnd.NumColumns = 3;
end