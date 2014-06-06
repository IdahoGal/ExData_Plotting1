## Assignment 1
## Data Set:    UC Irvine MLR: Electric Power Consumption
## Description: Measurements of electric power consumption in one
##              household with one-minute sampling rate over 4 years.
## Variable descriptions: 
##    https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
## Goal:   Plot to examine household energy from 2/1/2007 - 2/2/2007
## Ref:  For dates: http://stackoverflow.com/questions/24006475/subsetting-data-based-on-a-date-range-in-r/24007871#2400

# Set working, data directory
setwd("C:/Admin/Coursera/Exploratory Data Analysis")

## Read data into R.  This function is much slower than fread but it 
## handles the missing character string (?) properly. 
myOrigData <- read.table("./data/household_power_consumption.txt", sep = ';', header=TRUE, 
		na.strings="?", stringsAsFactors=FALSE)

## Did the data read in correctly?
head(myOrigData)
nrow(myOrigData)

## Subset the data for the date range we are interested in,
## keep in mind the format of the current field: D/M/Y  
myData <- subset(myOrigData, (myOrigData$Date == "1/2/2007" | myOrigData$Date == "2/2/2007"), drop = TRUE)

## verify row count: 2,880 rows.
nrow(myData)   

## Remove original data set from work space because it is so large
rm(myOrigData)

## Convert the date field from character to date class.  Format needs  
## to describe the current format.  
myData$Date <- as.Date(myData$Date, format = "%d/%m/%Y" )

## Verify Date is now a date object
str(myData$Date)

## Combine the Date & Time fields into a new variable called DateTime  
myData$DateTime <- strptime(paste(myData$Date, myData$Time), format = "%Y-%m-%d %H:%M:%S")

# Verify the data type (Poxixlt) and the format: YYYY-DD-MM
str(myData$DateTime)

## Plot 4: Multiple graphs to single plot  

## Output to a PNG file
png("plot4.png", width=480, height=480)   

# 4 graphs on one page  
par(mfrow=c(2,2))

## 1st Graph
plot(myData$DateTime, myData$Global_active_power, type="l",
	xlab = "", ylab="Global Active Power" )

## 2nd Graph
plot(myData$DateTime, myData$Voltage, type="l",
	xlab = "datetime", ylab = "Voltage")

## 3rd Graph
xrange <- range(myData$DateTime)
# For the y axis, calculate the range from 0 to max value of the 3 variables
yrange <- range(0, myData$Sub_metering_1, myData$Sub_metering_2, myData$Sub_metering_3)

plot(xrange, yrange, type="n",
	xlab = "", ylab="Energy sub metering")  
# Add lines and legend in separately
lines(myData$DateTime, myData$Sub_metering_1, type="l",col="black")
lines(myData$DateTime, myData$Sub_metering_2, type="l",col="red")
lines(myData$DateTime, myData$Sub_metering_3, type="l",col="blue")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),
		col=c("black","red", "blue"), lty=1, bty="n")

## 4th Graph
plot(myData$DateTime, myData$Global_reactive_power, type="l",
	xlab = "datetime", ylab = "Global_reactive_power")

## Close device file
dev.off()


