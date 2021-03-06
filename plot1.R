###  This code reads in data,makes a histogram, and saves the histogram to a file.  Details follow.

## Read in data for February 1-2 from the household_power_consumption data set and assign column names.
##     Data is skipped over until the "greb" finds the beginning of the series desired.
##     nrows is (2days x 24 hours/day x 60 minutes/hour)=2880 less 1 for greb accuracy.
x <- read.table("household_power_consumption.txt", header=F, sep=";", na.strings="?",
                skip=grep("1/2/2007", readLines(file(description="household_power_consumption.txt",open="r")),fixed =TRUE),
                , nrows=2879)
colnames(x) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                 "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

##  Converts the date to a date-time series of type chron called Datetime
x$Date <- as.Date(x$Date,format="%d/%m/%Y")
datetime <- paste(as.Date(x$Date), x$Time)
x$Datetime <- as.POSIXct(datetime)

## plot a histogram of Global_active_power over frequency 
hist(x$Global_active_power, main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file "plot1.png"
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
