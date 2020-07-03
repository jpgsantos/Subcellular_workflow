%% Running this script will generate stimulation files for STEPS and Nfsim corresponding to
%  Figure6 (and figures 1C and 2C from Nair et al 2016), modified from Regenerate_figures.m 




%% using the updated model with new parameters governing CaMKII autophosphorylation


clear
proj = sbioloadproject('model_D1_LTP_time_window.sbproj');
obj = proj.m1; %modelobj;



%% Get steady state values after equilibrating for 100000 s

cnfst = getconfigset(obj);
cnfst.SolverType = 'ode15s';
cnfst.StopTime = 100000;
cnfst.TimeUnits = 'second';
cnfst.SolverOptions.AbsoluteTolerance = 1e-9;
cnfst.SolverOptions.RelativeTolerance = 1e-6;
cnfst.CompileOptions.UnitConversion = 1;
cnfst.SolverOptions.AbsoluteToleranceScaling = 0;
cnfst.RunTimeOptions.StatesToLog = 'all';
% set(obj.rules(2), 'Active', 0); % Uncomment if Ca input is incorporated
% set(obj.rules(3), 'Active', 0); % Uncomment if DA input is incorporated

[t,species,~] = sbiosimulate(obj);

SteadyState=species(length(t),:);

for i=1:length(SteadyState)
    if SteadyState(i)<0
        SteadyState(i)=0;
    end
end

for i=1:length(SteadyState)
    set(obj.species(i), 'InitialAmount', SteadyState(i));
end

%%
%% generate STEPS stimulation file 
% Select:
plot_simulation_results = 1;
name_rnf = 'model_D1_LTP_time_window_alternative_1_alternative_3.xml';
t_eq=100;
fconv=1e-9;

initial_concentrations=readtable('equilibrium_concentrations.xlsx');
vnames = initial_concentrations.Properties.VariableNames;
vtype = array2table(repmat({'setConc'},1,length(vnames)),'VariableNames',vnames);
vcomp = array2table(repmat({'Spine'},1,length(vnames)),'VariableNames',vnames);
vnames2=vnames;
for i=1:length(vnames)
    vnames2(i)={[vnames{i},'()','@',vcomp{1,i}{1}]};
end
vnames2 = array2table(vnames2,'VariableNames',vnames);
initial_concentrations = [initial_concentrations;vnames2;vtype;vcomp];
initial_concentrations.Properties.RowNames={'value','stim_name','stim_type','compartment'};
initial_concentrations=initial_concentrations(:,2:end);

for i=1:length(SteadyState)
    %set(obj.species(i), 'InitialAmount', SteadyState(i));
    if ismember(obj.species(i).Name,initial_concentrations.Properties.VariableNames)
    initial_concentrations{'value',obj.species(i).Name} = {SteadyState(i)*fconv};
    end
end


%% Add parameters used by the Calcium input

% nCa_peaksn=10;
% nCa_peakfirst=4;
% nCa_minpeaklngth=0.01;
% nCa_minburstinter=5;
% nCa_k2=9.3;
% nCa_k1=39.4;
% nCa_frequency=10;
% nCa_burstn=1.0;
% nCa_burstfreq=0.03;
% nCa_ampmax_noMg=1200;
% nCa_ampbasal=60;
% 
% %time = 1;
% Ca_expression = spiketraindd_Ca(time,nCa_peakfirst,nCa_frequency,nCa_peaksn,nCa_ampbasal,...
%     nCa_ampmax_noMg,nCa_k1,nCa_k2,nCa_minpeaklngth,[],nCa_burstfreq,nCa_burstn,nCa_minburstinter,1)';


% addparameter(obj, 'nCa_peaksn', nCa_peaksn);
% addparameter(obj, 'nCa_peakfirst', nCa_peakfirst);
% addparameter(obj, 'nCa_minpeaklngth', nCa_minpeaklngth);
% addparameter(obj, 'nCa_minburstinter', nCa_minburstinter);
% addparameter(obj, 'nCa_k2', nCa_k2);
% addparameter(obj, 'nCa_k1', nCa_k1);
% addparameter(obj, 'nCa_frequency', nCa_frequency);
% addparameter(obj, 'nCa_burstn', nCa_burstn);
% addparameter(obj, 'nCa_burstfreq', nCa_burstfreq);
% addparameter(obj, 'nCa_ampmax_noMg', nCa_ampmax_noMg);
% addparameter(obj, 'nCa_ampbasal', nCa_ampbasal);

addparameter(obj, 'nCa_peaksn', 10);
addparameter(obj, 'nCa_peakfirst', 4);
addparameter(obj, 'nCa_minpeaklngth', 0.01);
addparameter(obj, 'nCa_minburstinter', 5);
addparameter(obj, 'nCa_k2', 9.3);
addparameter(obj, 'nCa_k1', 39.4);
addparameter(obj, 'nCa_frequency', 10);
addparameter(obj, 'nCa_burstn', 1.0);
addparameter(obj, 'nCa_burstfreq', 0.03);
addparameter(obj, 'nCa_ampmax_noMg', 1200);
addparameter(obj, 'nCa_ampbasal', 60);
set(obj.parameters(231:241), 'ValueUnits', 'dimensionless');

ruleobj=addrule(obj, 'Spine.Ca = spiketraindd_Ca(time,nCa_peakfirst,nCa_frequency,nCa_peaksn,nCa_ampbasal,nCa_ampmax_noMg,nCa_k1,nCa_k2,nCa_minpeaklngth,[],nCa_burstfreq,nCa_burstn,nCa_minburstinter,1)');
set(ruleobj,'RuleType','RepeatedAssignment');
set(obj.rules(2), 'Name', '0 Ca spikes with 3 AP');



