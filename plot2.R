## load packages
library(lubridate)

## read in data
power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                    na.strings = "?", colClasses = c("factor", "factor",
                                                     "numeric", "numeric", 
                                                     "numeric", "numeric", 
                                                     "numeric", "numeric", 
                                                     "numeric"))

## convert Date to Date class, subset on relevant dates, and remove original
## large dataset from memory
power$Date <- dmy(power$Date)
power.f <- power[power$Date == ymd("2007-02-01") | power$Date == ymd("2007-02-02"),]
rm(power)

## merge date and time and convert to Date/Time class, remove original columns
power.f$DateTime <- ymd_hms(paste(power.f$Date, power.f$Time))
power.f <- power.f[,3:10]

## make plot 2
png(file = "plot2.png")
plot(power.f$DateTime, power.f$Global_active_power, type = "n", xlab="",
     ylab = "Global Active Power (kilowatts)")
lines(power.f$DateTime, power.f$Global_active_power)
dev.off()