
# Script is run inside my working directory where household_power_consumption.txt is located

# Load data.table package
library("data.table")

# Read data from household_power_consumption.txt
dt_hh_powercon <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Prevents histogram from printing in scientific notation
dt_hh_powercon[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Convert Date Column to Date Type (to be use as range on next line)
dt_hh_powercon[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter to use only data from dates 2007-02-01 and 2007-02-02
dt_hh_powercon <- dt_hh_powercon[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Initialize construction of the plot and save it to plot1.png file 
# with a width of 480 pixels and a height of 480 pixels
png("plot1.png", width=480, height=480)

# Complete hist plot with the following specs:
# Main Label   : Global Active Power
# x axis Label : Global Active Power (kilowatts)
# y axis Label : Frequency
# Color        : Red
hist(dt_hh_powercon[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Finally, close the png file using the dev.off function
dev.off()
