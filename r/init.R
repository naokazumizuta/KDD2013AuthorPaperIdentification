# set directory
Dir <- list()
Dir$r <- paste(RootDir, "/r", sep = '')
Dir$rdata <- paste(RootDir, "/rdata", sep = '')
Dir$raw <- paste(RootDir, "/raw", sep = '')
Dir$submit <- paste(RootDir, "/submit", sep = '')

options(stringsAsFactors = FALSE)

setwd(Dir$r)
source("util.R")
