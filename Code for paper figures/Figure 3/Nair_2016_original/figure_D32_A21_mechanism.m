proj = sbioloadproject('Nair_2016');
obj = proj.m1;

effectors = {'Neuron.totalpSubstrate',...
             'Neuron.totalactivePP1'...
             'Neuron.totalActCaMKIIpsd', ...
             'Neuron.totalActiveCaM', ...
             'Neuron.totalpARPP21'};

CaTStart = 4;
DAdelay = [-4:0.2:4];

simWithoutDA = runCaDACombination(obj, [], CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {});
activationAreaWithoutDA = sum(simWithoutDA.Data{1}(1,:));

simD32mutantWithoutDA = runCaDACombination(obj, [], CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {'D32T34A'});
activationAreaD32mutantWithoutDA = sum(simD32mutantWithoutDA.Data{1}(1,:));

simA21mutantWithoutDA = runCaDACombination(obj, [], CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {'A21S55A'});
activationAreaA21mutantWithoutDA = sum(simA21mutantWithoutDA.Data{1}(1,:));

activationAreaWithDAResults = zeros(1,length(DAdelay));
activationAreaD32mutantWithDAResults = zeros(1,length(DAdelay));
activationAreaA21mutantWithDAResults = zeros(1,length(DAdelay));

for i = 1:length(DAdelay)
    thisSimNormal = runCaDACombination(obj, (CaTStart+DAdelay(i)), CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {});
    activationAreaWithDAResults(i) = sum(thisSimNormal.Data{1}(1,:));
    
    thisSimD32mutant = runCaDACombination(obj, (CaTStart+DAdelay(i)), CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {'D32T34A'});
    activationAreaD32mutantWithDAResults(i) = sum(thisSimD32mutant.Data{1}(1,:));
    
    thisSimA21mutant = runCaDACombination(obj, (CaTStart+DAdelay(i)), CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {'A21S55A'});
    activationAreaA21mutantWithDAResults(i) = sum(thisSimA21mutant.Data{1}(1,:));
end

% Simulation traces
% Reward after stimulus
simNormal1 = runCaDACombination(obj, 5.0, CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {});
simD32mutant = runCaDACombination(obj, 5.0, CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {'D32T34A'});

% Reward preceeds stimulus
simNormal2 = runCaDACombination(obj, 3.0, CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {});
simA21mutant = runCaDACombination(obj, 3.0, CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {'A21S55A'});

figure('Color','w','Position',get(0,'ScreenSize'))

subplot(2,3,1)
hold on
plot(DAdelay, activationAreaWithDAResults/activationAreaWithoutDA, 'LineWidth', 2, 'Color', 'k')
plot(DAdelay, activationAreaD32mutantWithDAResults/activationAreaD32mutantWithoutDA, '-.', 'LineWidth', 2, 'Color', 'k')
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('\Deltat (s)');
ylabel('Substrate phosphorylation');
legend({'WT', 'D32T34A'})

subplot(2,3,[2,3])
hold on
plot(simNormal1.Time, simNormal1.Data{1}(2,:)/max(simWithoutDA.Data{1}(2,:)), '-.', 'LineWidth', 2, 'Color', 'k')
plot(simD32mutant.Time, simD32mutant.Data{1}(2,:)/max(simD32mutantWithoutDA.Data{1}(2,:)), 'LineWidth', 2, 'Color', 'k')
plot(simNormal1.Time, simNormal1.Data{1}(3,:)/max(simWithoutDA.Data{1}(3,:)), '-.', 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
plot(simD32mutant.Time, simD32mutant.Data{1}(3,:)/max(simD32mutantWithoutDA.Data{1}(3,:)), 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
legend({'Active PP1 (WT)', 'Active PP1 (D32T34A)', 'Active CaMKII (WT)', 'Active CaMKII (D32T34A)'})

subplot(2,3,4)
hold on
plot(DAdelay, activationAreaWithDAResults/activationAreaWithoutDA, 'LineWidth', 2, 'Color', 'k')
plot(DAdelay, activationAreaA21mutantWithDAResults/activationAreaA21mutantWithoutDA, '-.', 'LineWidth', 2, 'Color', 'k')
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('\Deltat (s)');
ylabel('Substrate phosphorylation');
legend({'WT', 'A21S55A'})

subplot(2,3,5)
hold on
plot(simNormal1.Time, simNormal1.Data{1}(3,:)/max(simWithoutDA.Data{1}(3,:)), 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
plot(simNormal2.Time, simNormal2.Data{1}(3,:)/max(simWithoutDA.Data{1}(3,:)), 'LineWidth', 2, 'Color', 'k')
plot(simA21mutant.Time, simA21mutant.Data{1}(3,:)/max(simA21mutantWithoutDA.Data{1}(3,:)), '-.', 'LineWidth', 2, 'Color', 'k')
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Active CaMKII');
legend({'\Deltat = 1s', '\Deltat = -1s (WT)', '\Deltat = -1s (A21S55A)'})

subplot(2,3,6)
hold on
plot(simNormal1.Time, simNormal1.Data{1}(4,:)/max(simWithoutDA.Data{1}(4,:)), 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
plot(simNormal2.Time, simNormal2.Data{1}(4,:)/max(simWithoutDA.Data{1}(4,:)), 'LineWidth', 2, 'Color', 'k')
plot(simNormal2.Time, simNormal2.Data{1}(5,:)/max(simWithoutDA.Data{1}(4,:)), '-.', 'LineWidth', 2, 'Color', 'k')
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
legend({'Active CaM (\Deltat = 1s)', 'Active CaM (\Deltat = -1s)', 'ARPP-21*CaM (\Deltat = -1s)'})