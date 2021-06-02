function f_plot_SA_sensitivities(rst,stg)
% Generates figures for Sensitivity Analysis

% Get the total number of outputs
[~,outputNames.sd] = f_get_outputs(stg);

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
    parNames{n} = char("P" + find(stg.partest==n));
end

for n = 1:size(parNames,2)
    parNames2{n} = string(parNames{n}(1,:));
    for m = 2:size(parNames{n},1)
        parNames2{n} = string(parNames2{n}) + ", " +...
            string(parNames{n}(m,:));
    end
end

f_generate_plot(rst,stg,outputNames,parNames2,"SA SI sd","SA SI sd",...
    "outputNames.sd",...
    "transpose(rst.SI.sd(:,1:stg.parnum))")

f_generate_plot(rst,stg,outputNames,parNames2,"SA SIT sd","SA SIT sd",...
    "outputNames.sd",...
    "transpose(rst.SIT.sd(:,1:stg.parnum))")

f_generate_plot(rst,stg,outputNames,parNames2,"SA SIT-SI sd","SIT-SI sd",...
    "outputNames.sd",...
    "transpose(rst.SIT.sd(:,1:stg.parnum)-rst.SI.sd(:,1:stg.parnum))")

f_generate_plot(rst,stg,outputNames,parNames2,"SA SI se","SA SI se",...
    "outputNames.se",...
    "transpose(rst.SI.se(:,1:stg.parnum))")

f_generate_plot(rst,stg,outputNames,parNames2,"SA SIT se","SA SIT se",...
    "outputNames.se",...
    "transpose(rst.SIT.se(:,1:stg.parnum))")

f_generate_plot(rst,stg,outputNames,parNames2,"SA SIT-SI se","SA SIT-SI se",...
    "outputNames.se",...
    "transpose(rst.SIT.se(:,1:stg.parnum)-rst.SI.se(:,1:stg.parnum))")

f_generate_plot(rst,stg,outputNames,parNames2,"SA SI xfinal","SA SI xfinal",...
    "outputNames.xfinal",...
    "transpose(rst.SI.xfinal(:,1:stg.parnum))")

f_generate_plot(rst,stg,outputNames,parNames2,"SA SIT xfinal","SA SIT xfinal",...
    "outputNames.xfinal",...
    "transpose(rst.SIT.xfinal(:,1:stg.parnum))")

f_generate_plot(rst,stg,outputNames,parNames2,"SA SIT-SI xfinal","SA SIT-SI xfinal",...
    "outputNames.xfinal",...
    "transpose(rst.SIT.xfinal(:,1:stg.parnum)-rst.SI.xfinal(:,1:stg.parnum))")

figHandles = findobj('type', 'figure', 'name', 'SA SI st');
close(figHandles);
figure('WindowStyle', 'docked','Name','SA SI st', 'NumberTitle', 'off');

for n = 1:size(parNames2,2)
    a{n} = char(parNames2{n});
end

a = categorical(a,a);

bar(a,[transpose(rst.SI.st(:,1:stg.parnum)),...
    transpose(rst.SIT.st(:,1:stg.parnum)),...
    transpose(rst.SIT.st(:,1:stg.parnum)-rst.SI.st(:,1:stg.parnum))])
xlabel('Parameters');
ylabel('Sensitivity');
title('Sensitivities of total score of all experiments');
legend({'SI','SIT','SIT-SI'});
legend boxoff



% rst.SiQ.st(:,1:stg.parnum)
figHandles = findobj('type', 'figure', 'name', 'SA Si st boxplots');
close(figHandles);
figure('WindowStyle', 'docked','Name','SA Si st boxplots', 'NumberTitle', 'off');

% for n = 1:size(parNames2,2)
% a{n} = char(parNames2{n});
% end
% 
%  a = categorical(a,a);

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
for n = 1:size(a,2)
    for m = 1:size(rst.SiTQ.st(:,n),1)
 T = [T;table(rst.SiTQ.st(m,n)-rst.SiQ.st(m,n),a(n),"SiT-Si")];
    end
end

%
%  T2 = table(rst.SiQ.st(2,1:stg.parnum),a,"Si")
%  T3 = [T;T2]
%  T
%  rst.SiQ.st(:,1:stg.parnum)

%  rst.SiQ.st(1,1:stg.parnum)';
% boxchart(a,rst.SiQ.st(1,1:stg.parnum)')
% boxchart(a,rst.SiQ.st(:,1:stg.parnum))
% subplot(2,2,1)
boxchart(T.Var2,T.Var1,'GroupByColor',T.Var3,'MarkerStyle','.')
legend({'Si','SiT',"SiT-Si"},'Location','best');
legend boxoff
% subplot(2,2,2)
% boxchart(rst.SiQ.st(:,1:stg.parnum),'MarkerStyle','none')
% legend({'Si'},'Location','best');
% legend boxoff
% subplot(2,2,3)
% boxchart(rst.SiTQ.st(:,1:stg.parnum),'MarkerStyle','none')
% legend({'SiT'},'Location','best');
% legend boxoff
% subplot(2,2,4)
% boxchart(rst.SiTQ.st(:,1:stg.parnum)-rst.SiQ.st(:,1:stg.parnum),'MarkerStyle','none')
% legend({"SiT-Si"},'Location','best');
% legend boxoff
% boxchart(rst.SiTQ.st(:,1:stg.parnum))

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

h = heatmap(heatmap_fixer,parNames2,heatmap_fixer2,'Colormap',jet);

eval(" h.Title = """ + title + """;")
h.XLabel = 'Outputs';
h.YLabel = 'Parameters';
end