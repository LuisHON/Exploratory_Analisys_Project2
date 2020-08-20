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

###### Question 5

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(dplyr)
library(ggplot2)

# using aggregate base R to sum all values of Motor vehicle sources Emission by Year
Emission_Vehicle_Balt = aggregate(x = NEI$Emissions, by = list(NEI$year, NEI$fips == "24510", NEI$type == "ON-ROAD"), FUN = sum)
colnames(Emission_Vehicle_Balt) =c("Year", "Logical_1","Logical_2", "Emissions")

# organizing the dataset and filter unwanted values
Emission_Vehicle_Balt = Emission_Vehicle_Balt %>% 
     filter(Logical_1 == TRUE & Logical_2 == TRUE) %>%
     select(Year, Emissions)

# opening png device for plot
png('plot5.png')

# Quickplot function from ggplot2 library
qplot(
     as.factor(Year),
     data=Emission_Vehicle_Balt, 
     geom="bar", 
     weight=Emissions, 
     fill=Year, 
     main='Motor vehicle emissions changes from 1999 - 2008', 
     xlab='Years', 
     ylab = 'Emissions'
)

# closing the plot device
dev.off()
