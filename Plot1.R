# # download de dataset

# file address
Arquivo = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# using method = "curl" because https gets error without.
download.file(url = Arquivo, destfile = 'Data_for_Peer_Assessment.zip', method = "curl")

# unzip the files
unzip('Data_for_Peer_Assessment.zip')

# reading the files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# loading the libraries
library(dplyr)
library(ggplot2)

###### Question 1

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using
# the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the
# years 1999, 2002, 2005, and 2008.

# using aggregate base R to sum all values of Emission by Year
total_pm2.5 = aggregate(x = NEI$Emissions, by = list(NEI$year), FUN = sum)
colnames(total_pm2.5) =c("Year","Emissions")

# opening png device for plot
png('plot1.png')

barplot(names.arg = total_pm2.5$Year,
        total_pm2.5$Emissions/1000000,
        xlab = "Years",
        ylab = "Emissions (tons)",
        main = "Total PM2.5 over the Years",
        ylim = c(0,8)
)

# closing the plot device
dev.off()
