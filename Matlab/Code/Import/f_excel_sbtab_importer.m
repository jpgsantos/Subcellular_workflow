function f_excel_sbtab_importer(model_folders)
% This function, f_excel_sbtab_importer, takes a model_folders structure as
% input, which contains paths to the source Excel SBtab file and the
% destination folders for the parsed data (MATLAB .mat file) and TSV files.
% The function processes the Excel file with multiple sheets in the SBtab
% format, imports the data from each sheet, replaces missing values with
% empty spaces, and exports the processed data as .mat and TSV files.
%
% Inputs:
% - model_folders: A structure containing the following fields:
% - model.sbtab: Path to the source Excel SBtab file.
% - model.data.sbtab: Path to the destination folder for the parsed .mat
% file.
% - model.tsv.model_name: Path to the destination folder for the TSV files.
%
% Outputs: - No direct output. The parsed data is saved as .mat and TSV
% files in the specified folders.
%
% Functions called:
% - impexp: This function is called for each sheet in the Excel SBtab file.
% It imports the sheet's data, replaces missing values with empty spaces, 
% and exports the processed data as a TSV file.
% - cell_write_tsv: This function writes the data in a cell array to a TSV
% file, taking care of transposing the array and converting numeric values
% to strings.
% 
% Variables:
% Loaded:
% - Source_sbtab: Path to the source Excel SBtab file.
% - Matlab_sbtab: Path to the destination folder for the parsed .mat file.
% - sheets: Cell array containing the names of sheets in the Excel SBtab
% file.
% - sbtab_excel: A cell array containing the processed data for each sheet.
%
% Initialized:
% - None
%
% Persistent:
% - None


% Get the folders for the model SBtab file and the destination for the
% parsed data
Source_sbtab = model_folders.model.sbtab;
Matlab_sbtab = model_folders.model.data.sbtab;

% Get the total number of sheets in the SBTAB
sheets = sheetnames(Source_sbtab);

% Attempt to run the import of sheets in parallel, depending on the version
% of Excel being used, this may not work
try
    parfor i = 1:size(sheets, 1)
        sbtab_excel{i} = impexp (i, model_folders);
    end
catch
    for i = 1:size(sheets, 1)
        sbtab_excel{i} = impexp (i, model_folders);
    end
end

% Save the parsed SBTAB tables in .mat format
save(Matlab_sbtab, 'sbtab_excel');
disp("SBtab with " + size(sheets, 1) + " sheets parsed successfully")
end

function sbtab_excel = impexp (i, model_folders)

% Load the source SBTAB file and the folder to save the TSV files
Source_sbtab = model_folders.model.sbtab;
tsv_name_folder = model_folders.model.tsv.model_name;

% Import the SBTAB sheet as a cell array
sbtab_excel = readcell(Source_sbtab, 'sheet', i);

% Replace missing values with empty spaces
mask = cellfun(@ismissing, sbtab_excel, 'UniformOutput', false);
mask = cellfun(@min, mask);
mask = logical(mask);
sbtab_excel(mask) = {[]};

% Get the name for the TSV file to be exported
field = regexp(sbtab_excel{1, 2}, "TableName='[^']*'", 'match');
field = string(replace(field, ["TableName='", "'", " "], ["", "", "_"]));

% Export the TSV file
cell_write_tsv(tsv_name_folder + field + ".tsv", sbtab_excel)
end

function cell_write_tsv(filename, origCell)

% Create a new version of the cell for reference
modCell = origCell;

% Find the indices of numeric cells
iNum = cellfun(@isnumeric, origCell);

% % Replace numeric cells with cell strings
for n = 1:size(iNum, 1)
    for m = 1:size(iNum, 2)
        modCell(n, m) = cellstr(num2str(origCell{n, m}));
    end
end

% Transpose the cell array to have the correct orientation
modCell = transpose(modCell);

% Create a format string for saving the TSV file
[rNum, cNum] = size(origCell);
frmt = repmat([repmat('%s\t', 1, cNum-1), '%s\n'], 1, rNum);
fid = fopen(filename, 'wt');

% Save the TSV file using the format string
fprintf(fid, frmt, modCell{:});
fclose(fid);
end