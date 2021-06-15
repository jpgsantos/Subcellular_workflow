function [stg] = f_settings_analysis_example()

% Experiments to run
stg.ms.exprun = 1:4;

% Choice between 0,1,2 and 3 to change either and how to apply log10 to the
% scores (check documentation)
stg.useLog = 3;

% 0 or 1 to decide whether to use multicore everywhere it is available
stg.optmc = 0;

% Choice of ramdom seed
stg.rseed = 1;

% 0 or 1 to decide whether to use display things in the console
stg.csl = 0;

% 0 or 1 to decide whether to display results on console
stg.console = 1;
end