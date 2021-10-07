function [stg,sb] = f_generate_sbtab_struct(stg,mmf)

Matlab_sbtab = mmf.model.data.sbtab;

if isfile(Matlab_sbtab)
    
    load(Matlab_sbtab,'sbtab_excel');

    sb = f_get_sbtab_fields(sbtab_excel);
    
    stg.expn = size(sb.Experiments.ID,1);
    stg.outn = size(sb.Output.ID,1);
end
end

function sb = f_get_sbtab_fields(sbtab_excel)
for n = 1:size(sbtab_excel,2)
    
    if ~isempty(sbtab_excel{1,n}{1,2})
        
        field = regexp(sbtab_excel{1,n}{1,2},"TableName='[^']*'",'match');
        field = string(replace(field,["TableName='","'"," "],["","","_"]));
        
        for k = 1:size(sbtab_excel{1,n},2)
            
            if ~isempty(sbtab_excel{1,n}{2,k})
                subfield = sbtab_excel{1,n}{2,k};
                subfield =...
                    string(replace(subfield,["!",">",":"," "],["","","_","_"]));
                
                sb.(field).(subfield)(:,1) = sbtab_excel{1,n}(3:end,k)';
                
                sb.(field).(subfield) = sb.(field).(subfield)...
                    (~cellfun('isempty', sb.(field).(subfield)));
            end
        end
    end
end
end