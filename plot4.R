if (!"lubridate" %in% rownames(installed.packages())) {
  install.packages("lubridate")
}

library(lubridate)

if (!exists("data") ||
      class(data)  != "data.frame" ||
      nrow(data) != 2880 ||
      ncol(data) != 8) {
  data <- read.table(file = "household_power_consumption.txt",
                     header = TRUE,
                     sep = ";",
                     na.strings = "?")
  data$DateTime <- dmy_hms(paste(data$Date, data$Time))
  data <- data[data$DateTime >= ymd("2007-02-01") &
                 data$DateTime < ymd("2007-02-03"), c(10, 3:9)]
}

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

plot(x = data$DateTime,
     y = data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

plot(x = data$DateTime,
     y = data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

plot(x = data$DateTime,
     y = data$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black")
lines(x = data$DateTime,
      y = data$Sub_metering_2,
      col = "red")
lines(x = data$DateTime,
      y = data$Sub_metering_3,
      col = "blue")
legend(x = "topright",
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       lty = c(1, 1, 1),
       col = c("black",
               "red",
               "blue"))

plot(x = data$DateTime,
     y = data$Global_reactive_power,
     type = "l",
     xlab = "",
     ylab = "Global_reactive_power")

dev.off()
