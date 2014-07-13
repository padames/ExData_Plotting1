## Create the third plot for Project One of the course Exploratory Data Analysis
## July 13, 2014
## Author: Padames


## Download and read the data source into an R data.frame called 't':

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file( fileURL, destfile = "./data/hhpower.txt", method = "curl")
t<-read.table("./data/household_power_consumption.txt", 
              as.is=c(1,2), 
              colClasses=c("character", 'character', 'numeric','numeric','numeric',
                           'numeric','numeric','numeric','numeric'), 
              header=TRUE,
              sep=";",
              na.strings="?") # avoid the NA's in the original text file as per instructions


## Create a new column with the datatime class objects to allow for time series analysis

datetime <- mapply( FUN=function(x,y) paste(x,y,sep=" "),
                    t$Date,
                    t$Time,
                    SIMPLIFY = TRUE,
                    USE.NAMES=FALSE)
t$datetime <- as.POSIXct( datetime, format="%d/%m/%Y %H:%M:%S" )

## Filter data of interest, first two days of February 2007:

firstTwoDaysFeb2007<-t[(t$Date == "1/2/2007" | t$Date == "2/2/2007" ),]

## create plot:

with( firstTwoDaysFeb2007, 
      plot(   x = datetime,
              y = Sub_metering_1, type="l",col="black",xlab="",ylab="Energy sub metering") 
      )
with( firstTwoDaysFeb2007,
      lines(  x = datetime,
              y = Sub_metering_2,type="l",col="red")
)

with( firstTwoDaysFeb2007,
      lines(  x = datetime,
              y = Sub_metering_3,type="l",col="blue")
)
with( firstTwoDaysFeb2007,
      legend( x = "top", y = "right", 
              legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
              lty=1, 
              col=c("black","red","blue"),
              ncol=1,  # for a vertically stacked legend
              bty="n") # eliminated the visible box around legend because it did not grow to wrap text on png output 
      )

## create png file for permanent storage
dev.copy( device=png,
          file = "plot3.png",
#           which = dev.next(), # cannot provide 'which' and 'device' simultaneously
          width = 480, 
          height = 480,
          units = "px")
dev.off()
