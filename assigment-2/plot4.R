#data load
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#I need find Across the United States, the emissions from coal combustion-related sources changed from 1999-2008
#I need extract scc code from SCC where coal combustion-related sources, and put in a new variable
# I need ignore the case with T letter, the relation is coal and combine
SCCData <- SCC[grepl("coal",SCC$EI.Sector, ignore.case=T) & grepl("comb",SCC$EI.Sector, ignore.case=T),]$SCC
# i need only the cases that SCC in SCCData over NEI
sumData_final <- NEI[NEI$SCC %in% SCCData,]
#sum emission about the sumData_final
sumData_final_emition <- aggregate(Emissions ~ year, sumData_final, sum)

# use par function for combine plots
par(mfrow=c(1,1))
# create the first plot, with all the data about this plot, about the sum emmition from baltimore 
plot(sumData_final_emition$year, sumData_final_emition$Emissions,pch=19,xlab="YEAR", ylab="Total Emissions", main="Emissions from coal combustion across the US By Masterins")
#connet the point and lines in this plot
lines(sumData_final_emition$year, sumData_final_emition$Emissions, col="navy")

#save the plot in a png file
dev.copy(png,"plot4.png",width=480, height=480)
dev.off()
