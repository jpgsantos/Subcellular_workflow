function f_Reproduce_sup_fig5(folder)

set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultAxesFontName', 'Times New Roman')
% load(folder + "inputs")



figHandles = findobj('type', 'figure', 'name', 'Paper supplementary figure 5');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper supplementary figure 5','NumberTitle',...
    'off');
layout = tiledlayout(2,2,'Padding','none','TileSpacing','compact');

layout.Units = 'inches';
layout.OuterPosition = [0 0 6.85 4];
% layout.OuterPosition = [0 0 15 9];

load(folder + "E0_Vs_before_after_long")

% Figure 7C
nexttile(layout,[1 1]);
set(gca,'visible','off')
% set(gca,'xtick',[])

% hold on
% plot(Time,Vs_before)
% plot(Time,Vs_after)
% % title('Spine')
% set(gca,'FontSize',8,'Fontweight','bold')
% xlabel('time (ms)','FontSize', 8,'Fontweight','bold')
% ylabel('V (mV)','FontSize', 8,'Fontweight','bold')
% hold off
% 
% xlim ([0 10000])
% legend(["\color{red}400 - 410 seconds","\color{red}840 - 850 seconds"],'FontSize', 6.5,'Fontweight','bold');
% legend boxoff
% % leg = legend({'Ca','Ca + DA (\Deltat=-1s)','Ca + DA (\Deltat=1s)'},'FontSize', 6.5,'Fontweight','bold');
% % leg.ItemTokenSize = [20,18];
% % legend boxoff
% 
% text(min(xlim)-(max(xlim)-min(xlim))*3.5/64,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'C','fontsize',10,'FontWeight','bold');

load(folder + "E0_pERK_NEURON_long")
load(folder + "data_Viswan_2018_optimized.mat",'Data','sbtab')
load(folder + "Analysis.mat")
rst = rst.diag;

% nexttile(layout);
% 
% layout3 = tiledlayout(layout,1,1,'TileSpacing','none');
% layout3.Layout.Tile = 4;
% layout3.Layout.TileSpan = [1 1];
% % 
% % 
% hold on
% ax3 = axes(layout3);
% 
% n = 1;
% o = 1;
%     p = 1;
%     m = 5;
% %     % Plot the inputs to each experiment
% 
%     p3 = plot(ax3,rst(p).simd{1,m}.Time,rst(p).simd{1,m}.Data(1:end,...
%         str2double(strrep(sbtab.datasets(n).input(o),'S','')...
%         )+1),'LineWidth',1)
% 
% % m = 1;
% %     j = 1;
% %     p = 1;
% % time_detailed = rst(2).simd{1,m+2*stg.expn}.Time;
% % [~,sim_results_detailed]= f_normalize(rst(2),stg,m,j,folder);
% % 
% % p3 = plot(ax3,time_detailed,...
% %     sim_results_detailed,'k',...
% %     'DisplayName',string("Parameter set "+p),...
% %     'LineWidth',1)
% % 
% % 
% % set(gca,'FontSize',8,'Fontweight','bold')
% % ax4 = axes(layout3);
% % p4 = plot (ax4,Time,pERK_ratio,'Color',[1 0 0], 'LineWidth',1)
% 
% 
%        set(gca,'FontSize',8,'Fontweight','bold')
%      ax4 = axes(layout3);
%     % Get the correct label for each input of the experiment
%     labelfig2(o) = rst(p).simd{1,m}.DataNames(str2double(...
%         strrep(sbtab.datasets(n).input(o),'S',''))+1);
%     
%     
% xlabel(ax3,'time (s)','FontSize', 8,'Fontweight','bold')
% ylabel(ax3,'micromole/liter','FontSize', 8,'Fontweight','bold')
% legend([p3], labelfig2,'FontSize', 6.5,'Fontweight','bold','box','off')
% ylim(ax3,[0 0.11])
% xlim(ax3,[0 10000])
% % set(gca,'FontSize',8,'Fontweight','bold')
% text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'A','fontsize',10,'FontWeight','bold');
% 
% % p4 = plot(ax3,rst(p).simd{1,m}.Time,rst(p).simd{1,m}.Data(1:end,...
% %         str2double(strrep(sbtab.datasets(n).input(o),'S','')...
% %         )+1),'LineWidth',1)
%     
% 
% ax4.XColor = 'r';
% ax4.XAxisLocation = 'top';
% ax4.YAxis.Visible = 'off';
% ylim(ax4,[0 0.1])
% xlim(ax4,[-1600 8000])
% xticks(ax4,[0,2000,4000])
% xticklabels(ax4,{0,2000,4000})
% hold off
% % % legend boxoff
% clear labelfig2
% 
% 
% 
% % Figure 7B
% % nexttile(layout);




