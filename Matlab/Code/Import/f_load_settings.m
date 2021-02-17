function [stg] = f_load_settings()

persistent sbtab_date_last

[settings_file,folder_model_name,folder_model_dir,Analysis] = f_prompt();

stg_add_default = eval("default_settings()");

f = fieldnames(stg_add_default);
for i = 1:length(f)
    stg.(f{i}) = stg_add_default.(f{i});
end

[stg_add] = eval(settings_file + "()");

f = fieldnames(stg_add);
for i = 1:length(f)
    stg.(f{i}) = stg_add.(f{i});
end

listing = dir(string(folder_model_dir+ "\"  + folder_model_name));

for n = 1:size(listing,1)
    if matches(stg.sbtab_excel_name,listing(n).name,"IgnoreCase",true)
        sbtab_date = listing(n).datenum;
    end
end

if sbtab_date ~= sbtab_date_last
    disp("Excel sbtab file changed, clearing functions")
    f_functions_to_clear()
end

sbtab_date_last = sbtab_date;

%  Get the working folder
stg.folder_model = folder_model_name;
stg.folder_main = pwd;
stg.folder_main = strrep(stg.folder_main,"\","/");
stg.analysis = Analysis;
end