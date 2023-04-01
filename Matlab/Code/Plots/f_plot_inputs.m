function plots = f_plot_inputs(rst,stg,sbtab,font_settings)
% Generates a figure with Inputs, one subplot per experiment

% Inform the user that fig2 is being ploted
disp("Plotting Inputs")

plot_n = 0;
fig_n = 0;
layout = [];
plots_1 = [];

%Font settings
set_font_settings(font_settings)

% Iterate over the number of experiments
for n = stg.exprun

    % Generate the right amount of figures for all plots and calculates
    % proper subploting position
    if mod(plot_n,12) == 0
        [fig_n,layout,plots_1] = f_get_subplot(size(stg.exprun,2),plot_n,fig_n,"Inputs",layout,plots_1);
        plots{fig_n,1} = plots_1{1};
        plots{fig_n,2} = plots_1{2};

        if fig_n > 1
            fig_name = "Inputs " + fig_n;
        else
            fig_name = "Inputs";
        end
        title(layout,fig_name,...
            'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight)
    end

    nexttile(layout);

    plot_n = plot_n +1;

    hold on

    % Iterate over the number of inputs in each experiment
    for j = 1:size(sbtab.datasets(n).input,2)

        % Iterate over the number of parameter arrays to test
        for m = stg.pat

            % (Until a non broken simulation is found)
            if rst(m).simd{1,n} ~= 0

                % Plot the inputs to each experiment
                plot(rst(m).simd{1,n}.Time,rst(m).simd{1,n}.Data(1:end,...
                    str2double(strrep(sbtab.datasets(n).input(j),'S',''))+1),'LineWidth',line_width)

                % Get the correct label for each input of the experiment
                labelfig2(j) = rst(m).simd{1,n}.DataNames(str2double(...
                    strrep(sbtab.datasets(n).input(j),'S',''))+1);

                ylabel(layout,string(rst(m).simd{1,n}.DataInfo{...
                    str2double(strrep(sbtab.datasets(n).input(j),'S',''))+1,1}.Units),...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

                break
            end
        end
    end

    if mod(plot_n,12) == 1

        xlabel(layout,"Seconds", 'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

        Lgnd = legend(labelfig2,'Orientation','vertical', ...
            'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,...
            'Location','layout','Box','off');
        Lgnd.Layout.Tile = 'East';
        Lgnd.ItemTokenSize = Legend_ItemTokenSize;
    end

    ylim([0 inf])
    ytickformat('%-4.1f')
    % Add a title to each plot
    title("E"+(n-1))

    hold off
end
end

function set_font_settings(font_settings)
font_settings_fields = fieldnames(font_settings);
for i = 1:numel(font_settings_fields)
    assignin('caller', font_settings_fields{i}, font_settings.(font_settings_fields{i}))
end
end