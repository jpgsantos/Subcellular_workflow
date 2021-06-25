function resetsCa(obj)
% -------------------------------------------------------------------------
%        resetsCa(obj)
% -------------------------------------------------------------------------
% 'resetsCa' updates after a system requilibration (relaxsys) the scaling factors modifying Ca inputs.
%
% The parameters assessed in this model are:
%
%       actNR2B              % This is an species
%       actschNR2B           % This is an species
%       actschSNR2B          % This is an species
%
%       basalActNR2B
%       basalPActXNR2B
%       basalPActXSNR2B
%       scaleTfCa
%       scaleCa
%       scaleSChCa
%       scaleSChCaS
%       SChX
%       SChXS

     compall = get(obj,'Compartment');
     for i = 1:length(compall)
     comp{i} = compall(i).name;
     end
        cmpn = strmatch('Spine',comp(:));
        cmpn = compall(cmpn);   

        %% Reseting scaleCa  
                         
        % Single channel scaling by tyrosine (Src or Fyn)
        sobj = sbioselect(cmpn,'Name','actschNR2B');
        if ~isempty(sobj)
        pobj = sbioselect(obj,'Name', 'SChX');        
        SChX = get(pobj,'Value');
  bPActXNR2B = ((SChX-1)*sobj.InitialAmount + 1); 
        pobj = sbioselect(obj,'Name', 'basalPActXNR2B');      
        set(pobj,'Value',bPActXNR2B)
        sobj = sbioselect(cmpn,'Name', 'scaleSChCa');
        set(sobj,'InitialAmount',1)        
        end
        
        % Single channel scaling by serine/threonine (PKA)
        sobj = sbioselect(cmpn,'Name','actschSNR2B');
        if ~isempty(sobj)
        pobj = sbioselect(obj,'Name', 'SChXS');
       SChXS = get(pobj,'Value');
 bPActXSNR2B = ((SChXS-1)*sobj.InitialAmount + 1);
        pobj = sbioselect(obj,'Name', 'basalPActXSNR2B');      
        set(pobj,'Value',bPActXSNR2B)   
        sobj = sbioselect(cmpn,'Name', 'scaleSChCaS');
        set(sobj,'InitialAmount',1)   
        end
        
        % Traffic based enhancement
        sobj = sbioselect(cmpn,'Name', 'actNR2B');
        if ~isempty(sobj)
        pobj = sbioselect(obj,'Name', 'basalActNR2B');
        set(pobj,'Value',sobj.InitialAmount) 
        sobj = sbioselect(cmpn,'Name', 'scaleTfCa');
        set(sobj,'InitialAmount',1)                 
        end
        
        if ~isempty(sobj)
        sobj = sbioselect(cmpn,'Name', 'scaleCa');
        set(sobj,'InitialAmount',1)   
        end
        
end