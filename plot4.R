plot4<-function(){
        #loads Houshold Power Consumption data and saves it into hpc dataframe
        hpc<-read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
        
        #transoforms Date column into date format using "as Date" function
        hpc[,1]<-as.Date(hpc[,1], format="%d/%m/%Y")
        
        #merges columns with Date and Time
        hpc$DateTime=paste(hpc$Date, hpc$Time, sep=" ")
        
        #creates new data.frame called hpcshort by subsetting with dates 2007-02-01 and 2007-02-02
        hpcshort<-hpc[hpc$Date=="2007-02-01" | hpc$Date=="2007-02-02",]
        
        #merges columns with Date and Time
        hpcshort$DateTime=paste(hpcshort$Date, hpcshort$Time, sep=" ")
        
        #creates new column with date and time striped from merged column
        hpcshort$DT=strptime(hpcshort$DateTime, format="%Y-%m-%d %H:%M:%S")
        
        #opens a png file
        png("plot4.png", width = 480, height = 480)
        
        #draws charts
        Sys.setlocale("LC_ALL","C")
        par(mfrow = c(2, 2))
        
        plot(hpcshort$DT,hpcshort$Global_active_power, type="n", ylab="Global Active Power", xlab="")
        lines(hpcshort$DT,hpcshort$Global_active_power, type="l")
        
        plot(hpcshort$DT,hpcshort$Voltage, type="n", ylab="Voltage", xlab="datetime")
        lines(hpcshort$DT,hpcshort$Voltage, type="l")
        
        plot(hpcshort$DT,hpcshort$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
        lines(hpcshort$DT,hpcshort$Sub_metering_1, type="l", col="black")
        lines(hpcshort$DT,hpcshort$Sub_metering_2, type="l", col="red")
        lines(hpcshort$DT,hpcshort$Sub_metering_3, type="l", col="blue")
        legend("topright", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
        
        plot(hpcshort$DT,hpcshort$Global_reactive_power, type="n", ylab="Global_reactive_power", xlab="datetime")
        lines(hpcshort$DT,hpcshort$Global_reactive_power, type="l", col="black")
        
        #closes the png file
        dev.off()
}
