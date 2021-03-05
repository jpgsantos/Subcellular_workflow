function f_excel_sbtab_importer(stg)

% Get the total number of sheets in the SBTAB
[~,sheets] = xlsfinfo(char(pwd + "/Model/" +...
    stg.folder_model + "/" + stg.sbtab_excel_name));

% Try to run the import the sheets in multicore, depending on the version
% of excel this migth not work
try
    parfor i = 1:size(sheets,2)
        sbtab_excel{i} = impexp (i,stg);
    end
catch
    for i = 1:size(sheets,2)
        sbtab_excel{i} = impexp (i,stg);
    end
end

% Save the SBTAB tables in .mat format
save(pwd + "/Model/" +stg.folder_model + "/Data/" +...
    "SBtab_" + stg.name + ".mat",'sbtab_excel');
end

function sbtab_excel = impexp (i,stg)

disp("Reading sbtab_excel Excel sheet number " + i)

% Import the SBTAB to a cell with a sheet per cell
sbtab_excel = readcell(char(pwd + "/Model/" +...
    stg.folder_model + "/" + stg.sbtab_excel_name),'sheet',i);

% Replace "ismissing" values with empty spaces
mask = cellfun(@ismissing, sbtab_excel,'UniformOutput',false);
mask = cellfun(@min, mask);
mask = logical(mask);
sbtab_excel(mask) = {[]};

% Get name for tsv that is going to be exported
field = regexp(sbtab_excel{1,2},"TableName='[^']*'",'match');
field = strrep(field,"TableName='",'');
field = strrep(field,"'",'');
field = strrep(field," ",'_');
%Export the tsv
cell_write_tsv(char(pwd + "/Model/" +stg.folder_model +...
    "/tsv/" + stg.name + "/" + field + ".tsv"),sbtab_excel)
end

function cell_write_tsv(filename,origCell)

% save a new version of the cell for reference
modCell = origCell;
% assume some cells are numeric, in which case set to char
iNum = cellfun(@isnumeric,origCell);

% Replace numeric sells with cell strings
for n = 1:size(iNum,1)
    for m = 1:size(iNum,2)
        modCell(n,m) = cellstr(num2str(origCell{n,m}));
    end
end

%Save the file that only as strings in each cell
modCell = transpose(modCell);

[rNum,cNum] = size(origCell);
frmt = repmat([repmat('%s\t',1,cNum-1),'%s\n'],1,rNum);
fid = fopen(filename,'wt');
fprintf(fid,frmt,modCell{:});
fclose(fid);
end

