% Script to reproduce previously obtained plots

clear
clc

addpath(genpath(pwd));

% Choose relevant path
% load("Results/Analysis_2020_Jun_3__12_50_29/Analysis.mat")
load("Results/Analysis_2020_Jun_3__15_29_7/Analysis.mat")


% Create needed folders
    mkdir("Model/" + stg.folder_model,"Data");
    mkdir("Model/" + stg.folder_model,"Formulas");
    mkdir("Model/" + stg.folder_model,"tsv");
    mkdir("Model/" + stg.folder_model,"Data/Exp");

f_import(stg,sb)

f_plot(rst,stg)