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

## plot histogram of Global Active Power
par(bg = "white")
with(plotData, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

## save PNG file
dev.copy(png, file = "plot1.png", width = 480, height = 480, bg = "white")
dev.off()
