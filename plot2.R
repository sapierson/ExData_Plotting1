#This is my plot2.R code to create a Global Active Power (Kilowatts over time) Plot
#
#
##Read full data file
power_data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";")

##Format Dates
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

##Select only data we care about and remove power_data to free up memory
focused_data <- power_data[(power_data$Date=="2007-02-01") | (power_data$Date=="2007-02-02"),]
rm(power_data)

##Remove NA's
focused_data$Global_active_power <- as.numeric(as.character(focused_data$Global_active_power))

##Build timestamp
dateTime <- paste(as.Date(focused_data$Date), focused_data$Time)
focused_data <- transform(focused_data, timestamp=as.POSIXct(dateTime), "%d/%m/%Y %H:%M:%S")

# create plot area
par(mfrow = c(1, 1))

#Plot 2
plot(focused_data$timestamp,focused_data$Global_active_power, type="l", xlab="",
    ylab="Global Active Power (kilowatts)")

## Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
