function f_Reproduce_sup_fig_4(folder)
work_folder = folder +"/Results";

set(0,'defaultAxesFontName', 'Times New Roman')
%%  read SBtab data for experimental output for E0

Tst_output=readtable('E0.csv','HeaderLines',1);
tst2_output=Tst_output{:,'x_Time'};
cst2_output_M=Tst_output{:,'x_Y0'};
cst2_output_SD=Tst_output{:,'SD_Y0'};

% 
% pwd
% cd
%% read BioNetGen ode E0 simulation
% Bionetgen_E0 = readcell("true_csv_temp_3_alternative.csv");

%  for n = 1:size(Bionetgen_E0,2)
%     variable_names{1,n} = Bionetgen_E0{1,n};
%     Tst_bng_ode(:,n) = [Bionetgen_E0{2:end,n}];
%  end
 
d0=cd;
% dir_bng_ode = work_folder+"/E0_BioNetGen_ode";
% cd(dir_bng_ode)
dir_bng_ode2=work_folder+"/E0_BioNetGen_ode/2021-03-04_12-51-14"; %temp_3_alternative.gdat
cd(dir_bng_ode2)
files2 = dir('*.gdat');
files3 = dir('*.csv');
if length(files3)==0 % if no csv - do csv
    if length(files2)>=1
    movefile( files2(1).name, [files2(1).name,'.csv'])
    files3 = dir('*.csv');
    end
end
fid = fopen(files3(1).name);
variable_names=textscan(fid,'%s',1,'Delimiter',{'\n'});
variable_names = variable_names{1,1}{1};
variable_names=textscan(variable_names,'%s');
variable_names = variable_names{1}(2:end);
fclose(fid);
Tst_bng_ode=readtable(files3(1).name);
Tst_bng_ode.Properties.VariableNames = variable_names;
cd(d0)

%% read COPASI ode E0 simulation

d0=cd;
dir_copasi = work_folder+'/E0_COPASI';
cd(dir_copasi)
% results_file_name='Viswan_2018_COPASI.txt';
Tst_copasi=readtable('Viswan_2018_COPASI.txt');
cd(d0)

%% read STEPS E0 simulation

d0=cd;
dir_steps = work_folder+'/E0_STEPS';
cd(dir_steps)
results_file_name=dir('*.csv');               
variable_names2=[variable_names([1,2,5:end]); [{'Var105'};{'Var106'}]];
for i=1:length(results_file_name)
    if i==1
        Tst_steps=readtable(results_file_name(i).name);
        Tst_steps.Properties.VariableNames = variable_names2;
    else 
        tst = readtable(results_file_name(i).name);
        tst.Properties.VariableNames = variable_names2;
        Tst_steps=[Tst_steps; tst];
    end
end
cd(d0)

%% read BioNetGen ssa E0 simulation

d0=cd;
dir_bng_ssa = work_folder+'/E0_BioNetGen_ssa';
cd(dir_bng_ssa)
dir_bng_ssa = cd;

results_file_name=dir; %dir('*.csv');  
select_variable_names = {'time','ERK1_2_ratio1','EGF','MAPK_p','MAPK_p_p' ,'PKC_active' };

j=1;
for i=1:length(results_file_name)
    if results_file_name(i).isdir&&(~ismember(results_file_name(i).name,{'.','..'}))
        cd(results_file_name(i).name)
        files2 = dir('*.gdat');
        files3 = dir('*.csv');
        if length(files3)==0 % if no csv - do csv
            if length(files2)>=1
            movefile( files2(1).name, [files2(1).name,'.csv'])
            files3 = dir('*.csv');
            end
        end
        if length(files3)>=1
            if j==1
                fid = fopen(files3(1).name);
                variable_names=textscan(fid,'%s',1,'Delimiter',{'\n'});
                variable_names = variable_names{1,1}{1};
                variable_names=textscan(variable_names,'%s');
                variable_names = variable_names{1}(2:end);
                fclose(fid);
                
                Tst_bng_ssa=readtable(files3(1).name);
                Tst_bng_ssa.Properties.VariableNames = variable_names;
                j=j+1;
                variable_names0 = variable_names;
            else 
                fid = fopen(files3(1).name);
                variable_names=textscan(fid,'%s',1,'Delimiter',{'\n'});
                variable_names = variable_names{1,1}{1};
                variable_names=textscan(variable_names,'%s');
                variable_names = variable_names{1}(2:end);
                fclose(fid);
                
                tst = readtable(files3(1).name);
                variable_names{1}='time';
                tst.Properties.VariableNames = variable_names;
                Tst_bng_ssa=[Tst_bng_ssa(:,select_variable_names); tst(:,select_variable_names)];
                %Tst_bng_ssa=innerjoin(Tst_bng_ssa, tst); %,variable_names0);
            end
        end
        cd(dir_bng_ssa)
    end
