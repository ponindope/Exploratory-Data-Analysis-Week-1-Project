# Script is run inside my working directory where household_power_consumption.txt is located

# Load data.table package
library("data.table")

# Read data from household_power_consumption.txt
dt_hh_powercon <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Prevents scientific notation
dt_hh_powercon[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Convert Date Column to POSIXct class (to be use as range on next line)
dt_hh_powercon[, POSdate := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter to use only data from dates 2007-02-01 and 2007-02-02
dt_hh_powercon <- dt_hh_powercon[(POSdate >= "2007-02-01") & (POSdate < "2007-02-03")]

# Initialize construction of the plot and save it to plot4.png file 
# with a width of 480 pixels and a height of 480 pixels
png("plot4.png", width=480, height=480)

# Initialize: Split plot screen 2 rows and 2 columns
par(mfrow=c(2,2))

#************************************************************************
# Specs: Plot 1 (row 1, column 1) 
#************************************************************************

# Main Label   : None
# x axis Label : None
# y axis Label : Global Active Power
# type         : Lines
plot(dt_hh_powercon[, POSdate],
     dt_hh_powercon[, Global_active_power],
     type="l", xlab="", ylab="Global Active Power")

#************************************************************************
# Specs: Plot 2 (row 1, column 2) 
#************************************************************************

# Main Label   : None
# x axis Label : datetime
# y axis Label : Voltage
# type         : Lines
plot(dt_hh_powercon[, POSdate],
     dt_hh_powercon[, Voltage],
     type="l", xlab="datetime", ylab="Voltage")

#************************************************************************
# Specs: Plot 3 (row 2, column 1) 
#************************************************************************

# Main Label   : None
# x axis Label : None
# y axis Label : Energy sub metering
# type         : Lines
plot(dt_hh_powercon[, POSdate],
     dt_hh_powercon[, Sub_metering_1],
     type="l", xlab="", ylab="Energy sub metering")

# Color Sub_metering_2 line with red
lines(dt_hh_powercon[, POSdate], dt_hh_powercon[, Sub_metering_2], col="red")

# Color Sub_metering_3 line with blue
lines(dt_hh_powercon[, POSdate], dt_hh_powercon[, Sub_metering_3], col="blue")

# Put some legends on the top right of the plot
# Line type = 1 , Box Type = 'n' , Character expansion factor = 0.5
legend("topright",
       col=c("black","red","blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), bty="n", cex=.5)

#************************************************************************
# Specs: Plot 4 (row 2, column 2) 
#************************************************************************

# Main Label   : None
# x axis Label : datetime
# y axis Label : Global_reactive_power
# type         : Lines
plot(dt_hh_powercon[, POSdate],
     dt_hh_powercon[,Global_reactive_power],
     type="l", xlab="datetime", ylab="Global_reactive_power")

# Finally, close the png file using the dev.off function
dev.off()