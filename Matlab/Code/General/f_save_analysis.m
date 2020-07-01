function f_save_analysis(stg,sb,rst,date_stamp)

    mkdir("Model/" + stg.folder_model,"Results");

    mkdir("Model/" + stg.folder_model + "/Results","Analysis_" +...
        string(date_stamp));

    save ("Model/" +char(stg.folder_model + "/Results/Analysis_" +...
        string(date_stamp) + "/Analysis.mat"),...
        'stg','sb','rst');
end