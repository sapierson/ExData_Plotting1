#This is my plot1.R code to create a Global Active Power Plot
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

# create plot area
par(mfrow = c(1, 1))

#Plot 1 Global Active Power (kilowatts)

hist(focused_data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
