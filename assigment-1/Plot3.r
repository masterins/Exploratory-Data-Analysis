#clean the variables
rm(list=ls())
#use the read.table function parameters are: 
#the first parameter is the file name separator after each data, in this case it is ";" 
#utilliza header is the parameter for the first renglo is a header and as the assignment says we must put null values or a symbol na?
rawdata<- read.table("household_power_consumption.txt", sep=";", header=TRUE, quote= "", strip.white=TRUE, stringsAsFactors = FALSE, na.strings= "?")


# already have data stored in varying rawdata 
#We will subdivide the data by a date range and comprises 1.2.2007 to 02.02.2007 
data<- subset(rawdata, (rawdata$Date == "1/2/2007" | rawdata$Date== "2/2/2007")) 


# household_power_consumption within the file must format the date field and the format is% d% m% Y, ie day, month, year
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")


# but now need add the time in the data and create a new column, this colum called Time
data$Time <- as.POSIXct(paste(data$Date, data$Time))


# as the data is ready now create the graph
# activate the function to create the png file here plo3.png, with the characteristics of width and height of 480
png("plot3.png", width = 480, height = 480)
# now the char new more data, this is the time, sub_metering_1, sub_metering_2, sub_metering_3
plot(data$Time, data$Sub_metering_1, type="l", ylab= "Energy sub metering by masterins", xlab="")
lines(data$Time, data$Sub_metering_2, type="l", col="red")
lines(data$Time, data$Sub_metering_3, type="l", col="blue")
# this is the label with the colors
legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), lty=1, col=c("black", "red", "blue"))

# the dev.off function, the graph is saved in the file 
dev.off()
