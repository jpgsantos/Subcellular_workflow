function f_Reproduce_sup_fig_3(folder)
load(folder + "Copasi_simulation_results.mat")
% load(folder + "Analysis.mat")
set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultAxesFontName', 'Times New Roman')

% rst = rst.diag;

addpath(genpath(pwd));

% Import the data on the first run
load(folder + "data_Viswan_2018_optimized.mat",'Data','sbtab')

n = 1;


figHandles = findobj('type', 'figure', 'name', 'Paper supplementary figure 3');
close(figHandles);
figure('WindowStyle', 'docked','Name', 'Paper supplementary figure 3',...
    'NumberTitle', 'off');
layout = tiledlayout(1,2,'Padding','none','TileSpacing','compact');

% if f_check_minimum_version(9,8)
    layout.Units = 'inches';
    layout.OuterPosition = [0 0 6.85 4];
% end

% supplementary figure 1A
layout1 = tiledlayout(layout,2,1,'TileSpacing','compact');
layout1.Layout.Tile = 1;
layout1.Layout.TileSpan = [1,1];

nexttile(layout1);

hold on

% for o = 1:size(sbtab.datasets(n).input,2)

%     p = 1;
%     m = 5;
% Plot the inputs to each experiment
plot(E0_Time,E0_Input,'LineWidth',1)

% Get the correct label for each input of the experiment
%     labelfig2(o) = rst(p).simd{1,m}.DataNames(str2double(...
%         strrep(sbtab.datasets(n).input(o),'S',''))+1);
% end

set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (s)','FontSize', 8,'Fontweight','bold')
ylabel('micromole/liter','FontSize', 8,'Fontweight','bold')
legend("EGF",'FontSize', 6.5,'Fontweight','bold')
legend boxoff
clear labelfig2
ylim([0 0.1])
xlim([0 10000])

text(-500,0.11,'A','FontWeight','bold');

nexttile(layout1);

hold on
plot(E1_Time,E1_Input,'LineWidth',1)
% for o = 1:size(sbtab.datasets(n).input,2)
%
%     p = 1;
%     m = 6;
%     % Plot the inputs to each experiment
% %     plot(rst(p).simd{1,m}.Time,rst(p).simd{1,m}.Data(1:end,...
% %         str2double(strrep(sbtab.datasets(n).input(o),'S','')...
% %         )+1),'LineWidth',1)
%
%     % Get the correct label for each input of the experiment
% %     labelfig2(o) = rst(p).simd{1,m}.DataNames(str2double(...
% %         strrep(sbtab.datasets(n).input(o),'S',''))+1);
% end

set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (s)','FontSize', 8,'Fontweight','bold')
ylabel('micromole/liter','FontSize', 8,'Fontweight','bold')
legend("EGF",'FontSize', 6.5,'Fontweight','bold')
legend boxoff
clear labelfig2

ylim([0 0.001])
xlim([0 40000])

% xlim([3 8])

% xticks([3,4,5,6,7,8])
% xticklabels({0,4,5,6,7,20})
% yticks([0,1000,3000,5000])

text(7.45,50,'//','fontsize',12);
text(3.45,50,'//','fontsize',12);

% text(0,0.115,'A','FontWeight','bold');
text(-2000,0.0011,'C','FontWeight','bold');
hold off

% supplementary figure 1B
layout2 = tiledlayout(layout,2,1);
layout2.Layout.Tile = 2;
layout2.Layout.TileSpan = [1,1];

for m = 1:2
    nexttile(layout2);
    j = 1;
    p = 1;
    hold on
    %     if m = 1
    %     if rst(1).simd{1,m} ~= 0
    
    %         time = rst(1).simd{1,m}.Time;
    time = Data(m).Experiment.t(:,j);
    data = Data(m).Experiment.x(:,j);
    
    data_SD = Data(m).Experiment.x_SD(:,j);
    
    % Plot the outputs to each dataset (new subplots) as they
    % are given in the data provided in sbtab
