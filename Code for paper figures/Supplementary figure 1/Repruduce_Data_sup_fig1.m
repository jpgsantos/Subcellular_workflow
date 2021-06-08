%% Script for reproducing data for paper supplementary figure 1
% 
% 
% This script should reproduce the data used in supplementary figure 1 of our 
% paper, it reproduces only the Matlab data of the new optimized model.
% 
% Run times measured on a Intel® Core™ i9-10980XE and MATLAB® 2021a
% 
% Total run time approximately 1 min.
% 
% 
% 
% Prerequisites:
% 
% Have the Model_Viswan_2018 model (found at https://github.com/jpgsantos/Model_Viswan_2018) 
% inside the Subcellular_workflow/Matlab/Model folder
% 
% Add the Subcellular_workflow folder and all subfolders to the Matlab path
% 
% Run the script with Subcellular_workflow as your main matlab folder
% 
% 
%% Supplementary figure 1
% Run the model with optimized parameters
% Run time ~= 40 seconds first time and 25 seconds subsequent runs (user input 
% is needed and might afect this time)
% 
% 
% 
% Copy the settings file to be used in this analysis from the "Subcellular_workflow\Code 
% for paper figures\Supplementary figure 1" into the Subcellular_workflow\Matlab\Model\Model_Viswan_2018\Settings" 
% folder.

copyfile("../Subcellular_workflow/Code for paper figures/Supplementary figure 1/Viswan_2018_optimized_sup_fig1.m", ...
    "../Subcellular_workflow/Matlab/Model/Model_Viswan_2018/Settings/Viswan_2018_optimized_sup_fig1.m")
%% 
% Note: If you have customized folder names please change the above code accordingly 
% or manually copy the settings file.
% 
% 
% 
% In the command window select the following:
% 
% Model_Viswan_2018 (The folder of the model)
% 
% Diagnostics (The analysis to be performed)
% 
% Viswan_2018_optimized_sup_fig1.m (The settings file to be used)

Run_main
%% 
% 
% Save the needed files for the plots or copy them from the model folder
% Run time ~= 1.5 seconds
% 
% 

save ("../Subcellular_workflow/Code for paper figures/Supplementary figure 1/Analysis_sup_fig1.mat", ...
     'stg','sb','rst')
%% 
% If this line fails check the paths or manually copy the "model_Nair_2016_optimized.mat" 
% file from Matlab/Model/"Model folder name"/Data into the folder of this script 
% and rename it to model_Nair_2016_optimized_fig3.mat
% 
% 

copyfile("../Subcellular_workflow/Matlab/Model/Model_Viswan_2018/Data/data_Viswan_2018_optimized.mat", ...
    "../Subcellular_workflow/Code for paper figures/Supplementary figure 1/data_Viswan_2018_optimized_sup_fig1.mat")
%% 
% If this line fails check the paths or manually copy the "data_Nair_2016_optimized.mat" 
% file from Matlab/Model/"Model folder name"/Data into the folder of this script 
% and rename it to data_Nair_2016_optimized.mat_fig3.mat
% 
%