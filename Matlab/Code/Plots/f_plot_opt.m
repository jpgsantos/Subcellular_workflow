function plots = f_plot_opt(rst,stg)
% Generates a figure with optimization results

%Font settings
set_font_settings(font_settings)

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
            m = m+1;
            scatter([1:stg.parnum]+((0.5/size(rst.opt,2))*m)-((0.5/size(rst.opt,2))*(size(rst.opt,2)+1)/2),rst.opt(n).x(I(1),:),...
                20,'filled','MarkerFaceAlpha',1,'MarkerFaceColor',colour{n})        
            name{m} = char(string(rst.opt(n).name) + " ( Score = " + rst.opt(n).fval(I(1)) + " )");

    end
end

scatter([1:stg.parnum],stg.bestpa,20,'k','filled','MarkerFaceAlpha',0.5)
scatter([1:stg.parnum],stg.lb,50,'x','k','MarkerFaceAlpha',0.75)
scatter([1:stg.parnum],stg.ub,50,'x','k','MarkerFaceAlpha',0.75)
for n = 2:stg.parnum
    plot([n-0.5 n-0.5],[min(stg.lb) max(stg.ub)],'--k','Color', [0.5 0.5 0.5 0.5])
end

hold off
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
b = 0;
for n = 1:size(rst.opt,2)
    if ~isempty(rst.opt(n).x)
        B = sort(rst.opt(n).fval);
        b = b +1;
        for a = 1:size(rst.opt(n).x,1)
            if a == 1
                p1(b) = scatter(a+(0.5/size(rst.opt,2)*n)-(0.5/size(rst.opt,2)*(size(rst.opt,2)+1)/2),log10(B(a)),20,...
                    'filled','MarkerFaceAlpha',1,'MarkerFaceColor',colour{n},...
                    'DisplayName',char(string(rst.opt(n).name)));

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

t2.FontSize = Major_Title_Spacing;
ax = gca;
set(gca,'xtick',[1:size(rst.opt,1)])
Lgnd = legend(p1,...
    'Orientation','horizontal', ...
    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
    'Location','layout','Box','off');
Lgnd.Layout.Tile = 'South';
Lgnd.ItemTokenSize = Legend_ItemTokenSize;
Lgnd.NumColumns = 3;
end

function set_font_settings(font_settings)
font_settings_fields = fieldnames(font_settings);
for i = 1:numel(font_settings_fields)
    assignin('caller', font_settings_fields{i}, font_settings.(font_settings_fields{i}))
end
end