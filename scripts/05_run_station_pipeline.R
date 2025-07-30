
# 5_run_station_pipeline.R
# Description: End-to-end runner for training and evaluating SVR models for multiple stations

# Load all required scripts
source("scripts/01_data_preprocessing.R")
source("scripts/02_model_training.R")
source("scripts/03_model_evaluation.R")
source("scripts/04_utilities.R")

# Define list of station IDs to run
station_list <- c("7196900", "7196973", "7195800")  # You can add more station IDs here
seasons <- c("wet", "dry")  # Run for both seasons

# Preprocess data (optional if already done)
# Comment out next line if you already ran preprocessing manually
source("scripts/01_data_preprocessing.R")

# Run training and evaluation for each station and season
for (station_id in station_list) {
  for (season in seasons) {
    cat("Running station", station_id, "for", season, "season\n")

    tryCatch({
      train_svr_model(station_id, season)
      metrics <- evaluate_svr_model(station_id, season)
      print(metrics)
    }, error = function(e) {
      cat("Failed for station", station_id, "season", season, ":", e$message, "\n")
    })
  }
}
