function f_save_analysis(stg,sb,rst)

if ispc
    mkdir("Model\" + stg.folder_model,"Results");
else
    mkdir("Model/" + stg.folder_model,"Results");
end

date_stamp = string(year(datetime)) + "_" + ...
    string(month(datetime,'shortname')) + "_" + string(day(datetime))...
    + "__" + string(hour(datetime)) + "_" + string(minute(datetime))...
    + "_" + string(round(second(datetime)));

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