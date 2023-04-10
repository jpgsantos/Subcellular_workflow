function plots = f_plot_gsa_sensitivities(results,settings,sbtab)
% This function creates plots for Global Sensitivity Analysis. It takes in
% results from sensitivity analysis, settings, an SBtab table, and font
% settings, then generates a set of plots for each section of the analysis.
% The function relies on three helper functions to generate heatmap plots,
% compute mean values, and set font settings. 
% 
% Inputs:
% - results: A structure containing the results from the sensitivity
%   analysis
% - settings: A structure containing various settings for the analysis
% - sbtab: An SBtab table used for creating the outputs
% - font_settings: A structure containing the font settings for the plots
%
% Outputs:
% - plots: A cell array containing the generated plots and their names
%
% Functions called:
% - f_generate_plot: Generates a heatmap plot for the given parameters
% - get_mean_values: Computes the mean values of an input matrix
% - set_font_settings: Sets font settings according to the provided
%   configuration
% - f_renew_plot: Closes any existing figures with the specified name and
% then creates a new figure with the given name and properties. It returns
% a 1x2 cell array containing the figure name and the figure handle.
%
% Variables:
% Loaded:
% None
%
% Initialized:
% - output_names2: Names of the outputs used in the plots
% - par_names: Names of the parameters used in the plots
% - par_names2: Modified names of the parameters used in the plots
% - plot_sections: Information about each plot section, including name,
% title, output_names2, and heatmap_values
% 
% Persistent:
% None



% Set font settings
f_set_font_settings()

% Get the total number of outputs
[~,output_names2.sd] = f_get_outputs(settings,sbtab);

% Set output_names2 values
for n = 1:size(output_names2.sd,2)
    output_names2.sd{n}{:} = strrep(output_names2.sd{n}{:},"_","\_");
end
for n = settings.exprun
    output_names2.se{n} = "E " + string(n-1);
end
output_names2.xfinal = output_names2.sd;

% Set parameter names
par_names = cell(1,settings.parnum);
par_names2 = cell(1,settings.parnum);
for n = 1:settings.parnum
    par_names{n} = char("\theta_{" + find(settings.partest==n) + "}");
    par_names2{n} = string(par_names{n}(1,:));
    % Confirm if can be deleted
    % for m = 2:size(par_names{n},1)
    %     par_names2{n} = string(par_names2{n}) + ", " +...
    %         string(par_names{n}(m,:));
    % end
end

% Define plot sections
plot_sections = {
    % Bootstrapping quartile mean of first order Sensitivity index for
    % score per Experimental Output
    "Si seo bm", ...
    ["First order Sensitivities",...
    "calculated using the Score of each Experimental Output",...
    "(Bootstrapping Mean)"],...
    "output_names2.sd", "get_mean_values(results.SiQ.sd,settings)";
    % Bootstrapping quartile mean of total order Sensitivity index for
    % score per Experimental Output
    "SiT seo bm",...
    ["Total order Sensitivities",...
    " calculated using the Score of each Experimental Output ",...
    " (Bootstrapping Mean)"],...
    "output_names2.sd", "get_mean_values(results.SiTQ.sd,settings)";
    % Bootstrapping quartile mean of first order Sensitivity index for
    % score per Experiments
    "Si se bm",...
    ["First order Sensitivities",...
    " calculated using the Score of each Experiment",...
    "(Bootstrapping Mean)"],...
    "output_names2.se", "get_mean_values(results.SiQ.se,settings)";
    % Bootstrapping quartile mean of total order Sensitivity index for
    % score per Experiments
    "SiT se bm",...
    ["Total order Sensitivities",...
    " calculated using the Score of each Experiment",...
    "(Bootstrapping Mean)"],...
    "output_names2.se", "get_mean_values(results.SiTQ.se,settings)";
    % Bootstrapping quartile mean of first order Sensitivity index for the
    % final points of the simulations for the output beeing measured
    "Si xfinal bm",...
    ["First order Sensitivities",...
    " calculated using the final value of each Experimental Output",...
    "(Bootstrapping Mean)"],...
    "output_names2.xfinal", "get_mean_values(results.SiQ.xfinal,settings)"
    % Bootstrapping quartile mean of total order Sensitivity index for the
    % final points of the simulations for the output beeing measured
    "SiT xfinal bm",...
    ["Total order Sensitivities",...
    " calculated using the final value of each Experimental Output",...
    "(Bootstrapping Mean)"],...
    "output_names2.xfinal", "get_mean_values(results.SiTQ.xfinal,settings)"
    };

