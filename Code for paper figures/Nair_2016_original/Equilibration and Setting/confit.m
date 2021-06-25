function confit(obj,stoptime,maxstep,solver)
% -------------------------------------------------------------------------
%        confit(obj,stoptime,maxstep,solver)
% -------------------------------------------------------------------------
% 'conf' configures the solver with user defined "stoptime", "maxstep" and 
% "solvertype".

         cnfst = getconfigset(obj);
         set(cnfst.SolverOptions,'MaxStep',maxstep);
         set(cnfst, 'StopTime',stoptime);
         set(cnfst,'SolverType',solver)
end