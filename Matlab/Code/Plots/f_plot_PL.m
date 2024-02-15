function plots = f_plot_PL(results,settings,model_folder)
% F_PLOT_PL This function creates plots of Parameter Profile Likelihood
% (PL) for given results (rst), settings (stg), and model (mmf), using
% specified font settings (font_settings). The function iterates through
% the pltest values and generates plots for each value. It uses the
% f_get_subplot function to create the required number of subplots, and
% sets font settings using the set_font_settings function. The function
% plots the PL results from the Simulated Annealing and fmincon processes
% if they exist, and also plots the 95% confidence threshold, best
% parameter values, and diagnostic results. The x-axis limits are set based
% on the lower and upper bounds of the parameters.
%
% Inputs:
%   - rst: A structure containing the results from the optimization and
%   diagnostic processes.
%   - stg: A structure containing the settings and parameters for the
%   optimization and diagnostic processes.
%   - mmf: A function handle for the model to be used.
%   - font_settings: A structure containing font settings for the plot.
%
% Outputs:
%   - plots: An array of generated plots.
%
% Functions called:
%   - f_sim_score: Calculates the best score for the model.
%   - f_get_subplot: Generates the required number of figures and
%   calculates subplot positions.
%   - set_font_settings: Sets the font settings for the plot.
%
% Variables:
% Loaded:
% None
%
% Initialized:
%   - fig_n: The current figure number.
%   - plot_n: The current plot number.
%   - layout: The layout for the subplots.
%   - best_score: The best score calculated using the best parameter set.
%   - minfval: The minimum fval for the plot.
%   - Lgnd: The legend object for the plot.
%
% Persistent:
% None


% Inform the user that PLA figure is being ploted
disp("Plotting PL")

% Check if 'bestpa' field exists in stg and calculate the best score if it
% does
if isfield(settings,'bestpa')
    settings.sbioacc = false;
    [best_score,~,~] = f_sim_score(settings.bestpa,settings,model_folder);
end
% best_score
% Set the font settings
f_set_font_settings()

% Initialize variables
fig_n = 0;
plot_n = 0;
layout = [];
plots = [];

