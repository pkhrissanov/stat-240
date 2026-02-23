library(rjson)
library(imager)
libraries <- fromJSON(file = "libraries.json")
image <- load.image("Figure03.png")


b <- (301611434 %% 21) + 1


cords <- libraries[["features"]][[b]][["geometry"]]$coordinates
lib <- libraries[["features"]][[b]][["properties"]]$maptip


plot(image)

