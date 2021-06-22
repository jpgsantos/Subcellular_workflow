proj = sbioloadproject('D1 LTP time window_clean');
obj = proj.m1;

effectors = {'Spine.totalpCaMui'};

CaTStart = 4;
DAdelay = [-4:0.2:4];

DApeakamps = logspace(2,4,20);
plotDAAmps = [500, 1500, 5000, 10000];

CaFreqs = [1:20];
plotCaFreqs = [5 10 15 20];

simWithoutDA = runCaDACombination(obj, [], CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {});
activationAreaWithoutDA = sum(simWithoutDA.Data{1}(1,:));

% Scan with different levels of reinforcer
['Starting DA scan...']
DApeakampScan = zeros(length(DApeakamps), length(DAdelay));
for i = 1:length(DApeakamps)
    ['DA amp = ' num2str(DApeakamps(i))]
    for j = 1:length(DAdelay)
        thisSim = runCaDACombination(obj, (CaTStart+DAdelay(j)), CaTStart, 1, 1, DApeakamps(i), 30, 0.01, {}, effectors, {});
        DApeakampScan(i,j) = sum(thisSim.Data{1}(1,:));
    end
end
['End of DA Scan']


% Scan with different frequencies of Calcium stimulus
CaFreqScan = zeros(length(CaFreqs), length(DAdelay));
pobj = sbioselect(obj,'Name', 'nCa_frequency');
origalFreq = pobj.Value;
['Starting Ca scan...']
for i = 1:length(CaFreqs)
    ['Ca frequency = ' num2str(CaFreqs(i))]
    set(pobj,'Value',CaFreqs(i));
    for j = 1:length(DAdelay)
        thisSim = runCaDACombination(obj, (CaTStart+DAdelay(j)), CaTStart, 1, 1, 1500, 30, 0.01, {}, effectors, {});
        CaFreqScan(i,j) = sum(thisSim.Data{1}(1,:));
    end
end
['End of Ca Scan']
set(pobj,'Value',origalFreq);

figure('Color','w','Position',get(0,'ScreenSize'))

subplot(2,2,1);
imagesc(DAdelay,linspace(2,4,20),DApeakampScan); axis xy;
set(gca,'FontSize',12, 'FontWeight', 'bold')
set(gca,'xtick',[-4 -2 0 2 4])
set(gca,'xticklabel',[-4 -2 0 2 4])
set(gca,'ytick',[2 3 4])
set(gca,'yticklabel',[2 3 4])
title('A')
xlabel('\Deltat (s)')
ylabel('log([DA] (nM))')

subplot(2,2,2);
imagesc(DAdelay,CaFreqs,CaFreqScan); axis xy;
set(gca,'FontSize',12, 'FontWeight', 'bold')
set(gca,'xtick',[-4 -2 0 2 4])
set(gca,'xticklabel',[-4 -2 0 2 4])
set(gca,'ytick',[1 5 10 15 20])
set(gca,'yticklabel',[1 5 10 15 20])
title('B')
xlabel('\Deltat (s)')
ylabel('Ca frequency (Hz)')