% m = 1;
%     j = 1;
%     p = 1;
% time_detailed = rst(2).simd{1,m+2*stg.expn}.Time;
% [~,sim_results_detailed]= f_normalize(rst(2),stg,m,j,folder);

layout2 = tiledlayout(layout,1,1,'TileSpacing','none');
layout2.Layout.Tile = 1;
layout2.Layout.TileSpan = [1 1];
hold on
ax1 = axes(layout2);

n = 1;
o = 1;
    p = 1;
    m = 5;
%     % Plot the inputs to each experiment

    p1 = plot(ax1,rst(p).simd{1,m}.Time,rst(p).simd{1,m}.Data(1:end,...
        str2double(strrep(sbtab.datasets(n).input(o),'S','')...
        )+1),'LineWidth',1);


% p1 = plot(ax1,time_detailed,...
%     sim_results_detailed,'k',...
%     'DisplayName',string("Parameter set "+p),...
%     'LineWidth',1)
set(gca,'FontSize',8,'Fontweight','bold')
ax2 = axes(layout2);
% p2 = plot (ax2,Time,pERK_ratio,'Color',[1 0 0], 'LineWidth',1)

ax2.XColor = 'r';
ax2.XAxisLocation = 'top';
ax2.YAxis.Visible = 'off';

xlim(ax1,[0 10000])
xlim(ax2,[-1600 8000])
ylim(ax1,[0 0.1])
ylim(ax2,[0 0.1])
% ax2.XAxisLocation = 'top';
% ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax1.Box = 'off';
ax2.Box = 'off';

xticks(ax2,[0,2000,4000])
xticklabels(ax2,{0,2000,4000})

set(gca,'FontSize',8,'Fontweight','bold')

xlabel(ax1,'time (s) MATLAB','FontSize', 8,'Fontweight','bold')
xlabel(ax2,'time (s) NEURON','FontSize', 8,'Fontweight','bold')
ylabel(ax1,'micromole/liter','FontSize', 8,'Fontweight','bold')
% plot([-4 4], [1 1], '--', 'LineWidth', 1,'Color', [0.5 0.5 0.5])
% plot([0 0], [0 1.2], '-.',...
%     'LineWidth', 1, 'Color', [0.5 0.5 0.5])
legend([p1],["EGF"],'FontSize', 6.5,'Fontweight','bold','box','off')
%     set(sortes,'boxoff')
hold off
% ylim ([0 5])
% yticks([0,1,3,5])

text(min(xlim)-(max(xlim)-min(xlim))*3.5/30 ,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'A','fontsize',10,'FontWeight','bold');






m = 1;
    j = 1;
    p = 1;
time_detailed = rst(2).simd{1,m+2*stg.expn}.Time;
[~,sim_results_detailed]= f_normalize(rst(2),stg,m,j,folder);

layout2 = tiledlayout(layout,1,1,'TileSpacing','none');
layout2.Layout.Tile = 2;
layout2.Layout.TileSpan = [1 1];
hold on
ax1 = axes(layout2);
p1 = plot(ax1,time_detailed,...
    sim_results_detailed,'k',...
    'DisplayName',string("Parameter set "+p),...
    'LineWidth',1);
