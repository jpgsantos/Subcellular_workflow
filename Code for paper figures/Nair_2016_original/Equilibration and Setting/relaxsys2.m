function [t,x,names] = relaxsys2(obj,timevar,tune,totals,integ)
% -------------------------------------------------------------------------
%        [t,x,names] = relaxsys2(obj,timevar,tune,totals,integ)
% -------------------------------------------------------------------------
% 'relaxsys2' equilibrates the system by simulating a user defined time 
% length at a user specified maxstep and then substituting the final values 
% of the concentration for each species as the InitialAmount. 
% The arguments of the function are,
% -     obj: This is the model object.
% - timevar: A 2 member vector with the StopTime and the MaxStep to be set
%            after equilibration. If this is left empty, the original 
%            values before equilibration will be reinstated. 
% -    tune: A 2 member vector with the MaxStep and the StopTime for the
%            equilibration set.
% -  totals: A boolean to define if the total amounts will be reinstated 
%            (with a call to 'setotals') before equilibration.
% -   integ: The ODE solver to use. 
%
% --- By Omar Gutierrez Arenas while @ Hellgren-Kotaleski Lab 2011-2015 ---

           act = checkrules(obj,[],0); 
           checkrules(obj,act,0);
         spall = obj.species;
         if length(obj.compartments) > 1
            for i = 1:length(spall)
 cmpspnames{i} = [spall(i).parent.name,'.',spall(i).name];
            end
         else
            for i = 1:length(spall)    
 cmpspnames{i} = spall(i).name;
            end
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
       
                set(cnfst.SolverOptions,'MaxStep',tune(1));
                set(cnfst,'StopTime',tune(2));
                set(cnfst.SolverOptions, 'OutputTimes',[])
        
        %set(so,'MaxStep',1e6);
        %set(cnfst, 'StopTime',1e9);
       
           t = [];
        switch integ
            case 'ode15s'
   set(cnfst,'SolverType','ode15s')  
  [t,x,names] = sbiosimulate(obj);     
            case 'sundials'
   set(cnfst,'SolverType','sundials')  
  [t,x,names] = sbiosimulate(obj);                  
        end

        if isempty(t)
            'Apparently the simulation had problems. Check that the solver name is ''sundials'' or ''ode15s''.'
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