end
cd(d0)

%% parameters for convertion from mole/liter to # of molecules
Na = 6.022e23;
v_Cell= 1.0e-15; % Volume of Cell, l

%% select compounds to display, transform to micromole/liter
snames2 = {'time','ERK1_2_ratio1','EGF','MAPK_p','MAPK_p_p' ,'PKC_active' };
snames3 = {'x_Time','x_pERK1_2_ratio1_','x_MAPK_p_','x_MAPK_p_p_' ,'x_PKC_active_' };
cst_steps = Tst_steps{:,snames2}; % convert to micromoles/liter
cst_bng_ssa = Tst_bng_ssa{:,snames2};     % convert to micromoles/liter
cst_steps(:,2:end) = cst_steps(:,2:end)/(Na*v_Cell*1e-6);
cst_bng_ssa(:,2:end) = cst_bng_ssa(:,2:end)/(Na*v_Cell*1e-6);

cst_copasi = Tst_copasi{:,snames3}; % convert to micromoles/liter
cst_bng_ode = Tst_bng_ode{:,snames2};     % convert to micromoles/liter
cst_copasi(:,2:end) = cst_copasi(:,2:end)/(1);
cst_bng_ode(:,2:end) = cst_bng_ode(:,2:end)/(1);

%% Plot all stochastic simulated traces together with their averages and
%% determenistic COPASI and BIoNetGen traces 
% figure
%subplot(2,1,1)
% hold on
 % BioNetGen stochastic plot
cst_bng_ssa2=cst_bng_ssa(cst_bng_ssa(:,1)<=5100,:);
DT = 5101; %fix(size(Tst,1)/ntrain);
ntrain=fix(size(cst_bng_ssa2,1)/DT);
for j=1:ntrain
    jj=(j-1)*DT+(1:DT);

tst2 = cst_bng_ssa2(jj,1); %Tst{jj,'Time'};
cst2 = cst_bng_ssa2(jj,2);%cst(jj,ii);
% plot(tst2(:), cst2(:), '-', 'LineWidth', 1,'Color',[0.8,0.8, 1.0])

end
cst2 = reshape(cst_bng_ssa2(1:DT*ntrain,2),DT,[]); % output averaged
% plot(tst2(:), mean(cst2,2), '-', 'LineWidth', 2,'Color',[0.4,0.4,1.0])
cst2_ssa_= cst2;
tst2_ssa_= tst2;

% STEPS stochastic plot
cst_steps2=cst_steps; %(cst_steps(:,1)<=9980,:);
DT = fix(max(cst_steps2(:,1))/diff(cst_steps2(1:2,1))); %fix(size(Tst,1)/ntrain);
DT = 498;
ntrain=fix(size(cst_steps2,1)/DT);

jj2=find(diff(cst_steps(1:end,1))<0);
ntrain = length(jj2);
jj2=[0;jj2];
DT=min(diff(jj2));
cst2_=[];
for j=1:ntrain
     jj=jj2(j)+1:jj2(j)+DT;
tst2 = cst_steps2(jj,1); %Tst{jj,'Time'};
cst2 = cst_steps2(jj,2);%cst(jj,ii);
% plot(tst2(:), cst2(:), '-', 'LineWidth', 1,'Color',[1.0,0.8, 0.8])
cst2_=[cst2_,cst2];
end
cst2 = cst2_; %reshape(cst_steps2(1:DT*ntrain,2),DT,[]);
cst2_steps_ = cst2;
tst2_steps_= tst2;
% plot(tst2, mean(cst2,2), '-', 'LineWidth', 2,'Color',[1.0,0.4, 0.4])

% COPASI deterministic plot
t_copasi=cst_copasi(:,1);
x_copasi=cst_copasi(:,2);
% plot(t_copasi, x_copasi, '-.', 'LineWidth', 2)

% BioNetGen deterministic plot
t_bng_ode=cst_bng_ode(:,1);
x_bng_ode=cst_bng_ode(:,2);
% plot(t_bng_ode, x_bng_ode, 'LineWidth', 2,'Color',[0,0,0])

% set(gca,'FontSize',12, 'FontWeight', 'bold')
% xlabel('time (s)');
% ylabel('MAPK_p + MAPK_p_p (\muM)');
% legend({'STEPS stochastic','BioNetGen stochastic' ,'COPASI deterministic', 'BioNetGen stochastic'});
% title(['all stochastic simulated traces (STEPS - red , BioNetGen - blue)',  ...
%        'together with their averages and determenistic COPASI and BIoNetGen traces'])
% 
% xlim([0,10000]);

