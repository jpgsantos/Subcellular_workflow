%%  read simbiology version

Regenerate_figures


%%    read results of nfsim simulation
% d0=cd;
% %dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/MODEL1603270000-translated_corrected/';
% %dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/Nair_spatial2_nonfun_cmp3';
% 
% dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/Nair_KTH/new_Nair_and_workflow/Code_EPFL-master/BNGL';
% 
% %cd([dir0,'/2019-09-04_10-32-52/'])
% %cd([dir0,'/2019-09-06_12-50-51/'])
% 
% %cd([dir0,'/2019-10-04_09-03-35/'])
% cd(dir0)
% %results_file_name='Nair_spatial2_nonfun_cmp3.gdat';
% results_file_name='model_D1_LTP_time_window_alternative_1_alternative_3_nf_DA.gdat';
% try
%     movefile( results_file_name, [results_file_name,'.csv'])
% end
% T=readtable([results_file_name,'.csv']);
% cd(d0)

% %%    read results of nfsim simulation
% d0=cd;
% %dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/MODEL1603270000-translated_corrected/';
% %dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/Nair_spatial2_nonfun_cmp3';
% 
% %dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/model_D1_LTP_time_window_alternative_1_alternative_3';
% dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/model_D1_LTP_time_window_alternative_1_alternative_4';
% sdir = '2020-05-25_23-46-24';
% sdir = '2020-05-26_00-25-58';
% sdir = '2020-05-26_00-48-39';
% sdir = '2020-05-26_01-05-19';
% sdir = '2020-05-26_01-13-17';
% sdir = '2020-05-26_01-27-57';
% sdir = '2020-05-26_01-33-15';
% sdir = '2020-05-27_17-15-53';
% 
% 
% cd([dir0,'/',sdir])
% %results_file_name='Nair_spatial2_nonfun_cmp3.gdat';
% %results_file_name='model_D1_LTP_time_window_alternative_1_alternative_3.gdat';
% results_file_name='model_D1_LTP_time_window_alternative_1_alternative_4.gdat';
% try
%     movefile( results_file_name, [results_file_name,'.csv'])
% end
% Tode=readtable([results_file_name,'.csv']);
% cd(d0)

%% read steps

d0=cd;
%dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/MODEL1603270000-translated_corrected/';
%dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/Nair_spatial2_nonfun_cmp3';

dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/Nair_KTH/new_Nair_and_workflow/Code_EPFL-master/BNGL';
dir0 = [dir0,'/','simple_steps'];
%cd([dir0,'/2019-09-04_10-32-52/'])
%cd([dir0,'/2019-09-06_12-50-51/'])

%cd([dir0,'/2019-10-04_09-03-35/'])
cd(dir0)
%results_file_name='Nair_spatial2_nonfun_cmp3.gdat';
results_file_name='model_D1_LTP_time_window_alternative_1_alternative_3__Copy of sim0-5__2020-05-26T03_05_22.995Z.csv';
results_file_name='model_D1_LTP_time_window_alternative_1_alternative_3__DA__2020-05-26T04_32_08.855Z.csv';
results_file_name='model_D1_LTP_time_window_alternative_1_alternative_4__Copy of sim4-0__2020-05-26T12_48_39.748Z.csv';
results_file_name='model_D1_LTP_time_window_alternative_1_alternative_4__sim7__2020-05-28T00_25_26.146Z.csv';
Tst=readtable(results_file_name);
cd(d0)

%% read steps noDA

d0=cd;
%dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/MODEL1603270000-translated_corrected/';
%dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/Nair_spatial2_nonfun_cmp3';

dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/Nair_KTH/new_Nair_and_workflow/Code_EPFL-master/BNGL';
dir0 = [dir0,'/','simple_steps'];
%cd([dir0,'/2019-09-04_10-32-52/'])
%cd([dir0,'/2019-09-06_12-50-51/'])

%cd([dir0,'/2019-10-04_09-03-35/'])
cd(dir0)
%results_file_name='Nair_spatial2_nonfun_cmp3.gdat';
results_file_name='model_D1_LTP_time_window_alternative_1_alternative_3__Copy of sim0-5__2020-05-26T03_05_22.995Z.csv';
results_file_name='model_D1_LTP_time_window_alternative_1_alternative_3__DA__2020-05-26T04_32_08.855Z.csv';
results_file_name='model_D1_LTP_time_window_alternative_1_alternative_4__Copy of sim5_nonDA_4-0__2020-05-26T13_34_00.156Z.csv';
results_file_name='model_D1_LTP_time_window_alternative_1_alternative_4__sim8__2020-05-28T00_41_56.325Z.csv';
Tstn=readtable(results_file_name);
cd(d0)



