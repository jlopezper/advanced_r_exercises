###########################
#         Chapter 2       #
###########################

list_packages <- c("lobstr")
new_pkg <- list_packages[!(list_packages %in% installed.packages()[,"Package"])]
if(length(new_pkg)) install.packages(new_pkg)
sapply(list_packages, require, character.only = TRUE)

