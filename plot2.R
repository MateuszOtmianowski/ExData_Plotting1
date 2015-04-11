plot2<-function(){
        #load Houshold Power Consumption data and saces it into hpc dataframe
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
        png("plot2.png", width = 480, height = 480)
        
        #draws the chart
        Sys.setlocale("LC_ALL","C")
        plot(hpcshort$DT,hpcshort$Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab="")
        lines(hpcshort$DT,hpcshort$Global_active_power, type="l")
        
        #closes the png file
        dev.off()
}