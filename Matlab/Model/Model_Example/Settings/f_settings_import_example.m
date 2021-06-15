function [stg] = f_settings_import_example()

% Name of the folder where everything related to the model is stored
stg.folder_model = "Example";

% Name of the excel file with the sbtab
stg.sbtab_excel_name = "sbtab example.xlsx";

% Name of the model
stg.name = "example";

% Name of the model compartment
stg.cname = "Compartment";

% Name of the sbtab saved in .mat format
stg.sbtab_name = "sbtab_"+stg.name;

end