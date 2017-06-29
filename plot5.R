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
motorBalEMI <- subset(motorEMI, motorEMI$fips=="24510")

aggMotorBalEMI <- aggregate(Emissions ~ year, motorBalEMI, sum)

ggplot(data = aggMotorBalEMI, aes(x=year, y=Emissions)) + 
  geom_line() + geom_text(aes(label=Emissions), vjust=-2) + geom_point( size=4, shape=21, fill="white") + 
  xlab("Year") + ylab("Emissions (thousands of tons)" ) + ggtitle("Baltimore Emissions from motor vehicle")

# output png file
dev.copy(png, filename="plot5.png", width=480, height=480)
dev.off ()
