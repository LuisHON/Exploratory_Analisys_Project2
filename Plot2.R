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

###### Question 2

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999
# to 2008? Use the base plotting system to make a plot answering this question

# using aggregate base R to sum all values of Emission by Year
total_pm2.5_Balt = aggregate(x = NEI$Emissions, by = list(NEI$year, NEI$fips == "24510"), FUN = sum)
colnames(total_pm2.5_Balt) =c("Year", "Logical","Emissions")

# Filter the unwanted values
total_pm2.5_Balt = total_pm2.5_Balt  %>% 
     select(Year, Emissions)  %>% 
     slice (5:8)

# opening png device for plot
png('plot2.png')

barplot(names.arg = total_pm2.5_Balt$Year,
        
        total_pm2.5_Balt$Emissions,
        xlab = "Years",
        ylab = "Emissions",
        main = "Total Emissions of PM2.5 in Baltimore City over the Years",
        ylim = c(0,3500)
)

# closing the plot device
dev.off()
