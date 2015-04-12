## SETTING WORKING DIRECTORY
setwd("C:/Users/HerrinFamilyPC/Desktop/Coursera/Exploratory Data Analysis")

##read in household_power_consumption
hpcdata <-read.table("C:/Users/HerrinFamilyPC/Desktop/Coursera/Exploratory Data Analysis/household_power_consumption.txt", sep=";")

hpcdata[1,]

##change column names from V1, V2, to values in row 1
colnames(hpcdata) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#str(hpcdata)
#tail(hpcdata)

##cut out row 1 and call new dF hpcdata1
hpcdata1 <- hpcdata[2:2075260,]
##head(hpcdata1)

##create new DateTime column 
hpcdata1$DateTime <- as.POSIXct(paste(hpcdata1$Date, hpcdata1$Time), format="%d/%m/%Y %H:%M:%S")

##use as.Date() to convert Date Column from factor
hpcdata1$Date <- as.Date(hpcdata1$Date, format = "%d/%m/%Y")



## subset dates between 2007-02-01 and 2007-02-02
## call new dF hpcdata2

date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

hpcdata2 <- subset(hpcdata1, Date %in% c(date1,date2))
## hpcdata2 is my processed dataset

#################################################################
#################################################################


##plot 1 Global Active Power Histogram
hpcdata2$Global_active_power <- as.numeric(hpcdata2$Global_active_power)
plot1 <- hist(hpcdata2$Global_active_power, col = "red", main = "Global Active Power", 
              xlab = "Global Active Power (kilowatts)")


##plot 2 Global Active Power Plot
plot2 <- plot(hpcdata2$DateTime, hpcdata2$Global_active_power, type='l', 
              ylab= "Global Active Power (kilowatts)", xlab="")

##plot 3 Energy Sub Meeting 1,2,3 Plot
hpcdata2$Sub_metering_1 <- as.numeric(hpcdata2$Sub_metering_1)
hpcdata2$Sub_metering_2 <- as.numeric(hpcdata2$Sub_metering_2)
hpcdata2$Sub_metering_3 <- as.numeric(hpcdata2$Sub_metering_3)
plot3 <- plot(hpcdata2$DateTime,hpcdata2$Sub_metering_1, 
              ylim=c(0,40), type='l',
              col="black",ylab="Energy Sub Meeting", xlab="")
lines(hpcdata2$DateTime, hpcdata2$Sub_metering_2, ylim=c(0,80), type='l',col="red")
lines(hpcdata2$DateTime, hpcdata2$Sub_metering_3, ylim=c(0,20), type='l',col="blue")
legend('topright', names(hpcdata2[,7:9]), 
       lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)

##plot 4 
## use par(mfrow = c(2,2)) to create 2x2 panel for plots
## use actual code when applying plots to panel
par(mfrow = c(2,2))
plot(hpcdata2$DateTime, hpcdata2$Global_active_power, type='l', 
     ylab= "Global Active Power (kilowatts)", xlab="")
plot(hpcdata2$DateTime, hpcdata2$Voltage, type='l', 
              ylab= "Voltage", xlab="datetime")
plot(hpcdata2$DateTime,hpcdata2$Sub_metering_1, 
              ylim=c(0,40), type='l',
              col="black",ylab="Energy Sub Meeting", xlab="")
lines(hpcdata2$DateTime, hpcdata2$Sub_metering_2, ylim=c(0,80), type='l',col="red")
lines(hpcdata2$DateTime, hpcdata2$Sub_metering_3, ylim=c(0,20), type='l',col="blue")
legend('topright', names(hpcdata2[,7:9]), 
       lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)
plot(hpcdata2$DateTime, hpcdata2$Global_reactive_power, type='l', 
              ylab= "Global_reactive_power", xlab="datetime")

