library(data.table)
data<-fread("household_power_consumption.txt", sep=";", na.strings="?") ## READ LARGE FILE
smallset<-data[data$Date == "2/2/2007" | data$Date == "1/2/2007",] ## SUBSET THE TWO DATES
smallset[,newDate:=paste(Date,Time,sep=" ")] ## CONCATENATE THE DATE AND TIME STRINGS
smallset[,newDateTime:=as.POSIXct(strptime(newDate, "%d/%m/%Y %H:%M:%S"))] ## CONVERT TO ACTUAL DATE/TIME

## CREATE CHART
hist(as.numeric(smallset$Global_active_power), breaks=12, main="Global Active Power", xlab="Global Active Power (kilowatts) ", ylab="Frequency", col="red")
dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off()
