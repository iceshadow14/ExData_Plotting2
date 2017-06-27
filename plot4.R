## plot4.R ##
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

coalSCC <- SCC[grepl('Coal', SCC$Short.Name, fixed=T), ]
coalEMI <- merge(x=EMI, y=coalSCC, by="SCC")

aggCoalEMI <- aggregate(Emissions ~ year, coalEMI, sum)

ggplot(data = aggCoalEMI, aes(x=year, y=Emissions)) + geom_line() + geom_text(aes(label=Emissions), vjust=1)+ geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Emissions (thousands of tons)" ) + ggtitle("Total United States PM2.5 Coal Emissions")

### output png file
dev.copy(png, filename="plot4.png", width=480, height=480)
dev.off ()
