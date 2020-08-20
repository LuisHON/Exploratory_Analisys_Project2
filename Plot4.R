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

###### Question 4

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999 - 2008?

# Find emissions from coal combustion-related sources
Coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
Comb.coal.sources <- SCC[Coal,]
Emissions_Coal_Comb <- NEI[(NEI$SCC %in% Comb.coal.sources$SCC), ]

# using aggregate base R to sum all values of Coal Combustion Emission by Year
Relatead = aggregate(x = Emissions_Coal_Comb$Emissions, by = list(Emissions_Coal_Comb$year), FUN = sum)
colnames(Relatead) =c("Year", "Emissions")

# opening png device for plot
png('plot4.png')

# Quickplot function from ggplot2 library
qplot(
     as.factor(Year),
     data=Relatead, 
     geom="bar", 
     weight=Emissions, 
     fill=Year, 
     main='Coal Combustion-related emissions changes from 1999 - 2008', 
     xlab='Years', 
     ylab = 'Emissions'
)

# closing the plot device
dev.off()
