library(data.table)
data<-fread("household_power_consumption.txt", sep=";", na.strings="?")
smallset<-data[data$Date == "2/2/2007" | data$Date == "1/2/2007",]
smallset[,newDate:=paste(Date,Time,sep=" ")]
smallset[,newDateTime:=as.POSIXct(strptime(newDate, "%d/%m/%Y %H:%M:%S"))]

plot(smallset$newDateTime,as.numeric(smallset$Global_active_power),type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off()