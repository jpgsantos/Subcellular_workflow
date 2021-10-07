function f_plot_PL(rst,stg)

% Inform the user that fig4 is being ploted
disp("Plotting PL")

if isfield(stg,'bestx')
[best_score,~] = f_sim_score(stg.bestx,stg);
end

fig_n = 0;
plot_n = 1;

for m = stg.pltest
    
    % Generate the right amount of figures for all plots and calculates
    % proper subploting position
    fig_n = f_get_subplot(size(stg.pltest,2),plot_n,fig_n,"Profile Likelihood");
    
    
    % Add a legend to the figure
    if mod(plot_n,24) == 1
        Lgnd = legend('show');
        Lgnd.Position(1) = 0;
        Lgnd.Position(2) = 0.5;
        legend boxoff
    end
    
    plot_n = plot_n + 1;
    
    hold on
    
    % Check if there are results from PL function
    if isfield(rst,'PLA')
        % If there are PL results from simulated annealing plot them
        if isfield(rst.PLA,'sa')
            plot(stg.lb(m):(stg.ub(m)-stg.lb(m))/stg.plres:stg.ub(m),...
                [rst.PLA.sa.fval{m}],'DisplayName','PL sa')
        end
        
        % If there are PL results from fmincon plot them
        if isfield(rst.PLA,'fm')
            plot(stg.lb(m):(stg.ub(m)-stg.lb(m))/stg.plres:stg.ub(m),...
                [rst.PLA.fm.fval{m}],'DisplayName','PL fmincon')
        end
    end
    
    % If it exists in settings plot the best parameter value
    if isfield(stg,'bestx')
        scatter(stg.bestx(m),best_score,20,'filled',...
            'DisplayName','best pa')
    end
    
    % If it exists in results plot the parameters run in diagnostics
    if isfield(rst,'diag')
        scatter(stg.pa(stg.pat,m),[rst.diag(stg.pat).st],...
            10,'filled','DisplayName','pat')
    end
    
    hold off
    xlim([stg.lb(m) stg.ub(m)])
    
    % Add a title to each plot
    title("Parameter " + find(stg.partest==m))

end
end