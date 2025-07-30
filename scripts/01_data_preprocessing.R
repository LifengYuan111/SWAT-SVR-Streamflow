
# 01_preprocess_data.R
# Purpose: Load streamflow dataset, convert dates, split into wet and dry seasons

library(data.table)

# Load dataset
data <- fread("data/all_stations_all_month.csv")

# Convert 'Date' column to R Date format
data$Date <- as.POSIXct(paste("01", data$Date, sep = "-"), format = "%d-%b-%y")
data$Station.ID <- as.character(data$Station.ID)

# Add Month and Year columns
data$Month <- as.integer(format(data$Date, "%m"))
data$Year <- as.integer(format(data$Date, "%Y"))

# Split into Wet and Dry seasons (Wet: Jan–Jun, Dry: Jul–Dec)
data_wet <- data[data$Month < 7, ]
data_dry <- data[data$Month >= 7, ]

# Reorder columns and add row ID
data_wet$No. <- 1:nrow(data_wet)
data_dry$No. <- 1:nrow(data_dry)
setcolorder(data_wet, c("No.", "Station.ID", "Date", "Observed", "Simulated", "Month", "Year"))
setcolorder(data_dry, c("No.", "Station.ID", "Date", "Observed", "Simulated", "Month", "Year"))

# Save outputs (optional)
fwrite(data_wet, file = "data/wet_all_stations.csv")
fwrite(data_dry, file = "data/dry_all_stations.csv")
