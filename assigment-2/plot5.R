#data load
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#I need findemissions from motor vehicle sources changed from 1999-2008 in Baltimore City
#I need extract scc code from SCC where coal combustion-related mobile, and put in a new variable
#I need ignore the case with T letter, the relation is mobile and vehicles
SCCData <- SCC[grepl("mobile",SCC$EI.Sector,ignore.case=T) & grepl("vehicles",SCC$EI.Sector,ignore.case=T) ,]$SCC

# i need only the cases that SCC in SCCData over NEI and filter by 24510 of baltimore
sumData_final <- NEI[(NEI$SCC %in% SCCData & NEI$fips=="24510"),]
#sum emission about the sumData_final
sumData_final_emition <- aggregate(Emissions ~ year, sumData_final, sum)

# use par function for combine plots
par(mfrow=c(1,1))
# create the first plot, with all the data about this plot, about the sum emmition from baltimore 
plot(sumData_final_emition$year, sumData_final_emition$Emissions,pch=19,xlab="YEAR", ylab="Total Emissions", main="Emissions from motor vehicle sources in Baltimore City By Masterins")
#connet the point and lines in this plot
lines(sumData_final_emition$year, sumData_final_emition$Emissions, col="navy")

#save the plot in a png file
dev.copy(png,"plot5.png",width=580, height=580)
dev.off()
