function f_plot_inputs(rst,stg,sbtab)
% Generates a figure with Inputs, one subplot per experiment

% Inform the user that fig2 is being ploted
disp("Plotting Inputs")

plot_n = 1;
fig_n = 0;
layout = [];
% Iterate over the number of experiments
for n = stg.exprun
    
    % Generate the right amount of figures for all plots and calculates
    % proper subploting position
    
        [fig_n,layout] = f_get_subplot(size(stg.exprun,2),plot_n,fig_n,"Inputs",layout);
    nexttile(layout);
    
%     fig_n = f_get_subplot(size(stg.exprun,2),plot_n,fig_n,"Inputs");
    
if mod(plot_n,24) == 1
%             Lgnd = legend('show','Orientation','Horizontal');
%             Lgnd.Position(1) = 0;
%             Lgnd.Position(2) = 0.5;
%             Lgnd.Layout.Tile = 'North';
            xlabel(layout,"seconds", 'FontSize', 12,'Fontweight','bold')
%             ylabel(layout,string(rst(m).simd{1,n}.DataInfo{end-...
%                     size(sbtab.datasets(n).output,2)+j,1}.Units), 'FontSize', 12,'Fontweight','bold')
%             legend boxoff
            
%             ylabel(string(rst(m).simd{1,n}.DataInfo{end-...
%                     size(sbtab.datasets(n).output,2)+j,1}.Units))
        end


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
                    str2double(strrep(sbtab.datasets(n).input(j),'S',''))+1),'LineWidth',1.5)
                
                % Get the correct label for each input of the experiment
                labelfig2(j) = rst(m).simd{1,n}.DataNames(str2double(...
                    strrep(sbtab.datasets(n).input(j),'S',''))+1);
                                  
                ylabel(layout,string(rst(m).simd{1,n}.DataInfo{...
                    str2double(strrep(sbtab.datasets(n).input(j),'S',''))+1,1}.Units),...
                    'FontSize', 12,'Fontweight','bold')
                
                break
            end
        end
    end
    
%     xlabel('seconds') 
    % Add a legend to each plot
    legend(labelfig2)
    legend boxoff
    clear labelfig2
    
    ylim([0 inf])
    
    % Add a title to each plot
    title("E"+(n-1))
    
    hold off
end

end