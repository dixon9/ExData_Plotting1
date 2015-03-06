##  Read in data
x <- read.csv2("household_power_consumption.txt", header = TRUE, 
               colClasses = "character", na.strings = c("?"))
x$date2 <- as.Date(strptime(x$Date, "%d/%m/%Y"))
xtime <- x[x$date2 == "2007-02-01" | x$date2 == "2007-02-02", ]
xtime$datetime <- as.POSIXct(paste(xtime$Date, xtime$Time),
                                     format = "%d/%m/%Y %H:%M:%S")
xtime[, 3:9] <- sapply(xtime[, 3:9], as.numeric)
##  Open device--I'm specifying values that are defaults so the options are clear
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(2, 2))
# First panel -- same as Graph 2
with(xtime, plot(x = datetime, y = Global_active_power, type = "n", 
     ylab = "Global Active Power", xlab = ""))
with(xtime, lines(x = datetime, y = Global_active_power))

# Second panel -- 
with(xtime, plot(x = datetime, y = Voltage, type = "n"))
with(xtime, lines(x = datetime, y = Voltage))

# Third panel -- same as Graph 3
with(xtime, plot(x = datetime, y = Sub_metering_1, type = "n",
                 ylab = "Energy sub metering", xlab = ""))
with(xtime, lines(x = datetime, y = Sub_metering_1))
with(xtime, lines(x = datetime, y = Sub_metering_2, col="red"))
with(xtime, lines(x = datetime, y = Sub_metering_3, col="blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Fourth panel -- 
with(xtime, plot(x = datetime, y = Global_reactive_power, type = "n"))
with(xtime, lines(x = datetime, y = Global_reactive_power))

dev.off()  ## Close the PNG device!
