% load('C:\Users\Santos\Documents\GitHub\Subcellular_workflow\Matlab\Model\Model_Fujita_2010\Results\Examples\GSA 10000 Samples seed_1\Analysis.mat')


% 10^-4
% load('C:\Users\Santos\Documents\GitHub\Subcellular_workflow\Matlab\Model\Model_Fujita_2010\Results\Sensitivity Analysis\2021_Jun_1__16_12_16\Analysis.mat')

% 10^-5
% load('C:\Users\Santos\Documents\GitHub\Subcellular_workflow\Matlab\Model\Model_Fujita_2010\Results\Sensitivity Analysis\2021_Jun_1__15_57_31\Analysis.mat')

% 10^-6
load('C:\Users\Santos\Documents\GitHub\Subcellular_workflow\Matlab\Model\Model_Fujita_2010\Results\Sensitivity Analysis\2021_Jun_1__15_43_50\Analysis.mat')

stg.errorscore = 10^5;
rst = rst.SA;
stg.SAbootstrapsize = 317;
rst = f_calcSensitivities(rst,stg);
rst.SA = rst;
f_plot(rst,stg,"C:\Users\Santos\Documents\GitHub\Subcellular_workflow\Matlab/")