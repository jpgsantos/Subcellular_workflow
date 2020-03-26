function [score,rst] = f_sim_score(parameters,stg)

% Call the function that simulates the model
rst = f_prep_sim(parameters,stg);

% Call the function that scores
rst = f_score(rst,stg);

% Get the total score explicitly for optimization functions
score = rst.st;
end