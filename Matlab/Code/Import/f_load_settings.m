function [stg] = f_load_settings(model_name,folder_model,mode)

stg.folder_model = folder_model;

% Choose to load specific settings
if contains(mode,"import")
    stg = load_setting_chunk(model_name,"import",stg);
end
if contains(mode,"analysis")
    stg = load_setting_chunk(model_name,"analysis",stg);
end
if contains(mode,"simulation")
    stg = load_setting_chunk(model_name,"simulation",stg);
end
if contains(mode,"model")
    stg = load_setting_chunk(model_name,"model",stg);
end
if contains(mode,"diagnostics")
    stg = load_setting_chunk(model_name,"diagnostics",stg);
end
if contains(mode,"plots")
    stg = load_setting_chunk(model_name,"plots",stg);
end
if contains(mode,"sensitivity_analysis")
    stg = load_setting_chunk(model_name,"sensitivity_analysis",stg);
end
if contains(mode,"optimization")
    stg = load_setting_chunk(model_name,"optimization",stg);
end

% %  Load all settings
if mode == "all"
    stg = load_setting_chunk(model_name,"all",stg);
end

%  Get the working folder
stg.folder_main = pwd;
stg.folder_main = strrep(stg.folder_main,"\","/");
end

function [stg] = load_setting_chunk(name,chunk,stg)

settings_filename = "Model/" + stg.folder_model + "/Settings/f_settings_" +...
    chunk + "_" + name + ".m";

% if isfile(settings_filename)
%     try
        
    [stg_add] = eval("f_settings_" + chunk + "_" + name + "()");
    
    f = fieldnames(stg_add);
    for i = 1:length(f)
        stg.(f{i}) = stg_add.(f{i});
    end
%     catch
% % else
%     error("You are lacking the f_settings_" + chunk + "_" +...
%         name + ".m file")
% % end
%     end
end

