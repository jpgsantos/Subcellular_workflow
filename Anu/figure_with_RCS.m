proj = sbioloadproject('D1 LTP time window_clean');
obj = proj.m1;

effectors = {'Spine.totalpCaMui'};

DAdelay = [-4:0.2:4];
DAdelayplotpoint = [-2 -1 0 1 4];
CaTStart = 4;

simWithoutDA = runCaDACombination(obj, [], CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {});
activationArea = sum(simWithoutDA.Data{1}(1,:));

simWithDAResults = {};

activationAreaWithDAResults = zeros(1,length(DAdelay));

for i = 1:length(DAdelay)
    thisSim = runCaDACombination(obj, (CaTStart+DAdelay(i)), CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {});
    activationAreaWithDAResults(i) = sum(thisSim.Data{1}(1,:));
    simWithDAResults{end+1} = thisSim.Data{1}(1,:);
end

ocmap = myColorMap();
figure('Color','w','Position',get(0,'ScreenSize'))

subplot(1,2,1)
hold on
plot(DAdelay, activationAreaWithDAResults/activationArea, 'LineWidth', 2, 'Color', 'k')
plot([DAdelay(1) DAdelay(length(DAdelay))], [1 1], '-.', 'LineWidth', 2, 'Color', 'k')
plot([0 0], [0 max(activationAreaWithDAResults/activationArea)], '-.', 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('\Deltat (s)');
ylabel('Substrate phosphorylation');

subplot(1,2,2)
hold on
colorcounter = 0;
legends = {};
for i = 1:length(simWithDAResults)
    if sum(DAdelay(i) == DAdelayplotpoint)
        colorcounter = colorcounter +1;
        legends{end+1} = ['\Deltat=' num2str(DAdelay(i)) 's'];
        plot(simWithoutDA.Time, simWithDAResults{i}/max(simWithoutDA.Data{1}(1,:)), 'LineWidth', 2, 'Color', ocmap(2*colorcounter,:))
    end
end
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
legend(legends);