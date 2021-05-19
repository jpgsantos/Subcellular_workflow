function f_save_analysis(stg,sb,rst,date_stamp,script_folder)

mkdir(script_folder + "Model/" + stg.folder_model,"Results");

Folder_name = stg.analysis;
Folder_name2 = string(date_stamp);

mkdir(script_folder + "Model/" + stg.folder_model + "/Results",Folder_name);
mkdir(script_folder + "Model/" + stg.folder_model + "/Results"+ "/" + Folder_name,Folder_name2);
addpath(script_folder + "Model/" + stg.folder_model + "/Results"+ "/" + Folder_name+"/"+Folder_name2)

save (script_folder + "Model/" +char(stg.folder_model + "/Results/" +...
    Folder_name + "/" + Folder_name2 + "/Analysis.mat"),'stg','sb','rst');
end