#!/usr/bin/Rscript

sbml.file <- commandArgs(trailingOnly = TRUE);
source("sbml_fix.R")
sbml_fix(sbml.file)

