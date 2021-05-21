%% Script for reproducing data for paper figure 4
% This script should reproduce the data used in figure 4 of our paper.
% 
% Run times measured on a Intel® Core™ i9-10980XE and MATLAB® 2021a
% 
% Total run time approximately 4 hours.
% 
% 
% 
% Prerequisites:
% 
% Have the Model_Nair_2016 model (found at https://github.com/jpgsantos/Model_Nair_2016) 
% inside the Subcellular_workflow/Matlab/Model folder
% 
% Add the Subcellular_workflow folder and all subfolders to the Matlab path
% 
% Run the script with Subcellular_workflow as your main Matlab folder
% 
% 
%% For Figure 4 A and B
% Run sensitivity analysis on the model with optimized parameters
% Run time ~= ??? (user input is needed and might afect this time)
% 
% 
% 
% Copy the settings file to be used in this analysis from the "Subcellular_workflow\Code 
% for paper figures\Reproduce paper figure 4" into the Subcellular_workflow\Matlab\Model\Model_Nair_2016\Settings" 
% folder.

copyfile("../Subcellular_workflow/Code for paper figures/Reproduce paper figure 4/Nair_2016_optimized_fig4.m","../Subcellular_workflow/Matlab/Model/Model_Nair_2016/Settings/Nair_2016_optimized_fig4.m")
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

Run_main
%% 
% Note: There are plots usually generated when running this script but they 
% are not displayed when running a live script, if you want to take a look at 
% these outputs please run the "Run_main.m" script located in the Matlab folder 
% directly.
% 
% The live script is not as performant as native scripts so consider running 
% the Run_main script in the command line for increased performance.
% 
% 
% Save the needed files for the plots

save ("../Subcellular_workflow/Code for paper figures/Reproduce paper figure 4/SA_results_test.mat",'rst')