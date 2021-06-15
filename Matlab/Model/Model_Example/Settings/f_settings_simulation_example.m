function [stg] = f_settings_simulation_example()

% Maximum time for each individual function to run in seconds
stg.ms.maxt = 2;

% Equilibration time
stg.ms.eqt  = 500000;

% 0 or 1 to decide whether to do Dimensional Analysis
stg.ms.dimenanal = false;

% 0 or 1 to decide whether to do Absolute Tolerance Scaling
stg.ms.abstolscale = false;

% Number for Relative tolerance
stg.ms.reltol = 1.0E-4;

% Number for Absolute tolerance
stg.ms.abstol = 1.0E-4;

% 0 or 1 to decide whether to run sbioaccelerate (after changing this value
% you need to run "clear functions" to see an effect)
stg.ms.sbioacc = 0;

% Max step size in the simulation (if empty matlab decides whats best)
stg.maxstep = [];
end