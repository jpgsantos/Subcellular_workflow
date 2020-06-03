% Script to reproduce previously obtained plots
clear
clc

addpath(genpath(pwd));

load("Results/Analysis_2020_Jun_3__12_50_29/Analysis.mat")

f_plot(rst,stg)