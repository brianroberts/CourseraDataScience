#Read data
power <- read.csv('household_power_consumption.txt', sep=';', na.strings=c('?'))
power$Time <- strptime(paste(power$Date, power$Time), format = "%d/%m/%Y %H:%M:%S")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power <- power[power$Date >= '2007-02-01' & power$Date <= '2007-02-02',]

png(filename="plot2.png", width=480, height=480, units='px', bg="white")
with(power, plot(Time, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()