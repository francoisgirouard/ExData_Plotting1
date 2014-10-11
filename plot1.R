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

png(filename = "plot1.png", width = 480, height = 480)

hist(x = data$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     col = "red",
     main = "Global Active Power")

dev.off()
