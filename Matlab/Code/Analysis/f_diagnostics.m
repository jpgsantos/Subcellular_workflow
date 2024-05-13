function rst = f_diagnostics(stg,mmf)
% Description: This function runs a model for given parameters and
% settings, and computes the scores for fitness, both in multi-core and
% single-core mode. The function uses f_sim_score() to obtain the score for
% each parameter array. The mode (multi-core or single-core) is determined
% by the 'optmc' field in the 'stg' input.
%
% Inputs:
% - stg: A structure containing settings for the model, such as:
%        * pa: An array of parameter arrays to be tested.
%        * pat: Indices of the parameter arrays to be tested.
%        * optmc: A Boolean flag, if true the function runs in multi-core
%          mode, otherwise it runs in single-core mode.
% - mmf: A custom memory-mapped file object, used for reading or writing 
% data.
% 
% Outputs:
% - rst: A vector containing the computed scores for each parameter array.
%
% Used Functions:
% - f_sim_score: A function that takes a parameter array, model settings
% (stg), and a custom memory-mapped file object (mmf) as inputs and returns
% the computed score for that parameter array.
%
% Variables:
% Loaded:
% (None)
%
% Initialized:
% - par_array_idx: The current index of the parameter array being tested.
%
% Persistent:
% (None)

% Run the model and obtain scores for fitness Multi Core

pa = stg.pa(stg.pat,:);
if stg.optmc
    disp("Running the model and obtaining Scores (Multicore)")
    
    % Iterate over the parameter arrays to be tested
    parfor par_array_idx = 1:length(stg.pat)
        [~,rst(par_array_idx),~] =...
            f_sim_score(pa(par_array_idx,:),stg,mmf,0,0);
    end
        
    % Run the model and obtain scores for fitness single Core
else
    disp("Running the model and obtaining Scores (Singlecore)")
    
    % Iterate over the parameter arrays to be tested
    for par_array_idx = 1:length(stg.pat)
        [~,rst(par_array_idx),~] =...
            f_sim_score(pa(par_array_idx,:),stg,mmf,0,0);
    end
end
rst(stg.pat(1:length(stg.pat)))=rst(1:length(stg.pat));
end