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

## make plot 4
png(file = "plot4.png")
par(mfrow = c(2,2))

# plot 1
plot(power.f$DateTime, power.f$Global_active_power, type = "n", xlab="",
     ylab="Global Active Power")
lines(power.f$DateTime, power.f$Global_active_power)

# plot 2
plot(power.f$DateTime, power.f$Voltage, type = "n", xlab = "datetime",
     ylab = "Voltage")
lines(power.f$DateTime, power.f$Voltage)

# plot 3
plot(power.f$DateTime, power.f$Sub_metering_1, type = "n", xlab="",
     ylab = "Energy sub metering")
lines(power.f$DateTime, power.f$Sub_metering_1)
lines(power.f$DateTime, power.f$Sub_metering_2, col = "red")
lines(power.f$DateTime, power.f$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

# plot 4
plot(power.f$DateTime, power.f$Global_reactive_power, type = "n", 
     xlab = "datetime", ylab = "Global_reactive_power")
lines(power.f$DateTime, power.f$Global_reactive_power)

dev.off()
