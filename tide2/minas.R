## Set a point in Minas Basin (according to google-map)
lon <- -64.18
lat <- 45.31
## Get relevant tidal constituents from the ## WebTide database.
dir <- "/usr/local/WebTide/data/nwatl/"
nod <- read.table(paste0(dir, "nwatl_ll.nod"), header=FALSE)
fac <- 1 / cos(lat * pi / 180) # account for meridional convergence
closest <- nod[which.min((lon-nod$V2)^2*fac^2+(lat-nod$V3)^2),1]
paste0(dir, "O1.barotropic.s2c")
minas <- list()
for (name in c("O1", "K1", "N2", "M2", "S2")) {
    file <- paste0(dir, name, ".barotropic.s2c")
    ##cat("'", name, "' '", file, "'\n", sep="")
    dat <- read.table(file, header=FALSE, skip=3)[closest,]
    minas[[name]]$amplitude <- dat[[2]]
    minas[[name]]$phase <- dat[[3]]
}
## Construct line that can go in an R file, to save the above
## sink('a');dput(minas);sink()
minas <- list(O1 = list(amplitude = 0.121025, phase = 184.886933), K1 = list(
    amplitude = 0.168322, phase = 199.414863), N2 = list(amplitude = 1.041943,
    phase = 103.887159), M2 = list(amplitude = 5.169948, phase = 119.538393),
    S2 = list(amplitude = 0.850774, phase = 174.84689))

