function [stg,sb] = f_generate_sbtab_struct(stg)

if isfile(pwd + "/Model/" + stg.folder_model +"/Data/" +...
        stg.sbtab_name + ".mat")
    
    load(pwd + "/Model/" + stg.folder_model +"/Data/" +...
        stg.sbtab_name + ".mat",'sbtab_excel');
    
    sb = f_get_sbtab_fields(sbtab_excel);
    
    stg.expn = size(sb.Experiments.ID,1);
    stg.outn = size(sb.Output.ID,1);
end
end

function sb = f_get_sbtab_fields(sbtab_excel)
for n = 1:size(sbtab_excel,2)
    
    if ~isempty(sbtab_excel{1,n}{1,2})
        
        field = regexp(sbtab_excel{1,n}{1,2},"TableName='[^']*'",'match');
        field = strrep(field,"TableName='",'');
        field = strrep(field,"'",'');
        field = strrep(field," ",'_');
        
        for k = 1:size(sbtab_excel{1,n},2)
            
            if ~isempty(sbtab_excel{1,n}{2,k})
                subfield = sbtab_excel{1,n}{2,k};
                subfield = strrep(subfield,"!",'');
                subfield = strrep(subfield,">",'');
                subfield = strrep(subfield,":",'_');
                subfield = strrep(subfield," ",'_');
                
                sb.(field).(subfield)(:,1) = sbtab_excel{1,n}(3:end,k)';
                
                sb.(field).(subfield) = sb.(field).(subfield)...
                    (~cellfun('isempty', sb.(field).(subfield)));
            end
        end
    end
end
end