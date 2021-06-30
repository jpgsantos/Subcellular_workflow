clear
clc
clear functions

addpath(genpath(pwd));

script_folder = convertCharsToStrings(fileparts(mfilename('fullpath')))+"/";
script_folder = strrep(script_folder,"\","/");

%Runtimes measured using a intel i9-10980XE and MATLAB 2021a
% 
f_Reproduce_plot_fig3(script_folder + "Figure 3/")
% %Run time ~= 15 seconds
% 
f_Reproduce_plot_fig4(script_folder + "Figure 4/")
% %Run time ~= 7 seconds
% 
f_Reproduce_plot_fig5(script_folder + "Figure 5/")
% %Run time ~= 10 seconds

f_Reproduce_plot_fig6(script_folder + "Figure 6/")
%Run time ~= 34 seconds

f_Reproduce_plot_fig7_BCDE(script_folder + "Figure 7/")
% %Run time ~= 8 seconds
% 
% f_Reproduce_plot_sup_fig1(script_folder + "Supplementary figure 1/")
% %Run time ~= 10 seconds
% 
% f_Reproduce_plot_sup_fig2(script_folder + "Supplementary figure 2/")
% %Run time ~= 31 seconds
% 
% f_Reproduce_plot_sup_fig3(script_folder + "Supplementary figure 3/")
% %Run time ~= 15 seconds
% 
% f_Reproduce_plot_sup_fig4(script_folder + "Supplementary figure 4/")
% %Run time ~= 18 seconds
% 
% f_Reproduce_plot_sup_fig5(script_folder + "Supplementary figure 5/")
% %Run time ~= 7 seconds