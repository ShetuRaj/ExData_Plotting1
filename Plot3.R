library("data.table")

setwd("D:/Data Science")

#Reads in data from file then subsets data for specified dates
energy_consumed <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
energy_consumed[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
energy_consumed[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
energy_consumed <- energy_consumed[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("Plot3.png", width=480, height=480)

# This is Plot 3
plot(energy_consumed[, dateTime], energy_consumed[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(energy_consumed[, dateTime], energy_consumed[, Sub_metering_2],col="red")
lines(energy_consumed[, dateTime], energy_consumed[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
