function f_save_plots(stg,date_stamp,script_folder)

Folder_name = stg.analysis;

Folder_name2 = string(date_stamp);

FigList = findobj(allchild(0), 'flat', 'Type', 'figure');

mkdir(script_folder + "Model/" + stg.folder_model + "/Results"+ "/" + Folder_name,Folder_name2);

savefig(FigList(end:-1:1), script_folder + "Model/" +char(stg.folder_model) +...
    "/Results/" + Folder_name +"/" + Folder_name2 + "/All_figures.fig");

for iFig = 1:length(FigList)
    FigHandle = FigList(iFig);
    FigName   = get(FigHandle, 'Name');
    
    saveas(FigHandle,script_folder + "Model/" + char(stg.folder_model) +...
        "/Results/" + Folder_name +"/" + Folder_name2 + "/" +  FigName + ".png")
end
end