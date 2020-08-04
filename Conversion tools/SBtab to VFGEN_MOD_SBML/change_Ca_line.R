#!/usr/bin/Rscript
file <- "D1_LTP_time_window.mod"
mod <- readLines(file)
mod <- sub("Ca_expression = ","Ca_expression = cai :",mod)
cat(mod,sep="\n",file=file)
