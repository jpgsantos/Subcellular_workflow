function  [totamount vobj robj cmpn miss] = FFmodobj(obj,totalc,variants,rules,compartments,phenam,viewit)          
% -----------------------------------------------------------------------------------------------
%         [totamount vobj robj cmpn miss] = FFmodobj(obj,totalc,variants,rules,compartments,phenam,viewit)
% -----------------------------------------------------------------------------------------------
% 'FFmodobj' retrives total amounts, variant object, rule objects and
% compartment objects to the parent script according to user defined lists
% of these elements. The list are made of names of these type of objects.
% The argument of this function are:
% -         obj: Model object.
% -      totalc: Cell array with species names to retrieve species objects. This
%                is intended for defining new total amounts so the species must be the
%                unbound instance of a conserved moeity.
% -    variants: Cell array with variants names to retrieve variant objects.
% -       rules: Cell array with rule names to retrieve rule objects.
% - compartment: Cell array with compartment names to retrieve compartment
%                objects.
% -      phenam: Name of the phenotype encoded in the script making the request.
%                This is to produce an informative status message if required.
% -      viewit: A boolean defining if a message with describing the succes of
%                the retrieval is diplayed or not.
%
% The output of this function are:
% -   totamount: A cell array with the species objects 
% -        vobj: A cell array with the variant objects 
% -        robj: A cell array with the rule objects 
% -        cmpn: A cell array with the compartment objects 
% -        miss: If viewit ~= 0, it contains the sucess message.
%
% --- By Omar Gutierrez Arenas while @ Hellgren-Kotaleski Lab 2011-2014 ---

           misslab = {'total amounts', length(totalc);...
                      'variants'     , length(variants);...
                      'rules'        , length(rules);...
                      'compartments' , length(compartments)};
                                  
           missing = cell(4,1);
                      
%% Looking for total amounts of species to be used is a parent script

    if ~isempty(totalc)
                ct = 0;
     missing{1}{1} = '';       
         totamount = ones(length(totalc),1);
             vtall = sbioselect(obj.Variants,'Name','Total amounts');
                vr = cell(length(vtall.Content),4);
                for i = 1:length(vtall.Content)
           vr(i,:) = vtall.Content{i};
                end               
                for i = 1:length(totalc)
                na = find(strcmp(vr(:,2),totalc{i}));
                    if isempty(na)
                ct = ct + 1;
    missing{1}{ct} = totalc{i};                         
      totamount(i) = 0;         
                    else
      totamount(i) = vr{na,end};                 
                    end
      
                end  
    else
         totamount = [];         
    end


%% Looking for variants to be used is a parent script

    if ~isempty(variants)
               ct = 0;
    missing{2}{1} = '';
             vobj = cell(length(variants),1);
                for i = 1:length(variants)
          vobj{i} = sbioselect(obj.Variants,'Name',variants{i});
                    if isempty(vobj{i})
               ct = ct + 1;
   missing{2}{ct} = variants{i};
                    end
                end
    else
             vobj = {};         
    end


%% Looking for rules to be used is a parent script

    if ~isempty(rules)
                ct = 0;
     missing{3}{1} = '';
              robj = cell(length(rules),1);
                for i = 1:length(rules)
           robj{i} = sbioselect(obj.rules,'Name',rules{i});
                    if isempty(robj{i})
                ct = ct + 1;
    missing{3}{ct} = rules{i}; 
                    end
                end
    else
              robj = {};         
    end                             


%% Looking for compartments to be used is a parent script
                   
    if ~isempty(compartments)
               ct = 0;
    missing{4}{1} = '';
             cmpn = cell(length(compartments),1);
                for i = 1:length(compartments)
            cmpnt = sbioselect(obj.compartments,'Name','Spine');           
                    if isempty(cmpnt)
               ct = ct + 1;
   missing{4}{ct} = compartments{i};
                    else
          cmpn{i} = cmpnt(1);
                    end                    
                end
    else
             cmpn = {};
    end

if viewit
        miss{1,1} = ['REQUESTED MODEL OBJECTS BY "',phenam,'"'];
             miss = [miss;{''}];
    for i = 1:4
        if isempty(missing{i})
             miss = [miss;{['0 ',misslab{i,1},' were requested']};{''}];
        else
             miss = [miss;{[num2str(misslab{i,2}),' ', misslab{i,1},' were requested.']}]; 
            if length(missing{i}{1}) > 1
        miss{end} = [miss{end},' The following are missing:'];
                for j = 1:length(missing{i})
             miss = [miss;{['- ',missing{i}{j}]}];
                end
            else
        miss{end} = [miss{end},' All were retrieved.'];
            end
        end   
    end
             miss = [miss; {' '}];
             
            for i = 1:length(miss)            
               formatSpec = '%s';
        disp(sprintf(formatSpec,miss{i}))                      
            end  
else
             miss = {};
end

end
    