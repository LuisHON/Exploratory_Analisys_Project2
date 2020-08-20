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

###### Question 3


# Of the four types of sources indicated by the (point, nonpoint, onroad, nonroad) variable, which of
# these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have
# seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this
# question.

total_pm2.5_BaltType = aggregate(x = NEI$Emissions, by = list(NEI$year, NEI$fips == "24510", NEI$type), FUN = sum)
colnames(total_pm2.5_BaltType) =c("Year", "Logical","Type", "Emissions")

total_pm2.5_BaltType = total_pm2.5_BaltType %>% 
     filter(Logical == TRUE) %>%
     select(Year, Type, Emissions)

# opening png device for plot
png('plot3.png')

# Quickplot function from ggplot2 library
qplot(as.factor(Year),
      data=total_pm2.5_BaltType, 
      geom="bar", weight=Emissions, 
      facets=.~Type, 
      fill=Year, 
      main='Total Emissions of PM2.5 in Baltimore City per year and type', 
      xlab='Years', 
      ylab = 'Emissions'
      
)

# closing the plot device
dev.off()
