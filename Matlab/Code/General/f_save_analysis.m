function f_save_analysis(stg,sb,rst,mmf)

Results_Folder = mmf.model.results.main;
Analysis_folder = mmf.model.results.analysis.main;
Analysis_date_folder = mmf.model.results.analysis.date.main;

[~,~] = mkdir(Results_Folder);
[~,~] = mkdir(Analysis_folder);
[~,~] = mkdir(Analysis_date_folder);
addpath(Analysis_date_folder)

save (Analysis_date_folder + "Analysis.mat",'stg','sb','rst');
end