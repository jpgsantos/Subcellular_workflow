function f_Reproduce_plot_sup_fig3(folder)
load(folder + "Copasi_simulation_results.mat")
load(folder + "data_Viswan_2018_optimized_sup_fig3.mat",'Data','sbtab')
set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultAxesFontName', 'Times New Roman')

addpath(genpath(pwd));

n = 1;

figHandles = findobj('type', 'figure', 'name', 'Paper supplementary figure 3');
close(figHandles);
figure('WindowStyle', 'docked','Name', 'Paper supplementary figure 3',...
    'NumberTitle', 'off');
layout = tiledlayout(1,2,'Padding','none','TileSpacing','compact');

layout.Units = 'inches';
layout.OuterPosition = [0 0 6.85 4];

% Supplementary figure 3A
layout1 = tiledlayout(layout,2,1,'TileSpacing','compact');
layout1.Layout.Tile = 1;
layout1.Layout.TileSpan = [1,1];

nexttile(layout1);

hold on

plot(E0_Time,E0_Input,'LineWidth',1)

set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (s)','FontSize', 8,'Fontweight','bold')
ylabel('micromole/liter','FontSize', 8,'Fontweight','bold')
legend("EGF",'FontSize', 6.5,'Fontweight','bold')
legend boxoff
clear labelfig2
ylim([0 0.1])
xlim([0 10000])

text(-500,0.11,'A','FontWeight','bold');

% Supplementary figure 3C
nexttile(layout1);

hold on
plot(E1_Time,E1_Input,'LineWidth',1)

set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (s)','FontSize', 8,'Fontweight','bold')
ylabel('micromole/liter','FontSize', 8,'Fontweight','bold')
legend("EGF",'FontSize', 6.5,'Fontweight','bold')
legend boxoff
clear labelfig2

ylim([0 0.001])
xlim([0 40000])

text(7.45,50,'//','fontsize',12);
text(3.45,50,'//','fontsize',12);

text(-2000,0.0011,'C','FontWeight','bold');
hold off

% Supplementary figure 3B and D
layout2 = tiledlayout(layout,2,1);
layout2.Layout.Tile = 2;
layout2.Layout.TileSpan = [1,1];

for m = 1:2
    nexttile(layout2);
    j = 1;
    p = 1;
    hold on

    time = Data(m).Experiment.t(:,j);
    data = Data(m).Experiment.x(:,j);
    
    data_SD = Data(m).Experiment.x_SD(:,j);

    errorbar(time,data,data_SD,'ok','LineWidth',1,'MarkerSize',3,'MarkerFaceColor','k');

    if m == 1
        plot(E0_Time,E0_orig_norm,'b','LineWidth',1)
        plot(E0_Time,E0_opt_norm,'r','LineWidth',1)
    else
        plot(E1_Time,E1_orig_norm,'b','LineWidth',1)
        plot(E1_Time,E1_opt_norm,'r','LineWidth',1)
    end

    hold off
    
    set(gca,'FontSize',8,'Fontweight','bold')
    
    xlabel('time (s)','FontSize', 8,'Fontweight','bold')
    
    legend(["Data + SEM","Original parameters","Optimized parameters"],'FontSize', 6.5,'Fontweight','bold')
    legend boxoff
    
    % Choose number of decimal places for y axis
    ytickformat('%.2g')
    if m == 1
        ylabel('MAPK_p + MAPK_p_p (\muM)','FontSize', 8,'Fontweight','bold')
        text(-500,1.65,'B','FontWeight','bold');
        
    else
        text(-2000,3.85,'D','FontWeight','bold');
        ylabel('MAPK_p + MAPK_p_p (\muM)','FontSize', 8,'Fontweight','bold')
        ylim([0 3.5])
    end
end


%Saves the graphs
exportgraphics(layout,...
    folder + "supplementary figure 3.png",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "supplementary figure 3.tiff",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "supplementary figure 3.pdf",...
    'ContentType','vector')

end
function [sim_results,sim_results_detailed] = f_normalize(rst,stg,exp_number,output_number,folder)

    load(folder + "data_Viswan_2018_optimized.mat",'Data','sbtab','sb')

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
        
        if contains(sbtab.datasets(exp_number).Normalize,sbtab.datasets(exp_number).output_ID{output_number}{:})
            norm_factor = rst.simd{1,exp_number}.Data(:,end-...
                size(sbtab.datasets(exp_number).output,2)+output_number);
            
            
            sim_results = sim_results/max(norm_factor);
            if stg.simdetail
                sim_results_detailed = sim_results_detailed/max(norm_factor);
            end
        end
    end
    if contains(sbtab.datasets(exp_number).Normalize,'Min')
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