function f_plot_inputs(rst,stg,sbtab)
% Generates a figure with Inputs, one subplot per experiment

% Inform the user that fig2 is being ploted
disp("Plotting Inputs")

plot_n = 1;
fig_n = 0;
% Iterate over the number of experiments
for n = stg.exprun
    
    % Generate the right amount of figures for all plots and calculates
    % proper subploting position
    fig_n = f_get_subplot(size(stg.exprun,2),plot_n,fig_n,"Inputs");
    
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
                                  
                ylabel(string(rst(m).simd{1,n}.DataInfo{...
                    str2double(strrep(sbtab.datasets(n).input(j),'S',''))+1,1}.Units))
                
                break
            end
        end
    end
    
    xlabel('seconds') 
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