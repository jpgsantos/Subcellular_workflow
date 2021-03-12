function f_plot_outputs(rst,stg,sbtab,Data)
% Generates a figure with Outputs, one subplot per experimental output

% Inform the user that fig3 is being ploted
disp("Plotting Outputs")

% Get the total number of outputs to set the total number of plots
[plot_tn,~] = f_get_outputs(stg);
plot_n = 1;
fig_n = 0;

% Iterate over the number of experiments
for n = stg.exprun
    
    % Iterate over the number of datasets in each experiment
    for j = 1:size(sbtab.datasets(n).output,2)
        
        % Generate the right amount of figures for all plots and calculates
        % proper subploting position
        fig_n = f_get_subplot(plot_tn,plot_n,fig_n,"Outputs");
        
        % Add a legend to the figure
        if mod(plot_n,24) == 1
            Lgnd = legend('show');
            Lgnd.Position(1) = 0;
            Lgnd.Position(2) = 0.5;
            legend boxoff
        end
        
        plot_n = plot_n + 1;
        
        hold on
        
        % Iterate over the number of parameter arrays to test
        for m = stg.pat
            % (Until a non broken simulation is found)
            if rst(m).simd{1,n} ~= 0
                
                time = rst(m).simd{1,n}.Time;
                data = Data(n).Experiment.x(:,j);
                
                data_SD = Data(n).Experiment.x_SD(:,j);
                
                % Plot the outputs to each dataset (new subplots) as they
                % are given in the data provided in sbtab
                scatter(time,data,'filled','k',...
                    'DisplayName','data')
                
                errorbar(time,data,data_SD, 'vertical',	'k', 'LineStyle', 'none','LineWidth',1);
                
                break
            end
        end
        
        % Iterate over the number of parameter arrays to test
        for m = stg.pat
            
            % Plot only if the simulation was successful
            if rst(m).simd{1,n} ~= 0
                
                time = rst(m).simd{1,n}.Time;
                [sim_results,~] = f_normalize(rst(m),stg,n,j);
                if stg.simdetail
                    time_detailed = rst(m).simd{1,n+2*stg.expn}.Time;
                    [~,sim_results_detailed]= f_normalize(rst(m),stg,n,j);
                end
                
                % Plot the outputs to each dataset (new subplots) and
                % parameter array to test that are simulated using
                % Simbiology
                if stg.simdetail
                    plot(time_detailed,...
                        sim_results_detailed,'DisplayName',...
                        string("Parameter set "+m),'LineWidth',1.5)
                else
                    
                    plot(time,...
                        sim_results,'DisplayName',...
                        string("Parameter set "+m),'LineWidth',1.5)
                end
                
                ylabel(string(rst(m).simd{1,n}.DataInfo{end-...
                    size(sbtab.datasets(n).output,2)+j,1}.Units))
            end
        end
        
        hold off
        
        xlabel('seconds')
        
        if stg.simdetail
            ylim([min([0,min(sim_results_detailed),min(sim_results),min(data-data_SD),min(data)]) inf])
        else
            ylim([min([0,min(sim_results),min(data-data_SD),min(data)]) inf])
        end
        
        % Choose correct title according to settings
        if stg.plotoln == 1
            title("E" + (n-1) + " " +...
                strrep(string(sbtab.datasets(n).output_name{1,j}),'_','\_'))
        else
            title("E" + (n-1) + " " +...
                string(sbtab.datasets(n).output{1,j}))
        end
        
        % Choose number of decimal places for y axis
        ytickformat('%.2g')
    end
end
end