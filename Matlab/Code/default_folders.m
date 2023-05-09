function [mmf] = default_folders(stg,mmf,date_stamp)

% Matlab_main_folder
% Matlab/
% mmf.main

    % Model_folder
    % Matlab/"Model Folder name"
    mmf.model.main = mmf.main + "Model/" + stg.folder_model + "/";

    create_and_add_to_path(mmf.model.main)
    create_and_add_to_path(mmf.model.main+ "Matlab/")
        
        % Source_sbtab
        % Matlab/"Model Folder name"/"Source_sbtab_name"
        mmf.model.sbtab = mmf.model.main + stg.sbtab_excel_name;

        % Data_folder
        % Matlab/"Model Folder name"/Data/
        mmf.model.data.main = mmf.model.main + "Matlab/" + "Data/";

        create_and_add_to_path(mmf.model.data.main)

            % sbproj_model
            % Matlab/"Model Folder name"/Data/model_"model name".sbproj
            mmf.model.data.sbproj_model =...
                mmf.model.data.main + "model_" + stg.name + ".sbproj";

            % matlab_model
            % Matlab/"Model Folder name"/Data/model_"model name".mat
            mmf.model.data.mat_model =...
                mmf.model.data.main + "model_" + stg.name + ".mat";

            % data_model
            % Matlab/"Model Folder name"/Data/data_"model name".mat
            mmf.model.data.data_model =...
                mmf.model.data.main + "data_" + stg.name + ".mat";

            % xml_model
            % Matlab/"Model Folder name"/Data/model_"model name".xml
            mmf.model.data.xml_model =...
                mmf.model.data.main + "model_" + stg.name + ".xml"; 

            % input_model_data
            % Matlab/"Model Folder name"/Data/Input_"model name".mat
            mmf.model.data.input_model_data =...
                mmf.model.data.main + "Input_" + stg.name + ".mat";

            % Matlab_sbtab
            % Matlab/"Model Folder name"/Data/SBtab_"model name".mat
            mmf.model.data.sbtab =...
                mmf.model.data.main + "SBtab_" + stg.name + ".mat";

            % model_exp_folder
            % Matlab/"Model Folder name"/Data/Exp/
            mmf.model.data.model_exp.main =...
                mmf.model.data.main + "Exp/";

                create_and_add_to_path(mmf.model.data.model_exp.main)

                % model_exp_default
                % Matlab/"Model Folder name"/Data/Exp/Model_"model name"_
                mmf.model.data.model_exp.default =...
                    mmf.model.data.model_exp.main +...
                    "Model_" + stg.name + "_";

                % model_exp_eq
                % Matlab/"Model Folder name"/Data/Exp/Model_eq_"model name"_
                mmf.model.data.model_exp.equilibration =...
                    mmf.model.data.model_exp.main +...
                    "Model_eq_" + stg.name + "_";

                % model_exp_detail
                % Matlab/"Model Folder name"/Data/Exp/Model_detail_"model name"_
                mmf.model.data.model_exp.detail =...
                    mmf.model.data.model_exp.main +...
                    "Model_detail_" + stg.name + "_";

        % input_functions_folder
        % Matlab/"Model Folder name"/Input_functions/
        mmf.model.input_functions.main =...
            mmf.model.main + "Matlab/" + "Input_functions/";
        create_and_add_to_path(mmf.model.input_functions.main)

            % model_input
            % Matlab/"Model Folder name"/Input_functions/"model name"_input
            mmf.model.input_functions.input =...
                mmf.model.input_functions.main + stg.name + "_input";

        % tsv_folder
        % Matlab/"Model Folder name"/tsv/
        mmf.model.tsv.main = mmf.model.main + "tsv/"; 

        create_and_add_to_path(mmf.model.tsv.main)

            % tsv_name_folder
            % Matlab/"Model Folder name"/tsv/"model name"
            mmf.model.tsv.model_name = mmf.model.tsv.main + stg.name + "/";
            create_and_add_to_path(mmf.model.tsv.model_name)


        % Results_Folder
        % Matlab/"Model Folder name"/Results/
        mmf.model.results.main =  mmf.model.main + "Matlab/" + "Results/";

        create_and_add_to_path(mmf.model.results.main)
       
            % Analysis_folder
            % Matlab/"Model Folder name"/Results/"Analysis name"/
            mmf.model.results.analysis.main =...
                mmf.model.results.main + stg.analysis + "/";

                % Analysis_date_folder
                % Matlab/"Model Folder name"/Results/"Analysis
                % name"/"date"/
                mmf.model.results.analysis.date.main =...
                    mmf.model.results.analysis.main +...
                    string(date_stamp) + "/";
end

function create_and_add_to_path(folder)

if exist(folder, 'dir') ~= 7
    mkdir(folder);
end

if ~contains(strrep(path,"\","/"), extractAfter(folder,strlength(folder)-1),'IgnoreCase',true)
    addpath(folder);
end
end
