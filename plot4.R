# Reads electric power raw data assuming text file titled 
# "household_power_consumption.txt" is located in current working directory

atomic <- c("character", "character", "numeric", "numeric", "numeric", 
            "numeric", "numeric", "numeric", "numeric")

epower <- read.table("household_power_consumption.txt", header = TRUE, sep =";",
                     colClasses = atomic, na.strings = "?")

library(plyr)
library(dplyr)

datetime <- paste(epower$Date, epower$Time, sep = " ")
powerdata <- cbind(datetime, epower[, 3:9])
powerdata <- mutate(powerdata, datetime = 
                        as.POSIXct(strptime(datetime, 
                                            format = "%d/%m/%Y %H:%M:%S")))
feb_power <- filter(powerdata, (datetime >= "2007-02-01" & datetime < 
                                    "2007-02-03"))

# Creating png graphics device
png("plot4.png", width = 480, height = 480, units = "px") 

par(mfcol = c(2,2))

plot(feb_power$datetime, feb_power$Global_active_power, ylab = 
         "Global Active Power", xlab = "", type = "n")
lines(feb_power$datetime, feb_power$Global_active_power)

plot(feb_power$datetime, feb_power$Sub_metering_1, xlab = "", 
     ylab = "Energy sub metering", type = "n")
lines(feb_power$datetime, feb_power$Sub_metering_1)
lines(feb_power$datetime, feb_power$Sub_metering_2, col = "red")
lines(feb_power$datetime, feb_power$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")

plot(feb_power$datetime, feb_power$Voltage, ylab = "Voltage", xlab = "datetime",
     type = "n")
lines(feb_power$datetime, feb_power$Voltage)

plot(feb_power$datetime, feb_power$Global_reactive_power, type = "n", 
     ylab = "Global_reactive_power", xlab = "datetime")
lines(feb_power$datetime, feb_power$Global_reactive_power)

dev.off()