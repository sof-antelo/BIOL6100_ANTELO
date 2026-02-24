# looking at colors and color mapping in ggplot
# installing software for next class 
# Sof Antelo 
# 24 Feb 2026

###############################
install.packages("colorspace")
install.packages("wesanderson")
install.packages("ggsci")

#installing packages that werent working using devtools
install.packages("devtools")
library(devtools)
#dev tools allows us to download packages from git
#previously we have used CRAN (R standard) only 

#namespace: API
# devtools :: ensures only coming from devtools 
devtools::install_github("wilkelab/cowplot")
devtools::install_github("clauswilke/colorblindr")
install.packages("colorspace", repo = "https://R-Forge.R-project.org")

library(ggplot2)
library(ggthemes)
library(colorblindr)
library(colorspace)
library(wesanderson)
library(ggsci)
