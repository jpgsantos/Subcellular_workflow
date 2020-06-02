function f_save_analysis(stg,sb,rst,date_stamp)

if ispc
    mkdir("Model\" + stg.folder_model,"Results");
else
    mkdir("Model/" + stg.folder_model,"Results");
end

if ispc
    mkdir("Model\" + stg.folder_model + "\Results","Analysis_" +...
        string(date_stamp));
else
    mkdir("Model/" + stg.folder_model + "/Results","Analysis_" +...
        string(date_stamp));
end

if ispc
    save ("Model\" +char(stg.folder_model + "\Results\Analysis_" +...
        string(date_stamp) + "\Analysis.mat"),...
        'stg','sb','rst');
else
    save ("Model/" +char(stg.folder_model + "/Results/Analysis_" +...
        string(date_stamp) + "/Analysis.mat"),...
        'stg','sb','rst');
end
end