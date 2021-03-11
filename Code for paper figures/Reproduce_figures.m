clear
clc
clear functions

addpath(genpath(pwd));

script_folder = convertCharsToStrings(matlab.desktop.editor.getActiveFilename);
script_folder = strrep(script_folder,"\","/");
script_folder = strrep(script_folder,mfilename + ".m","");

% f_Reproduce_new_data_fig3_CD(script_folder + "Reproduce paper figure 3/")
f_Reproduce_fig3(script_folder + "Reproduce paper figure 3/")
% f_Reproduce_fig4(script_folder + "Reproduce paper figure 4/")
% f_Reproduce_fig5(script_folder + "Reproduce paper figure 5/")
% f_Reproduce_fig6(script_folder + "Reproduce paper figure 6/")
% f_Reproduce_fig7_BCDE(script_folder + "Reproduce paper figure 7/")
% f_Reproduce_sup_fig1(script_folder + "Reproduce paper supplementary figure 1/")
% f_Reproduce_sup_fig2_alt2(script_folder + "Reproduce paper supplementary figure 2/")
% f_Reproduce_sup_fig_3(script_folder + "Reproduce paper supplementary figure 3/")
% f_Reproduce_sup_fig_4(script_folder + "Reproduce paper supplementary figure 4/")