function  [t,x,names,simDataObj] = confANDrun(obj,stoptime,maxstep,outptimes,solver)
% -------------------------------------------------------------------------
%         [t,x,names,simDataObj] = confANDrun(obj,stoptime,maxstep,outptimes,solver)
% -------------------------------------------------------------------------
% 'confANDrun' runs a simulation for the model "obj" with user defined 
% parameters specified as arguments:
% -  stoptime: The length of the run in seconds.
% -   maxstep: The maximum step size in seconds.
% - outptimes: A vector with output times of interest.
% -    solver: The ODE solver.
% If the user defined solver, if any, fails to reach the end of the
% simulation, the solvers 'ode15s' and 'sundials' are also tried.

     defsolver = {'ode15s','sundials'};
         cnfst = getconfigset(obj);
     stoptime0 = get(cnfst,'StopTime');
       soltyp0 = get(cnfst,'SolverType');     
      maxstep0 = get(cnfst.SolverOptions,'MaxStep');
         otptm = get(cnfst.SolverOptions,'OutputTimes');
       
       if ~isempty(stoptime)       
       set(cnfst, 'StopTime',stoptime);
       end
       
       if ~isempty(maxstep)
       set(cnfst.SolverOptions,'MaxStep',maxstep);     
       end
       
       set(cnfst.SolverOptions,'OutputTimes',outptimes);    
       
            ct = 0;
       if ~isempty(solver)
           try
       set(cnfst,'SolverType',solver)
    simDataObj = sbiosimulate(obj);
  [t,x,namest] = getdata(simDataObj,'nummetadata');  
            for i = 1:length(namest)
      names{i} = [namest{i}.Compartment,'.',namest{i}.Name];
            end
            ct = 1;
           catch
   ['The solver ',solver,' chosen by the user failed.']
           end
       end
       
           if ~ct
              if ~isempty(solver)
           tsol = strmatch(solver,defsolver);
                if ~(isempty(tsol))
defsolver(tsol) = [];
                end
              end
              
              while ct < length(defsolver)       
                  try
        set(cnfst,'SolverType',defsolver{ct+1})
    simDataObj = sbiosimulate(obj);
  [t,x,namest] = getdata(simDataObj,'nummetadata');  
            for i = 1:length(namest)
      names{i} = [namest{i}.Compartment,'.',namest{i}.Name];
            end
            ct = 1000;
                  catch
    ['The default solver ',defsolver{ct+1},' also failed.']              
            ct = ct + 1;
                  end                  
              end
              
              if ct ~= 1000
    ['We are screwed. The run could not finish after trying all solvers']
                if ~isempty(outptimes)
               t = outptimes; 
               x = ones(length(outptimes),1);
           names = 'bollo rico';
                else
               t = [0 1];
               x = [1 1]';
           names = 'bollo rico';
                end       
              end
           end
    
    set(cnfst, 'StopTime',stoptime0);
    set(cnfst,'SolverType',soltyp0);
    set(cnfst.SolverOptions,'MaxStep',maxstep0);
    set(cnfst.SolverOptions,'OutputTimes',otptm); 

end