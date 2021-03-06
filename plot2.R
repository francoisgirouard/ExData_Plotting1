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

png(filename = "plot2.png", width = 480, height = 480)

plot(x = data$DateTime,
     y = data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()
