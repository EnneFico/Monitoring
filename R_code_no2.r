# setwd("C:/Users/nicof/lab/EN")

# import all images in one time 

rlistEN <- list.files(pattern = "EN_", full.names = T)

list_rastEN <- lapply(rlistEN, raster)

EN.multitemp <- stack(list_rastEN)

polt(EN.multitemp)
