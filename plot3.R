#This is my plot3.R code to create a Energy sub metering Plot
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
focused_data$Sub_metering_1 <- as.numeric(as.character(focused_data$Sub_metering_1))
focused_data$Sub_metering_2 <- as.numeric(as.character(focused_data$Sub_metering_2))
focused_data$Sub_metering_3 <- as.numeric(as.character(focused_data$Sub_metering_3))

##Build timestamp
dateTime <- paste(as.Date(focused_data$Date), focused_data$Time)
focused_data <- transform(focused_data, timestamp=as.POSIXct(dateTime), "%d/%m/%Y %H:%M:%S")

# create plot area
par(mfrow = c(1, 1))

#Plot 3 Energy sub metering
plot(focused_data$timestamp,focused_data$Sub_metering_1, type="l", xlab="",
    ylab="Energy sub metering")

lines(focused_data$timestamp,focused_data$Sub_metering_2, col="red")
lines(focused_data$timestamp,focused_data$Sub_metering_3, col="blue")

legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1), lwd=c(1,1))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
