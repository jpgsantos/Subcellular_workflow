function f_setup_input(stg)


persistent modelobj
persistent sbtab

if isempty(sbtab)
    
    %Find correct path for loading depending on the platform
    if ispc
        load("Model\" +stg.folder_model +"\Data\" + "data_" +...
            stg.name + ".mat",'sbtab')
        load("Model\" +stg.folder_model +"\Data\" + "model_" +...
            stg.name + ".mat",'modelobj');
    else
        load("Model/" +stg.folder_model +"/Data/" + "data_" +...
            stg.name + ".mat",'sbtab')
        load("Model/" +stg.folder_model +"/Data/" + "model_" +...
            stg.name + ".mat",'modelobj');
    end
end

for exp_n = 1:size(sbtab.datasets,2)
    
    for n =1:size(sbtab.datasets(exp_n).input,2)
        if size(sbtab.datasets(exp_n).input_value{n},2) > 100
%             sim_scale = 1/(Data(exp_n).Experiment.t(2)-Data(exp_n).Experiment.t(1));
            
            name = modelobj.species(1+str2double(strrep(...
                sbtab.datasets(exp_n).input(n),'S',''))).name;
            if ispc
                fullFileName = sprintf('%s.m',"Model\" +...
                    stg.folder_model + "\Formulas\" + stg.name +...
                    "_input" + exp_n + "_" + name  );
            else
                fullFileName = sprintf('%s.m',"Model/" +...
                    stg.folder_model + "/Formulas/" + stg.name +...
                    "_input" + exp_n + "_" + name  );
            end
            fileID = fopen(fullFileName, 'wt');
            fprintf(fileID, "function thisAmp = " + stg.name + "_input"...
                + exp_n + "_" + name + "(times)\n");
            fprintf(fileID, "persistent " + name + "X\n");
            fprintf(fileID, "persistent " + name + "T\n");
            fprintf(fileID, "persistent " + name + "h1\n");
            fprintf(fileID, "persistent " + name + "h2\n");
            fprintf(fileID, "if isempty(" + name + "X)\n");
            fprintf(fileID, "if ispc\n");
            fprintf(fileID, "Data = coder.load('Model\\" +...
                stg.folder_model +"\\Data\\Data_" + stg.name +...
                "_input.mat','exp"+ exp_n + "_" + name + "');\n");
            fprintf(fileID, "else\n");
            fprintf(fileID, "Data = coder.load('Model/" +...
                stg.folder_model +"/Data/Data_" + stg.name +...
                "_input.mat','exp"+ exp_n + "_" + name + "');\n");
            fprintf(fileID, "end\n");
            fprintf(fileID, name + "X = Data.exp"+ exp_n +...
                "_" + name + "(:,2);\n");
            fprintf(fileID, name + "T = Data.exp"+ exp_n +...
                "_" + name + "(:,1);\n");
            fprintf(fileID, name + "h1 = 1;\n");
            fprintf(fileID, "end\n");
            fprintf(fileID, "thisAmp = " + name + "X(end);\n");
            fprintf(fileID, "if times ~= " + sbtab.sim_time(exp_n)+"\n");
            fprintf(fileID, "if times == 0\n");
            fprintf(fileID, name + "h1 = 1;\n");
            fprintf(fileID, "thisAmp = " + name + "X(1);\n");
            fprintf(fileID, "else\n");
            fprintf(fileID, "while times > "  +...
                name + "T(" + name + "h1)\n");
            fprintf(fileID, name + "h1 = " + name + "h1 + 1;\n");
            fprintf(fileID, "end\n");
            fprintf(fileID, "while times < " +...
                name + "T(" + name + "h1 -1)\n");
            fprintf(fileID, name + "h1 = " + name + "h1 - 1;\n");
            fprintf(fileID, "end\n");
            fprintf(fileID, name + "h2 = (" + name + "T(" + name +...
                "h1)-times)*1/("+ name + "T("+name + "h1)-"+ name +...
                "T("+name + "h1-1));\n");
            fprintf(fileID, "thisAmp = (" + name + "X(" + name +...
                "h1-1)*"+ name + "h2 + " + name + "X(" + name +...
                "h1)*(1-"+ name + "h2));\n");
            fprintf(fileID, "end\n");
            fprintf(fileID, "end\n");
            fprintf(fileID, "end");
            fclose(fileID);
            
        end
    end
end

if ispc
    fullFileName = sprintf('%s.m',"Model\" + stg.folder_model +...
        "\Formulas\" + stg.name + "_input_creator"  );
else
    fullFileName = sprintf('%s.m',"Model/" + stg.folder_model +...
        "/Formulas/" + stg.name + "_input_creator"  );
end
fileID = fopen(fullFileName, 'wt');
fprintf(fileID, "function " + stg.name + "_input_creator(~)\n");
helper = 0;
for exp_n = 1:size(sbtab.datasets,2)
    for n =1:size(sbtab.datasets(exp_n).input,2)
        if size(sbtab.datasets(exp_n).input_value{n},2) > 100
            name = modelobj.species(1+str2double(strrep(...
                sbtab.datasets(exp_n).input(n),'S',''))).name;
            if helper == 0
               helper = 1;
               helper2 = exp_n;
            end
            if n == 1 && exp_n == helper2
                
                fprintf(fileID, "if ispc\n");
                fprintf(fileID, "load('Model\\" + stg.folder_model +...
                    "\\Data\\Data_" + stg.name + ".mat','sbtab');\n");
                fprintf(fileID, "else\n");
                fprintf(fileID, "load('Model/" + stg.folder_model +...
                    "/Data/Data_" + stg.name + ".mat','sbtab');\n");
                fprintf(fileID, "end\n");
                fprintf(fileID, "exp" + exp_n + "_" + name +...
                    "(:,1) = sbtab.datasets(" + exp_n +...
                    ").input_time{" + n + "};\n");
                fprintf(fileID, "exp" + exp_n + "_" + name +...
                    "(:,2) = sbtab.datasets(" + exp_n +...
                    ").input_value{" + n + "};\n");
                fprintf(fileID, "if ispc\n");
                fprintf(fileID, "save('Model\\" + stg.folder_model +...
                    "\\Data\\Data_"+ stg.name + "_input.mat','exp" +...
                    exp_n + "_" + name + "');\n");
                fprintf(fileID, "else\n");
                fprintf(fileID, "save('Model/" + stg.folder_model +...
                    "/Data/Data_"+ stg.name + "_input.mat','exp" +...
                    exp_n + "_" + name + "');\n");
                fprintf(fileID, "end\n");
            else
                fprintf(fileID, "exp" + exp_n + "_" + name +...
                    "(:,1) = sbtab.datasets(" + exp_n +...
                    ").input_time{" + n + "};\n");
                fprintf(fileID, "exp" + exp_n + "_" + name +...
                    "(:,2) = sbtab.datasets(" + exp_n +...
                    ").input_value{" + n + "};\n");
                fprintf(fileID, "if ispc\n");
                fprintf(fileID, "save('Model\\" + stg.folder_model +...
                    "\\Data\\Data_"+ stg.name + "_input.mat','exp" +...
                    exp_n + "_" + name + "','-append');\n");
                fprintf(fileID, "else\n");
                fprintf(fileID, "save('Model/" + stg.folder_model +...
                    "/Data/Data_"+ stg.name + "_input.mat','exp" +...
                    exp_n + "_" + name + "','-append');\n");
                fprintf(fileID, "end\n");
            end
        end
    end
end
fprintf(fileID, "end\n");
fclose(fileID);

addpath(genpath(pwd));

eval(stg.name + "_input_creator()");
end