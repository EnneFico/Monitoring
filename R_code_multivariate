# R code for multivariate analysis

setwd("~/lab/") # "C:/lab/" ....

# install.packages("vegan")
library(vegan)

biomes <- read.table("biomes.csv", header=T, sep=",")
head(biomes) # View(biomes), biomes

# DEtrended CORrespondence ANAlysis
multivar <- decorana(biomes)
multivar

plot(multivar)

# biomes types
biomes_types <- read.table("biomes_types.csv", header=T, sep=",")
head(biomes_types)

attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
# or col=1:4

ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 
