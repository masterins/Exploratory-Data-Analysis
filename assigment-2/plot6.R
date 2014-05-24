#data load
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#I need extract scc code from SCC where coal combustion-related mobile, and put in a new variable
#I need ignore the case with T letter, the relation is mobile and vehicles
SCCDATA <- SCC[grepl("mobile",SCC$EI.Sector,ignore.case=T) & grepl("vehicles",SCC$EI.Sector,ignore.case=T) ,]$SCC

# i need only the cases that SCC in SCCData over NEI and filter by 24510 and 0637 of baltimore and Angeles County
sumData_final <- NEI[(NEI$SCC %in% SCCDATA & (NEI$fips=="24510" | NEI$fips=="06037") ),]

#I need to columns, one is the year by fips and another ir emissions
fipsCols = c("fips","year")
emission = c("Emissions")

# i need only combine the results the subset of data frame
sumData_final <- ddply(sumData_final, fipsCols, function(x) colSums(x[emission]))
# I need  a vector with the label 
sumData_final$fips <- factor(sumData_final$fips,labels=c("Los Angeles ","Baltimore City"))

# use par function for combine plots 
par(mfrow=c(1,1))

# create the first ggplot, with all the data about this ggplot, about the sum emmition and year from baltimore
#connect the point and lines in this ggplot form different flips
g <- ggplot(data=sumData_final, aes(x=year, y=Emissions, group = fips, colour = fips))
# first the title of ggplot
g <- g + ggtitle("Compare emissions from motor vehicle  Baltimore vs. LA  By Masterins") + xlab("YEAR") + ylab("Emissions by Fips") 
#create line that connect geom_line
g <- g + geom_line(size=0.1)
#create point by year
g <- g + geom_point(size=1, shape=21, fill="white")
g <- g + theme(text = element_text(size=4)) 

#save the plot in a png file
ggsave(filename="plot6.png", width=4, height=3)
dev.off()