set(gca,'FontSize',8,'Fontweight','bold')
ax2 = axes(layout2);
p2 = plot (ax2,Time,pERK_ratio,'Color',[1 0 0], 'LineWidth',1);

ax2.XColor = 'r';
ax2.XAxisLocation = 'top';
ax2.YAxis.Visible = 'off';

xlim(ax2,[-1600 8000])
ylim(ax1,[0 1.2])
ylim(ax2,[0 1.2])
% ax2.XAxisLocation = 'top';
% ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax1.Box = 'off';
ax2.Box = 'off';

xticks(ax2,[0,2000,4000])
xticklabels(ax2,{0,2000,4000})

set(gca,'FontSize',8,'Fontweight','bold')

xlabel(ax1,'time (s) MATLAB','FontSize', 8,'Fontweight','bold')
xlabel(ax2,'time (s) NEURON','FontSize', 8,'Fontweight','bold')
ylabel(ax1,'MAPK_p + MAPK_p_p (\muM)','FontSize', 8,'Fontweight','bold')
% plot([-4 4], [1 1], '--', 'LineWidth', 1,'Color', [0.5 0.5 0.5])
% plot([0 0], [0 1.2], '-.',...
%     'LineWidth', 1, 'Color', [0.5 0.5 0.5])
legend([p1 , p2],["MATLAB","NEURON"],'FontSize', 6.5,'Fontweight','bold','box','off')
%     set(sortes,'boxoff')
hold off
% ylim ([0 5])
% yticks([0,1,3,5])

text(min(xlim)-(max(xlim)-min(xlim))*3.5/30 ,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'B','fontsize',10,'FontWeight','bold');

load(folder + "E0_Vs_before_after_long")

% Figure 7C
nexttile(layout,[1 2]);

hold on
plot(Time,Vs_before)
plot(Time,Vs_after)
% title('Spine')
set(gca,'FontSize',8,'Fontweight','bold')
xlabel('time (ms)','FontSize', 8,'Fontweight','bold')
ylabel('V (mV)','FontSize', 8,'Fontweight','bold')
hold off

xlim ([0 10000])
legend(["\color{red}400 - 410 seconds","\color{red}840 - 850 seconds"],'FontSize', 6.5,'Fontweight','bold');
legend boxoff
% leg = legend({'Ca','Ca + DA (\Deltat=-1s)','Ca + DA (\Deltat=1s)'},'FontSize', 6.5,'Fontweight','bold');
% leg.ItemTokenSize = [20,18];
% legend boxoff

text(min(xlim)-(max(xlim)-min(xlim))*3.5/64,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'C','fontsize',10,'FontWeight','bold');

% load(folder + "E0_Vs_after")
% Figure 7D
% nexttile(layout);

% hold on
% plot(Time,Vs_after)
% set(gca,'FontSize',8,'Fontweight','bold')
% xlabel('time (ms)','FontSize', 8,'Fontweight','bold')
% ylabel('V (mV)','FontSize', 8,'Fontweight','bold')
% hold off
% xlim ([0 1000])
% % leg = legend({'Ca','Ca + DA (\Deltat=-1s)','Ca + DA (\Deltat=1s)'},'FontSize', 6.5,'Fontweight','bold');
% % leg.ItemTokenSize = [20,18];
% % legend boxoff
% text(min(xlim)-(max(xlim)-min(xlim))*3.5/30,max(ylim)+(max(ylim)-min(ylim))*0.65/5,'D','fontsize',10,'FontWeight','bold');

%Saves the graphs if running matlab 2020a or later
% if f_check_minimum_version(9,8)

exportgraphics(layout,...
    folder + "supplementary figure 5_alt3.png",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "supplementary figure 5_alt3.tiff",...
    'Resolution',600)

exportgraphics(layout,...
    folder + "supplementary figure 5_alt3.pdf",...
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