i = 1;
stg.lb(i)=-1;
stg.ub(i)= 1;
stg.sasamplesigma = 1;
stg.sansamples = 1000000;
stg.bestpa(i) = 0.5;

r{i} = stg.lb(i) +...
    (stg.ub(i)-stg.lb(i)).*rand(1,stg.sansamples);

f_plot_SA_dist("SA Dist 1",r,i)

pd(i) = makedist('Normal','mu',stg.bestpa(i),...
    'sigma',stg.sasamplesigma);
t(i) = truncate(pd(i),stg.lb(i),stg.ub(i));
r{i} = random(t(i),stg.sansamples,1);
r2{i} = random(t(i),stg.sansamples,1);
M1(:,i) = r{i};
M2(:,i) = r2{i};

f_plot_SA_dist("SA Dist 2",r,i)

pd(i) = makedist('Normal','mu',stg.bestpa(i),...
    'sigma',stg.sasamplesigma);
r{i} = random(pd(i),stg.sansamples,1);
r2{i} = random(pd(i),stg.sansamples,1);
M1(:,i) = r{i};
M2(:,i) = r2{i};

f_plot_SA_dist("SA Dist 3",r,i)

pd(i) = makedist('Normal','mu',...
    stg.lb(i) + (stg.ub(i)-stg.lb(i))/2,'sigma',stg.sasamplesigma);
t(i) = truncate(pd(i),stg.lb(i),stg.ub(i));
r{i} = random(t(i),stg.sansamples,1);

f_plot_SA_dist("SA Dist 4",r,i)

pd(i) = makedist('Normal','mu',...
    stg.lb(i) + (stg.ub(i)-stg.lb(i))/2,'sigma',stg.sasamplesigma);
r{i} = random(pd(i),stg.sansamples,1);

f_plot_SA_dist("SA Dist 5",r,i)

function f_plot_SA_dist(title_name,r,i)

figHandles = findobj('type', 'figure', 'name', title_name);
close(figHandles);
figure('WindowStyle', 'docked','Name',title_name, 'NumberTitle', 'off');

layout = tiledlayout(1,2,'Padding','none','TileSpacing','compact');

layout.Units = 'inches';
layout.OuterPosition = [0 0 14 6];

nexttile
histogram(10.^r{i},'BinMethod','fd','EdgeColor','none')
ylabel('frequency','FontSize', 12,'Fontweight','bold')
xlabel('x_{example}','FontSize', 12,'Fontweight','bold')

nexttile
histogram(r{i},'EdgeColor','none')
xlabel('log x_{example}','FontSize', 12,'Fontweight','bold')
ylabel('frequency','FontSize', 12,'Fontweight','bold')

exportgraphics(layout,...
    title_name + '.png',...
    'Resolution',600)
end