load("Reproduce paper figure 3/Analysis_new.mat")

set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultAxesFontName', 'Times New Roman')

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

n = 6;

figHandles = findobj('type', 'figure', 'name', 'Paper Figure 3');
close(figHandles);
figure('WindowStyle', 'docked','Name', 'Paper Figure 3',...
    'NumberTitle', 'off');
layout = tiledlayout(1,5,'Padding','none','TileSpacing','compact');

if f_check_minimum_version(9,8)
    layout.Units = 'inches';
    layout.OuterPosition = [0 0 6.85 4];
end

% Figure 3A
layout1 = tiledlayout(layout,3,1,'TileSpacing','compact');
layout1.Layout.Tile = 1;
layout1.Layout.TileSpan = [1,3];

nexttile(layout1);

hold on

for o = 1:size(sbtab.datasets(n).input,2)

    p = 1;
    % Plot the inputs to each experiment
    plot(rst(p).simd{1,n}.Time,rst(p).simd{1,n}.Data(1:end,...
        str2double(strrep(sbtab.datasets(n).input(o),'S','')...
        )+1),'LineWidth',1)
    
    % Get the correct label for each input of the experiment
    labelfig2(o) = rst(p).simd{1,n}.DataNames(str2double(...
        strrep(sbtab.datasets(n).input(o),'S',''))+1);
end

set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (s)','FontSize', 8,'Fontweight','bold')
ylabel('nanomole/liter','FontSize', 8,'Fontweight','bold')
legend(labelfig2,'FontSize', 6.5,'Fontweight','bold')
legend boxoff
clear labelfig2

ylim([0 5000])
xlim([3 8])

xticks([3,4,5,6,7,8])
xticklabels({0,4,5,6,7,20})
yticks([0,1000,3000,5000])

text(7.45,50,'//','fontsize',12);
text(3.45,50,'//','fontsize',12);

text(2.6875,5750,'A','FontWeight','bold');
text(8.7,5750,'B','FontWeight','bold');
hold off

% Figure 3B
layout2 = tiledlayout(layout,4,1,'TileSpacing','none');
layout2.Layout.Tile = 4;
layout2.Layout.TileSpan = [1 2];

for j = 1:size(sbtab.datasets(n).output,2)
    
    nexttile(layout2);
    
    m = 1;
    hold on
    
    % Plot the outputs to each dataset (new subplots) as they
    % are given in the data provided in sbtab
    plot(rst(m).simd{1,n}.Time,Data(n).Experiment.x(:,j),'k',...
        'DisplayName','data','LineWidth',1.5)
    
    % Plot the outputs to each dataset (new subplots) and
    % parameter array to test that are simulated using
    % Simbiology
    plot(rst(m).simd{1,n}.Time,...
        rst(m).simd{1,n}.Data(1:end,end-...
        size(sbtab.datasets(n).output,2)+j),'r',...
        'DisplayName',string("Parameter set "+m),...
        'LineWidth',1)
    
    hold off
    
    set(gca,'FontSize',8,'Fontweight','bold')
    
    if j ~= 4
        set(gca,'xtick',[0,5,10,15,20])
        xticklabels({})
    end
    if j == 4
        xlabel('time (s)','FontSize', 8,'Fontweight','bold')
    end
    if j == 2
        yticks([1000,2000])
    end
    
    ylabel({strrep(string(sbtab.datasets(n).output_name{1,j}),'_',...
        '\_'),'nmol/l'},'FontSize', 8,'Fontweight','bold')
    
    % Choose number of decimal places for y axis
    ytickformat('%.2g')
end

load('Reproduce paper figure 3/old_data','old_data')
load('Reproduce paper figure 3/new_data','new_data')

% Figure 3C
nexttile(layout1);
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

xlabel('time (s)','FontSize',8);
ylabel('pSubstrate','FontSize',8);
legend({'Ca','Ca + DA (\Deltat=1s)'},...
    'FontSize',6.5);
legend boxoff
text(-1.875,3.45,'C','FontWeight','bold');
hold off

% Figure 3D
nexttile(layout1);
hold on
plot(old_data{3}(:,1), old_data{3}(:,2),'k', 'LineWidth', 1.5)
plot(new_data{3}(:,1), new_data{3}(:,2),'r', 'LineWidth', 1)
plot([-4 4], [1 1], '--k', 'LineWidth', 1)
plot([0 0], [0 max(max(new_data{3}(:,2)),max(old_data{3}(:,2)))], '-.',...
    'LineWidth', 1, 'Color', [0.5 0.5 0.5])
set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel("\Deltat (s)",'FontSize',8);
ylabel("pSubstrate area",'FontSize',8);
text(-4.5,4.6,'D','FontWeight','bold');
hold off

%Saves the graphs if running matlab 2020a or later
if f_check_minimum_version(9,8)
    
    exportgraphics(layout,...
        'Reproduce paper figure 3/Figure 3.png',...
        'Resolution',600)
    
    exportgraphics(layout,...
        'Reproduce paper figure 3/Figure 3.tiff',...
        'Resolution',600)
    
    exportgraphics(layout,...
        'Reproduce paper figure 3/Figure 3.pdf',...
        'ContentType','vector')
end