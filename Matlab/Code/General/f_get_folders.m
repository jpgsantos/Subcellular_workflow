function [mmf] = f_get_folders(stg,script_folder)


%Matlab_model_folder
mmf.main = script_folder;

% Folder Model_folder
mmf.model.main = mmf.main + "Model/" + stg.folder_model + "/";

% File Source_sbtab
mmf.model.sbtab = mmf.model.main + stg.sbtab_excel_name;



% Folder Data_folder
mmf.model.data.main = mmf.model.main + "Data/";

% sbproj_model
mmf.model.data.sbproj_model =...
    mmf.model.data.main + "model_" + stg.name + ".sbproj";

% mat_model
mmf.model.data.mat_model = mmf.model.data.main + "model_" + stg.name + ".mat";

% data_model
mmf.model.data.data_model = mmf.model.data.main + "data_" + stg.name + ".mat";

% xml_model
mmf.model.data.xml_model = mmf.model.data.main + "model_" + stg.name + ".xml"; 

% input_model_data
mmf.model.data.input_model_data = mmf.model.data.main + "Input_" + stg.name + ".mat";

% File Matlab_sbtab
mmf.model.data.sbtab = mmf.model.data.main + "SBtab_" + stg.name + ".mat";


% Folder input_functions_folder
mmf.model.input_functions.main = mmf.model.main + "/Input_functions/";

% model_input
mmf.model.input_functions.input =...
    mmf.model.input_functions.main + stg.name + "_input";


% Folder tsv_folder
mmf.model.tsv.main = mmf.model.main + "tsv/"; 

% Folder tsv_name_folder
mmf.model.tsv.model_name = mmf.model.tsv.main + stg.name + "/";




mmf.model.results.main = mmf.model.main + "Results/";

% mmf.model.results.analysis.main =... 
% mmf.model.results.main + stg.analysis + "/";
% 
% mmf.model.results.analysis.date.main =...
% mmf.model.results.analysis.main + string(date_stamp) + "/";




end