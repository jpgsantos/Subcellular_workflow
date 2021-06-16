function f_save_plots(stg,date_stamp,script_folder)

Analysis_folder = stg.analysis+"/";
Date_folder = string(date_stamp)+"/";
Results_Folder = script_folder + "Model/" + stg.folder_model + "/Results/";

FigList = findobj(allchild(0), 'flat', 'Type', 'figure');

mkdir(Results_Folder + Analysis_folder,Date_folder);

savefig(FigList(end:-1:1),...
    Results_Folder + Analysis_folder  + Date_folder + "All_figures.fig");

for iFig = 1:length(FigList)
    FigHandle = FigList(iFig);
    FigName   = get(FigHandle, 'Name');
    
    saveas(FigHandle, Results_Folder ...
        + Analysis_folder + Date_folder + FigName + ".png")
end
end