function [t,x,names] = relaxsys(obj,timevar,totals)
% -------------------------------------------------------------------------
%        [t,x,names] = relaxsys(obj,timevar,totals)
% -------------------------------------------------------------------------
% 'relaxsys' equilibrates the system by simulating ~ 4 months, then
% substituting the final values of the concentration for each species as
% the InitialAmount. 
% The arguments of the function are,
% -     obj: This is the model object.
% - timevar: A 2 member vector with the StopTime and the MaxStep to be set
%            after equilibration. If this is left empty, the original 
%            values before equilibration will be reinstated. 
% -  totals: A boolean to define if the total amounts will be reinstated 
%            (with a call to 'setotals') before equilibration.
%
% --- By Omar Gutierrez Arenas while @ Hellgren-Kotaleski Lab 2011-2014 ---
%

           act = checkrules(obj,[],0); 
           checkrules(obj,act,0);
         spall = obj.species;
         for i = 1:length(spall)
 cmpspnames{i} = [spall(i).parent.name,'.',spall(i).name];
         end

        logsp(obj,1,0,{});                                                 % Record all species
        
        if totals
            setotals(obj,0)
        end

        cnfst = getconfigset(obj);
     stoptime = get(cnfst,'StopTime');
      maxstep = get(cnfst.SolverOptions,'MaxStep');
       soltyp = get(cnfst,'SolverType');
        otptm = get(cnfst.SolverOptions,'OutputTimes');
       
        set(cnfst.SolverOptions,'MaxStep',1e3);
        set(cnfst,'StopTime',1e6);
        set(cnfst.SolverOptions, 'OutputTimes',[])
        
        %set(so,'MaxStep',1e6);
        %set(cnfst, 'StopTime',1e9);
       
       try
       set(cnfst,'SolverType','ode15s')  
  [t,x,names] = sbiosimulate(obj);         
       catch           
       set(cnfst,'SolverType','sundials')         
  [t,x,names] = sbiosimulate(obj);
       end
       
      [a b c] = intersect(cmpspnames,names);
      
      for i = 1:length(b)
          try
          spall(b(i)).InitialAmount = abs(x(end,c(i)));
          catch              
            ['The initial amount of ', cmpspnames{b(i)},' could not be set by relaxsys']  
                abs(x(end,c(i)))
          end
      end
  
      if ~isempty(timevar)
          set(cnfst.SolverOptions,'MaxStep',timevar(1));
          set(cnfst,'StopTime',timevar(2));
      else
          set(cnfst.SolverOptions,'MaxStep',maxstep);
          set(cnfst,'StopTime',stoptime);
      end
      
          set(cnfst,'SolverType',soltyp);
          set(cnfst.SolverOptions,'OutputTimes',otptm);
                              
          checkrules(obj,act,1);
end