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


###
### GENERATING PLOT - directly on png ###

png(file="plot2.png", width=480, height=480, units="px", bg="transparent")

plot(x=pcons_data$TimeStamp, y=pcons_data$Global_active_power,
     xlab="", ylab="Global Active Power (kilowatts)",
     type="l")

dev.off()

###
