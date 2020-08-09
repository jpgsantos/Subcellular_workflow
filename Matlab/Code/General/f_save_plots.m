function f_save_plots(stg,date_stamp)

Folder_name = "Analysis_";

if contains(stg.analysis,"diag")
    Folder_name = append(Folder_name,"diag_");
end

if contains(stg.analysis,"opt")
    Folder_name = append(Folder_name,"opt_");
end

if contains(stg.analysis,"SA")
    Folder_name = append(Folder_name,"SA_");
end

Folder_name = append(Folder_name,string(date_stamp));

FigList = findobj(allchild(0), 'flat', 'Type', 'figure');


savefig(FigList(end:-1:1), "Model/" +char(stg.folder_model) +...
    "/Results/" + Folder_name + "/All_figures.fig");

for iFig = 1:length(FigList)
FigHandle = FigList(iFig);
FigName   = get(FigHandle, 'Name');

saveas(FigHandle,"Model/" + char(stg.folder_model) +...
    "/Results/" + Folder_name + "/" +  FigName + ".png")
end
end