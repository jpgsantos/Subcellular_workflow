function f_save_analysis(stg,sb,rst,date_stamp)

mkdir("Model/" + stg.folder_model,"Results");

Folder_name = stg.analysis;
Folder_name2 = string(date_stamp);

mkdir("Model/" + stg.folder_model + "/Results",Folder_name);
mkdir("Model/" + stg.folder_model + "/Results"+ "/" + Folder_name,Folder_name2);
addpath("Model/" + stg.folder_model + "/Results"+ "/" + Folder_name+"/"+Folder_name2)

save ("Model/" +char(stg.folder_model + "/Results/" +...
    Folder_name + "/" + Folder_name2 + "/Analysis.mat"),'stg','sb','rst');
end