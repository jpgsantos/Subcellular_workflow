%% Script for reproducing the Matlab data of the main figures
% 
% 
% This script should reproduce the Matlab data used in the main figures of our 
% paper (https://doi.org/10.1101/2020.11.17.385203).
% 
% Run times measured on a Intel® Core™ i9-10980XE and MATLAB® 2021a
% 
% Total run time approximately ??? hours.
% 
% 
% 
% Prerequisites:
% 
% Have the Model_Nair_2016 model (found at https://github.com/jpgsantos/Model_Nair_2016) 
% inside the Subcellular_workflow/Matlab/Model folder
% 
% Add the Subcellular_workflow folder and all subfolders to the MATLAB® path.
% 
% Run this script with Subcellular_workflow as your main MATLAB® folder.
% 
% Run Nair_2016 model with optimized parameters (used for figure 3, 5, 6 and 7)
% Run time ~= 40 seconds first time and 25 seconds subsequent runs (user input 
% is needed and might afect this time)
% 
% 
% 
% Copy the settings file to be used in this analysis from the "Subcellular_workflow\Code 
% for paper figures\Reproduce paper figure 3" into the Subcellular_workflow\Matlab\Model\Model_Nair_2016\Settings" 
% folder.

% tic
% copyfile("../Subcellular_workflow/Code for paper figures/Matlab Settings/Nair_2016_optimized_fig3_5_6_7.m", ...
%     "../Subcellular_workflow/Matlab/Model/Model_Nair_2016/Settings/Nair_2016_optimized_fig3_5_6_7.m")
%% 
% Note: If you have customized folder names please change the above code accordingly 
% or manually copy the settings file.
% 
% 
% 
% In the command window select the following:
% 
% Model_Nair_2016 (The folder of the model)
% 
% Diagnostics (The analysis to be performed)
% 
% Nair_2016_optimized_fig3_5_6_7.m (The settings file to be used)

% Run_main
% toc
% Save the needed files for the plots or copy them from the model folder
% Run time ~= 1.5 seconds
% 
% 

% tic
% save ("../Subcellular_workflow/Code for paper figures/Figure 3/Analysis_diagnostics_fig3.mat", ...
%     'stg','sb','rst')
%% 
% 

% copyfile("../Subcellular_workflow/Matlab/Model/Model_Nair_2016/Data/model_Nair_2016_optimized.mat", ...
%     "../Subcellular_workflow/Code for paper figures/Figure 3/model_Nair_2016_optimized_fig3.mat")
% copyfile("../Subcellular_workflow/Matlab/Model/Model_Nair_2016/Data/model_Nair_2016_optimized.mat", ...
%     "../Subcellular_workflow/Code for paper figures/Figure 5/model_Nair_2016_optimized_fig5.mat")
% copyfile("../Subcellular_workflow/Matlab/Model/Model_Nair_2016/Data/model_Nair_2016_optimized.mat", ...
%     "../Subcellular_workflow/Code for paper figures/Figure 7/model_Nair_2016_optimized_fig7.mat")
% copyfile("../Subcellular_workflow/Matlab/Model/Model_Nair_2016/Data/model_Nair_2016_optimized.mat", ...
%     "../Subcellular_workflow/Code for paper figures/Figure 6/model_Nair_2016_optimized_fig6.mat")
%% 
% 

% copyfile("../Subcellular_workflow/Matlab/Model/Model_Nair_2016/Data/data_Nair_2016_optimized.mat", ...
%     "../Subcellular_workflow/Code for paper figures/Figure 3/data_Nair_2016_optimized_fig3.mat")
% toc
%% 
% 
% Run the optimized model with dopamine input at different times
% Run time ~= 1 minute
% 
% For Figure 3 C and D

% tic
% f_Reproduce_data_fig3_CD("../Subcellular_workflow/Code for paper figures/Figure 3/")
% toc
%% 
% For Figure 5 B and C

% tic
% f_Reproduce_data_fig5_BC("../Subcellular_workflow/Code for paper figures/Figure 5/")
% toc
%% 
% For Figure 6 B

% tic
% f_Reproduce_data_fig6_B_Matlab("../Subcellular_workflow/Code for paper figures/Figure 6/")
% toc
%% 
% For Figure 7 C

% tic
% f_Reproduce_data_fig7_C("../Subcellular_workflow/Code for paper figures/Figure 7/")
% toc
%% 
% 
% 
% 

tic
copyfile("../Subcellular_workflow/Code for paper figures/Matlab Settings/Nair_2016_optimized_fig6.m", ...
    "../Subcellular_workflow/Matlab/Model/Model_Nair_2016/Settings/Nair_2016_optimized_fig6.m")

Run_main
toc
copyfile("../Subcellular_workflow/Matlab/Model/Model_Nair_2016/Data/model_Nair_2016_optimized.mat", ...
    "../Subcellular_workflow/Code for paper figures/Figure 6/model_Nair_2016_optimized_alternative.mat")

tic
f_Reproduce_data_fig6_B_Matlab("../Subcellular_workflow/Code for paper figures/Figure 6/")
toc
%% Figure 4 A and B
% Run sensitivity analysis on the model with optimized parameters
% Run time ~= 4 hours (user input is needed and might afect this time)
% 
% 
% 
% Copy the settings file to be used in this analysis from the "Subcellular_workflow\Code 
% for paper figures\Reproduce paper figure 4" into the Subcellular_workflow\Matlab\Model\Model_Nair_2016\Settings" 
% folder.

% copyfile("../Subcellular_workflow/Code for paper figures/Figure 4/Nair_2016_optimized_fig4.m","../Subcellular_workflow/Matlab/Model/Model_Nair_2016/Settings/Nair_2016_optimized_fig4.m")
%% 
% Note: If you have customized folder names please change the above code accordingly 
% or manually copy the settings file.
% 
% 
% 
% In the command window select the following:
% 
% Model_Nair_2016 (The folder of the model)
% 
% Sensitivity Analysis (The analysis to be performed)
% 
% Nair_2016_optimized_fig4.m (The settings file to be used)

% Run_main
%% 
% Note: The live script is not as performant as native scripts so consider running 
% the non-live script provided for increased performance
% 
% 
% Save the needed files for the plots

% save ("../Subcellular_workflow/Code for paper figures/Figure 4/SA_results.mat",'rst')