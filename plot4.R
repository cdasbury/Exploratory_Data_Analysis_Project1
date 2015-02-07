###  Course Project 1 - Exploratory Data Analysis: Plot 4
### This code reads in data,makes the required plots, and saves the plots to a file.  Details follow.

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

####  Efficent code for four plots on one screen
par(mfrow=c(2,2), mar=c(4,4,2,1),cex.lab=.75)
with (x, {
  plot(Datetime,Global_active_power, type="l",ylab="Global Active Power",
       xlab="", col="black")
  plot(Datetime,Voltage, type="l")
  plot(Datetime,Sub_metering_1, type="l",ylab="Energy sub-metering", xlab="",col="black")
  lines(Datetime,Sub_metering_2,col="red")
  lines(Datetime,Sub_metering_3, col="blue")
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), pt.cex=1, cex=.5,lwd=2, bty= "n",col=c("black","red","blue"),lty=1)
  plot(Global_reactive_power~Datetime, type="l")
})

## Saving to file "plot4.png"
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

