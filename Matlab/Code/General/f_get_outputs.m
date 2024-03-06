function [n_outputs,output_names] = f_get_outputs(stg,sbtab)
% Retrieves the total number of outputs and their names from a set of
% experiment runs. It iterates through all the experiment runs specified in the
% input 'stg' and, for each run, extracts the output names from the
% corresponding dataset in 'sbtab'. It appends each output name to a cell
% array, 'out_name', with a prefix indicating the experiment run number.
% Finally, it returns the total number of outputs and the cell array of
% output names.
% 
% Inputs:
% - stg: A structure containing experiment run indices
% - sbtab: A structure containing datasets with output information for each
% experiment run
%
% Outputs:
% - n_outputs: The total number of outputs across all experiment runs
% - output_names: A cell array containing the output names, prefixed with
% the experiment run number
%
% Used Functions:
% (none)
%
% Variables:
% Loaded:
% (none)
%
% Initialized:
% - out_name: A cell array to store output names
%
% Persistent:
% (none)

% Initialize an empty cell array to store output names
out_name = [];

% Loop through all experiment runs specified in 'stg'
for n = stg.exprun
    % Loop through all outputs in the current experiment run
    for j = 1:size(sbtab.datasets(n).output,2)
        % Add the output name to 'out_name' with a prefix indicating the
        % experiment run
        out_name{end+1} =...
            {"E" + (n-1) + " " + string(sbtab.datasets(n).output{1,j})};
    end
end
% Get the total number of outputs
n_outputs = size(out_name,2);

% Assign the output names to 'output_names'
output_names = out_name;
end