%% read steps DT dependence

d0=cd;
%dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/MODEL1603270000-translated_corrected/';
%dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/Nair_spatial2_nonfun_cmp3';

dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/Nair_KTH/new_Nair_and_workflow/Code_EPFL-master/BNGL';
dir0 = [dir0,'/','simple_steps'];
%cd([dir0,'/2019-09-04_10-32-52/'])
%cd([dir0,'/2019-09-06_12-50-51/'])

%cd([dir0,'/2019-10-04_09-03-35/'])
cd(dir0)
%results_file_name='Nair_spatial2_nonfun_cmp3.gdat';
results_file_name={'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__Copy of sim1_part1-0__2020-05-28T03_22_47.442Z.csv';
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__sim1_part2__2020-05-28T02_33_55.706Z.csv';
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__sim1_part3__2020-05-28T02_41_11.612Z.csv';
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__sim1_part4__2020-05-28T03_02_18.323Z.csv';
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__sim1_part5__2020-05-28T03_09_35.187Z.csv';
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__Copy of sim1_part1-0__2020-05-28T06_30_49.801Z.csv';               
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__Copy of sim1_part2-0__2020-05-28T06_46_58.616Z.csv';               
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__Copy of sim1_part3-0__2020-05-28T07_00_22.746Z.csv';               
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__Copy of sim1_part4-0__2020-05-28T07_16_50.237Z.csv';               
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__Copy of sim1_part5-0__2020-05-28T07_26_13.572Z.csv';
'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__Copy of sim1_part1-1__2020-05-28T07_40_30.251Z.csv';               
'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__Copy of sim1_part2-1__2020-05-28T08_09_09.684Z.csv';              
'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__Copy of sim1_part3-2__2020-05-28T08_57_51.457Z.csv';               
'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__Copy of sim1_part4-1__2020-05-28T09_27_51.691Z.csv';               
'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__Copy of sim1_part5-1__2020-05-28T09_57_55.405Z.csv'; };               


Tst_=readtable(results_file_name{1});
for i=2:length(results_file_name)
    tsti=readtable(results_file_name{i});
Tst_=[Tst_; tsti];
end
cd(d0)




%% read steps noDA v_spine=0.02um^3

d0=cd;
%dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/MODEL1603270000-translated_corrected/';
%dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/Nair_spatial2_nonfun_cmp3';

dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/Nair_KTH/new_Nair_and_workflow/Code_EPFL-master/BNGL';
dir0 = [dir0,'/','simple_steps'];
%cd([dir0,'/2019-09-04_10-32-52/'])
%cd([dir0,'/2019-09-06_12-50-51/'])

