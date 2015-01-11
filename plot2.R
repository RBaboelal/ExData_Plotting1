library(data.table)
data<-fread("household_power_consumption.txt", sep=";", na.strings="?") ## READ LARGE FILE
smallset<-data[data$Date == "2/2/2007" | data$Date == "1/2/2007",] ## SUBSET THE TWO DATES
smallset[,newDate:=paste(Date,Time,sep=" ")] ## CONCATENATE THE DATE AND TIME STRINGS
smallset[,newDateTime:=as.POSIXct(strptime(newDate, "%d/%m/%Y %H:%M:%S"))] ## CONVERT TO ACTUAL DATE/TIME

## CREATE CHART
plot(smallset$newDateTime,as.numeric(smallset$Global_active_power),type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off()