function f_plot_PL(rst,stg,mmf)

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

fig_n = 0;
plot_n = 1;
layout = [];
% stg.pltest = [1,2,9];
for m = stg.pltest
    
    % Generate the right amount of figures for all plots and calculates
    % proper subploting position
    [fig_n,layout] = f_get_subplot(size(stg.pltest,2),plot_n,fig_n,"Parameter Profile Likelihood",layout);
    nexttile(layout);

    
    % Add a legend to the figure
    if mod(plot_n,24) == 1
        Lgnd = legend('show','Orientation','Horizontal');
%         Lgnd.Position(1) = 0;
%         Lgnd.Position(2) = 0.5;
        Lgnd.Layout.Tile = 'North';
        legend boxoff
    xlabel(layout,"$log_{10} \theta$", 'FontSize', 12,'Fontweight','bold','Interpreter','latex')
%     layout.XLabel.String = 'My x-Axis Label';
%     layout.XLabel.FontSize = 14;
    ylabel(layout,"-2 PL", 'FontSize', 12,'Fontweight','bold','Interpreter','latex')
%     title(layout,"Profile Likelihood", 'FontSize', 16,'Fontweight','bold')
    end
    
    plot_n = plot_n + 1;
    
    hold on
    
    % Check if there are results from PL function
    if isfield(rst,'PLA')
        % If there are PL results from simulated annealing plot them
        if isfield(rst.PLA,'sa')
            plot(stg.lb(m):(stg.ub(m)-stg.lb(m))/stg.plres:stg.ub(m),...
                [rst.PLA.sa.fvalt{m}],'DisplayName','Total score sa','LineWidth',1.5,'color','k')
            minfval = min(rst.PLA.sa.fvalt{m});
        end
        
        % If there are PL results from fmincon plot them
        if isfield(rst.PLA,'fm')
            plot(stg.lb(m):(stg.ub(m)-stg.lb(m))/stg.plres:stg.ub(m),...
                [rst.PLA.fm.fvalt{m}],'DisplayName','Total score fmincon','LineWidth',1.5,'color','k')
            minfval = min(rst.PLA.fm.fvalt{m});
        end
%         for j = stg.exprun
%         if isfield(rst.PLA,'sa')
%             plot(stg.lb(m):(stg.ub(m)-stg.lb(m))/stg.plres:stg.ub(m),...
%                 [rst.PLA.sa.fval{j}{m}],'DisplayName',"score E" + j + "sa",'LineWidth',1)
% %             minfval2 = min(rst.PLA.sa.fval{j}{m});
%         end
%         
%         % If there are PL results from fmincon plot them
%         if isfield(rst.PLA,'fm')
%             plot(stg.lb(m):(stg.ub(m)-stg.lb(m))/stg.plres:stg.ub(m),...
%                 [rst.PLA.fm.fval{j}{m}],'DisplayName',"score E" + j + "fmincon",'LineWidth',1)
% %             minfval3 = min(rst.PLA.fm.fval{j}{m});
%         end
%         end
    end
%     xlabel("log_{10} pval", 'FontSize', 12,'Fontweight','bold')
%     ylabel("-2 PL", 'FontSize', 12,'Fontweight','bold')
%     yline(icdf('chi2',0.90,1),'DisplayName','icdf(\chi^2,0.90)')
    yline(icdf('chi2',0.95,1)+minfval,'DisplayName','Total score icdf($\chi^2,0.95$)')
%     yline(icdf('chi2',0.99,1),'DisplayName','icdf(\chi^2,0.99)')
    
    % If it exists in settings plot the best parameter value
    if isfield(stg,'bestpa')
        scatter(stg.bestpa(m),best_score,20,'filled',...
            'DisplayName','best $\theta$','MarkerFaceColor','k')
    end
    
    % If it exists in results plot the parameters run in diagnostics
    if isfield(rst,'diag')
        scatter(stg.pa(stg.pat,m),[rst.diag(stg.pat).st],...
            10,'filled','DisplayName','$\theta$ test')
    end
    
    hold off
    xlim([stg.lb(m) stg.ub(m)])
    ylim([0 icdf('chi2',0.95,1)+max(minfval)+0.5])
   
    titlestring = "$\theta_{" + find(stg.partest==m)+"}$";
%     for n = 1:size(titlestring,1)
%         if n == 1
            titlestring2 = titlestring(1);
%         else
%             titlestring2 = append(titlestring2,",",titlestring(n));
%         end
%     end

    
%     transpose("\theta_{" + find(stg.partest==m)+"}")
%     "\theta_{" + find(stg.partest==m)+"}"
    % Add a title to each plot
    title(titlestring2)
%     legend('Location','South')

end
end