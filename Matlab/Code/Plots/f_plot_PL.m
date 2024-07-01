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
    [best_score,~,~] = f_sim_score(settings.bestpa,settings,model_folder,0,0);
end
% best_score
% Set the font settings
f_set_font_settings()

% Initialize variables
fig_n = 0;
plot_n = 0;
layout = [];
plots = cell(1,2);

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
    % [fig_n,layout,plots] = f_get_subplot(size(settings.pltest,2),plot_n,...
    %     fig_n,"Profile Likelihood Analysis",layout,plots);

    % Add a legend, labels, and title to the figure if it's the first plot
    % in a set of 12
    if mod(plot_n,12) == 0
        [fig_n,layout,plots(fig_n,:)] = f_get_subplot(size(settings.pltest,2),plot_n,fig_n,"PLA",layout);


        % % Set figure name based on its order
        % if fig_n > 1
        %     fig_name = "PLA " + fig_n;
        % else
        %     fig_name = "PLA";
        % end

    end
    if mod(plot_n,12) ==  1 
        % Add a legend to the figure
        Lgnd = legend('show','Orientation','Horizontal',...
            'fontsize',Legend_FontSize);
        Lgnd.Layout.Tile = 'North';
        legend boxoff
        xlabel(layout,"log_{10} P",...
            'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
        ylabel(layout,"-2 PL",...
            'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
        title(layout,settings.plot_name + " Parameter Profile Likelihood",...
            'FontSize', Major_title_FontSize,...
            'Fontweight',Major_title_Fontweight)

    end

    % Set the next tile in the layout
    nexttile(layout);

    % Increment the plot counter
    plot_n = plot_n +1;

    hold on

    % Check if there are results from PL function
    if isfield(results,'PLA')

        % color = generateRainbowGradient(settings.plroptn+1);

        % for n = 1:settings.plroptn+1
        %     i = find([results.PLA.("reopt" +n).min.fvalt{m}]);
        %     plot(results.PLA.("reopt" +n).min.Pval{m}(i),...
        %         nonzeros([results.PLA.("reopt" +n).min.fvalt{m}]),'DisplayName',"Total score min" + n,...
        %         'LineWidth',1,'color',color(n,:))
        %     minfval = min(nonzeros([results.PLA.("reopt" +n).min.fvalt{m}]));
        % end

            i = find([results.PLA.("reopt" +(settings.plroptn+1)).min.fvalt{m}]);
            plot(results.PLA.("reopt" +(settings.plroptn+1)).min.Pval{m}(i),...
                nonzeros([results.PLA.("reopt" +(settings.plroptn+1)).min.fvalt{m}]),'DisplayName',"Total score",...
                'LineWidth',1.5,'color',"k")
            minfval = min(nonzeros([results.PLA.("reopt" +(settings.plroptn+1)).min.fvalt{m}]));
    end
switch settings.useLog

    case {0, 4}
    % Add a line indicating the 95% confidence threshold
    yline(icdf('chi2',0.95,1)+minfval,...
        'DisplayName','Total score icdf(\chi^2,0.95)')

    case {1, 2, 3}
        % Add a line indicating the 95% confidence threshold
    yline(log10(icdf('chi2',0.95,1)+10^minfval),...
        'DisplayName','Total score icdf(\chi^2,0.95)')

end

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
    % ylim([0 (icdf('chi2',0.95,1)+max(minfval)+0.5)*5])
    % ylim([0 10000])
    % Set the title for each plot
    % titlestring = "P_{" + find(settings.partest==m)+"}";
    titlestring = "P_{" + m +"}";
    title(titlestring(1),'FontSize',Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight)



end

color = generateRainbowGradient(9);  
% Generate the required number of figures and calculate the subplot positions
plots(end+1,:) = f_renew_plot('PLA Summary');
layout = tiledlayout(1,1,'Padding','tight','TileSpacing','tight');

% Generate top plot of Scores figure
nexttile(layout);



for m = settings.pltest

i = find([results.PLA.("reopt" +(settings.plroptn+1)).min.fvalt{m}]);
x{m} = results.PLA.("reopt" +(settings.plroptn+1)).min.Pval{m}(i);
y{m} = nonzeros([results.PLA.("reopt" +(settings.plroptn+1)).min.fvalt{m}]);

for j = 2:8
    for k = 1:size(y{m},1)
        if y{m}(k) <= j
            y2{j}{m}(k) = y{m}(k);
            x2{j}{m}(k) = x{m}(k);
        end
    end
end
hold on
    for j = 8:-1:2
        % scatter(nonzeros(x2{j}{m}),zeros(size(nonzeros(x2{j}{m})))+m,5,color(j,:),"|")
        X{m,j}(1,:) = nonzeros(x2{j}{m})';
        Y{m,j}(1,:) = zeros(size(nonzeros(x2{j}{m})))+m+0.4;
        Y{m,j}(2,:) = zeros(size(nonzeros(x2{j}{m})))+m-0.4;

        % Prepare x coordinates for the shaded area
        Xh=[X{m,j}(1:end-1); X{m,j}(1:end-1); X{m,j}(2:end); X{m,j}(2:end); ];
        % Prepare y coordinates for the shaded area
        Yh=[Y{m,j}(1,1:end-1); Y{m,j}(2,1:end-1); Y{m,j}(2,2:end); Y{m,j}(1,2:end); ];
        % Create the shaded area plot

        if j == 2
            plot_patch{m}(j) = patch(Xh,Yh,zeros(size(Xh)),'DisplayName',"Data\_SD",'EdgeColor',...
                'none','FaceColor',color(j,:),'FaceAlpha',1,'HandleVisibility','off','DisplayName',"Total Score <= 10^" + string(j));
        elseif j == 8
            plot_patch{m}(j) = patch(Xh,Yh,zeros(size(Xh)),'DisplayName',"Data\_SD",'EdgeColor',...
                'none','FaceColor',color(j,:),'FaceAlpha',1,'HandleVisibility','off','DisplayName',"Total Score > 10^" + string(j-1));
        else
            plot_patch{m}(j) = patch(Xh,Yh,zeros(size(Xh)),'DisplayName',"Data\_SD",'EdgeColor',...
                'none','FaceColor',color(j,:),'FaceAlpha',1,'HandleVisibility','off','DisplayName',"10^" + string(j-1)+ " < Total Score <= 10^" + string(j));
        end
        reducepatch(plot_patch{m}(j),2)
    end

parNames = cell(1,size(settings.pltest,1));

for n = settings.pltest
    parNames{n} = char("P" + find(settings.pltest==n));
end

for n = 1:size(parNames,2)
    if size(parNames{n},1) > 1
        parNames{n} = parNames{n}(1,:);
    end
end

ax = gca;
set(gca,'ytick',1:settings.parnum,'yticklabel',parNames)


% yline(m+0.5,'w','LineWidth',4,'Alpha',1)
xlim([min(settings.lb) max(settings.ub)])
ylim([0.5 max(settings.pltest)+0.5])
hold off

end

   Lgnd = legend(plot_patch{m}(2:8),'Orientation','vertical',...
            'fontsize',Legend_FontSize);
        Lgnd.Layout.Tile = 'south';
        legend boxoff
Lgnd.NumColumns = 3;

        xlabel(layout,"log_{10} P",...
            'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
        ylabel(layout,"Parameters",...
            'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
        title(layout,settings.plot_name + " Profile Likelihood Analysis Summary",...
            'FontSize', Major_title_FontSize,...
            'Fontweight',Major_title_Fontweight)



end