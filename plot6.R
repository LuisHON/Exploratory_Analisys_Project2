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

###### Question 6

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle
# sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over
# time in motor vehicle emissions?


# Baltimore
# using aggregate base R to sum all values of Motor vehicle sources Emission by Year
Emission_Vehicle_Balt = aggregate(x = NEI$Emissions, by = list(NEI$year, NEI$fips == "24510", NEI$type == "ON-ROAD"), FUN = sum)
colnames(Emission_Vehicle_Balt) =c("Year", "Logical_1","Logical_2", "Emissions")

# organizing the dataset and filter unwanted values
Emission_Vehicle_Balt = Emission_Vehicle_Balt %>% 
     filter(Logical_1 == TRUE & Logical_2 == TRUE) %>%
     select(Year, Emissions)

# Add a County column
Emission_Vehicle_Balt = mutate(Emission_Vehicle_Balt, City = "Baltimore City, MD")


# Los Angeles
# using aggregate base R to sum all values of Motor vehicle sources Emission by Year
Emission_Vehicle_LA = aggregate(x = NEI$Emissions, by = list(NEI$year, NEI$fips == "06037", NEI$type == "ON-ROAD"), FUN = sum)
colnames(Emission_Vehicle_LA) =c("Year", "Logical_1","Logical_2", "Emissions")

# organizing the dataset and filter unwanted values
Emission_Vehicle_LA = Emission_Vehicle_LA %>% 
     filter(Logical_1 == TRUE & Logical_2 == TRUE) %>%
     select(Year, Emissions)

# Add a County column
Emission_Vehicle_LA = mutate(Emission_Vehicle_LA, City = "Los Angeles County, CA")

# merging the both datasets by rows
Answer = rbind(Emission_Vehicle_Balt, Emission_Vehicle_LA)

# opening png device for plot
png('plot6.png')

# Quickplot function from ggplot2 library
qplot(
     as.factor(Year),
     data=Answer, 
     geom="bar", 
     weight=Emissions,
     facets = .~City,
     fill = City,
     main = 'Motor vehicle emissions: Batimore x Los Angeles from 1999 - 2008', 
     xlab='Years', 
     ylab = 'Emissions',
     ylim = c(0,5000)
)

# closing the plot device
dev.off()
