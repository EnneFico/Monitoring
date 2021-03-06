###R code for multivariate analysis###

#Open R#
#set the working directory
setwd("C:/Users/nicof/lab")  #PC
#The vegan package contains all common ordination methods: Principal component analysis, correspondence analysis, detrended correspondence analysis (decorana) and a wrapper for nonmetric multidimensional scaling (metaMDS)
#install the package
install.packages("vegan")
#access to the package
library(vegan)

#biomes is the name that we give(the vector assigned by the symbol <-), read.table is to analyze the data, "biomes.csv" is the name of the file, head=T because the first row is words, sep="," is the separator between the names of the words in the row (that the Professor used to create columns)
biomes<-read.table("biomes.csv",head=T,sep=",")

#to look at the dataset: head(biomes)or view(biomes)
head(biomes)

#multivariate analysis: decorana=detrended correspondence analysis
multivar<- decorana(biomes)

#we can then make the plot of the multivariate analysis
plot(multivar)

#we are now seeing the graph from 1 point of view, but we can see it from other (Dali' example)
#if we just put multivar, we see the analysis that happened
multivar
#eigenvalues= the percentage of data that we are able to see from this prospective
#we got DCA1=0.5117 DCA2=0.3036,  51%+30%=81%

#let's use other data to then sum up the same biomes
biomes_types <- read.table("biomes_types.csv", header=T, sep=",")
head(biomes_types)
attach(biomes_types)

#we make an ordiellipse that connects all the data. Multivar is the first name we gave.
ordiellipse(multivar,type, col=1:4, kind="ehull", lwd=3)
#we can put the color like this or col=c("green","orange","red","blue")

#to see the 'disk' of the biomes
ordispider(multivar, type, col=1:4, label = T)
