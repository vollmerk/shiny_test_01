library(oce)
lines <- readLines("Chuuk-Harmonics-2009.txt")
location <- lines[grep("^#", lines, invert=TRUE)[1]]
lat <- as.numeric(scan(text=lines[grep("latitude:", lines)], what="character", quiet=TRUE)[3])
unit <- scan(text=lines[grep("units:", lines)], what="character", quiet=TRUE)[3]
factor <- if (unit == "feet") .3 else 1
con <- lines[grep("^[A-Z]{1-3}[1-9]{1}", lines)]
T <- read.table(text=con, header=FALSE,
                col.names=c("name", "amp", "phase"),
                stringsAsFactors=FALSE)
if (unit == "feet") {
    T$amp <- 0.3048 * T$amp
    warning("converting amplitude from metres to feet\n")
}
tRef <- as.POSIXct("2019-07-17 00:00:00", tz="UTC")
days <- 28
time <- tRef + seq(0, days*86400, 3600)
tide <- as.tidem(tRef=tRef, latitude=lat, name=T$name, amplitude=T$amp, phase=T$phase)
summary(tide)
eta <- predict(tide, newdata=time)
if (!interactive()) png("chuuk.png")
oce.plot.ts(time, eta, type="l", drawTimeRange=FALSE)
grid()
mtext(location)
if (!interactive()) dev.off()