% Assign DA_expression to dopamine
%DA_start = 100;   %ms
%tau_DA1 = 34.979; %ms
%tau_DA2 = 420; %ms
%DA_basal = 20; %nM
%DA_max = 1500; %nM
%DA_expression = 0; %nM
%DA_expression = DA_basal+(1/(1+exp((-10E+10)*(time-DA_start)))*(DA_max/(exp(-tau_DA1*tau_DA2/(tau_DA2-tau_DA1)*log(tau_DA2/tau_DA1)/tau_DA1)-exp(-tau_DA1*tau_DA2/(tau_DA2-tau_DA1)*log(tau_DA2/tau_DA1)/tau_DA2))*(exp(-(time-DA_start)/tau_DA1)-exp(-(time-DA_start)/tau_DA2))));


% Assign DA_expression to dopamine

ruleobj=addrule(obj, 'Spine.DA = Spine.DA_expression');
set(ruleobj,'RuleType','RepeatedAssignment');


%% Run simulations
effector = {'Spine.pSubstrate'};

DA = [-4:0.2:4];
DA = [-4:1:4];
CaStart = obj.parameters(232).Value;
cnfst.StopTime = 30;
cnfst.SolverOptions.MaxStep = 0.01;
cnfst.SolverOptions.OutputTimes = 0:0.01:30;
cnfst.RuntimeOptions.StatesToLog = {'pSubstrate','DA','Ca','ATP','AMP'};
set(obj.rules(2), 'Active', 1);
set(obj.rules(3), 'Active', 0);



if plot_simulation_results==1
[t_noDA,x_noDA,~] = sbiosimulate(obj);


save_stimulation('stim_noDA.tsv',t_eq+t_noDA,x_noDA(:,2:3),{'setParam','DA_Spine_parameter0'; 'setParam','Ca_Spine_parameter0'},name_rnf)
save_stimulation('stim_noDA_simple.tsv',t_eq+t_noDA,x_noDA(:,2:3)*fconv,{'setConc','DA()@Spine'; 'setConc','Ca()@Spine'; })

do_add=0;
for j=1:30 
update_concentrations('stim_noDA_complex.tsv',(j-1)*t_noDA(end),initial_concentrations,[],do_add)
do_add=1;
save_stimulation('stim_noDA_complex.tsv',(j-1)*t_noDA(end)+t_noDA,x_noDA(:,2:3)*fconv,{'setConc','DA()@Spine'; 'setConc','Ca()@Spine'; },[],do_add);
end

activationArea = sum(x_noDA(:,1)) - x_noDA(1,1) * length(x_noDA(:,1));
end

set(obj.rules(3), 'Active', 1);
set(obj.parameters(228), 'ValueUnits', 'second');
obj.parameters(228).Value = CaStart + 1;

if plot_simulation_results==1
[t_DA,x_DA,~] = sbiosimulate(obj);
save_stimulation('stim_DA.tsv',t_eq+t_DA,x_DA(:,2:3),{'setParam','DA_Spine_parameter0'; 'setParam','Ca_Spine_parameter0'},name_rnf)
save_stimulation('stim_DA_simple.tsv',t_eq+t_DA,x_DA(:,2:3)*fconv,{'setConc','DA()@Spine'; 'setConc','Ca()@Spine'; })
do_add=0;
for j=1:30 
update_concentrations('stim_DA_complex.tsv',(j-1)*t_DA(end),initial_concentrations,[],do_add)
do_add=1;
save_stimulation('stim_DA_complex.tsv',(j-1)*t_DA(end)+t_DA,x_DA(:,2:3)*fconv,{'setConc','DA()@Spine'; 'setConc','Ca()@Spine'; },[],do_add);
end

subplot(2,1,1)
hold on
plot(t_noDA, x_noDA(:,1)/max(x_noDA(:,1)), '-.', 'LineWidth', 2)
plot(t_DA, x_DA(:,1)/max(x_noDA(:,1)), 'LineWidth', 2)
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
legend({'Calcium only', 'Calcium + Dopamine (\Deltat=1s)'});

end


activationAreaWithMultipleDA = zeros(1,length(DA));
do_add=0;
ntrain=10;
t2=0;
dn=1;
prt=1;
fnm=['stim_complex_',num2str(prt),'.tsv'];
for n = 1:length(DA)
    obj.parameters(228).Value = CaStart + DA(n);
    if plot_simulation_results==1
    [t,x,~] = sbiosimulate(obj);
    
    %save_stimulation(['stim_',num2str(n),'.tsv'],t_eq+t,x(:,2:3),{'setParam','DA_Spine_parameter0'; 'setParam','Ca_Spine_parameter0'})
    dn=dn+1;
    if dn==3 
     do_add=0;
     prt=prt+1;
     fnm=['stim_complex_',num2str(prt),'.tsv'];
     dn=1; 
     t2=0;
    end
    for j=1:ntrain 
    update_concentrations(fnm,t2+(j-1)*t(end),initial_concentrations,[],do_add)
    do_add=1;
    save_stimulation(fnm,t2+(j-1)*t(end)+t,x(:,2:3)*fconv,{'setConc','DA()@Spine'; 'setConc','Ca()@Spine'; },[],do_add);
    end
    t2=t2+t(end)*ntrain;
    
    activationAreaWithMultipleDA(n) = sum(x(:,1)) - x(1,1) * length(x(:,1));
    clear t x names
    end
end

if plot_simulation_results==1
subplot(2,1,2)
hold on
plot(DA, activationAreaWithMultipleDA/activationArea, 'LineWidth', 2)
plot([-4 4], [1 1], '-.', 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
plot([0 0], [0 max(activationAreaWithMultipleDA/activationArea)], '-.', 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('\Deltat (s)');
ylabel('Substrate phosphorylation');

end



