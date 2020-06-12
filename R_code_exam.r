# R_code_exam.r

Indices
1




1. R_code_first

#the function install.packages is used to install something from outside (present in the CRAN) with the use of " "
install.packages("sp")
#sp is a package for spatial data
#library is to start using the data present in the package
library(sp)
#meuse is a dataset comprising of four heavy metals measured in the top soil in a flood plain along the river Meuse
data(meuse)

#let's see how the dataset meuse is structured, calling the name we can have the infos in r
meuse

#lets's look at the first rows of the set with the function head( )
head(meuse)

#let's plot two variables:
#let's see if the zinc is related to the one of the copper
#the function attach () connects the dataset to the r search path, so calling the name of an element we can have the infos
attach(meuse)
#the function plot( ) is the most generic and used function for plotting dataset
plot(zinc,copper)
#col is used to change the colour
plot(zinc,copper,col="green")
#pch is used to change the symbol
plot(zinc,copper,col="green",pch=19)
#cex is used to change the size of the symbol
plot(zinc,copper,col="green",pch=19,cex=2)

#######################################################################################################
#######################################################################################################

2. R_code_multipanel.r

  
###Multipanel in R. The second lesson of monitoring ecosystem
#sp is a package for spatial data
install.packages("sp")
#GGally is a package that extends 'ggplot2' by adding several functions to reduce the complexity of combining geometric objects with transformed data.
install.packages("GGally")
#library( ) function is to be able to start using the functions (install.packages is like buying a book, library is like taking the book out from the bookshelf to start reading it
library(sp)  #require(sp) do also the same action
library(GGally)
#meuse is provided by package sp. is a data set comprising of four heavy metals measured in the top soil in a flood plain along the river Meuse
#data( ) allow users to load datasets from packages for use it in the workspace
data(meuse)
#attach( ) is to connect the dataset to the r search path
attach(meuse)

#EXERCISE: see the name of the variables and plot cadmium and zinc
meuse
plot(cadmium,zinc)

#There are 2 ways to see the names of the variable
#names( ) is used to see the names of the different variables
names(meuse)
#head( ) is used to see the first rows of the dataset
head(meuse)
#pch=a number, to change the character
#col to change the colour
#cex to change the size of the character
plot(cadmium,zinc,pch=15,col="red",cex=2)

#Exercise: make all the paiwise possible plots of the dataset)
#plo(x,cadmium)
#plot(x,zinc)
#plot,...
#no, plot is not a good idea!

#the function pairs( ) is used to produce a matrix of scatterplots
pairs(meuse)

#code to switch from the whole varaiable to the 4 variable
pairs(~ cadmium + copper + lead + zinc, data=meuse)

pairs(meuse[,3:6])

#Exercise:prettify the graph changing the character, colour and size
pairs(meuse[,3:6], pch=11, col="green", cex=0.7)


#ggpairs( ) is a GGally package with prettyfied graph
ggpairs(meuse[,3:6])

####################################################################################################
####################################################################################################

3. R_code_spatial.r

#R Code for spatial view of points
#we don't need to install the package because we've already precedently done it, we just need to open it through the function library( )
library(sp)    

data(meuse)       #is the data in this sp library.

head(meuse)     #to see the first 5 rows.

#coordinates
#the function coordinates( ) is to say to R that in the dataset meuse the coordinates are x and y
coordinates(meuse) = ~x+y      
plot(meuse)
#spplot() is within lattice (trellis) plot methods for spatial data with attributes
spplot(meuse, "zinc")    #to relate just to 1 variable and his legenda.

#Exercise: plot the spatial amount of copper
spplot(meuse, "copper")

#to change the title we use the function "main":
spplot(meuse, "copper", main="copper concentration")

#the function bubble() results in a change in the size of the points (bigger for higher values) instead of having different colors. 
bubble(meuse, "zinc")
bubble(meuse, "zinc", main="Zinc concentration")

###Exercise: bubble copper in red
bubble(meuse, "copper", col="red", main= "Copper concentration")


####Importing new data

#download file covid_agg.csv from our teaching site and put it into folder lab (no capital letters)

#setting the working directory (where data is coming from and going to)
#for mac setwd("/Users/yourname/lab")
setwd("/Users/alessandro/lab")
#the function read.table("covid_agg.csv", head=T) is to open and read the file, with "" because importing from outside
#<- is to assign to a vector
covid <- read.table("covid_agg.csv", head=T)  #where head=T or head=TRUE is when we have a first row with no numbers
#head of our new vector indicates the first 5 rows of the file
head(covid)  #to show the first 5 rows
#attach is once again used to access objects in the database by simply giving their names
attach(covid)
#in case we dont do attach(covid) we need to write: plot(covid$country, covid$cases)
plot(country, cases)  #where country is x and cases is y

#we cannot see all the countries so we need to change the orientation inverting x and y
plot(country, cases, las=0)  #parallel labels
plot(country, cases, las=1)  #all the labels horizontal
plot(country, cases, las=2)  #perpendicular labels
plot(country, cases, las=3)  #vertical labels

#we want to reduce the size of the x axis labels using cex.axis and assignin a value lower than 1
plot(country, cases, las=3, cex.axis=0.5)

#ggplot2 package
install.packages("ggplot2")
library(ggplot2)  #or function require(ggplot2). in both cases we start to make use of the package

#####save theworkspace as .RData under the menu file#####

#####Load the previously data with double click on the file in the lab folder
#OR
#Open r and set (ALWAYS) the working directory (where data is coming from and going to)
setwd("/Users/alessandro/lab") #mac
#load the previous RData
load("covid_workspace.RData")
#ls() is the function to check which files are uploaded
ls() 

###Using ggplo2###
library(ggplot2) #requireto have already install.packages("ggplot2")
#mpg is a dataset that contains a subset of the fuel economy data that the EPA
data(mpg) #to access to it
head(mpg) #to see the first 5 lines
#key components: data, aes, geometry
#data in this case is mpg, we close both the () after x and y cuz the geometry is by itself apart
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_line()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon()

#let's look at the covid data that we already have uploaded
head(covid)
#we will exagerate the size by the number of cases
ggplot(covid, aes(x=lon,y=lat, size=cases)) + geom_point()


###########################################################################################
###########################################################################################
