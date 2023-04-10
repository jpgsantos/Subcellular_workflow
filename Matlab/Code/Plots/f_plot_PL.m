function plots = f_plot_PL(rst,stg,mmf)
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
if isfield(stg,'bestpa')
    stg.sbioacc = false;
    [best_score,~] = f_sim_score(stg.bestpa,stg,mmf);
end

% Set the font settings
f_set_font_settings()

% Initialize variables
fig_n = 0;
plot_n = 0;
layout = [];
plots = [];

% Iterate through the pltest values
for m = stg.pltest

    % Generate the required number of figures and calculate the subplot positions
    [fig_n,layout,plots] = f_get_subplot(size(stg.pltest,2),plot_n,...
        fig_n,"Parameter Profile Likelihood",layout,plots);

    % Set the next tile in the layout
    nexttile(layout);

    % Add a legend, labels, and title to the figure if it's the first plot
    % in a set of 12
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

    % Increment the plot counter
    plot_n = plot_n +1;

    hold on

    % Check if there are results from PL function
    if isfield(rst,'PLA')
        % Plot the PL results from simulated annealing if they exist
        if isfield(rst.PLA,'sa')
            plot(stg.lb(m):(stg.ub(m)-stg.lb(m))/stg.plres:stg.ub(m),...
                [rst.PLA.sa.fvalt{m}],'DisplayName','Total score sa',...
                'LineWidth',1.5,'color',[0, 0, 1, 0.5])
            minfval = min(rst.PLA.sa.fvalt{m});
        end

        % Plot the PL results from fmincon if they exist
        if isfield(rst.PLA,'fm')
            plot(stg.lb(m):(stg.ub(m)-stg.lb(m))/stg.plres:stg.ub(m),...
                [rst.PLA.fm.fvalt{m}],'DisplayName','Total score fmincon',...
                'LineWidth',1.5,'color',[1, 0, 0, 0.5])
            minfval = min(rst.PLA.fm.fvalt{m});
        end
    end

    % Add a line indicating the 95% confidence threshold
    yline(icdf('chi2',0.95,1)+minfval,...
        'DisplayName','Total score icdf(\chi^2,0.95)')

    % If the best parameter value exists in the settings, plot it
    if isfield(stg,'bestpa')
        scatter(stg.bestpa(m),best_score,20,'filled',...
            'DisplayName','best \theta','MarkerFaceColor','k')
    end

    % If the diagnostic results exist, plot the parameters used in the
    % diagnostics
    if isfield(rst,'diag')
        scatter(stg.pa(stg.pat,m),[rst.diag(stg.pat).st],...
            10,'filled','DisplayName','\theta test')
    end

    hold off

    % Set the x-axis limits
    xlim([stg.lb(m) stg.ub(m)])
    % ylim([0 (icdf('chi2',0.95,1)+max(minfval)+0.5)*5])

    % Set the title for each plot
    titlestring = "\theta_{" + find(stg.partest==m)+"}";
    title(titlestring(1),'FontSize',Minor_title_FontSize,...
        'Fontweight',Minor_title_Fontweight)
end
end