function f_save_analysis(stg,sb,rst,date_stamp)

mkdir("Model/" + stg.folder_model,"Results");

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

mkdir("Model/" + stg.folder_model + "/Results",Folder_name);

save ("Model/" +char(stg.folder_model + "/Results/" +...
    Folder_name + "/Analysis.mat"),'stg','sb','rst');
end