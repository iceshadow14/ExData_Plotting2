library(plyr)
library(ggplot2)

### Load Data ###
if(!file.exists("Data.zip")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL, "Data.zip")
  unzip("Data.zip")
}

### Read Data ###
EMI <- readRDS(file = "summarySCC_PM25.rds")
SCC <- readRDS(file = "Source_Classification_Code.rds")

motorSCC <- SCC[grepl('vehicle', SCC$SCC.Level.Two, ignore.case=T), ]
motorEMI <- merge(x=EMI, y=motorSCC, by="SCC")
motorBalEMI <- subset(motorEMI, motorEMI$fips=="24510" )
motorLAEMI <-  subset(motorEMI, motorEMI$fips=="06037")
motorBalEMI$city <- "Baltimore"
motorLAEMI$city <- "Los Angeles"
motorBalAndLAEMI <- rbind(motorBalEMI, motorLAEMI)

aggMotorBalAndLAEMI <- aggregate(Emissions ~ year+city, motorBalAndLAEMI, sum)

ggplot(aggMotorBalAndLAEMI, aes(year, Emissions, color = city)) +
  geom_line() + xlab("Year") + ylab(expression("Total PM2.5 Emissions")) + 
  ggtitle("Total Emissions from motor vehicle in Baltimore and Los Angeles")

### output png file
dev.copy(png, filename="plot6.png", width=480, height=480)
dev.off ()
