# Read in data
data_path <- file.path("data/household_power_consumption.txt")
header <- read.table(data_path, nrows=1, header=FALSE, sep=";", stringsAsFactors=FALSE)
dat <- read.table(data_path, nrows=69517-66638+1, skip=66637, header=FALSE, sep=";", 
                  stringsAsFactors=FALSE, colClasses=c("character", "character", rep("numeric",7)))

# Format date/time as datetime and add to frame
dates <- strptime(paste(dat$V1, dat$V2), format="%d/%m/%Y %H:%M:%S")
colnames(dat) <- unlist(header)
final_dat <- as.data.frame(dat)
final_dat$datetime <- dates

# Remove old date and time columns
final_dat$Date <- NULL
final_dat$Time <- NULL

# Make plot3.png
png(file="plot3.png", width=480, height=480)
plot(x=final_dat$datetime, y=final_dat$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x=final_dat$datetime, y=final_dat$Sub_metering_2, col="red")
lines(x=final_dat$datetime, y=final_dat$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
dev.off()