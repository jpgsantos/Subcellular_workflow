clear
clc
clear functions

addpath(genpath(pwd));

script_folder = convertCharsToStrings(matlab.desktop.editor.getActiveFilename);
script_folder = strrep(script_folder,"\","/");
script_folder = strrep(script_folder,mfilename + ".m","");

%Runtimes measured using a intel i9-10980XE and MATLAB 2021a

f_Reproduce_plot_fig3(script_folder + "Reproduce paper figure 3/")
%Run time ~= 15 seconds

f_Reproduce_plot_fig4(script_folder + "Reproduce paper figure 4/")
%Run time ~= 7 seconds

f_Reproduce_plot_fig5(script_folder + "Reproduce paper figure 5/")
%Run time ~= 10 seconds

f_Reproduce_plot_fig6(script_folder + "Reproduce paper figure 6/")
%Run time ~= 34 seconds

f_Reproduce_plot_fig7_BCDE(script_folder + "Reproduce paper figure 7/")
%Run time ~= 8 seconds

f_Reproduce_plot_sup_fig1(script_folder + "Reproduce paper supplementary figure 1/")
%Run time ~= 10 seconds

f_Reproduce_plot_sup_fig2(script_folder + "Reproduce paper supplementary figure 2/")
%Run time ~= 31 seconds

f_Reproduce_plot_sup_fig3(script_folder + "Reproduce paper supplementary figure 3/")
%Run time ~= 15 seconds

f_Reproduce_plot_sup_fig4(script_folder + "Reproduce paper supplementary figure 4/")
%Run time ~= 18 seconds

f_Reproduce_plot_sup_fig5(script_folder + "Reproduce paper supplementary figure 5/")3
%Run time ~= 7 seconds