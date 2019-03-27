library("data.table")

setwd("D:/Data Science")

#Reads in data from file then subsets data for specified dates
energy_consumed <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
                             )

# Prevents histogram from printing in scientific notation
energy_consumed[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Changes Date Column to Date Class
energy_consumed[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
energy_consumed <- energy_consumed[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## This gives Plot 1
hist(energy_consumed[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
