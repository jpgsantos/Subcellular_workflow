function f_plot_in_out(rst,stg,sbtab,Data,mmf)
% Generates a figure with input and Output of all experiments on the left
% side it plots the inputs of the experiment and on the right side it plots
% the outputs


%Font settings
Letter_FontSize = 10;
Letter_Fontweight = 'bold';
Axis_FontSize = 8;
Axis_Fontweight = 'bold';
Minor_title_FontSize = 10;
Minor_title_Fontweight = 'bold';
Major_title_FontSize = 12;
Major_title_Fontweight = 'bold';
Legend_FontSize = 8;
Legend_Fontweight = 'bold';
Legend_ItemTokenSize = [20,18];
line_width = 1;


for n = stg.exprun

    helper = 1;
    [layout,p1] = f_plot_in_out_left(rst,stg,sbtab,helper,...
        size(sbtab.datasets(n).output,2) > 4);

    for j = 1:size(sbtab.datasets(n).output,2)

        if j/4 > helper
            helper = helper +1;
            [layout,p1] = f_plot_in_out_left(rst,stg,sbtab,helper,...
                size(sbtab.datasets(n).output,2) > 4);
        end

        %         if size(sbtab.datasets(n).output,2) == 1
        %             subplot(1,2,j+ceil(j/(2/2))*1)
        %         elseif size(sbtab.datasets(n).output,2) == 2
        %             subplot(2,2,j+ceil(j/(2/2))*1)
        %         elseif size(sbtab.datasets(n).output,2) > 2 &&...
        %                 size(sbtab.datasets(n).output,2) <= 4
        %             subplot(2,4,j+ceil(j/(4/2))*2)
        %         elseif size(sbtab.datasets(n).output,2) > 4
        %             subplot(2,4,j+ceil(j/(4/2))*2-helper*8+8)
        %         end
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

                %                 errorbar(time,data,data_SD, 'vertical',	'k', 'LineStyle', 'none','LineWidth',1);
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
                    p2(m) = plot(time_detailed,...
                        sim_results_detailed,'DisplayName',...
                        string("\theta_"+m),'LineWidth',line_width);
                else
                    p2(m) = plot(time,...
                        sim_results,...
                        'DisplayName',string("\theta_"+m),...
                        'LineWidth',line_width);
                end

                ylabel(string(rst(m).simd{1,n}.DataInfo{end-...
                    size(sbtab.datasets(n).output,2)+j,1}.Units),...
                    'FontSize', Axis_FontSize,'Fontweight','bold')
            end
        end

        hold off

        %         set(gca,'FontSize',12,'Fontweight','bold')

        if stg.simdetail
            ylim([min([0,min(sim_results_detailed),min(sim_results),min(data-data_SD),min(data)]) inf])
        else
            ylim([min([0,min(sim_results),min(data-data_SD),min(data)]) inf])
        end

        xlabel('seconds','FontSize', Axis_FontSize,'Fontweight','bold')

        % Choose correct title according to settings
        if stg.plotoln == 1
            title(strrep(string(sbtab.datasets(n).output_name{1,j}),'_',...
                '\_'),'FontSize', Minor_title_FontSize,'Fontweight','bold')
        else
            title(string(sbtab.datasets(n).output{1,j}),'FontSize', Minor_title_FontSize,...
                'Fontweight','bold')
        end

        % Choose number of decimal places for y axis
        ytickformat('%.2g')

        leg = legend([p1,p2(1:4),plot_data,plot_data_SD],...
            'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,'Location','layout',"Orientation","Horizontal");
        leg.Layout.Tile = 'South';
        leg.ItemTokenSize = Legend_ItemTokenSize;
        set(leg,'Box','off')
    end
end

    function [layout,p1] = f_plot_in_out_left(rst,stg,sbtab,helper,reuse)

        if reuse
            name_short = "E " + (n-1) + " " + helper;
            name_long = "Experiment " + (n-1) + " " + helper + "  (E " +...
                (n-1) + " " + helper +")";
        else
            name_short = "E " + (n-1);
            name_long = "Experiment " + (n-1) + "  (E " + (n-1) +")";
        end
%         if reuse
            figHandles = findobj('type', 'figure', 'name', name_short);
            close(figHandles);
            figure('WindowStyle', 'docked','Name', name_short,...
                'NumberTitle', 'off');
            %             sgtitle( "Experiment " + (n-1) + " " + helper + "  (E " +...
            %                 (n-1) + " " + helper +")",'FontSize', Major_title_FontSize,'Fontweight','bold');
%         else
%             figHandles = findobj('type', 'figure', 'name', "E " + (n-1));
%             close(figHandles);
%             figure('WindowStyle', 'docked','Name', "E " + (n-1),...
%                 'NumberTitle', 'off','Position', [0 0 15 6]);
            %             sgtitle( "Experiment " + (n-1) + "  (E " + (n-1) +...
            %                 ")",'FontSize', Major_title_FontSize,'Fontweight','bold');
%         end


        layout = tiledlayout(2,4,'Padding',"tight",'TileSpacing','compact' );

        layout.Units = 'centimeters';
        layout.OuterPosition = [0 0 15 7];
        %         subplot(2,4,[1,2,5,6])
        nexttile(layout,[2 2]);

        title(layout,name_long,...
            'FontSize', Major_title_FontSize,'Fontweight','bold')
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

                    % Get the correct label for each input of the
                    % experiment
%                     labelfig2(o) = rst(p).simd{1,n}.DataNames(str2double(...
%                         strrep(sbtab.datasets(n).input(o),'S',''))+1);

                    ylabel(string(rst(p).simd{1,n}.DataInfo{...
                        str2double(strrep(sbtab.datasets(n).input(o),'S',''))+1,1}.Units),...
                        'FontSize', Axis_FontSize,'Fontweight','bold')


                    break
                end
            end

        end

        %         set(gca,'FontSize',12,'Fontweight','bold')



        xlabel('seconds','FontSize', Axis_FontSize,'Fontweight','bold')
        % Add a legend to each plot


%         leg = legend(labelfig2,...
%             'FontSize', Legend_FontSize,'Fontweight',Legend_Fontweight,'Location','Best',"Orientation","Horizontal");
%         % leg.Layout.Tile = 'South';
%         leg.ItemTokenSize = Legend_ItemTokenSize;
%         set(leg,'Box','off')
%         %         legend(labelfig2,'FontSize', 16,'Fontweight','bold')
%         %         legend boxoff
% %         clear labelfig2

        ylim([0 inf])

        % Add a title to each plot
        title("Inputs",'FontSize', Minor_title_FontSize,'Fontweight','bold')

        hold off
    end
end