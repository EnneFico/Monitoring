setwd("~/lab/")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

library(spatstat)

inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T)

#with this command you can use directly the name of columns without $
attach(inp)

#plotting x , y columns
plot(X,Y)

#explaining to the software what x and y are
inppp <- ppp(x=X,y=Y,c(716000,718000),c(4859000,4861000))

#mark for the sofware different tipe of cover
marks(inppp) <- Canopy.cov

#we are going to interpolate the data to fill the empy space
canopy <- Smooth(inppp)

plot(canopy)
points(inppp, col="green")

#we can see the same protocol for other variables
marks(inppp) <- cop.lich.mean
lichs <- Smooth(inppp)
plot(lichs)
points(inppp)

#see both the graph
par(mfrow=c(1,2))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)

#see olso the correlation
par(mfrow=c(1,3))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
plot(Canopy.cov, cop.lich.mean, col="red", pch=19, cex=2)

##########################################

#second dataset from Giacomo

inp.psam <- read.table("dati_psammofile.csv", sep=";", head=T)

attach(inp.psam)
plot(E,N) 

#choose the limity see the max min value of east and north
inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))

marks(inp.psam.ppp) <- C_org

C <- Smooth(inp.psam.ppp)

plot(C)

#put points on top
points(inp.psam.ppp)

