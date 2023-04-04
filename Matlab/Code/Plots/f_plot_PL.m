function plots = f_plot_PL(rst,stg,mmf,font_settings)

% Inform the user that fig4 is being ploted
disp("Plotting PL")

if isfield(stg,'bestpa')
    [best_score,~] = f_sim_score(stg.bestpa,stg,mmf);
end

% fig_n = 0;
% plot_n = 1;
% layout = [];

% for m = stg.pltest
%
%     % Generate the right amount of figures for all plots and calculates
%     % proper subploting position
%     [fig_n,layout] = f_get_subplot(size(stg.pltest,2),plot_n,fig_n,"Prediction Profile Likelihood",layout);
%     nexttile(layout);
%     if mod(plot_n,24) == 1
%         Lgnd = legend('show','Orientation','Horizontal');
% %         Lgnd.Position(1) = 0;
% %         Lgnd.Position(2) = 0.5;
%         Lgnd.Layout.Tile = 'North';
%         legend boxoff
%     xlabel(layout,"log_{10} pval", 'FontSize', 12,'Fontweight','bold')
% %     layout.XLabel.String = 'My x-Axis Label';
% %     layout.XLabel.FontSize = 14;
%     ylabel(layout,"-2 PL", 'FontSize', 12,'Fontweight','bold')
% %     title(layout,"Profile Likelihood", 'FontSize', 16,'Fontweight','bold')
%     end
%
%     plot_n = plot_n + 1;
%
%     hold on
%
%     % Check if there are results from PL function
%     if isfield(rst,'PLA')
%         % If there are PL results from simulated annealing plot them
%         if isfield(rst.PLA,'sa')
% %             for n = 1:20
% %                 plot(rst.PLA.sa.simdt{1,1}{1,n}.Time,rst.PLA.sa.simdt{1,1}{1,n}.Data(:,8))
% %             end
%
%
%
%             for n = 1:20
% %                 z(n,:) = zeros(1,size(Time(n,:),2))+rst.PLA.sa.fvalt{m}(n)
%                 if rst.PLA.sa.fvalt{m}(n) < 4
%                 Time(n,:) = rst.PLA.sa.simdt{1,1}{1,n}.Time;
%                 Data(n,:) = rst.PLA.sa.simdt{1,1}{1,n}.Data(:,8);
%                 z(n,:) = zeros(1,size(Time(n,:),2))+rst.PLA.sa.fvalt{m}(n);
%                 end
%
%             end
%
%             surf(Data(:,:),Time(:,:),z(:,:))
%             ylabel("Time", 'FontSize', 12,'Fontweight','bold')
%             xlabel("Data", 'FontSize', 12,'Fontweight','bold')
%             zlabel("-2 PL", 'FontSize', 12,'Fontweight','bold')
% %             plot(stg.lb(m):(stg.ub(m)-stg.lb(m))/stg.plres:stg.ub(m),...
% %                 [rst.PLA.sa.fvalt{m}],'DisplayName','sa T','LineWidth',1.5,'color','k')
% %             minfval = min(rst.PLA.sa.fvalt{m});
%         end
%     end
% end

%Font settings
set_font_settings(font_settings)

fig_n = 0;
plot_n = 0;
layout = [];
plots = [];
% stg.pltest = [1,2,9];

for m = stg.pltest
    % Generate the right amount of figures for all plots and calculates
    % proper subploting position
    [fig_n,layout,plots] = f_get_subplot(size(stg.pltest,2),plot_n,...
        fig_n,"Parameter Profile Likelihood",layout,plots);

    nexttile(layout);

    if mod(plot_n,12) == 1

        % Add a legend to the figure
        Lgnd = legend('show','Orientation','Horizontal','fontsize',Legend_FontSize);
        Lgnd.Layout.Tile = 'North';
        legend boxoff
        xlabel(layout,"log_{10} \theta",...
            'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
        ylabel(layout,"-2 PL",...
            'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
        title(layout,"Parameter Profile Likelihood",...
            'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight)

    end

    plot_n = plot_n +1;

    hold on

    % Check if there are results from PL function
    if isfield(rst,'PLA')
        % If there are PL results from simulated annealing plot them
        if isfield(rst.PLA,'sa')
            plot(stg.lb(m):(stg.ub(m)-stg.lb(m))/stg.plres:stg.ub(m),...
                [rst.PLA.sa.fvalt{m}],'DisplayName','Total score sa',...
                'LineWidth',1.5,'color',[0, 0, 1, 0.5])
            minfval = min(rst.PLA.sa.fvalt{m});
        end

        % If there are PL results from fmincon plot them
        if isfield(rst.PLA,'fm')
            plot(stg.lb(m):(stg.ub(m)-stg.lb(m))/stg.plres:stg.ub(m),...
                [rst.PLA.fm.fvalt{m}],'DisplayName','Total score fmincon',...
                'LineWidth',1.5,'color',[1, 0, 0, 0.5])
            minfval = min(rst.PLA.fm.fvalt{m});
        end
    end

    yline(icdf('chi2',0.95,1)+minfval,...
        'DisplayName','Total score icdf(\chi^2,0.95)')

    % If it exists in settings plot the best parameter value
    if isfield(stg,'bestpa')
        scatter(stg.bestpa(m),best_score,20,'filled',...
            'DisplayName','best \theta','MarkerFaceColor','k')
    end

    % If it exists in results plot the parameters run in diagnostics
    if isfield(rst,'diag')
        scatter(stg.pa(stg.pat,m),[rst.diag(stg.pat).st],...
            10,'filled','DisplayName','\theta test')
    end

    hold off
    xlim([stg.lb(m) stg.ub(m)])
    %     ylim([0 (icdf('chi2',0.95,1)+max(minfval)+0.5)*5])

    titlestring = "\theta_{" + find(stg.partest==m)+"}";
    % Add a title to each plot
    title(titlestring(1),'FontSize',Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight)
end
end

function set_font_settings(font_settings)
fields = fieldnames(font_settings);
for i = 1:numel(fields)
    assignin('caller', fields{i}, font_settings.(fields{i}))
end
end