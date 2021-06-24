clear
clear functions
clc

model_name = "Nair_2016";
name1 = "Neuron.pSubstrate";
name2 = "Neuron.Ca";

for n = 1:1
species{n} = [];
thisSim{n} = [];
activationAreaWithDAResultsWithBaseline{n} = [];
       
proj = sbioloadproject(char(model_name{n}));
obj = proj.m1;
effectors{n} = {char(name1{n}), char(name2{n})};
%effectors = {"Neuron.pSubstrate", "Neuron.Ca"}

species{n}.names = {char(name2{n})};
species{n}.values = 0;

DAdelay{n} = [-4:0.2:4];
DAdelayplotpoint{n} = [-4 -1 0 1 4];
CaTStart = 4;
DATStart = 5;

simWithoutDA{n} = runCaDACombination(obj, [], CaTStart, 1, 1, 1500, 30, 0.01, species{n}, effectors{n}, {});
activationAreaWithBaseline{n} = sum(simWithoutDA{n}.Data{1}(1,:));
baselineArea{n} = simWithoutDA{n}.Data{1}(1)*length(simWithoutDA{n}.Data{1});
activationArea{n} = activationAreaWithBaseline{n} - baselineArea{n};

simWithstandDelayDA{n} = runCaDACombination(obj, DATStart, CaTStart, 1, 1, 1500, 30, 0.01, species{n}, effectors{n}, {});

simWithDAResults{n} = {};
calcium{n} = {};

activationAreaWithDAResults{n} = zeros(1,length(DAdelay{n}));

for i = 1:length(DAdelay{n})
    thisSim{n} = runCaDACombination(obj, (CaTStart+DAdelay{n}(i)), CaTStart, 1, 1, 1500, 30, 0.01, species{n}, effectors{n}, {}); 
    activationAreaWithDAResultsWithBaseline{n}(i) = sum(thisSim{n}.Data{1}(1,:));
    activationAreaWithDAResults{n} = activationAreaWithDAResultsWithBaseline{n} - baselineArea{n};
    simWithDAResults{n}{1,end+1} = thisSim{n}.Data{1}(1,:);
    calcium{n}{end+1} = thisSim{n}.Data{1}(2,:);
end

end

ocmap = myColorMap();
figure('Color','w','Position',get(0,'ScreenSize'))
mc = ['k','r','g','b','k','r','g','b'];

subplot(2,2,1)
hold on
for n = 1:1
plot(simWithoutDA{n}.Time, simWithoutDA{n}.Data{1}(1,:)/max(simWithoutDA{n}.Data{1}(1,:)), '-.', 'LineWidth', 2, 'Color', mc(n))
plot(simWithstandDelayDA{n}.Time, simWithstandDelayDA{n}.Data{1}(1,:)/max(simWithoutDA{n}.Data{1}(1,:)), 'LineWidth', 2, 'Color', mc(n))
end
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
legend({'Calcium only, new', 'Calcium + Dopamine (\Deltat=1s)',' Calcium only, original', 'Calcium + Dopamine (\Deltat=1s)'});

subplot(2,2,2)
hold on
for n = 1:1
plot(DAdelay{n}, activationAreaWithDAResults{n}/activationArea{n}, 'LineWidth', 2, 'Color',  mc(n))
plot([DAdelay{n}(1) DAdelay{n}(length(DAdelay{n}))], [1 1], '-.', 'LineWidth', 2, 'Color',  mc(n))
plot([0 0], [0 max(activationAreaWithDAResults{n}/activationArea{n})], '-.', 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
end
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('\Deltat (s)');
ylabel('Substrate phosphorylation')
legend({'New model','Original model'});

subplot(2,2,3)
hold on
for n = 3:4
plot(simWithoutDA{n}.Time, simWithoutDA{n}.Data{1}(1,:)/max(simWithoutDA{n}.Data{1}(1,:)), '-.', 'LineWidth', 2, 'Color', mc(n))
plot(simWithstandDelayDA{n}.Time, simWithstandDelayDA{n}.Data{1}(1,:)/max(simWithoutDA{n}.Data{1}(1,:)), 'LineWidth', 2, 'Color', mc(n))
end
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('time (s)');
ylabel('Substrate phosphorylation');
legend({'no DA new', 'DA (\Deltat=1s) K','no DA old', 'DA (\Deltat=1s) K1'});

subplot(2,2,4)
hold on
for n = 3:4
plot(DAdelay{n}, activationAreaWithDAResults{n}/activationArea{n}, 'LineWidth', 2, 'Color',  mc(n))
plot([DAdelay{n}(1) DAdelay{n}(length(DAdelay{n}))], [1 1], '-.', 'LineWidth', 2, 'Color',  mc(n))
plot([0 0], [0 max(activationAreaWithDAResults{n}/activationArea{n})], '-.', 'LineWidth', 2, 'Color', [0.5 0.5 0.5])
end
set(gca,'FontSize',12, 'FontWeight', 'bold')
xlabel('\Deltat (s)');
ylabel('Substrate phosphorylation')
legend({'new','old'});



subplot(2,2,[3,4])
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