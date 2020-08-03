% Script to reproduce previously obtained plots

clear
clc

addpath(genpath(pwd));

% Choose relevant path

%Example diagnostics
load("Results/Analysis_diagnostics_example.mat")

%Example Global sensitivitie analysis
% load("Results/Analysis_GSA_example.mat")


% Create needed folders
    mkdir("Model/" + stg.folder_model,"Data");
    mkdir("Model/" + stg.folder_model,"Formulas");
    mkdir("Model/" + stg.folder_model,"tsv");
    mkdir("Model/" + stg.folder_model,"Data/Exp");

% Runs the import scripts if chosen in settings
f_import(stg,sb)

% Plots the results of the analysis
f_plot(rst,stg)