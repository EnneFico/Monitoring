# R code for spatial viow of points

install.packages("sp")

library(sp)

data(meuse)

head(meuse)

# coordinates
coordinates(meuse) = ~x+y   #alt+126

plot(meuse)
spplot(meuse, "zinc")

# Exercise: plot the spatial amount of copper
spplot(meuse, "copper", main= "Copper Concentration")

bubble(meuse, "zinc")

#Exercise: bubble Copper in red
bubble(meuse, "Copper", main= "Copper Concentration", col= "red")

## Importing new data from local folder
# download covid_agg.csv from our teaching site and build a folder called lab in to C:
# put the covid_agg.csv file into the folder lab

# setting the working directory: lab
# Windows
setwd("C:/Users/nicof/OneDrive/Documenti/UNI/UNIBO/esami scelti/2_Ecology/BIO03_MONITORING ECOSYSTEM CHANGES AND FUNCTIONING/Practical/lab")

#inizializate new variable related to the file
covid <- read.table("covid_agg.csv", head=TRUE)

attach(covid)
plot(country,cases)
# make the city names vertical
plot(country,cases, las=0) # parallel labes
plot(country,cases, las=1) # orizontal labes
plot(country,cases, las=2) # ortogonal labes
plot(country,cases, las=3) # vertical labes


plot(country,cases, las=3, cex.axes=0.5)


#package ggplot2
install.packages("ggplot2")

#save the .RData under the menu Files
