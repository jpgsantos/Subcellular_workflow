function f_plot_outputs(rst,stg,sbtab,Data)

% Inform the user that fig3 is being ploted
disp("Plotting Diag3")

% Get the total number of outputs to set the total number of plots
[plot_tn,~] = f_get_outputs(stg);
plot_n = 1;
fig_n = 0;

% Iterate over the number of experiments
for n = stg.ms.exprun
    
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
                
                % Plot the outputs to each dataset (new subplots) as they 
                % are given in the data provided in sbtab
                plot(rst(m).simd{1,n}.Time,Data(n).Experiment.x(:,j),'k',...
                    'DisplayName','data')
                break
            end
        end
        
        % Iterate over the number of parameter arrays to test
        for m = stg.pat
            
            % Plot only if the simulation was successful
            if rst(m).simd{1,n} ~= 0
                
                % Plot the outputs to each dataset (new subplots) and
                % parameter array to test that are simulated using
                % Sybiology while also normalizating with the starting
                % point of the result
                if sbtab.datasets(n).normstart == 1
                    scatter(rst(m).simd{1,n}.Time,...
                        rst(m).simd{1,n}.Data(1:end,...
                        end-size(sbtab.datasets(n).output,2)+j)./...
                        rst(m).simd{1,n}.Data(1,end-...
                        size(sbtab.datasets(n).output,2)+j),...
                        5,'filled','MarkerFaceAlpha',0.7,'DisplayName',string(m))
                else
                    
                    % Plot the outputs to each dataset (new subplots) and
                    % parameter array to test that are simulated using 
                    % Sybiology
                    scatter(rst(m).simd{1,n}.Time,...
                        rst(m).simd{1,n}.Data(1:end,end-...
                        size(sbtab.datasets(n).output,2)+j),...
                        5,'filled','MarkerFaceAlpha',0.7,'DisplayName',string(m))
                end
            end
        end
        

        
        hold off
        
        % Choose correct title according to settings
        if stg.plotnames == 1
            title("E" + (n-1) + " " +...
                strrep(string(sbtab.datasets(n).output_name{1,j}),'_','\_'))
        else
            title("E" + (n-1) + " " +...
                string(sbtab.datasets(n).output{1,j}))
        end
        
        % Choose number of decimal places for y axis
        ytickformat('%.2f')
    end
end
end