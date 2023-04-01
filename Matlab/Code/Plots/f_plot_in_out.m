function plots = f_plot_in_out(rst,stg,sbtab,Data,mmf,font_settings)
% Generates a figure with input and Output of all experiments on the left
% side it plots the inputs of the experiment and on the right side it plots
% the outputs

%Font settings
set_font_settings(font_settings)

for n = stg.exprun

    helper = 1;
    [layout,p1,plots] = f_plot_in_out_left(rst,stg,sbtab,helper,...
        size(sbtab.datasets(n).output,2) > 4,n,font_settings);

    for j = 1:size(sbtab.datasets(n).output,2)

        if j/4 > helper
            helper = helper +1;
            [layout,p1,plots] = f_plot_in_out_left(rst,stg,sbtab,helper,...
                size(sbtab.datasets(n).output,2) > 4,n,font_settings);
        end

        nexttile(layout,[1 1]);
        hold on

        % Iterate over the number of parameter arrays to test
        for m = stg.pat
            % (Until a non broken simulation is found)
            if rst(m).simd{1,n} ~= 0

                % Plot the outputs to each dataset (new subplots) as they
                % are given in the data provided in sbtab
                time = rst(m).simd{1,n}.Time;
                data = Data(n).Experiment.x(:,j);
                data_SD = Data(n).Experiment.x_SD(:,j);

                plot_data = plot(time,data,'LineWidth',0.5,...
                    'DisplayName','data','Color','k');

                plot_data_SD = f_error_area(transpose(time),transpose([data-data_SD,data+data_SD]));
                break
            end
        end
        % Iterate over the number of parameter arrays to test
        for m = stg.pat

            % Plot only if the simulation was successful
            if rst(m).simd{1,n} ~= 0

                time = rst(m).simd{1,n}.Time;
                [sim_results] = f_normalize(rst(m),stg,n,j,mmf);

                if stg.simdetail
                    time_detailed = rst(m).simd{1,n+2*stg.expn}.Time;
                    [~,sim_results_detailed]= f_normalize(rst(m),stg,n,j,mmf);
                end

                % Plot the outputs to each dataset (new subplots) and
                % parameter array to test that are simulated using
                % Simbiology
                if stg.simdetail
                    p2(:,m) = plot(time_detailed,...
                        sim_results_detailed,'DisplayName',...
                        string("\theta_"+m),'LineWidth',line_width);
                else
                    p2(:,m) = plot(time,...
                        sim_results,...
                        'DisplayName',string("\theta_"+m),...
                        'LineWidth',line_width);
                end

                ylabel(string(rst(m).simd{1,n}.DataInfo{end-...
                    size(sbtab.datasets(n).output,2)+j,1}.Units),...
                    'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
            end
        end

        hold off

        if stg.simdetail
            ylim([min([0,min(sim_results_detailed),min(sim_results),min(data-data_SD),min(data)]) inf])
        else
            ylim([min([0,min(sim_results),min(data-data_SD),min(data)]) inf])
        end

        xlabel('Seconds','FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)

        % Choose correct title according to settings
        if stg.plotoln == 1
            [t1,t2] = title(strrep(string(sbtab.datasets(n).output_name{1,j}),'_',...
                '\_')," ",'FontSize',Minor_title_FontSize,'Fontweight',Minor_title_Fontweight);
        else
            [t1,t2] = title(string(sbtab.datasets(n).output{1,j})," ",'FontSize',Minor_title_FontSize,...
                'Fontweight',Minor_title_Fontweight);
        end

        t2.FontSize = Minor_Title_Spacing;
        % Choose number of decimal places for y axis
        ytickformat('%-3.1f')
        % Add a legend for te entire image
        leg = legend([p1,p2(:,stg.pat),plot_data,plot_data_SD],...
            'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,'Location','layout',"Orientation","Horizontal");
        leg.Layout.Tile = 'South';
        leg.ItemTokenSize = Legend_ItemTokenSize;
        set(leg,'Box','off')
    end
end
end

function [layout,p1,plots] = f_plot_in_out_left(rst,stg,sbtab,helper,reuse,n,font_settings)

set_font_settings(font_settings)

if reuse
    name_short = "E " + (n-1) + " " + helper;
    name_long = "Experiment " + (n-1) + " " + helper + "  (E " +...
        (n-1) + " " + helper +")";
else
    name_short = "E " + (n-1);
    name_long = "Experiment " + (n-1) + "  (E " + (n-1) +")";
end

figHandles = findobj('type', 'figure', 'name', name_short);
close(figHandles);
plots{n-1+helper,1} = name_short;
plots{n-1+helper,2} = figure('WindowStyle','docked','Name', name_short,...
    'NumberTitle', 'off');

layout = tiledlayout(2,3,'Padding',"tight",'TileSpacing','tight');
nexttile(layout,[2 1]);

title(layout,name_long,...
    'FontSize', Major_title_FontSize,'Fontweight',Major_title_Fontweight)
hold on
for o = 1:size(sbtab.datasets(n).input,2)
    for p = stg.pat

        % (Until a non broken simulation is found)
        if rst(p).simd{1,n} ~= 0
            % Plot the inputs to each experiment
            p1 = plot(rst(p).simd{1,n}.Time,rst(p).simd{1,n}.Data(1:end,...
                str2double(strrep(sbtab.datasets(n).input(o),'S','')...
                )+1),'DisplayName',string(rst(p).simd{1,n}.DataNames(str2double(...
                strrep(sbtab.datasets(n).input(o),'S',''))+1)),'LineWidth',line_width);

            ylabel(string(rst(p).simd{1,n}.DataInfo{...
                str2double(strrep(sbtab.datasets(n).input(o),'S',''))+1,1}.Units),...
                'FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
            break
        end
    end
end

xlabel('Seconds','FontSize', Axis_FontSize,'Fontweight',Axis_Fontweight)
ylim([0 inf])
ytickformat('%-3.1f')
% Add a title to each plot
[t3,t4] = title("Inputs"," ",'FontSize', Minor_title_FontSize,'Fontweight',Minor_title_Fontweight);
t4.FontSize = Minor_Title_Spacing;
hold off
end

function set_font_settings(font_settings)
fields = fieldnames(font_settings);
for i = 1:numel(fields)
    assignin('caller', fields{i}, font_settings.(fields{i}))
end
end