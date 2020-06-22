load("Reproduce paper figure 3/Analysis.mat")

rst = rst.diag;

addpath(genpath(pwd));

% Create needed folders
mkdir("Model/" + stg.folder_model,"Data");
mkdir("Model/" + stg.folder_model,"Formulas");
mkdir("Model/" + stg.folder_model,"tsv");
mkdir("Model/" + stg.folder_model,"Data/Exp");

% Runs the import scripts if chosen in settings
% f_import(stg,sb)

addpath(genpath(pwd));

% Import the data on the first run
load("Model/" + stg.folder_model + "/Data/data_" + stg.name +...
    ".mat",'Data','sbtab')

f_plot_in_out2(rst,stg,sbtab,Data)

function f_plot_in_out2(rst,stg,sbtab,Data)
layout1 = [];
layout2 = [];
layout3 = [];
layout4 = [];
n = 6;

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
    
    if j ~= 4
    set(gca,'xtick',[0,5,10,15,20])
    xticklabels({})
    end
    if j == 4
    xlabel('time (s)','FontSize', 8,'Fontweight','bold')
%     xticks([])
    end
    if j == 2
    yticks([1000,2000])
%     yticks([])
    end
    
    ylabel({strrep(string(sbtab.datasets(n).output_name{1,j}),'_',...
            '\_'),'nmol/l'},'FontSize', 8,'Fontweight','bold')
%     ylabel  
    
    % Choose correct title according to settings
    if stg.plotoln == 1
%         title(strrep(string(sbtab.datasets(n).output_name{1,j}),'_',...
%             '\_'),'FontSize', 8,'Fontweight','bold')
    else
%         title(string(sbtab.datasets(n).output{1,j}),'FontSize', 16,...
%             'Fontweight','bold')
    end
    
    % Choose number of decimal places for y axis
    ytickformat('%.2g')
end
% end

load('Reproduce paper figure 4/old_data','old_data')
load('Reproduce paper figure 4/new_data','new_data')

% figHandles = findobj('type', 'figure', 'name', 'Paper Figure 4');
% close(figHandles);
% figure('WindowStyle', 'docked','Name','Paper Figure 4','NumberTitle',...
%     'off');

layout4 = tiledlayout(layout1,2,1,'TileSpacing','compact');
% fig4 = tiledlayout(1,2,'Padding','none','TileSpacing','compact');
layout4.Layout
layout4.Layout.Tile = 2;
layout4.Layout.TileSpan = [2,1];

        
% Figure 4A
nexttile(layout4);
hold on
plot(new_data{1}(:,1), new_data{1}(:,2)/max(new_data{1}(:,2)),...
    '-.k', 'LineWidth', 1)
plot(new_data{2}(:,1), new_data{2}(:,2)/max(new_data{1}(:,2)),...
    'k', 'LineWidth', 1)

plot(old_data{1}(:,1), old_data{1}(:,2)/max(old_data{1}(:,2)),...
    '-.k', 'LineWidth', 2)
plot(old_data{2}(:,1), old_data{2}(:,2)/max(old_data{1}(:,2)),...
    'k', 'LineWidth', 2)
plot(new_data{1}(:,1), new_data{1}(:,2)/max(new_data{1}(:,2)),...
    '-.r', 'LineWidth', 1)

plot(new_data{2}(:,1), new_data{2}(:,2)/max(new_data{1}(:,2)),...
    'r', 'LineWidth', 1)
set(gca,'FontSize',8, 'FontWeight', 'bold')


ylabel('pSubstrate','FontSize',8);
xlabel('time (s)','FontSize',8);
legend({'Ca only',...
   'Ca + Da (\Deltat=1s)'},...
    'FontSize',6.5);
legend boxoff
text(-1.875,3.45,'C','FontWeight','bold');
hold off

% Figure 4B
nexttile(layout4);
hold on
plot(old_data{3}(:,1), old_data{3}(:,2),'k', 'LineWidth', 1.5)
plot(new_data{3}(:,1), new_data{3}(:,2),'r', 'LineWidth', 1)
plot([-4 4], [1 1], '--k', 'LineWidth', 1)
plot([0 0], [0 max(max(new_data{3}(:,2)),max(old_data{3}(:,2)))], '-.',...
    'LineWidth', 1, 'Color', [0.5 0.5 0.5])
