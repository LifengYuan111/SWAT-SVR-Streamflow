
# 2_model_training.R
# Description: Train SVR model for a specific station using wet or dry season data

# Load required libraries
library(e1071)
library(dplyr)

# Helper function to train SVR model for a given station
train_svr_model <- function(station_id, season = 'wet') {
  # Load data based on season
  data_path <- ifelse(tolower(season) == 'wet', 
                      'data/Wet_all_stations.csv', 
                      'data/Dry_all_stations.csv')
  data <- read.csv(data_path)

  # Subset data for the specific station
  df <- data %>% filter(Station.ID == station_id)

  # Split into training and testing
  train_len <- floor(0.8 * nrow(df))
  train_data <- df[1:train_len, ]
  test_data <- df[(train_len + 1):nrow(df), ]

  # Train SVR model (tune parameters if needed)
  svr_model <- svm(Simulated ~ Observed, data = train_data, 
                   type = 'eps-regression', kernel = 'radial',
                   cost = 10, epsilon = 0.1, gamma = 0.01)

  # Save model and data
  saveRDS(svr_model, paste0('models/SVR_', station_id, '_', season, '.rds'))
  write.csv(train_data, paste0('data/train_', station_id, '_', season, '.csv'), row.names = FALSE)
  write.csv(test_data, paste0('data/test_', station_id, '_', season, '.csv'), row.names = FALSE)

  print(paste('SVR model trained and saved for station', station_id, '(', season, 'season )'))
}

# run 
source("scripts/02_model_training.R")
train_svr_model("7195800", season = "wet")
