# Reads electric power raw data assuming text file titled 
# "household_power_consumption.txt" is located in current working directory

atomic <- c("character", "character", "numeric", "numeric", "numeric", 
            "numeric", "numeric", "numeric", "numeric")

epower <- read.table("household_power_consumption.txt", header = TRUE, sep =";",
                     colClasses = atomic, na.strings = "?")

library(plyr)
library(dplyr)

Date_Time <- paste(epower$Date, epower$Time, sep = " ")
powerdata <- cbind(Date_Time, epower[, 3:9])
powerdata <- mutate(powerdata, Date_Time = 
                         as.POSIXct(strptime(Date_Time, 
                                             format = "%d/%m/%Y %H:%M:%S")))
feb_power <- filter(powerdata, (Date_Time >= "2007-02-01" & Date_Time < 
                                 "2007-02-03"))

# Creating png graphics device
png("plot2.png", width = 480, height = 480, units = "px") 

plot(feb_power$Date_Time, feb_power$Global_active_power, ylab = 
"Global Active Power (kilowatts)", xlab = "", type = "n")
lines(feb_power$Date_Time, feb_power$Global_active_power)
dev.off()