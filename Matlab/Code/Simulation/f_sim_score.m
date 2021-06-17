function [score,rst,rst_not_simd] = f_sim_score(parameters,stg,mmf)

%Turn off Dimension analysis warning from simbiology
warning('off','SimBiology:DimAnalysisNotDone_MatlabFcn_Dimensionless')

% Call the function that simulates the model
rst = f_prep_sim(parameters,stg,mmf);

% Call the function that scores
rst = f_score(rst,stg,mmf);

% Get the total score explicitly for optimization functions
score = rst.st;

rst_not_simd = rmfield( rst , 'simd');
end