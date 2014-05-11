###
### DATA LOAD ###

#setwd("/Users/paul/Documents/Coursera/04_Exploratory Data Analysis/hw/peer_assessment_01/")

pcons_data <- read.table(file="household_power_consumption.txt", header=TRUE, sep=';', stringsAsFactors=FALSE)

# verify the correctness of the import
str(pcons_data)

# create timestamp column
pcons_data$TimeStamp <- as.POSIXct(
    apply(pcons_data[,c("Date", "Time")], 1,
          function(x) paste(x, collapse=' ')),
    format='%d/%m/%Y %H:%M:%S')

# keep only data for the selected days
pcons_data <- pcons_data[(pcons_data$TimeStamp >= as.POSIXct("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S"))
                         & (pcons_data$TimeStamp < as.POSIXct("03/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S")),]

# remove unused columns
pcons_data <- pcons_data[,!(names(pcons_data) %in% c("Date","Time"))]

# convert numeric columns
pcons_data$Global_active_power <- as.numeric(pcons_data$Global_active_power)
pcons_data$Global_reactive_power <- as.numeric(pcons_data$Global_reactive_power)
pcons_data$Global_intensity <- as.numeric(pcons_data$Global_intensity)
pcons_data$Voltage <- as.numeric(pcons_data$Voltage)
pcons_data$Sub_metering_1 <- as.numeric(pcons_data$Sub_metering_1)
pcons_data$Sub_metering_2 <- as.numeric(pcons_data$Sub_metering_2)
pcons_data$Sub_metering_3 <- as.numeric(pcons_data$Sub_metering_3)

# verifiy cleaning
str(pcons_data)


# FIRST PLOT
hist(x=pcons_data$Global_active_power,
     xlab="Global Active Power (kilowatts)",
     col="red",
     main="Global Active Power")

# SECOND PLOT
plot(x=pcons_data$TimeStamp, y=pcons_data$Global_active_power,
     xlab="", ylab="Global Active Power (kilowatts)",
     type="l")

# THIRD PLOT
plot(x=pcons_data$TimeStamp, y=pcons_data$Sub_metering_1,
     xlab="", ylab="Energy sub metering",
     type="l",
     col="black")
lines(x=pcons_data$TimeStamp, y=pcons_data$Sub_metering_2,
      col="red")
lines(x=pcons_data$TimeStamp, y=pcons_data$Sub_metering_3,
      col="blue")
legend("topright", col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd=1)

# FOURTH PLOT
par(mfcol=c(2,2))

# upper-left plot
plot(x=pcons_data$TimeStamp, y=pcons_data$Global_active_power,
     xlab="", ylab="Global Active Power",
     type="l")

# lower-left plot
plot(x=pcons_data$TimeStamp, y=pcons_data$Sub_metering_1,
     xlab="", ylab="Energy sub metering",
     type="l",
     col="black")
lines(x=pcons_data$TimeStamp, y=pcons_data$Sub_metering_2,
      col="red")
lines(x=pcons_data$TimeStamp, y=pcons_data$Sub_metering_3,
      col="blue")
legend("topright", col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd=1, bty="n",
       cex=0.5)
# added cex param for screen printing

# upper-right plot
plot(x=pcons_data$TimeStamp, y=pcons_data$Voltage,
     xlab="datetime", ylab="Voltage",
     type="l", col="black")

# lower-right plot
plot(x=pcons_data$TimeStamp, y=pcons_data$Global_reactive_power,
     xlab="datetime", ylab="Global_reactive_power",
     type="l", col="black")

