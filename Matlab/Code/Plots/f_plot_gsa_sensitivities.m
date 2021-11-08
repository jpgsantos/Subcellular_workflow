function f_plot_gsa_sensitivities(rst,stg,sbtab)
% Generates figures for Sensitivity Analysis

% Get the total number of outputs
[~,outputNames.sd] = f_get_outputs(stg,sbtab);

for n = 1:size(outputNames.sd,2)
    outputNames.sd{n}{:} = strrep(outputNames.sd{n}{:},"_","\_");
end
for n = stg.exprun
    outputNames.se{n} = "E " + string(n-1);
end

outputNames.xfinal = outputNames.sd;

parNames = cell(1,stg.parnum);
parNames2 = cell(1,stg.parnum);

for n = 1:stg.parnum
    parNames{n} = char("\theta_{" + find(stg.partest==n) + "}");
end

for n = 1:size(parNames,2)
    parNames2{n} = string(parNames{n}(1,:));
    for m = 2:size(parNames{n},1)
        parNames2{n} = string(parNames2{n}) + ", " +...
            string(parNames{n}(m,:));
    end
end

% Bootstrapping quartile mean of first order Sensitivity index for score
% per Experimental Output
f_generate_plot(rst,stg,outputNames,parNames2,...
    "Si seo bm",...
    "First order Sensitivities calculated using the Score of each Experimental Output  (Bootstrapping Mean)",...
    "outputNames.sd",...
    "transpose(reshape(mean(rst.SiQ.sd(:,:,1:stg.parnum)),[size(rst.SiQ.sd,2),size(rst.SiQ.sd,3)]))")

% Bootstrapping quartile mean of total order Sensitivity index for score
% per Experimental Output
f_generate_plot(rst,stg,outputNames,parNames2,"SiT seo bm",...
    "Total order Sensitivities calculated using the Score of each Experimental Output (Bootstrapping Mean)",...
    "outputNames.sd",...
    "transpose(reshape(mean(rst.SiTQ.sd(:,:,1:stg.parnum)),[size(rst.SiQ.sd,2),size(rst.SiQ.sd,3)]))")

% Bootstrapping quartile mean of first order Sensitivity index for score
% per Experiments
f_generate_plot(rst,stg,outputNames,parNames2,"Si se bm",...
    "First order Sensitivities calculated using the Score of each Experiment(Bootstrapping Mean)",...
    "outputNames.se",...
    "transpose(reshape(mean(rst.SiQ.se(:,:,1:stg.parnum)),[size(rst.SiQ.se,2),size(rst.SiQ.se,3)]))")

% Bootstrapping quartile mean of total order Sensitivity index for score
% per Experiments
f_generate_plot(rst,stg,outputNames,parNames2,"SiT se bm",...
    "Total order Sensitivities calculated using the Score of each Experiment (Bootstrapping Mean)",...
    "outputNames.se",...
    "transpose(reshape(mean(rst.SiTQ.se(:,:,1:stg.parnum)),[size(rst.SiQ.se,2),size(rst.SiQ.se,3)]))")

% Bootstrapping quartile mean of first order Sensitivity index for the
% final points of the simulations for the output beeing measured
f_generate_plot(rst,stg,outputNames,parNames2,"Si xfinal bm",...
    "First order Sensitivities calculated using the final value of each Experimental Output (Bootstrapping Mean)",...
    "outputNames.xfinal",...
    "transpose(reshape(mean(rst.SiQ.xfinal(:,:,1:stg.parnum)),[size(rst.SiQ.xfinal,2),size(rst.SiQ.xfinal,3)]))")

% Bootstrapping quartile mean of total order Sensitivity index for the
% final points of the simulations for the output beeing measured
f_generate_plot(rst,stg,outputNames,parNames2,"SiT xfinal bm",...
    "Total order Sensitivities calculated using the final value of each Experimental Output (Bootstrapping Mean)",...
    "outputNames.xfinal",...
    "transpose(reshape(mean(rst.SiTQ.xfinal(:,:,1:stg.parnum)),[size(rst.SiQ.xfinal,2),size(rst.SiQ.xfinal,3)]))")

figHandles = findobj('type', 'figure', 'name', 'Si,SiT');
close(figHandles);
figure('WindowStyle', 'docked','Name','Si,SiT', 'NumberTitle', 'off');

for n = 1:size(parNames2,2)
    a{n} = char(parNames2{n});
end

a = categorical(a,a);

bar(a,[transpose(rst.Si.st(:,1:stg.parnum)),...
    transpose(rst.SiT.st(:,1:stg.parnum))])
xlabel('Parameters');
ylabel('Sensitivity');
title('Sensitivities calculated using the sum of the Score of all Experiments');
legend({'SI','SIT'});
legend boxoff

figHandles = findobj('type', 'figure', 'name', 'Si,SiT b');
close(figHandles);
figure('WindowStyle', 'docked','Name','Si,SiT b', 'NumberTitle', 'off');

T = [];

for n = 1:size(a,2)
    for m = 1:size(rst.SiQ.st(:,n),1)
 T = [T;table(rst.SiQ.st(m,n),a(n),"Si")];
    end
end
for n = 1:size(a,2)
    for m = 1:size(rst.SiTQ.st(:,n),1)
 T = [T;table(rst.SiTQ.st(m,n),a(n),"SiT")];
    end
end

boxchart(T.Var2,T.Var1,'GroupByColor',T.Var3,'MarkerStyle','.','JitterOutliers','on')
xlabel('Parameters');
ylabel('Sensitivity');
title('Sensitivities calculated using the sum of the Score of all Experiments (Bootstrapping)');
legend({'Si','SiT'},'Location','best');
legend boxoff
end

function f_generate_plot(rst,stg,outputNames,parNames2,name,title,...
    helprer1,helprer2)

eval("figHandles = findobj('type', 'figure', 'name', '" + name + "');")
close(figHandles);
eval("figure('WindowStyle', 'docked','Name','" + name +...
    "','NumberTitle', 'off');")

heatmap_fixer = eval(helprer1);
heatmap_fixer=heatmap_fixer(~cellfun('isempty',heatmap_fixer));

heatmap_fixer2 = eval(helprer2);
heatmap_fixer2 = heatmap_fixer2(:,all(~isnan(heatmap_fixer2)));

h = heatmap(heatmap_fixer,parNames2,heatmap_fixer2,'Colormap',turbo,...
    'ColorLimits',[0 1],'GridVisible','off');
h.CellLabelFormat = '%.2f';

eval(" h.Title = """ + title + """;")
h.XLabel = 'Outputs';
h.YLabel = 'Parameters';
end