%cd([dir0,'/2019-10-04_09-03-35/'])
cd(dir0)
%results_file_name='Nair_spatial2_nonfun_cmp3.gdat';
results_file_name={'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__sim0_noDA__2020-05-28T03_51_30.253Z.csv';
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__sim0_noDA_2__2020-05-28T04_13_58.525Z.csv';
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__sim0_noDA_2__2020-05-28T04_57_39.096Z.csv';};

Tst_noDA_v2=readtable(results_file_name{1});
for i=2:length(results_file_name)
    tsti=readtable(results_file_name{i});
Tst_noDA_v2=[Tst_noDA_v2; tsti];
end
cd(d0)




%% read steps DA v_spine=0.02um^3

d0=cd;
%dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/MODEL1603270000-translated_corrected/';
%dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/results/Nair_spatial2_nonfun_cmp3';

dir0='/Users/stepaniu/RuleBender-workspace/Motivating_example_cBNGL/Nair_KTH/new_Nair_and_workflow/Code_EPFL-master/BNGL';
dir0 = [dir0,'/','simple_steps'];
%cd([dir0,'/2019-09-04_10-32-52/'])
%cd([dir0,'/2019-09-06_12-50-51/'])

%cd([dir0,'/2019-10-04_09-03-35/'])
cd(dir0)
%results_file_name='Nair_spatial2_nonfun_cmp3.gdat';
results_file_name={'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__sim0_DA__2020-05-28T03_55_25.632Z.csv';
    'model_D1_LTP_time_window_alternative_1_alternative_4_few_observables__sim0_DA_v2__2020-05-28T05_22_47.130Z.csv'};

Tst_DA_v2=readtable(results_file_name{1});
for i=2:length(results_file_name)
    tsti=readtable(results_file_name{i});
Tst_DA_v2=[Tst_DA_v2; tsti];
end
cd(d0)
%%
Na = 6.022e23;
v_Spine = 1.0e-16;

%v_Spine_2=1e-15;
v_Spine_2 = 1.0e-16;
v_Spine_3 = 2.0e-17; %???

%%
sname={};
for i = 1:length(obj.Species) 
    sname(i)={obj.Species(i).Name}; 
end
ssname=string(sname);
%T.Properties.VariableNames = [{'t'},sname];


%figure
%plot(T{:,'t'},T{:,'CaM_Ca2'})
%v_Spine_2=1e-15;
snames2 = {'Obs_pSubstrate','Obs_DA','Obs_Ca','Obs_CaM','Obs_PP1','Obs_D32','Obs_CaM_Ca2','Obs_D1R_DA','Obs_cAMP','Obs_CaMKII_CaM_Ca2',...
    'Obs_B72PP2A_Ca_pARPP21','Obs_PP1_pSubstrate', 'Obs_PDE10c','Obs_CaMKII_CaM_Ca2_psd','Obs_PP2B_CaM_Ca2','Obs_pARPP21'  };
cst = Tst{:,snames2}/(Na*v_Spine_2*1e-9);
cstn = Tstn{:,snames2}/(Na*v_Spine_2*1e-9);
snames3 = {'Obs_pSubstrate','Obs_DA','Obs_Ca','Obs_CaM','Obs_D32','Obs_cAMP'};
cst_ = Tst_{:,snames3}/(Na*v_Spine_3*1e-9);
cst_v2 = Tst_DA_v2{:,snames3}/(Na*v_Spine_3*1e-9);
cstn_v2 = Tst_noDA_v2{:,snames3}/(Na*v_Spine_3*1e-9);

snames2=snames2';
%figure
%plot(Tst{:,'Time'},cst(:,1))


%cnf = T{:,{'pSubstrate','DA','Ca','CaM_Ca2','D1R_DA'}}/(Na*v_Spine*1e-9);
%figure
%plot(T{:,'t'},cnf(:,1))

%figure
%plot(Tst{:,'Time'},cst(:,1),100+t_DA,x_DA(:,1))
%%{'pSubstrate','DA','Ca','CaM_Ca2','D1R_DA'};
%%plots(t_DA,x_DA)

% spine kinetic rate?
% D = 1e3*0.1 um^2*s^-1
% L = 1.0 um
% d_neck  = 0.06 um
% d_head = 0.27 um?
% 4/3*pi*0.27^3/4 + 1.000*0.06^2*pi -> volume of spine = 0.031922 um^3

% 20/1.000*0.06^2*pi/(4/3*pi*0.27^3/8) -> k_spine = 22 s^-1  (0.02um^3)
% 20/1.000*0.06^2*pi/(4/3*pi*0.27^3/4) -> k_spine = 11 s^-1  (0.03um^3)


% https://www.cell.com/cell-reports/pdf/S2211-1247(19)30461-9.pdf
%
% Ca ~30um^2/s check!!!
% egfp 30kDa - 15-20um^2/s (2.5um^2/s - RISC estimate);  frap! - tau~0.4 to 0.6s
% egfp5 150kDa - 5um^2/s   (1um^2/s - RISC estimate!!!); frap! - tau~3-3.5s

%% Plot for 0.1 um^3 spine
figure
%subplot(2,1,1)
hold on

ii = 1;
ntrain=10;
DT = fix(size(Tst,1)/ntrain);
for j=1:ntrain
    jj=(j-1)*DT+(1:DT);
nonz=Tst{jj,'Obs_CaMKII'}>0;
tst2 = Tst{jj,'Time'};
cst2 = cst(jj,ii);
plot(tst2(nonz)-tst2(1), cst2(nonz)/max(x_noDA(:,1)), '-', 'LineWidth', 1,'Color',[0.8,0.8, 1.0])
end
cst2 = reshape(cst(1:DT*ntrain,ii),DT,[]);
plot(tst2-tst2(1), mean(cst2,2)/max(x_noDA(:,1)), '-', 'LineWidth', 2,'Color',[0.4,0.4, 1.0])
%nonzn=Tstn{:,'Obs_CaMKII'}>0;
%plot(Tstn{nonzn,'Time'}-100, cstn(nonzn,1)/max(x_noDA(:,1)), 'LineWidth', 1,'Color',[0.7,0.7, 0.7])
ntrain=10;
DT = fix(size(Tstn,1)/ntrain);
for j=1:ntrain
    jj=(j-1)*DT+(1:DT);
nonz=Tstn{jj,'Obs_CaMKII'}>0;
tst2 = Tstn{jj,'Time'};
cst2 = cstn(jj,ii);
plot(tst2(nonz)-tst2(1), cst2(nonz)/max(x_noDA(:,1)), '-', 'LineWidth', 1,'Color',[1.0,0.8, 0.8])
end
cst2 = reshape(cstn(1:DT*ntrain,ii),DT,[]);
cst2_noDA = cst2;
plot(tst2-tst2(1), mean(cst2,2)/max(x_noDA(:,1)), '-', 'LineWidth', 2,'Color',[1.0,0.4, 0.4])

plot(t_noDA, x_noDA(:,1)/max(x_noDA(:,1)), '-.', 'LineWidth', 2)
plot(t_DA, x_DA(:,ii)/max(x_noDA(:,1)), 'LineWidth', 2)
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
legend({'Calcium only', 'Calcium + Dopamine (\Deltat=1s)'});

xl = xlim;
%xlim(xl);
xlim([0,30]);





%%
figure
subplot(1,2,1)
hold on

ii = 1;
ntrain=40;
DT = 150; 
%DT1=fix(size(Tst_DA_v2,1)/ntrain);
%tst2=DT+ones(DT,1);
%cst2=ones(DT,1);
%nonz=ones(DT,1)==0;
for j=1:ntrain
    DT2=DT;
    if j==ntrain; DT2=DT*ntrain-size(cst_v2,1); end
    jj=(j-1)*DT+(1:DT2);
nonz=Tst_DA_v2{jj,'Obs_CaMKII'}>0;
tst2 = Tst_DA_v2{jj,'Time'};
cst2 = cst_v2(jj,ii);
%plot(tst2(nonz)-tst2(1), cst2(nonz)/max(x_noDA(:,1)), '-', 'LineWidth', 1,'Color',[0.8,0.8, 1.0])
end
cst_v2 = [cst_v2; zeros(DT*ntrain-size(cst_v2,1), size(cst_v2,2))];
cst2 = reshape(cst_v2(1:DT*ntrain,ii),DT,[]);
tst2 = Tst_DA_v2{1:DT,'Time'};
patch_error_plot(tst2'-tst2(1),cst2/max(x_noDA(:,1)),[0.1,0.9],[0.8,0.8, 1.0],0.5)
plot(tst2-tst2(1), mean(cst2,2)/max(x_noDA(:,1)), '-', 'LineWidth', 2,'Color',[0.4,0.4, 1.0])
%nonzn=Tstn{:,'Obs_CaMKII'}>0;
%plot(Tstn{nonzn,'Time'}-100, cstn(nonzn,1)/max(x_noDA(:,1)), 'LineWidth', 1,'Color',[0.7,0.7, 0.7])
ntrain=50;
DT = 150; %fix(size(Tst_noDA_v2,1)/ntrain);
%DT1=fix(size(Tst_DA_v2,1)/ntrain);
%tst2=DT+ones(DT,1);
%cst2=ones(DT,1);
%nonz=ones(DT,1)==0;
for j=1:ntrain
    DT2=DT;
    if j==ntrain; DT2=DT*ntrain-size(cstn_v2,1); end
    jj=(j-1)*DT+(1:DT2);
nonz=Tst_noDA_v2{jj,'Obs_CaMKII'}>0;
tst2 = Tst_noDA_v2{jj,'Time'};
cst2 = cstn_v2(jj,ii);
%plot(tst2(nonz)-tst2(1), cst2(nonz)/max(x_noDA(:,1)), '-', 'LineWidth', 1,'Color',[1.0,0.8, 0.8])
end
cstn_v2 = [cstn_v2; zeros(DT*ntrain-size(cstn_v2,1), size(cstn_v2,2))];
cst2 = reshape(cstn_v2(1:DT*ntrain,ii),DT,[]);
cst2_noDA_v2 = cst2;
tst2 = Tst_noDA_v2{1:DT,'Time'};
patch_error_plot(tst2'-tst2(1),cst2/max(x_noDA(:,1)),[0.1,0.9],[1.0,0.8, 0.8],0.5)
plot(tst2-tst2(1), mean(cst2,2)/max(x_noDA(:,1)), '-', 'LineWidth', 2,'Color',[1.0,0.4, 0.4])

plot(t_noDA, x_noDA(:,1)/max(x_noDA(:,1)), '-.', 'LineWidth', 2)
plot(t_DA, x_DA(:,ii)/max(x_noDA(:,1)), 'LineWidth', 2)
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
legend({'Calcium only', 'Calcium + Dopamine (\Deltat=1s)'});

xl = xlim;
%xlim(xl);
xlim([0,30]);


%figure
%{'pSubstrate','DA','Ca','CaM_Ca2','D1R_DA'};
%plots(Tode{:,'t'},Tode{:,{'pSubstrate','DA','Ca','CaM_Ca2','D1R_DA'}}/(6.022e23*v_Spine*1e-9))

%%
ii = 1;
%n_DA=10;
ntrain1=10;
ntrain2=10;
ntrain3=3;
ntrain = ntrain1*ntrain2*ntrain3;

DT = 150; %fix(size(Tst_,1)/ntrain);
fconc = 1; %Na*v_Spine_3*1e-9;
activationArea_steps = sum(mean(cst2_noDA_v2,2)) - mean(mean(cst2_noDA_v2(1:20,:)))*fconc * length(cst2_noDA_v2(:,1));
%jj=(j-1)*DT+(1:DT);

cst_ = [cst_; zeros(DT*ntrain-size(cst_,1), size(cst_,2))];
cst2 = reshape(cst_(1:DT*ntrain,ii),DT,[]);
%activationAreaWithMultipleDA_steps = zeros(length(DA),ntrain2);
%jj=(n-1)*ntrain2+(1:ntrain2);
gg = sum(cst2(:,:)) -  mean(mean(cst2_noDA_v2(1:20,:)))*fconc * length(cst2_noDA_v2(:,1));
%gg = sum(cst2(:,:)) - mean(mean(cst2(1:20,:)))*fconc * length(cst2(:,1));
gg1 = reshape(gg',[],ntrain3)';
activationAreaWithMultipleDA_steps = reshape(gg1,ntrain2*ntrain3,[]);
activationAreaWithMultipleDA_steps = activationAreaWithMultipleDA_steps(:,[1,3:end])*9824/6792.5;

%DA1 = [-4:0.2:4];
DA1 = [-4:1:4];
activationAreaWithMultipleDA = zeros(1,length(DA1));
for n = 1:length(DA1)
    obj.parameters(228).Value = CaStart + DA1(n);
    [t,x,~] = sbiosimulate(obj);
    activationAreaWithMultipleDA(n) = sum(x(:,1)) - x(1,1) * length(x(:,1));
    %jj=(n-1)*ntrain2+(1:ntrain2);
    %activationAreaWithMultipleDA_steps(n,1:end) = sum(cst2(:,jj)) - mean(mean(cst2(1:20,:)))*fconc * length(cst2(:,1));
    clear t x names
end

subplot(1,2,2)
hold on
plot(DA1, activationAreaWithMultipleDA/activationArea, 'LineWidth', 2)
boxplot(activationAreaWithMultipleDA_steps/activationArea_steps, 'Positions',DA,'Labels',DA)
plot(DA, median(activationAreaWithMultipleDA_steps)/activationArea_steps, 'LineWidth', 2)
plot([-4 4], [1 1], '-.', 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
plot([0 0], [0 max(activationAreaWithMultipleDA/activationArea)], '-.', 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('\Deltat (s)');
ylabel('Substrate phosphorylation');










%%
% snames3 = Tst.Properties.VariableNames;
% for i=2:length(snames3)
%    snames3(i) =  {snames3{i}(5:end)};
% end    
% Tode.Properties.VariableNames = snames3; %[{'t'},sname];
% %code=Tode{end,{'Obs_pSubstrate','Obs_DA','Obs_Ca','Obs_CaM_Ca2','Obs_D1R_DA'}}/(6.022e23*v_Spine*1e-9);
% %csimb=x_DA(1,:);
% %(csimb-code)./csimb
% tstend=Tst{(Tst{:,'Time'}>90)&(Tst{:,'Time'}<=100),:}/(6.022e23*v_Spine*1e-9);
% cend=[mean(tstend,1)'-std(tstend,[],1)',mean(tstend,1)'+std(tstend,[],1)',1e9*Tode{end,:}'];
% 
% writetable(Tode(end,:),'equilibrium_concentrations_.xlsx')
% 
% %figure;
% %plot([(cend(2:end,1)-cend(2:end,3)),cend(2:end,3)])


