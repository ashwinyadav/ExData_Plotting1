library(data.table)
library(dplyr)

## Load the data from the file 
## Ensure file named 'household_power_consumption.txt' exists in the working directory

## reads only data for Feb 1, 2 2007 - number of rows = 1 reading per minute for 48 hours
plotData <- fread("household_power_consumption.txt", sep = ";", skip = "1/2/2007", nrows = 2880, na.strings = "?", col.names = colnames(read.table("household_power_consumption.txt", sep = ";", nrow = 1, header = TRUE)))

## convert data and time field format
plotData$Time <- paste(plotData$Date, plotData$Time, sep = " ")
plotData$Date <- as.Date(plotData$Date, format = "%d/%m/%Y")
plotData$Time <- as.POSIXct(plotData$Time, format = "%d/%m/%Y %H:%M:%S")

## plot Energy Sub Metering 1,2 and 3 by Day on screen
with(plotData, plot(x = Time, y = Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l"))
with(plotData, points(x = Time, y = Sub_metering_2, type = "l", col = "red"))
with(plotData, points(x = Time, y = Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), x.intersp = 0.8)

## save PNG file
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

     