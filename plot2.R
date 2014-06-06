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

## Plot 2 Line graph

## Output to a PNG file
png("plot1.png", width=480, height=480)   

plot(myData$DateTime, myData$Global_active_power, type="l",
	xlab = "", ylab="Global Active Power (kilowatts)" )

## Close device file
dev.off()


