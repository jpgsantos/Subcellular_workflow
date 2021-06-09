%% Script for reproducing the Matlab data of the supplementary figures 1, 2, 3 and 5
% 
% 
% This script should reproduce the Matlab data used in the supplementary figures 
% of our paper (https://doi.org/10.1101/2020.11.17.385203).
% 
% Run times measured on a Intel® Core™ i9-10980XE and MATLAB® 2021a
% 
% Total run time approximately ??? hours.
% 
% 
% 
% Prerequisites:
% 
% Have the Model_Viswan_2018 model (found at https://github.com/jpgsantos/Model_Viswan_2018) 
% inside the Subcellular_workflow/Matlab/Model folder
% 
% Add the Subcellular_workflow folder and all subfolders to the MATLAB® path.
% 
% Run this script with Subcellular_workflow as your main MATLAB® folder.
% 
% 
%% Supplementary figure 1, 3 and 5
% Run the model with optimized parameters
% Run time ~= 40 seconds first time and 25 seconds subsequent runs (user input 
% is needed and might afect this time)
% 
% 
% 
% Copy the settings file to be used in this analysis from the "Subcellular_workflow/Code 
% for paper figures/Matlab Settings" into the Subcellular_workflow/Matlab/Model\Model_Viswan_2018/Settings" 
% folder.

tic
copyfile("../Subcellular_workflow/Code for paper figures/Matlab Settings/Viswan_2018_optimized_sup_fig1_3_5.m", ...
    "../Subcellular_workflow/Matlab/Model/Model_Viswan_2018/Settings/Viswan_2018_optimized_sup_fig1_3_5.m")
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
% Viswan_2018_optimized_sup_fig1_3_5.m (The settings file to be used)

Run_main
toc
%% 
% 
% Save the needed files for the plots or copy them from the model folder into each figure folder.
% Run time ~= 1.5 seconds
% 
% 

tic
save ("../Subcellular_workflow/Code for paper figures/Supplementary figure 1/Analysis_sup_fig1.mat", ...
     'stg','sb','rst')
save ("../Subcellular_workflow/Code for paper figures/Supplementary figure 3/Analysis_sup_fig3.mat", ...
     'stg','sb','rst')
save ("../Subcellular_workflow/Code for paper figures/Supplementary figure 5/Analysis_sup_fig5.mat", ...
     'stg','sb','rst')
%% 
% If this line fails check the paths or manually copy the "model_Nair_2016_optimized.mat" 
% file from Matlab/Model/"Model folder name"/Data into the folder of this script 
% and rename it appropriately.
% 
% 

copyfile("../Subcellular_workflow/Matlab/Model/Model_Viswan_2018/Data/data_Viswan_2018_optimized.mat", ...
    "../Subcellular_workflow/Code for paper figures/Supplementary figure 1/data_Viswan_2018_optimized_sup_fig1.mat")
copyfile("../Subcellular_workflow/Matlab/Model/Model_Viswan_2018/Data/data_Viswan_2018_optimized.mat", ...
    "../Subcellular_workflow/Code for paper figures/Supplementary figure 3/data_Viswan_2018_optimized_sup_fig3.mat")
copyfile("../Subcellular_workflow/Matlab/Model/Model_Viswan_2018/Data/data_Viswan_2018_optimized.mat", ...
    "../Subcellular_workflow/Code for paper figures/Supplementary figure 5/data_Viswan_2018_optimized_sup_fig5.mat")
toc
%% 
% If this line fails check the paths or manually copy the "data_Nair_2016_optimized.mat" 
% file from Matlab/Model/"Model folder name"/Data into the folder of this script 
% and rename it appropriately.
% 
% 
%% Supplementary figure 2
% 

tic
copyfile("../Subcellular_workflow/Code for paper figures/Matlab Settings/Viswan_2018_optimized_sup_fig2.m", ...
    "../Subcellular_workflow/Matlab/Model/Model_Viswan_2018/Settings/Viswan_2018_optimized_sup_fig2.m")
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
% Sensitivity Analysis (The analysis to be performed)
% 
% Viswan_2018_optimized_sup_fig2.m (The settings file to be used)

Run_main
save ("../Subcellular_workflow/Code for paper figures/Supplementary figure 2/Analysis_sup_fig2_no_rst.mat", ...
     'stg','sb')

SiQ = rst.gsa.SiQ;
save ("../Subcellular_workflow/Code for paper figures/Supplementary figure 2/GSA_SiQ_sup_fig2.mat", ...
     "SiQ")
SiTQ = rst.gsa.SiTQ;
save ("../Subcellular_workflow/Code for paper figures/Supplementary figure 2/GSA_SiTQ_sup_fig2.mat", ...
     "SiTQ")
toc