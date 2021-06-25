function setotals(obj,createORfill)
% -------------------------------------------------------------------------
%        setotals(obj,createORfill)
% -------------------------------------------------------------------------
% 'setotals' perform any of two operations related to the conserved moeites
% in the model "obj" depending of the value of the boolean "createORfill".
% createORfill = 1: Creates the conserved sum for the conserved moeties in 
% the model "obj".
% createORfill = 0: Zeros the initial concentrations of all species in the
% model "obj" and set the total concentration of each conserved moeity from
% the values stored in the variant "Total amounts".
%

            compall = get(obj,'Compartment');
                 ct = 0;
        for i = 1:length(compall)
             cmp{i} = compall(i).name;
                spt = compall(i).species;
                for j = 1:length(spt)
                 ct = ct + 1;
     cmpspnames{ct} = [cmp{i},'.',spt(j).name];
       cmpnames{ct} = cmp{i};
        spnames{ct} = spt(j).name;
                end
        end
        
    if createORfill
        
            [G, Sp] = sbioconsmoiety(obj,'semipos');
            [a b c] = intersect(cmpspnames, Sp);
                  G = G(:,c);
                 Sp = Sp(c);     
            spnames = spnames(b);
           cmpnames = cmpnames(b);
                  G = logical(G);                                  
           nspecies = 1:size(G,2);
        
        for i = 1:size(G,1)
        spnames2add = spnames(G(i,:));
       cmpnames2add = cmpnames(G(i,:));
                nsp = sum(G(i,:));
            if nsp == 1
          cvname{i} = ['total',spnames2add{1}];  
            else                
     [trash idxmin] = min([length(spnames2add{1}), length(spnames2add{2})]);
              minam = spnames2add{idxmin};
                if nsp == 2
          cvname{i} = ['total',minam];
                else                    
                    for j = 3:nsp
             minamt = {minam, spnames2add{j}};
     [trash idxmin] = min([length(minam), length(spnames2add{j})]); 
              minam = minamt{idxmin};
                    end
          cvname{i} = ['total',minam];
                end                
            end
            
            if i > 1
               used = strmatch(cvname{i},cvname(1:end-1));
               if ~isempty(used)
          cvname{i} = [cvname{i},'_',num2str(length(used))];
               end
            end 
                                                                  
            for j = 1:nsp                                
                if j == 1  
            specsum = ['[',cvname{i},'] = ',cmpnames2add{j},'.[',spnames2add{j},']'];
                else
            specsum = [specsum,' + ',cmpnames2add{j},'.[',spnames2add{j},']'];        
                end              
            end
            
             cmpall = unique(cmpnames2add);
            for j = 1:length(cmpall)
            cmpn(j) = length(strmatch(cmpall{j},cmpall));                
            end
      [trash idxmx] = max(cmpn);          
                                                
             cmpobj = sbioselect(obj,'Name', cmpall(idxmx));
                  s = get(cmpobj,'species');
                  try
              spobj = addspecies(cmpobj,cvname{i});
             set(spobj, 'InitialAmount', 0,'InitialAmountUnits',s(1).InitialAmountUnits);   
            ruleobj = addrule(obj, specsum);
            set(ruleobj, 'RuleType', 'repeatedAssignment','Name',cvname{i})              
                  catch
                  end           
        end
        
    else
 %% Zeroing all species and seting total concentrations of conserved moeties
 
                allsp = obj.species;
                
                for j = 1:length(allsp)
                    allsp(j).InitialAmount = 0;
                end
                
 %{
                for j = 1:length(cmpspnames)                    
             cmpobj = sbioselect(obj,'Name', cmpnames{i});
              spobj = sbioselect(cmpobj,'Name',spnames{i});  
                set(spobj, 'InitialAmount', 0);             
                end        
 %}
                
              vtall = sbioselect(obj.Variants,'Name','Total amounts');
              
                 vr = vtall.Content{1};
            for i = 2:length(vtall.Content)
                 vr = [vr;vtall.Content{i}];
            end
            
            [a b c] = intersect(cmpspnames,vr(:,2));
            
            if isempty(a)
            [a b c] = intersect(spnames,vr(:,2));    
            end
            
           cmpnames = cmpnames(b);        
            spnames = spnames(b);
                 vr = vr(c,:);

            for i = 1:length(spnames)
             cmpobj = sbioselect(obj,'Name', cmpnames{i});
              spobj = sbioselect(cmpobj,'Name',spnames{i});               
                set(spobj, 'InitialAmount', vr{i,end});
            end                                          
    end    
end