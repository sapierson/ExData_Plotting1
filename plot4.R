#This is my plot4.R code to create:
# Global Active Power, Voltage, Energy sub metering Plot, Global_reactive_power plots
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
focused_data$Global_reactive_power <- as.numeric(as.character(focused_data$Global_reactive_power))
focused_data$Voltage <- as.numeric(as.character(focused_data$Voltage))
focused_data$Sub_metering_1 <- as.numeric(as.character(focused_data$Sub_metering_1))
focused_data$Sub_metering_2 <- as.numeric(as.character(focused_data$Sub_metering_2))
focused_data$Sub_metering_3 <- as.numeric(as.character(focused_data$Sub_metering_3))

##Build timestamp
dateTime <- paste(as.Date(focused_data$Date), focused_data$Time)
focused_data <- transform(focused_data, timestamp=as.POSIXct(dateTime), "%d/%m/%Y %H:%M:%S")

# create plot area
par(mfrow = c(2, 2))

#Global Active Power Plot
plot(focused_data$timestamp,focused_data$Global_active_power, type="l", xlab="",
     ylab="Global Active Power (kilowatts)")

#Voltage Plot
plot(focused_data$timestamp,focused_data$Voltage, type="l", xlab="datetime",
     ylab="Voltage")

#Energy sub metering plot
plot(focused_data$timestamp,focused_data$Sub_metering_1, type="l", xlab="",
    ylab="Energy sub metering")

lines(focused_data$timestamp,focused_data$Sub_metering_2, col="red")
lines(focused_data$timestamp,focused_data$Sub_metering_3, col="blue")

legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1), lwd=c(1,1))

#Voltage Plot
plot(focused_data$timestamp,focused_data$Global_reactive_power, type="l", xlab="datetime",
     ylab="Global_reactive_power")

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