% Iterate through the pltest values
% for m = settings.pltest
% 
%     % Generate the required number of figures and calculate the subplot positions
%     [fig_n,layout,plots] = f_get_subplot(size(settings.pltest,2)*2,plot_n,...
%         fig_n,"Parameter Profile Likelihood",layout,plots);
% 
%     % Set the next tile in the layout
%     nexttile(layout);
% 
%     % Add a legend, labels, and title to the figure if it's the first plot
%     % in a set of 12
%     if mod(plot_n,12) == 1
% 
%         % Add a legend to the figure
%         Lgnd = legend('show','Orientation','Horizontal','fontsize',Legend_FontSize);
%         Lgnd.Layout.Tile = 'North';
%         legend boxoff
%         xlabel(layout,"log_{10} Parameter",...
%             'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
%         ylabel(layout,"-2 PL",...
%             'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
%         title(layout,"Parameter Profile Likelihood",...
%             'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight)
% 
%     end
% 
%     % Increment the plot counter
%     plot_n = plot_n +1;
% 
%     hold on
% 
%     % Check if there are results from PL function
%     if isfield(results,'PLA')
% 
%         if isfield(results.PLA,'sa') && isfield(results.PLA,'fm')
%             common_PVal = [];
%             common_fval = [];
%             for n = 1:length([results.PLA.sa.Pval{m}])
%                 k = find(results.PLA.sa.Pval{m}(n)==[results.PLA.fm.Pval{m}]);
%                 if ~isempty(k)
%                     common_PVal(n) = results.PLA.sa.Pval{m}(n);
%                     common_fval(n) = ...
%                         min(results.PLA.sa.fvalt{m}(n),results.PLA.fm.fvalt{m}(k));
%                 else
%                     common_PVal(n) = results.PLA.sa.Pval{m}(n);
%                     common_fval(n) = results.PLA.sa.fvalt{m}(n);
%                 end
%             end
%             plot(common_PVal,...
%                 common_fval,'DisplayName','Total score sa and fmincon',...
%                 'LineWidth',1.5,'color',[0, 0, 0, 1])
%             minfval = min(common_fval);
% 
%         elseif isfield(results.PLA,'sa')
%             plot([results.PLA.sa.Pval{m}],...
%                 [results.PLA.sa.fvalt{m}],'DisplayName','Total score sa',...
%                 'LineWidth',1.5,'color',[0, 0, 1, 0.5])
%             minfval = min(results.PLA.sa.fvalt{m});
% 
%             % Plot the PL results from fmincon if they exist
%         elseif isfield(results.PLA,'fm')
%             plot([results.PLA.fm.Pval{m}],...
%                 [results.PLA.fm.fvalt{m}],'DisplayName','Total score fmincon',...
%                 'LineWidth',1.5,'color',[1, 0, 0, 0.5])
%             minfval = min(results.PLA.fm.fvalt{m});
%         end
%     end
% 
%     % Add a line indicating the 95% confidence threshold
%     yline(icdf('chi2',0.95,1)+minfval,...
%         'DisplayName','Total score icdf(\chi^2,0.95)')
% 
%     % If the best parameter value exists in the settings, plot it
%     if isfield(settings,'bestpa')
%         scatter(settings.bestpa(m),best_score,20,'filled',...
%             'DisplayName','best \theta','MarkerFaceColor','k')
%     end
% 
%     % If the diagnostic results exist, plot the parameters used in the
%     % diagnostics
%     if isfield(results,'diag')
%         scatter(settings.pa(settings.pat,m),[results.diag(settings.pat).st],...
%             10,'filled','DisplayName','\theta test')
%     end
% 
%     hold off
% 
%     % Set the x-axis limits
%     xlim([settings.lb(m) settings.ub(m)])
%     % ylim([0 (icdf('chi2',0.95,1)+max(minfval)+0.5)*5])
% 
%     % Set the title for each plot
%     titlestring = "\theta_{" + find(settings.partest==m)+"}";
%     title(titlestring(1),'FontSize',Minor_title_FontSize,...
%         'Fontweight',Minor_title_Fontweight)
% end

% Iterate through the pltest values
for m = settings.pltest

    % Generate the required number of figures and calculate the subplot positions
    [fig_n,layout,plots] = f_get_subplot(size(settings.pltest,2),plot_n,...
        fig_n,"Parameter Profile Likelihood",layout,plots);

    % Set the next tile in the layout
    nexttile(layout);

    % Add a legend, labels, and title to the figure if it's the first plot
    % in a set of 12
    if mod(plot_n,12) == 1

        % Add a legend to the figure
        Lgnd = legend('show','Orientation','Horizontal',...
            'fontsize',Legend_FontSize);
        Lgnd.Layout.Tile = 'North';
        legend boxoff
        xlabel(layout,"log_{10} P",...
            'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
        ylabel(layout,"-2 PL",...
            'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
        title(layout,"Parameter Profile Likelihood",...
            'FontSize', Major_title_FontSize,...
            'Fontweight',Major_title_Fontweight)

    end

    % Increment the plot counter
    plot_n = plot_n +1;

    hold on

    % Check if there are results from PL function
    if isfield(results,'PLA')

        % if isfield(results.PLA,'sa') && isfield(results.PLA,'fm')
        %     common_PVal = [];
        %     common_fval = [];
        % 
        %     for n = 1:length([results.PLA.sa.Pval{m}])
        %         k = find(results.PLA.sa.Pval{m}(n)==[results.PLA.fm.Pval{m}]);
        %         if ~isempty(k)
        %             common_PVal(n) = results.PLA.sa.Pval{m}(n);
        %             common_fval(n) = ...
        %                 min(results.PLA.sa.fvalt{m}(n),...
        %                 results.PLA.fm.fvalt{m}(k));
        %         else
        %             common_PVal(n) = results.PLA.sa.Pval{m}(n);
        %             common_fval(n) = results.PLA.sa.fvalt{m}(n);
        %         end
        %     end
        % 
        %     plot(common_PVal,...
        %         common_fval,'DisplayName','Total score sa',...
        %         'LineWidth',1.5,'color',[0, 0, 0, 1])
        %     minfval = min(common_fval);
        % else
         if isfield(results.PLA,'sa')

            i = find([results.PLA.sa.fvalt{m}]);
            plot(results.PLA.sa.Pval{m}(i),...
                nonzeros([results.PLA.sa.fvalt{m}]),'DisplayName','Total score sa',...
                'LineWidth',4,'color',[0, 0, 1, 0.5])

            % minfval = min(results.PLA.sa.fvalt{m});
         end
            % Plot the PL results from fmincon if they exist
        if isfield(results.PLA,'fm')

            i = find([results.PLA.fm.fvalt{m}]);
            plot(results.PLA.fm.Pval{m}(i),...
                nonzeros([results.PLA.fm.fvalt{m}]),'DisplayName','Total score fm',...
                'LineWidth',4,'color',[1, 0, 0, 0.5])

            % minfval = min(results.PLA.fm.fvalt{m});
            % elseif isfield(results.PLA,'ps')
        end
        if isfield(results.PLA,'ps')
            i = find([results.PLA.ps.fvalt{m}]);
            plot(results.PLA.ps.Pval{m}(i),...
                nonzeros([results.PLA.ps.fvalt{m}]),'DisplayName','Total score ps',...
                'LineWidth',4,'color',[0, 1, 0, 0.5])

            % minfval = min(results.PLA.min.fvalt{m});
        end

        color = generateRainbowGradient(settings.plroptn+1);

        for n = 1:settings.plroptn+1
            i = find([results.PLA.("reopt" +n).min.fvalt{m}]);
            plot(results.PLA.("reopt" +n).min.Pval{m}(i),...
                nonzeros([results.PLA.("reopt" +n).min.fvalt{m}]),'DisplayName',"Total score min" + n,...
                'LineWidth',1,'color',color(n,:))
            minfval = min(nonzeros([results.PLA.("reopt" +n).min.fvalt{m}]);
        end

            % i = find([results.PLA.min.fvalt{m}]);
            % plot(results.PLA.min.Pval{m}(i),...
            %     nonzeros([results.PLA.min.fvalt{m}]),'DisplayName','Total score min',...
            %     'LineWidth',2,'color',[0, 0, 0, 0.5])
            % minfval = min(results.PLA.min.fvalt{m});
            % 
            % i = find([results.PLA.test1.min.fvalt{m}]);
            % plot(results.PLA.test1.min.Pval{m}(i),...
            %     nonzeros([results.PLA.test1.min.fvalt{m}]),'DisplayName','Total score min2',...
            %     'LineWidth',1.5,'color',[0.75, 0.75, 0.75, 0.5])
            % minfval = min(results.PLA.test1.min.fvalt{m});
            % 
            % i = find([results.PLA.test2.min.fvalt{m}]);
            % plot(results.PLA.test2.min.Pval{m}(i),...
            %     nonzeros([results.PLA.test2.min.fvalt{m}]),'DisplayName','Total score min2',...
            %     'LineWidth',1,'color',[0.5, 0.5, 0.5, 0.5])
            % minfval = min(results.PLA.test2.min.fvalt{m});
            % 
            % i = find([results.PLA.test3.min.fvalt{m}]);
            % plot(results.PLA.test3.min.Pval{m}(i),...
            %     nonzeros([results.PLA.test3.min.fvalt{m}]),'DisplayName','Total score min2',...
            %     'LineWidth',1,'color',[0.25, 0.25, 0.25, 0.5])
            % minfval = min(results.PLA.test3.min.fvalt{m});

% end

    end

    % Add a line indicating the 95% confidence threshold
    yline(icdf('chi2',0.95,1)+minfval,...
        'DisplayName','Total score icdf(\chi^2,0.95)')

    % If the best parameter value exists in the settings, plot it
    if isfield(settings,'bestpa')
        scatter(settings.bestpa(m),best_score,20,'filled',...
            'DisplayName','best \theta','MarkerFaceColor','k')
    end

    % If the diagnostic results exist, plot the parameters used in the
    % diagnostics
    if isfield(results,'diag')
        scatter(settings.pa(settings.pat,m),[results.diag(settings.pat).st],...
            10,'filled','DisplayName','\theta test')
    end

    hold off

    % Set the x-axis limits
    xlim([settings.lb(m) settings.ub(m)])
    ylim([0 (icdf('chi2',0.95,1)+max(minfval)+0.5)*5])

    % Set the title for each plot
    % titlestring = "P_{" + find(settings.partest==m)+"}";
    titlestring = "P_{" + m +"}";
    title(titlestring(1),'FontSize',Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight)
end
end