%%
%% Plot stochastic simulated traces 10%-90% confidence intervals together with their averages,
%% determenistic COPASI and BIoNetGen traces and original experimental Data

figHandles = findobj('type', 'figure', 'name', 'Paper supplementary figure 4');
close(figHandles);
figure('WindowStyle', 'docked','Name','Paper supplementary figure 4','NumberTitle',...
    'off');

layout = tiledlayout(1,1,'Padding','compact','TileSpacing','compact');

layout.Units = 'inches';
layout.OuterPosition = [0 0 6.85 3];

nexttile(layout);
% figure
% subplot(1,2,1)
hold on

% draw mean ERK1_2_ratio1 and CI 10-90% , BioNetGen ssa solver, 'BioNetGen stochastic'
percentiles = [0.1,0.9]; % 10% - 90% confidence interval (CI)
color = [0.8,0.8, 1.0]; 
transparency = 0.5;
patch_error_plot(tst2_ssa_',cst2_ssa_,percentiles,color,transparency)
p1 = plot(tst2_ssa_, mean(cst2_ssa_,2), '-', 'LineWidth', 1,'Color',[0.4,0.4, 1.0]);

% draw mean ERK1_2_ratio1 and CI 10-90% , Subcellular application STEPS
% TetOpt solver,  'STEPS stochastic'
color = [1.0,0.8, 0.8];
patch_error_plot(tst2_steps_',cst2_steps_,percentiles,color,transparency)

p2 = plot(tst2_steps_, mean(cst2_steps_,2), '-', 'LineWidth', 1,'Color',[1.0,0.4, 0.4]);

% draw mean ERK1_2_ratio1, COPASI deterministic LSODA solver , 'COPASI deterministic'
p3 = plot(t_copasi, x_copasi, '-', 'LineWidth', 1, 'Color',[0.4, 1, 0.4]);

% draw mean ERK1_2_ratio1, BioNetGen deterministic ode solver , 'BioNetGen deterministic'
p4 = plot(t_bng_ode, x_bng_ode,':', 'LineWidth', 3,'Color',[0.7, 0.7, 0.7]);

% draw Mean+-SD ERK1_2_ratio1, experimental , 'Data'
cf=0.2;
p5 = errorbar(tst2_output, cst2_output_M*cf, cst2_output_SD*cf,'ok', 'LineWidth', 1,'MarkerSize',3);

set(gca,'FontSize',8, 'FontWeight', 'bold')
xlabel('time (s)','FontSize',8,'Fontweight','bold');
ylabel('MAPK_p + MAPK_p_p (\muM)','FontSize',8,'Fontweight','bold');

legend ([p1,p2,p3,p4,p5],{'BioNetGen stochastic','STEPS stochastic','COPASI deterministic','BioNetGen deterministic', 'Data + SEM'},'FontSize',6.5,'Fontweight','bold');
legend boxoff
% title(['stochastic simulated traces 10%-90% CI (STEPS - red , BioNetGen - blue), their averages, \n',  ...
%        ' determenistic COPASI and BIoNetGen traces (smooth lines) \n',... 
%        ' and experimental data (black)'])

%%
% Legend:
% plot([5000,6000],[0.325, 0.325],':', 'LineWidth', 6, 'Color',[0, 1, 0])
% text(6200,0.325,'COPASI deterministic','FontSize',16 )
% 
% plot([5000,6000],[0.30, 0.30],'LineWidth', 2,'Color',[1, 0, 1])
% text(6200,0.300,'BioNetGen deterministic','FontSize',16 )
% 
% plot([5000,6000],[0.275, 0.275], '-', 'LineWidth', 2,'Color',[0.4,0.4, 1.0])
% text(6200,0.275,'BioNetGen stochastic','FontSize',16 )
% 
% plot([5000,6000],[0.25, 0.25], '-', 'LineWidth', 2,'Color',[1.0,0.4, 0.4])
% text(6200,0.25,'STEPS stochastic','FontSize',16 )
% 
% errorbar(6000, 0.225, 0.015,'ok', 'LineWidth', 3,'MarkerSize',5)
% text(6200,0.225,'Data','FontSize',16 )

xlim([0,9500]);

ylim([-0.02, 0.35])

% set(gcf,'Position', [1   150   900   600])
   
    exportgraphics(layout,...
        folder +"supplementary figure 4.png",...
        'Resolution',600)
    
    exportgraphics(layout,...
        folder +"supplementary figure 4.tiff",...
        'Resolution',600)
    
    exportgraphics(layout,...
        folder +"supplementary figure 4.pdf",...
        'ContentType','vector')
end