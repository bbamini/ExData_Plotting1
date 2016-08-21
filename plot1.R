# Reads electric power raw data assuming text file titled 
# "household_power_consumption.txt" is located in current working directory

atomic <- c("character", "character", "numeric", "numeric", "numeric", 
            "numeric", "numeric", "numeric", "numeric")

epower <- read.table("household_power_consumption.txt", header = TRUE, sep =";",
                     colClasses = atomic, na.strings = "?")

library(dplyr)

epower <- mutate(epower, Date = as.Date(Date, format = "%d/%m/%Y"))
feb_power <- filter(epower, (Date == "2007-02-01" | Date == "2007-02-02"))

# Creating png graphics device
png("plot1.png", width = 480, height = 480, units = "px") 
hist(feb_power$Global_active_power, main = "Global Active Power", 
     col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()