function [stg,sb] = f_generate_sbtab_struct(stg,mmf)
% This function is used to load an SBtab data file, convert the SBtab data
% into a structure, and extract the number of experiments and outputs. The
% function takes two input arguments, stg and mmf, and returns two output
% arguments, the modified stg and the generated sb structure. The function
% calls the helper function convert_sbtab_to_struct to convert the SBtab
% data into a structure. The SBtab data file is loaded into the variable
% sbtab_excel.
% 
% Inputs:
% stg: An existing structure that will be updated with the number
% of experiments and outputs.
% mmf: A structure containing the model
% information, including the SBtab data file name.
% 
% Outputs: 
% stg: The updated structure containing the number of experiments
% and outputs.
% sb: A structure generated from the SBtab data.
% 
% Called functions: 
% convert_sbtab_to_struct: A helper function that converts
% SBtab data into a structure.
% 
% Loaded variables:
% sbtab_excel: A variable that holds the loaded SBtab data from the
% specified file.

% Extract the sbtab file name from the mmf
% structure
Matlab_sbtab = mmf.model.data.sbtab;

% Check if the sbtab file exists
if isfile(Matlab_sbtab)

    % Load the sbtab data into a variable called 'sbtab_excel'
    load(Matlab_sbtab,'sbtab_excel');

    % Convert the sbtab data into a structure
    sb = convert_sbtab_to_struct(sbtab_excel);

    % Extract the number of experiments and outputs
    stg.expn = size(sb.Experiments.ID,1);
    stg.outn = size(sb.Output.ID,1);
end
end

% Helper function that converts sbtab data into a structure
function sb = convert_sbtab_to_struct(sbtab_excel)

% Initialize an empty structure
sb = struct();

% Loop through all columns in the sbtab data
for col = 1:size(sbtab_excel,2)

    % Check if the first row of the column contains a table name
    if ~isempty(sbtab_excel{1,col}{1,2})

        % Extract the table name from the first row of the column
        field = regexp(sbtab_excel{1,col}{1,2},"TableName='[^']*'",'match');
        field = string(replace(field,["TableName='","'"," "],["","","_"]));

        % Loop through all rows in the column
        for row = 1:size(sbtab_excel{1,col},2)

            % Check if the current row contains a subfield name
            if ~isempty(sbtab_excel{1,col}{2,row})
                % Extract the subfield name from the current row
                subfield = sbtab_excel{1,col}{2,row};
                subfield = string(replace(subfield,["!",">",":"," "],["","","_","_"]));

                % Extract the subfield values from the column
                sb.(field).(subfield)(:,1) = sbtab_excel{1,col}(3:end,row)';

                % Remove empty values from the subfield
                sb.(field).(subfield) = sb.(field).(subfield)...
                    (~cellfun('isempty', sb.(field).(subfield)));
            end
        end
    end
end
end