% Generate plots for each section
for i = 1:size(plot_sections, 1)
    [plots(i,:)] = f_generate_plot(results, settings, output_names,...
        par_names2, plot_sections{i, 1}, plot_sections{i, 2},...
        plot_sections{i, 3}, plot_sections{i, 4});
end

% Create Si, SiT plot
plots(7,:) = f_renew_plot('Si,SiT');

layout = tiledlayout(1,1,'Padding','compact','TileSpacing','tight');
nexttile(layout)

for n = 1:size(par_names2,2)
    a{n} = char(par_names2{n});
end

a = categorical(a,a);

bar(a,[transpose(results.Si.st(:,1:settings.parnum)),...
    transpose(results.SiT.st(:,1:settings.parnum))])
set(gca,'FontSize', Axis_FontSize);
xlabel('Parameters','FontSize', Axis_FontSize,...
    'Fontweight',Axis_Fontweight);
ylabel('Sensitivity','FontSize', Axis_FontSize,...
    'Fontweight',Axis_Fontweight);
title(layout,...
    'Sensitivities calculated using the sum of the Score of all Experiments',...
    'FontSize',Major_title_FontSize,'Fontweight',Major_title_Fontweight);
leg = legend({'Si','SiT'},'Location','best',...
    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight);
leg.ItemTokenSize = Legend_ItemTokenSize;
legend boxoff

% Create Si, SiT bootstraping plot
plots(8,:) = f_renew_plot('Si,SiT b');


layout = tiledlayout(1,1,'Padding','compact','TileSpacing','tight');
nexttile(layout)

T = [];

for n = 1:size(a,2)
    for m = 1:size(results.SiQ.st(:,n),1)
        T = [T;table(results.SiQ.st(m,n),a(n),"Si")];
    end
end
for n = 1:size(a,2)
    for m = 1:size(results.SiTQ.st(:,n),1)
        T = [T;table(results.SiTQ.st(m,n),a(n),"SiT")];
    end
end

boxchart(T.Var2,T.Var1,'GroupByColor',T.Var3,...
    'MarkerStyle','.','JitterOutliers','on')
set(gca,'FontSize', Axis_FontSize);
xlabel('Parameters','FontSize',...
    Axis_FontSize,'Fontweight',Axis_Fontweight);
ylabel('Sensitivity','FontSize',...
    Axis_FontSize,'Fontweight',Axis_Fontweight);
title(layout,...
    {'Sensitivities calculated using the sum of the Score of all Experiments ',...
    '(Bootstrapping)'},'FontSize',Major_title_FontSize,...
    'Fontweight',Major_title_Fontweight);
leg = legend({'Si','SiT'},'Location','best',...
    'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight);
leg.ItemTokenSize = Legend_ItemTokenSize;
legend boxoff
end

function [plots] =...
    f_generate_plot(results,settings,output_names,par_names2,name,major_title,...
    output_names2,heatmap_values)
% Function to generate heatmap plot for the given parameters

% Set font settings
f_set_font_settings()

plots = f_renew_plot(name);

layout = tiledlayout(1,1,'Padding','compact','TileSpacing','tight');
nexttile(layout)

fixed_output_names2 = eval(output_names2);
fixed_output_names2 =...
    fixed_output_names2(~cellfun('isempty',fixed_output_names2));

fixed_heatmap_values = eval(heatmap_values);
fixed_heatmap_values =...
    fixed_heatmap_values(:,all(~isnan(fixed_heatmap_values)));

h = heatmap(fixed_output_names2,par_names2,...
    fixed_heatmap_values,'Colormap',turbo,...
    'ColorLimits',[0 1],'GridVisible','off',FontSize=Axis_FontSize);
h.CellLabelFormat = '%.2f';

title(layout,major_title,'FontSize', Major_title_FontSize,...
    'Fontweight',Major_title_Fontweight);

h.XLabel = '\fontsize{8} \bf Outputs';
h.YLabel = '\fontsize{8} \bf Parameters';
end

function mean_values = get_mean_values(input_matrix,settings)
% Function to compute the mean values of the input matrix

mean_values = transpose(reshape(mean(input_matrix(:,:,1:settings.parnum)),...
    [size(input_matrix,2),size(input_matrix,3)]));
end