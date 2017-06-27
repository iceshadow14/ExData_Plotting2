library(plyr)

### Load Data ###
if(!file.exists("Data.zip")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL, "Data.zip")
  unzip("Data.zip")
}

### Read Data ###
EMI <- readRDS(file = "summarySCC_PM25.rds")
SCC <- readRDS(file = "Source_Classification_Code.rds")

# plot(summarySCC_PM25$Emissions, summarySCC_PM25$year)
aggEMI <- aggregate(Emissions ~ year, EMI, sum)

barplot(aggEMI$Emissions, names.arg = aggEMI$year, xlab = "Year", ylab = "Emissions", main = "Total emissions per year")

### The answer is YES
dev.copy(png, filename="plot1.png", width=480, height=480)
dev.off ()
