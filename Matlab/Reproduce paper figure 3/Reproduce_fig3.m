load("Reproduce paper figure 3/Analysis.mat")

rst = rst.diag;

addpath(genpath(pwd));

% Create needed folders
mkdir("Model/" + stg.folder_model,"Data");
mkdir("Model/" + stg.folder_model,"Formulas");
mkdir("Model/" + stg.folder_model,"tsv");
mkdir("Model/" + stg.folder_model,"Data/Exp");

% Runs the import scripts if chosen in settings
f_import(stg,sb)

addpath(genpath(pwd));

% Import the data on the first run
load("Model/" + stg.folder_model + "/Data/data_" + stg.name +...
    ".mat",'Data','sbtab')

f_plot_in_out2(rst,stg,sbtab,Data)

function f_plot_in_out2(rst,stg,sbtab,Data)
layout2 = [];
n = 5;

helper = 1;

f_plot_in_out_left(rst,stg,sbtab,helper,...
    size(sbtab.datasets(n).output,2) > 4)

for j = 1:size(sbtab.datasets(n).output,2)
    
    if j/4 > helper
        helper = helper +1;
        f_plot_in_out_left(rst,stg,sbtab,helper,...
            size(sbtab.datasets(n).output,2) > 4)
    end
    
    nexttile(layout2);
    
    hold on
    
    % Iterate over the number of parameter arrays to test
    for m = stg.pat
        % (Until a non broken simulation is found)
        if rst(m).simd{1,n} ~= 0
            
            % Plot the outputs to each dataset (new subplots) as they
            % are given in the data provided in sbtab
            plot(rst(m).simd{1,n}.Time,Data(n).Experiment.x(:,j),'k',...
                'DisplayName','data','LineWidth',1.5)
            break
        end
    end
    % Iterate over the number of parameter arrays to test
    for m = stg.pat
        
        % Plot only if the simulation was successful
        if rst(m).simd{1,n} ~= 0
            
            % Plot the outputs to each dataset (new subplots) and
            % parameter array to test that are simulated using
            % Simbiology while also normalizating with the starting
            % point of the result
            if sbtab.datasets(n).normstart == 1
                plot(rst(m).simd{1,n}.Time,...
                    rst(m).simd{1,n}.Data(1:end,...
                    end-size(sbtab.datasets(n).output,2)+j)./...
                    rst(m).simd{1,n}.Data(1,end-...
                    size(sbtab.datasets(n).output,2)+j),'r',...
                    'DisplayName',string("Parameter set "+m),...
                    'LineWidth',1)
            else
                
                % Plot the outputs to each dataset (new subplots) and
                % parameter array to test that are simulated using
                % Simbiology
                plot(rst(m).simd{1,n}.Time,...
                    rst(m).simd{1,n}.Data(1:end,end-...
                    size(sbtab.datasets(n).output,2)+j),'r',...
                    'DisplayName',string("Parameter set "+m),...
                    'LineWidth',1)
            end
        end
    end
    
    hold off
    
    set(gca,'FontSize',8,'Fontweight','bold')
    
    xlabel('seconds','FontSize', 8,'Fontweight','bold')
    ylabel('nanomole/liter','FontSize', 8,'Fontweight','bold')
    
    % Choose correct title according to settings
    if stg.plotoln == 1
        title(strrep(string(sbtab.datasets(n).output_name{1,j}),'_',...
            '\_'),'FontSize', 8,'Fontweight','bold')
    else
        title(string(sbtab.datasets(n).output{1,j}),'FontSize', 16,...
            'Fontweight','bold')
    end
    
    % Choose number of decimal places for y axis
    ytickformat('%.2g')
end
% end

    function f_plot_in_out_left(rst,stg,sbtab,helper,reuse)
        if reuse
            figHandles = findobj('type', 'figure', 'name', "E " + (n-1) +...
                " " + helper);
            close(figHandles);
            figure('WindowStyle', 'docked','Name', "E " + (n-1)+ " " +...
                helper,'NumberTitle', 'off');
            layout = tiledlayout(1,3,'Padding','none','TileSpacing','compact');
            
        else
            figHandles = findobj('type', 'figure', 'name', "E " + (n-1));
            close(figHandles);
            figure('WindowStyle', 'docked','Name', "E " + (n-1),...
                'NumberTitle', 'off');
            layout = tiledlayout(1,3,'Padding','none','TileSpacing','compact');
            
        end
        
        layout1 = tiledlayout(layout,1,1);
        layout1.Layout.Tile = 1;
        txt = title(layout1,"Inputs");
        txt.FontSize = 10;
        txt.FontWeight = 'bold';
        nexttile(layout1);
        
        hold on
        
        for o = 1:size(sbtab.datasets(n).input,2)
            for p = stg.pat
                
                % (Until a non broken simulation is found)
                if rst(p).simd{1,n} ~= 0
                    % Plot the inputs to each experiment
                    plot(rst(p).simd{1,n}.Time,rst(p).simd{1,n}.Data(1:end,...
                        str2double(strrep(sbtab.datasets(n).input(o),'S','')...
                        )+1),'LineWidth',1)
                    
                    % Get the correct label for each input of the experiment
                    labelfig2(o) = rst(p).simd{1,n}.DataNames(str2double(...
                        strrep(sbtab.datasets(n).input(o),'S',''))+1);
                    
                    break
                end
            end
        end
        
        set(gca,'FontSize',8,'Fontweight','bold')
        xlabel('seconds','FontSize', 8,'Fontweight','bold')
        ylabel('nanomole/liter','FontSize', 8,'Fontweight','bold')
        % Add a legend to each plot
        legend(labelfig2,'FontSize', 6.5,'Fontweight','bold')
        legend boxoff
        clear labelfig2
        
        % Add a title to each plot
        title("Ca + Da (\Deltat=0s)",'FontSize', 8,'Fontweight','bold')
        
        hold off
        
        if size(sbtab.datasets(n).output,2) == 1
            layout2 = tiledlayout(layout,1,1);
        elseif size(sbtab.datasets(n).output,2) == 2
            layout2 = tiledlayout(layout,2,1);
        elseif size(sbtab.datasets(n).output,2) > 2 &&...
                size(sbtab.datasets(n).output,2) <= 4
            layout2 = tiledlayout(layout,2,2);
        end
        
        layout2.Layout.Tile = 2;
        layout2.Layout.TileSpan = [1 2];
        txt = title(layout2,"Outputs");
        txt.FontSize = 10;
        txt.FontWeight = 'bold';
    end

%Saves the graphs if running matlab 2020a or later
if f_check_minimum_version(9,8)
    layout.Units = 'inches';
    layout.OuterPosition = [0 0 6.5 3];
    
    exportgraphics(layout,...
        'Reproduce paper figure 3/Figure 3.png',...
        'Resolution',600)
    
    layout.Units = 'normalized';
    layout.OuterPosition = [0 0 1 1];
end
end