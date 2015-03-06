library(reshape)

#Read data
power <- read.csv('household_power_consumption.txt', sep=';', na.strings=c('?'))
power$Time <- strptime(paste(power$Date, power$Time), format = "%d/%m/%Y %H:%M:%S")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power <- power[power$Date >= '2007-02-01' & power$Date <= '2007-02-02',]

submeter <- power[,c(2,7,8,9)]
submeter<-melt(submeter, id=c('Time'))

png(filename="plot4.png", width=480, height=480, units='px', bg="white")
par(mfrow=c(2,2))

with(power, plot(Time, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
with(power, plot(Time, Voltage, type="l", ylab="Voltage", xlab="datetime"))

with(submeter, plot(Time, value, type="n"))
lines(submeter[submeter$variable=="Sub_metering_1",1], submeter[submeter$variable=="Sub_metering_1",3], col="black")
lines(submeter[submeter$variable=="Sub_metering_2",1], submeter[submeter$variable=="Sub_metering_2",3], col="red")
lines(submeter[submeter$variable=="Sub_metering_3",1], submeter[submeter$variable=="Sub_metering_3",3], col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black","red","blue"), bty="n")

with(power, plot(Time, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))

dev.off()