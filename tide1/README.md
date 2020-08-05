Google maps suggests that the centre of Minas Basin is near

    lon <- -64.18
    lat <- 45.31

An estimate of the relevant tidal constituents may be found using the
WebTide database, as follows.

    dir <- "/usr/local/WebTide/data/nwatl/"
    nod <- read.table(paste0(dir, "nwatl_ll.nod"), header=FALSE)
    fac <- 1 / cos(lat * pi / 180) # account for meridional convergence
    closest <- nod[which.min((lon-nod$V2)^2*fac^2+(lat-nod$V3)^2),1]
    O1<-read.table(paste0(dir, "O1.barotropic.s2c"), header=FALSE, skip=3)[closest, 2]
    K1<-read.table(paste0(dir, "K1.barotropic.s2c"), header=FALSE, skip=3)[closest, 2]
    N2<-read.table(paste0(dir, "N2.barotropic.s2c"), header=FALSE, skip=3)[closest, 2]
    M2<-read.table(paste0(dir, "M2.barotropic.s2c"), header=FALSE, skip=3)[closest, 2]
    S2<-read.table(paste0(dir, "S2.barotropic.s2c"), header=FALSE, skip=3)[closest, 2]

with results O1 = 0.121025m, K1 = 0.168322m, N2 = 1.041943m,
M2 = 5.169948m, and S2 = 0.850774m.