set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel("\Deltat (s)",'FontSize',8);
ylabel("pSubstrate",'FontSize',8);
% legend({'Ca + Da','Ca + Da'},'location','northwest','FontSize',6.5);
% legend boxoff
% title('D','position',[-4.5 4.06])
text(-4.5,4.6,'D','FontWeight','bold');
hold off
% t = text(-4.5,4.2,'E');
% t.FontWeight = 'Bold';
%Saves the graphs if running matlab 2020a or later
% if f_check_minimum_version(9,8)
%     fig4.Units = 'inches';
%     fig4.OuterPosition = [0 0 6.5 2.15];
%     
%     exportgraphics(fig4,...
%         'Reproduce paper figure 4/Figure 4.png',...
%         'Resolution',600)
%     
%     fig4.Units = 'normalized';
%     fig4.OuterPosition = [0 0 1 1];
% end

    function f_plot_in_out_left(rst,stg,sbtab,helper,reuse)
        if reuse
            figHandles = findobj('type', 'figure', 'name', 'Paper Figure 3');
            close(figHandles);
            figure('WindowStyle', 'docked','Name', 'Paper Figure 3','NumberTitle', 'off');
            layout = tiledlayout(1,5,'Padding','none','TileSpacing','compact');
            
        else
            figHandles = findobj('type', 'figure', 'name', 'Paper Figure 3');
            close(figHandles);
            figure('WindowStyle', 'docked','Name', 'Paper Figure 3',...
                'NumberTitle', 'off');
            layout = tiledlayout(1,5,'Padding','none','TileSpacing','compact');
            
        end
        
        layout1 = tiledlayout(layout,3,1,'TileSpacing','compact');
        layout1.Layout.Tile = 1;
        layout1.Layout.TileSpan = [1,3];
        layout3 = tiledlayout(layout1,1,1,'TileSpacing','compact');
        layout3.Layout
        layout3.Layout.Tile = 1;
%         layout3.Layout.TileSpan = [1,2];
%         txt = title(layout3,"Inputs");
%         txt.FontSize = 10;
%         txt.FontWeight = 'bold';

        nexttile(layout3);
        
        hold on
        
        for o = 1:size(sbtab.datasets(n).input,2)
%             if  o == 1
%             yyaxis left
%             else
%             yyaxis right
%             end
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
        
%         yyaxis left
        
        set(gca,'FontSize',8,'Fontweight','bold')
        xlabel('time (s)','FontSize', 8,'Fontweight','bold')
        ylabel('nanomole/liter','FontSize', 8,'Fontweight','bold')
        % Add a legend to each plot
        legend(labelfig2,'FontSize', 6.5,'Fontweight','bold')
        legend boxoff
        clear labelfig2
        
        ylim([0 5000])
        xlim([3 8])
%         
        xticks([3,4,5,6,7,8])
        xticklabels({0,4,5,6,7,20})
        yticks([0,1000,3000,5000])
        
        % Add a title to each plot
        title("\Deltat = 1 s",'FontSize', 8,'Fontweight','bold')
        
        text(7.45,50,'//','fontsize',12);
        text(3.45,50,'//','fontsize',12);
        
        text(2.6875,5750,'A','FontWeight','bold');
%         txt.FontSize = 8;
%         txt.FontWeight = 'bold';
        text(8.75,5750,'B','FontWeight','bold');
%         txt.FontSize = 8;
%         txt.FontWeight = 'bold';
        hold off
        
        if size(sbtab.datasets(n).output,2) == 1
            layout2 = tiledlayout(layout,1,1,'TileSpacing','compact');
        elseif size(sbtab.datasets(n).output,2) == 2
            layout2 = tiledlayout(layout,1,2,'TileSpacing','compact');
        elseif size(sbtab.datasets(n).output,2) > 2 &&...
                size(sbtab.datasets(n).output,2) <= 4
            layout2 = tiledlayout(layout,4,1,'TileSpacing','none');
        end
        
        layout2.Layout.Tile = 4;
        layout2.Layout.TileSpan = [1 2];
%         txt = title(layout2,"Outputs");
%         txt.FontSize = 10;
%         txt.FontWeight = 'bold';
    end

%Saves the graphs if running matlab 2020a or later
if f_check_minimum_version(9,8)
    layout.Units = 'inches';
    layout.OuterPosition = [0 0 6.85 4];
    
    pause(1)
    
    exportgraphics(layout,...
        'Reproduce paper figure 3/Figure 3 alt3.png',...
        'Resolution',600)
%     
%     layout.Units = 'normalized';
%     layout.OuterPosition = [0 0 1 1];
end
end