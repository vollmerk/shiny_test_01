## https://tidesandcurrents.noaa.gov/harcon.html?unit=0&timezone=0&id=9414290&name=San+Francisco&state=CA
t <- read.table("san_francisco.dat", sep="\t", header=TRUE)
t$Frequency <- t$Speed / 360
o <- order(t$Amplitude, decreasing=TRUE)
to <- t[o,]
tstrong <- to[to$Amplitude > 0.1, ]
tstrong <- tstrong[order(tstrong$Frequency), ]
tstrong
##    Constituent Name Amplitude Phase    Speed                                   Description  Frequency
## 6            6   O1     0.230 208.4 13.94304                     Lunar diurnal constituent 0.03873065
## 30          30   P1     0.114 222.1 14.95893                     Solar diurnal constituent 0.04155259
## 4            4   K1     0.370 225.4 15.04107                     Lunar diurnal constituent 0.04178075
## 3            3   N2     0.122 183.2 28.43973 Larger lunar elliptic semidiurnal constituent 0.07899925
## 1            1   M2     0.576 208.2 28.98410       Principal lunar semidiurnal constituent 0.08051140
## 2            2   S2     0.137 216.2 30.00000       Principal solar semidiurnal constituent 0.08333333