%     scatter(time,data,'filled','k',...
%         'DisplayName','data')
    
    errorbar(time,data,data_SD,'ok','LineWidth',1,'MarkerSize',3,'MarkerFaceColor','k');
    %     end
    %     if m = 2
    
    %     end
    
    if m == 1
        plot(E0_Time,E0_orig_norm,'b','LineWidth',1)
        plot(E0_Time,E0_opt_norm,'r','LineWidth',1)
    else
        plot(E1_Time,E1_orig_norm,'b','LineWidth',1)
        plot(E1_Time,E1_opt_norm,'r','LineWidth',1)
    end
    %         time_detailed = rst(1).simd{1,m+2*stg.expn}.Time;
    %         [~,sim_results_detailed]= f_normalize(rst(1),stg,m,j);
    %
    %     % Plot the outputs to each dataset (new subplots) as they
    %     % are given in the data provided in sbtab
    %     %     plot(rst(p).simd{1,p}.Time,Data(n).Experiment.x(:,j),'k',...
    %     %         'DisplayName','data','LineWidth',1.5)
    %
    %     plot(time_detailed,...
    %         sim_results_detailed,'b',...
    %         'DisplayName',string("Parameter set "+p),...
    %         'LineWidth',1)
    %
    %
    %     time_detailed = rst(2).simd{1,m+2*stg.expn}.Time;
    %     [~,sim_results_detailed]= f_normalize(rst(2),stg,m,j);
    %
    %     % Plot the outputs to each dataset (new subplots) and
    %     % parameter array to test that are simulated using
    %     % Simbiology
    %     plot(time_detailed,...
    %         sim_results_detailed,'r',...
    %         'DisplayName',string("Parameter set "+p),...
    %         'LineWidth',1)
    
    hold off
    
    set(gca,'FontSize',8,'Fontweight','bold')
    
    xlabel('time (s)','FontSize', 8,'Fontweight','bold')
    
    legend(["Data + SEM","Original parameters","Optimized parameters"],'FontSize', 6.5,'Fontweight','bold')
    legend boxoff
    
    % Choose number of decimal places for y axis
    ytickformat('%.2g')
    if m == 1
        ylabel("pERK1\_2\_ratio1",'FontSize', 8,'Fontweight','bold')
        text(-500,1.65,'B','FontWeight','bold');
        
    else
        text(-2000,3.85,'D','FontWeight','bold');
        ylabel("pERK1\_2\_ratio2",'FontSize', 8,'Fontweight','bold')
        ylim([0 3.5])
    end
end


%Saves the graphs if running matlab 2020a or later
% if f_check_minimum_version(9,8)

exportgraphics(layout,...
    folder + "supplementary figure 3.png",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "supplementary figure 3.tiff",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "supplementary figure 3.pdf",...
    'ContentType','vector')
% end
end
function [sim_results,sim_results_detailed] = f_normalize(rst,stg,exp_number,output_number,folder)

% load("Model/" +stg.folder_model + "/Data/data_"+stg.name+".mat",'Data','sbtab')

persistent sbtab
persistent Data
persistent sb

if isempty(Data)
    load(folder + "data_Viswan_2018_optimized.mat",'Data','sbtab','sb')
end

sim_results = rst.simd{1,exp_number}.Data(:,end-...
    size(sbtab.datasets(exp_number).output,2)+output_number);

if stg.simdetail
    sim_results_detailed = rst.simd{1,exp_number+2*stg.expn}.Data(:,end-...
        size(sbtab.datasets(exp_number).output,2)+output_number);
else
    sim_results_detailed = [];
end

if ~isempty(sbtab.datasets(exp_number).Normalize)
    if contains(sbtab.datasets(exp_number).Normalize,'Max')
        
        %         for n = 1:size(sb.Compound.ID,1)
        %             if contains(sbtab.datasets(exp_number).Normalize,sb.Compound.ID(n))
        %                 norm_factor = rst.simd{1,exp_number}.Data(:,n);
        %                 norm_factor
        %             end
        %         end
        
        if contains(sbtab.datasets(exp_number).Normalize,sbtab.datasets(exp_number).output_ID{output_number}{:})
            %                     m
            norm_factor = rst.simd{1,exp_number}.Data(:,end-...
                size(sbtab.datasets(exp_number).output,2)+output_number);
            
            
            sim_results = sim_results/max(norm_factor);
            if stg.simdetail
                sim_results_detailed = sim_results_detailed/max(norm_factor);
            end
        end
    end
    if contains(sbtab.datasets(exp_number).Normalize,'Min')
        
        %         for n = 1:size(sb.Compound.ID,1)
        %             if contains(sbtab.datasets(exp_number).Normalize,sb.Compound.ID(n))
        %                 norm_factor = rst.simd{1,exp_number}.Data(:,n);
        %             end
        %         end
        
        if contains(sbtab.datasets(exp_number).Normalize,sbtab.datasets(exp_number).output_ID{output_number}{:})
            norm_factor = rst.simd{1,exp_number}.Data(:,end-...
                size(sbtab.datasets(exp_number).output,2)+output_number);
            
            
            sim_results = sim_results/min(norm_factor);
            if stg.simdetail
                sim_results_detailed = sim_results_detailed/min(norm_factor);
            end
        end
    end
    
    if contains(sbtab.datasets(exp_number).Normalize,'Time')
        
        %         for n = 1:size(sb.Compound.ID,1)
        %             if contains(sbtab.datasets(exp_number).Normalize,sb.Compound.ID(n))
        %                 norm_factor = rst.simd{1,exp_number}.Data(:,n);
        %             end
        %         end
        
        if contains(sbtab.datasets(exp_number).Normalize,sbtab.datasets(exp_number).output_ID{output_number}{:})
            norm_factor = rst.simd{1,exp_number}.Data(:,end-...
                size(sbtab.datasets(exp_number).output,2)+output_number);
            
            for n = 1:size(Data(exp_number).Experiment.t,1)
                if contains(sbtab.datasets(exp_number).Normalize,eval("sb.E"+(exp_number-1)+".ID(n)"))
                    sim_results = sim_results/norm_factor(n);
                    if stg.simdetail
                        sim_results_detailed = sim_results_detailed/norm_factor(n);
                    end
                end
            end
        end
    end
end
end