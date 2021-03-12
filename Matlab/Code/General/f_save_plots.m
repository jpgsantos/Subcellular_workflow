function f_save_plots(stg,date_stamp)

Folder_name = stg.analysis;

Folder_name2 = string(date_stamp);

FigList = findobj(allchild(0), 'flat', 'Type', 'figure');

mkdir("Model/" + stg.folder_model + "/Results"+ "/" + Folder_name,Folder_name2);

savefig(FigList(end:-1:1), "Model/" +char(stg.folder_model) +...
    "/Results/" + Folder_name +"/" + Folder_name2 + "/All_figures.fig");

for iFig = 1:length(FigList)
    FigHandle = FigList(iFig);
    FigName   = get(FigHandle, 'Name');
    
    saveas(FigHandle,"Model/" + char(stg.folder_model) +...
        "/Results/" + Folder_name +"/" + Folder_name2 + "/" +  FigName + ".png")
end
end