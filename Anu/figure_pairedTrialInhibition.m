proj = sbioloadproject('D1 LTP time window_clean');
obj = proj.m1;

effectors = {'Spine.totalpCaMui',...
             'Spine.totalpRCS'};
caStart = 0; 
rewardStart = 1;

trialInterval = logspace(1,2,10);

specificITIs = [10 50];
specificTrace = {};
mutantTrace = {};

refractoryIndex = zeros(1,length(trialInterval));
mutantrefractoryIndex = zeros(1,length(trialInterval));

% single trial for normalization
singleTrialOnlyDA = runCaDACombination(obj, rewardStart, [], 1, 0.01, 1500, 125, 0.01, {}, effectors, {});

singleTrial = runCaDACombination(obj, rewardStart, caStart, 1, 0.01, 1500, 125, 0.01, {}, effectors, {});
singleTrialactivationArea = sum(singleTrial.Data{1}(1,:));
maxWithoutDA = max(singleTrial.Data{1}(1,:));

mutantsingleTrial = runCaDACombination(obj, rewardStart, caStart, 1, 0.01, 1500, 125, 0.01, {}, effectors, {'A21S55A'});
mutantsingleTrialactivationArea = sum(mutantsingleTrial.Data{1}(1,:));
maxMutantWithoutDA = max(mutantsingleTrial.Data{1}(1,:));

% two trials well separated by 100s for normalization
wellSeparatedTrial = runCaDACombination(obj, rewardStart, caStart, 2, 0.01, 1500, 125, 0.01, {}, effectors, {});
wellSeparatedTrialactivationArea = sum(wellSeparatedTrial.Data{1}(1,:));
wellSeparatedTrialSecondArea = wellSeparatedTrialactivationArea - singleTrialactivationArea;

traceTimePoint = wellSeparatedTrial.Time;

mutantwellSeparatedTrial = runCaDACombination(obj, rewardStart, caStart, 2, 0.01, 1500, 125, 0.01, {}, effectors, {'A21S55A'});
mutantwellSeparatedTrialactivationArea = sum(mutantwellSeparatedTrial.Data{1}(1,:));
mutantwellSeparatedTrialSecondArea = mutantwellSeparatedTrialactivationArea - mutantsingleTrialactivationArea;
    
for j = 1:length(trialInterval)
    [j]
    thisTrial = runCaDACombination(obj, rewardStart, caStart, 2, 1/trialInterval(j), 1500, 125, 0.01, {}, effectors, {});
    thisTrialactivationArea = sum(thisTrial.Data{1}(1,:));
    refractoryIndex(j) = (thisTrialactivationArea - singleTrialactivationArea) / wellSeparatedTrialSecondArea;

    mutantTrial = runCaDACombination(obj, rewardStart, caStart, 2, 1/trialInterval(j), 1500, 125, 0.01, {}, effectors, {'A21S55A'});
    mutantTrialactivationArea = sum(mutantTrial.Data{1}(1,:));
    mutantrefractoryIndex(j) = (mutantTrialactivationArea - mutantsingleTrialactivationArea) / mutantwellSeparatedTrialSecondArea;
end


refractoryIndex = 1 - refractoryIndex;
mutantrefractoryIndex = 1 - mutantrefractoryIndex;

specificITIs = [10 30];
specificTrace = {};
mutantTrace = {};

for i = 1:length(specificITIs)
    thisTrial = runCaDACombination(obj, rewardStart, caStart, 2, 1/specificITIs(i), 1500, 125, 0.01, {}, effectors, {});
    specificTrace{end+1} = thisTrial.Data{1}(1,:);
    
    mutantTrial = runCaDACombination(obj, rewardStart, caStart, 2, 1/specificITIs(i), 1500, 125, 0.01, {}, effectors, {'A21S55A'});
    mutantTrace{end+1} = mutantTrial.Data{1}(1,:);
end

figure('Color','w','Position',get(0,'ScreenSize'))

subplot(2,3,[1,4])
hold on
plot(trialInterval, refractoryIndex, 'LineWidth', 2, 'Color', 'k')
plot(trialInterval, mutantrefractoryIndex, '-.', 'LineWidth', 2, 'Color', 'k')
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('ITI (s)');
ylabel('Refractory Index');
legend({'WT', 'A21S55A'});

subplot(2,3,2)
hold on
plot(traceTimePoint, specificTrace{1}/maxWithoutDA, 'LineWidth', 2, 'Color', 'k')
plot(traceTimePoint, mutantTrace{1}/maxMutantWithoutDA, '-.', 'LineWidth', 2, 'Color', 'k')
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
xlim([0 50])
legend({'WT', 'A21S55A'});

subplot(2,3,3)
hold on
plot(traceTimePoint, specificTrace{2}/maxWithoutDA, 'LineWidth', 2, 'Color', 'k')
plot(traceTimePoint, mutantTrace{2}/maxMutantWithoutDA, '-.', 'LineWidth', 2, 'Color', 'k')
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
xlim([0 50])
legend({'WT', 'A21S55A'});

subplot(2,3,[5,6])
hold on
plot(singleTrialOnlyDA.Time, singleTrialOnlyDA.Data{1}(2,:)/singleTrialOnlyDA.Data{1}(2,1), 'LineWidth', 2, 'Color', 'k')
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('pARPP-21 (/basal)');
xlim([0 30])
