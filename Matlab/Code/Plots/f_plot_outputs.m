function plots = f_plot_outputs(rst,stg,sbtab,Data,mmf,font_settings)
% Generates a figure with Outputs, one subplot per experimental output

% Inform the user that fig3 is being ploted
disp("Plotting Outputs")

% Get the total number of outputs to set the total number of plots
[plot_tn,~] = f_get_outputs(stg,sbtab);
plot_n = 0;
fig_n = 0;
layout = [];
plots_1 = [];
plots = cell(1,2);

%Font settings
set_font_settings(font_settings)

% Iterate over the number of experiments
for n = stg.exprun

    % Iterate over the number of datasets in each experiment
    for j = 1:size(sbtab.datasets(n).output,2)

        % Generate the right amount of figures for all plots and calculates
        % proper subploting position
        if mod(plot_n,12) == 0
            [fig_n,layout,plots_1] = f_get_subplot(plot_tn,plot_n,fig_n,"Outputs",layout,plots_1);
            plots{fig_n,1} = plots_1{1};
            plots{fig_n,2} = plots_1{2};
            if fig_n > 1
                fig_name = "Outputs " + fig_n;
            else
                fig_name = "Outputs";
            end
            title(layout,fig_name,...
                'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight)
        end

        nexttile(layout);
        plot_n = plot_n + 1;

        hold on

        error_area_plotted = false;
        % Iterate over the number of parameter arrays to test
        for m = stg.pat

            % Plot only if the simulation was successful
            if rst(m).simd{1,n} ~= 0

                data = Data(n).Experiment.x(:,j);

                data_SD = Data(n).Experiment.x_SD(:,j);

                time = rst(m).simd{1,n}.Time;

                if ~error_area_plotted
                    f_error_area(transpose(time), transpose([data-data_SD, data+data_SD]));
                    error_area_plotted = true;
                end

                [sim_results,~] = f_normalize(rst(m),stg,n,j,mmf);
                if stg.simdetail
                    time_detailed = rst(m).simd{1,n+2*stg.expn}.Time;
                    [~,sim_results_detailed]= f_normalize(rst(m),stg,n,j,mmf);

                    plot(time_detailed,sim_results_detailed,'DisplayName',...
                        string("\theta_"+m),'LineWidth',line_width)

                else
                    plot(time,sim_results,'DisplayName',...
                        string("\theta_"+m),'LineWidth',line_width)
                end

                ylabel(string(rst(m).simd{1,n}.DataInfo{end-...
                    size(sbtab.datasets(n).output,2)+j,1}.Units),...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
            end
        end

        hold off

        min_y = min([0, min(sim_results), min(data - data_SD), min(data),...
            stg.simdetail * min(sim_results_detailed)]);
        ylim([min_y, inf]);

        % Choose correct title according to settings
        if stg.plotoln == 1
            title_text = "E" + (n-1) + " " +...
                strrep(string(sbtab.datasets(n).output_name{1,j}),'_','\_');
        else
            title_text = "E" + (n-1) + " " +...
                string(sbtab.datasets(n).output{1,j});
        end

        title(title_text, 'FontSize', Minor_title_FontSize,...
            'Fontweight', Minor_title_Fontweight);

        % Choose number of decimal places for y axis
        ytickformat('%-4.1f')
        if mod(plot_n,12) == 1

            Lgnd = legend('show','Orientation','vertical',...
                'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
                'Location','layout');
            Lgnd.Layout.Tile = 'East';
            Lgnd.ItemTokenSize = Legend_ItemTokenSize;
            xlabel(layout,"Seconds",...
                'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

            set(Lgnd,'Box','off')
        end
    end
end
end

function set_font_settings(font_settings)
fields = fieldnames(font_settings);
for i = 1:numel(fields)
    assignin('caller', fields{i}, font_settings.(fields{i}))
end
end