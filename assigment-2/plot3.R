#libraries load, remember install if you dont have libraries
library("plyr")
library("ggplot2")

#load data
NEI <- readRDS("summarySCC_PM25.rds")

#I need to columns, one is the year and another ir emissions
yearCols = c("type","year")
sumCols = c("Emissions")

# create the first plot, with all the data about this plot, about the sum emmition from baltimore 
# but in this summatory, add the year
sumData_year <- ddply(NEI[NEI$fips=='24510',], yearCols, function(x) colSums(x[sumCols]))

# use par function for combine plots 
par(mfrow=c(1,1))

# create the first ggplot, with all the data about this ggplot, about the sum emmition and year from baltimore
#connect the point and lines in this ggplot form different types: non-road, nonpoint, on-road, point
g <- ggplot(data=sumData_year, aes(x=year, y=Emissions, group = factor(type), colour = type))
# first the title of ggplot
g <- g + ggtitle("Change of Emissions by Type Baltimore City by masterins ") + xlab("YEAR") + ylab("Emissions by Type") 
#create line that connect geom_line
g <- g + geom_line(size=0.1)
#create point by year
g <- g + geom_point(size=1, shape=21, fill="white")
g <- g + theme(text = element_text(size=4)) 

#save the ggplot in a png file
ggsave(filename="plot3.png", width=4, height=3)
dev.off()
