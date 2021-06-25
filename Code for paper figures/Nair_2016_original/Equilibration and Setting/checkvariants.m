function checkvariants(obj,on,off,printit,printitforbasal)
% -------------------------------------------------------------------------
%        checkvariants(obj,on,off,printit,printitforbasal)
% -------------------------------------------------------------------------
% 'checkvariants' is used to change the status of a variant (active or
% inactive) and display the status of all model's variants with the full
% name. The arguments are:
%     obj: The model object.
%      on: Which variants will have its status changed to active.
%     off: Which variants will have its status changed to inactive.
% printit: A boolean to decide to print it or not.
% printitforbasal: A boolean to decide if the variant names as strings are
%                  printed for setting the basal status of variants in scripts like 'FFbastate' 

if sum(on)
    for i = 1:length(on)
        obj.variant(on(i)).active = 1;
    end
end

if sum(off)
    for i = 1:length(off)
        obj.variant(off(i)).active = 0;
    end    
end

if printit
for i = 1:length(obj.v)            
  formatSpec = '% 3d % 6d      %s';
  disp(sprintf(formatSpec,i,obj.variant(i).active,obj.variant(i).name))                      
end
end

if printitforbasal
    for i = 1:length(obj.variants)
variants{i,1} = obj.variant(i).name;
    end
    variants
end

end