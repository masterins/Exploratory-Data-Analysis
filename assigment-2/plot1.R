#load data
NEI <- readRDS("summarySCC_PM25.rds")

#sum emission by year
sumData_year <- aggregate(Emissions ~ year , NEI, FUN=sum)
# use par function for combine plots 
par(mfrow=c(1,1))
# create the first plot, with all the data about this plot, about the sum emmition 
plot(sumData_year$year, sumData_year$Emissions,pch=19,xlab="YEAR", ylab="Total Emissions PM 2,5", main="Total Emissions from USA By Masterins")
#connet the point and lines in this plot
lines(sumData_year$year, sumData_year$Emissions, col="navy")
#save the plot in a png file
dev.copy(png,"plot1.png",width=480, height=480)
dev.off()
