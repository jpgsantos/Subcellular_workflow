function f_save_plots(stg,date_stamp)

FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
savefig(FigList(end:-1:1), "Model/" +char(stg.folder_model) +...
    "/Results/Analysis_" +string(date_stamp) + "/All_figures.fig");

for iFig = 1:length(FigList)
FigHandle = FigList(iFig);
FigName   = get(FigHandle, 'Name');

saveas(FigHandle,"Model/" + char(stg.folder_model) +...
    "/Results/Analysis_" +string(date_stamp) + "/" +  FigName + ".png")
end
end