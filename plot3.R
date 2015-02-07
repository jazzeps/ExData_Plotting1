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

## make plot 3
png(file = "plot3.png")
plot(power.f$DateTime, power.f$Sub_metering_1, type = "n", xlab="",
     ylab = "Energy sub metering")
lines(power.f$DateTime, power.f$Sub_metering_1)
lines(power.f$DateTime, power.f$Sub_metering_2, col = "red")
lines(power.f$DateTime, power.f$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()