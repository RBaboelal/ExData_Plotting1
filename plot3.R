library(data.table)
data<-fread("household_power_consumption.txt", sep=";", na.strings="?") ## READ LARGE FILE
smallset<-data[data$Date == "2/2/2007" | data$Date == "1/2/2007",] ## SUBSET THE TWO DATES
smallset[,newDate:=paste(Date,Time,sep=" ")] ## CONCATENATE THE DATE AND TIME STRINGS
smallset[,newDateTime:=as.POSIXct(strptime(newDate, "%d/%m/%Y %H:%M:%S"))] ## CONVERT TO ACTUAL DATE/TIME

## CREATE CHART
plot(smallset$newDateTime,as.numeric(smallset$Sub_metering_1),col = "black",type = "l",ylab="Energy sub metering",xlab="",cex=0.75)
lines(smallset$newDateTime,as.numeric(smallset$Sub_metering_2),col = "red",type = "l")
lines(smallset$newDateTime,as.numeric(smallset$Sub_metering_3),col = "blue",type = "l")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),text.width = strwidth("1,000,000,00"),
lty = 1, xjust = 1, yjust = 1, col=c("black","red","blue"),pt.cex = 0.75,cex=0.75)

dev.copy(png, file = "plot3.png") 
dev.off()