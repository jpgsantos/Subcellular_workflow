function [stg,sb] = f_generate_sbtab_struct(stg,mmf)

% Extract the sbtab file name from the mmf structure
Matlab_sbtab = mmf.model.data.sbtab;

% Check if the sbtab file exists
if isfile(Matlab_sbtab)

    % Load the sbtab data into a variable called 'sbtab_excel'
    load(Matlab_sbtab,'sbtab_excel');

    % Convert the sbtab data into a structure
    sb = f_get_sbtab_struct(sbtab_excel);

    % Extract the number of experiments and outputs
    stg.expn = size(sb.Experiments.ID,1);
    stg.outn = size(sb.Output.ID,1);
end
end

% Helper function that converts sbtab data into a structure
function sb = f_get_sbtab_struct(sbtab_excel)

% Initialize an empty structure
sb = struct();

% Loop through all columns in the sbtab data
for n = 1:size(sbtab_excel,2)

    % Check if the first row of the column contains a table name
    if ~isempty(sbtab_excel{1,n}{1,2})

        % Extract the table name from the first row of the column
        field = regexp(sbtab_excel{1,n}{1,2},"TableName='[^']*'",'match');
        field = string(replace(field,["TableName='","'"," "],["","","_"]));

        % Loop through all rows in the column
        for k = 1:size(sbtab_excel{1,n},2)

            % Check if the current row contains a subfield name
            if ~isempty(sbtab_excel{1,n}{2,k})
                % Extract the subfield name from the current row
                subfield = sbtab_excel{1,n}{2,k};
                subfield = string(replace(subfield,["!",">",":"," "],["","","_","_"]));

                % Extract the subfield values from the column
                sb.(field).(subfield)(:,1) = sbtab_excel{1,n}(3:end,k)';

                % Remove empty values from the subfield
                sb.(field).(subfield) = sb.(field).(subfield)...
                    (~cellfun('isempty', sb.(field).(subfield)));
            end
        end
    end
end
end