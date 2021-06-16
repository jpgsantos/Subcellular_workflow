function f_save_analysis(stg,sb,rst,date_stamp,script_folder)

Model_folder = script_folder + "Model/" + stg.folder_model + "/";
Results_Folder = Model_folder + "Results/";
Analysis_folder = stg.analysis + "/";
Date_folder = string(date_stamp) + "/";

mkdir(Model_folder,"Results");
mkdir(Results_Folder, Analysis_folder);
mkdir(Results_Folder  + Analysis_folder, Date_folder);
addpath(Results_Folder  + Analysis_folder  + Date_folder)

save (Results_Folder +...
    Analysis_folder + Date_folder + "Analysis.mat",'stg','sb','rst');
end