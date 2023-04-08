function f_setup_input(stg,mmf)
% The f_setup_input function is designed to generate code for loading
% experiment inputs into a .mat file and create code to read these inputs
% during the simulation of the experiments. The generated code is stored in
% the "Input_functions" folder.
% 
% Inputs:
% 
% stg: A structure containing information about the simulation settings.
% mmf: A structure containing information about the model, including the
% model data, main folder, and input functions.
% 
% Outputs: This function
% creates input function files and an input creator function file in the
% "Input_functions" folder. The input functions are used to calculate input
% values based on the simulation time, while the input creator function is
% used to create input data from the sbtab.datasets.
% 
% Functions called:
% 
% template1: Generates code for input functions.
% template2: Generates code for the first input of the first experiment in
% the input creator function.
% template3: Generates code for the rest of the inputs in the input creator
% function.
% 
% Loaded variables:
% 
% matlab_model: Loaded from mmf.model.data.mat_model.
% data_model: Loaded from mmf.model.data.data_model.
% inp_model_data: Loaded from mmf.model.data.input_model_data.
% Model_folder: Loaded from mmf.model.main. model_input: Loaded from
% mmf.model.input_functions.input.
% sbtab: Loaded from the data_model file.
% modelobj: Loaded from the
% matlab_model file.

% Load required data from mmf.model.data:
matlab_model = mmf.model.data.mat_model;
data_model = mmf.model.data.data_model;
inp_model_data = mmf.model.data.input_model_data;
Model_folder = mmf.model.main;
model_input = mmf.model.input_functions.input;

% Load the sbtab and modelobj variables from the respective files:
load(data_model,'sbtab')
load(matlab_model,'modelobj');

% Iterate over the experiments and their inputs to generate input functions
% and an input creator function:
for Exp_n = 1:size(sbtab.datasets,2)
    for index = 1:size(sbtab.datasets(Exp_n).input,2)
        % If input size is larger than 100, generate input function file
        % for each input
        if size(sbtab.datasets(Exp_n).input_value{index},2) > 100
            
            % Generate input names by replacing "." with an empty string,
            % and concatenating the "X", "T", "h1", and "h2" suffixes:
            input_name = strrep(modelobj.species(1+str2double(strrep(...
                sbtab.datasets(Exp_n).input(index),'S',''))).name,".","");
            input_X = input_name + "X";
            input_T = input_name + "T";
            input_h1 = input_name + "h1";
            input_h2 = input_name + "h2";
            
            % Create a new .m file for each input and write the generated
            % code to that file, based on the template1() function:
            fullFileName = sprintf('%s.m',...
                model_input + Exp_n + "_" + input_name  );

            fileID = fopen(fullFileName, 'wt');

            inp_str = template1();
            inp_str = replace(inp_str,...
                ["SBtab_name","Exp_n","input_name",...
                "input_X", "input_T", "input_h1", "input_h2", "inp_model_data",...
                "sbtab.sim_time(Exp_n)"],[stg.name,Exp_n,...
                input_name, input_X, input_T, input_h1,...
                input_h2, inp_model_data,...
                sbtab.sim_time(Exp_n)]);

            fprintf(fileID,inp_str);
            fclose(fileID);
        end
    end
end

% Create the input creator function file:
fullFileName = sprintf('%s.m',model_input + "_creator"  );
fileID = fopen(fullFileName, 'wt');

% Write the content of the input creator function:
fprintf(fileID, "function " + stg.name + "_input_creator(~)\n");
helper = 0;
for Exp_n = 1:size(sbtab.datasets,2)
    for index =1:size(sbtab.datasets(Exp_n).input,2)
        if size(sbtab.datasets(Exp_n).input_value{index},2) > 100
            input_name = strrep(modelobj.species(1+str2double(strrep(...
                sbtab.datasets(Exp_n).input(index),'S',''))).name,".","");
            if helper == 0
                helper = 1;
                helper2 = Exp_n;
            end
            % Write code to the input creator function file, using either
            % template2() or template3() functions:
            if index == 1 && Exp_n == helper2
                fprintf(fileID,"load('" + data_model + "','sbtab');\n");
                inp_creator_str = template2();
                inp_creator_str = replace(inp_creator_str,...
                    ["Exp_n", "input_name", "index", "inp_model_data"],...
                    [Exp_n, input_name, index, inp_model_data]);
            else
                inp_creator_str = template3();
                inp_creator_str = replace(inp_creator_str,...
                    ["Exp_n", "input_name", "index", "inp_model_data"],...
                    [Exp_n, input_name, index, inp_model_data]);
            end
            fprintf(fileID,inp_creator_str);
        end
    end
end
fprintf(fileID, "end\n");
fclose(fileID);

eval(stg.name + "_input_creator()");
end

% The template1() function generates the code for the input functions,
% which calculate the input based on the simulation time.
function inp_str = template1()
inp_str =...
    "function thisAmp = SBtab_name_inputExp_n_input_name(times)\n"+...
    "persistent input_X\n"+...
    "persistent input_T\n"+...
    "persistent input_h1\n"+...
    "persistent input_h2\n"+...
    "if isempty(input_X)\n"+...
        "Data = coder.load('inp_model_data','expExp_n_input_name');\n"+...
        "input_X = Data.expExp_n_input_name(:,2);\n"+...
        "input_T = Data.expExp_n_input_name(:,1);\n"+...
        "input_h1 = 1;\n"+...
    "end\n"+...
    "thisAmp = input_X(end);\n"+...
    "if times ~= sbtab.sim_time(Exp_n)\n"+...
        "if times == 0\n"+...
            "input_h1 = 1;\n"+...
            "thisAmp = input_X(1);\n"+...
            "else\n"+...
            "while times > input_T(input_h1)\n"+...
            "input_h1 = input_h1 + 1;\n"+...
        "end\n"+...
        "while times < input_T(input_h1-1)\n"+...
            "input_h1  = input_h1-1;\n"+...
            "end\n"+...
            "input_h2 = (input_T(input_h1)-times)*1/(input_T(input_h1)-input_T(input_h1-1));\n"+...
            "thisAmp = (input_X(input_h1-1)*input_h2 + input_X(input_h1)*(1-input_h2));\n"+...
        "end\n"+...
    "end\n"+...
    "end";
end

% The template2() function generates the code for the first input of the
% first experiment in the "_input_creator()" function.
function inp_creator_str = template2()
inp_creator_str = ...
    "expExp_n_input_name(:,1) = sbtab.datasets(Exp_n).input_time{index};\n"+...
    "expExp_n_input_name(:,2) = sbtab.datasets(Exp_n).input_value{index};\n"+...
    "save('inp_model_data','expExp_n_input_name');\n";
end

% The template3() function generates the code for the rest of the inputs in
% the "_input_creator()" function.
function inp_creator_str = template3()
inp_creator_str = ...
    "expExp_n_input_name(:,1) = sbtab.datasets(Exp_n).input_time{index};\n"+...
    "expExp_n_input_name(:,2) = sbtab.datasets(Exp_n).input_value{index};\n"+...
    "save('inp_model_data','expExp_n_input_name','-append');\n";
end