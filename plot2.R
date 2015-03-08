##  Read in data from working directory
##  Data can be downloaded as a .zip file from: 
##  https://class.coursera.org/exdata-012/human_grading/view/courses/973506/assessments/3/submissions
##  Should be unzipped into local working directory
x <- read.csv2("household_power_consumption.txt", header = TRUE, 
               colClasses = "character", na.strings = c("?"))
x$date2 <- as.Date(strptime(x$Date, "%d/%m/%Y"))
xtime <- x[x$date2 == "2007-02-01" | x$date2 == "2007-02-02", ]
xtime$datetime <- as.POSIXct(paste(xtime$Date, xtime$Time),
                                     format = "%d/%m/%Y %H:%M:%S")
xtime[, 3:9] <- sapply(xtime[, 3:9], as.numeric)

##  Open device--I'm specifying values that are defaults so the options are clear
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
##  Graph2
with(xtime, plot(x = datetime, y = Global_active_power, type = "n",
                 ylab = "", xlab = ""))
with(xtime, lines(x = datetime, y = Global_active_power))
title(ylab = "Global Active Power (kilowatts)")
dev.off()  ## Close the PNG device!
