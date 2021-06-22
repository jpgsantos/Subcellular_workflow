function setotalX(obj,spec)
% -------------------------------------------------------------------------
%        setotalX(obj,spec)
% -------------------------------------------------------------------------
% 'setotalX' set total amounts for a user define set of species. It
% wraps 'setotals' for the subtitution of all total amounts from the variant
% 'Total amounts' and then change the total amounts of the user defined 
% species in the argument 'spec'. This argument 'spec' is an structure with
% two fields,
%
%              spec.names, a cell array with species names
%              spec.values, a vector with total species amount
%
% IT IS PENDING TO MODIFY SPECIES TOTAL AMOUNTS IN COMPARTMENTS OTHER THAN THE SPINE

     compall = get(obj,'Compartment');
     for i = 1:length(compall)
     comp{i} = compall(i).name;
     end
        cmpn = strmatch('Spine',comp(:));
        cmpn = compall(cmpn);
        
                setotals(obj,0)

               if  ~isempty(spec) 
                   if length(spec.names) == length(spec.values)
                       for i = 1:length(spec.names)
                   sobj = sbioselect(cmpn,'Name', spec.names{i});
                   set(sobj, 'InitialAmount', spec.values(i))
                       end
                   else
        ['The number of species names (',num2str(length(spec.names)),') and species values (',num2str(length(spec.values)),') don''t match']        
                   end
               end
               
end