function f_Reproduce_sup_fig5(folder)
set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultAxesFontName', 'Times New Roman')
load(folder + "E0_pERK_NEURON")
load(folder + "data_Viswan_2018_optimized.mat",'Data','sbtab')
load(folder + "Analysis.mat")
% load(folder + "inputs")

rst = rst.diag;

figHandles = findobj('type', 'figure', 'name', 'Paper Figure 7');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper Figure 7','NumberTitle',...
    'off');
layout = tiledlayout(2,2,'Padding','none','TileSpacing','compact');

layout.Units = 'inches';
layout.OuterPosition = [0 0 6.85 3];

nexttile(layout);

hold on

n = 1;
for o = 1:size(sbtab.datasets(n).input,2)
    
    p = 1;
    m = 5;
    % Plot the inputs to each experiment
    plot(rst(p).simd{1,m}.Time,rst(p).simd{1,m}.Data(1:end,...
        str2double(strrep(sbtab.datasets(n).input(o),'S','')...
        )+1),'LineWidth',1)
    
    % Get the correct label for each input of the experiment
    labelfig2(o) = rst(p).simd{1,m}.DataNames(str2double(...
        strrep(sbtab.datasets(n).input(o),'S',''))+1);
end

set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (s)','FontSize', 8,'Fontweight','bold')
ylabel('micromole/liter','FontSize', 8,'Fontweight','bold')
legend(labelfig2,'FontSize', 6.5,'Fontweight','bold')
legend boxoff
clear labelfig2
ylim([0 0.1])
xlim([0 10000])

text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'A','fontsize',10,'FontWeight','bold');

% Figure 7B
nexttile(layout);

hold on
m = 1;
    j = 1;
    p = 1;
time_detailed = rst(2).simd{1,m+2*stg.expn}.Time;
[~,sim_results_detailed]= f_normalize(rst(2),stg,m,j,folder);

plot(time_detailed,...
    sim_results_detailed,'k',...
    'DisplayName',string("Parameter set "+p),...
    'LineWidth',1)

plot (Time,pERK_ratio,'Color',[1 0 0], 'LineWidth',1)


set(gca,'FontSize',8,'Fontweight','bold')

xlabel('time (s)','FontSize', 8,'Fontweight','bold')
ylabel('pERK1\_2\_ratio1','FontSize', 8,'Fontweight','bold')
% plot([-4 4], [1 1], '--', 'LineWidth', 1,'Color', [0.5 0.5 0.5])
% plot([0 0], [0 1.2], '-.',...
%     'LineWidth', 1, 'Color', [0.5 0.5 0.5])
    legend(["MATLAB","NEURON"],'FontSize', 6.5,'Fontweight','bold')
    legend boxoff
hold off
% ylim ([0 5])
% yticks([0,1,3,5])

text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'B','fontsize',10,'FontWeight','bold');

load(folder + "E0_Vs_before")
load(folder + "E0_Vs_after")

% Figure 7C
nexttile(layout);

hold on
plot(Time,Vs_before)

% title('Spine')
set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (ms)','FontSize', 8,'Fontweight','bold')
ylabel('V (mV)','FontSize', 8,'Fontweight','bold')
hold off

xlim ([0 1000])
% leg = legend({'Ca','Ca + DA (\Deltat=-1s)','Ca + DA (\Deltat=1s)'},'FontSize', 6.5,'Fontweight','bold');
% leg.ItemTokenSize = [20,18];
% legend boxoff

text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'C','fontsize',10,'FontWeight','bold');


load(folder + "E0_Vs_after")
% Figure 7D
nexttile(layout);

hold on
plot(Time,Vs_after)
set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (ms)','FontSize', 8,'Fontweight','bold')
ylabel('V (mV)','FontSize', 8,'Fontweight','bold')
hold off
xlim ([0 1000])
% leg = legend({'Ca','Ca + DA (\Deltat=-1s)','Ca + DA (\Deltat=1s)'},'FontSize', 6.5,'Fontweight','bold');
% leg.ItemTokenSize = [20,18];
% legend boxoff
text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'D','fontsize',10,'FontWeight','bold');

%Saves the graphs if running matlab 2020a or later
% if f_check_minimum_version(9,8)

exportgraphics(layout,...
    folder + "supplementary figure 5.png",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "supplementary figure 5.tiff",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "supplementary figure 5.pdf",...
    'ContentType','vector')
% end
end

function [sim_results,sim_results_detailed] = f_normalize(rst,stg,exp_number,output_number,folder)

% load("Model/" +stg.folder_model + "/Data/data_"+stg.name+".mat",'Data','sbtab')

% persistent sbtab
% persistent Data
% persistent sb

% if isempty(Data)
load(folder + "data_Viswan_2018_optimized.mat",'Data','sbtab','sb')
% end

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