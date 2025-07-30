
# 3_model_evaluation.R
# Description: Evaluate SVR model performance for a given station and season

# Load required libraries
library(hydroGOF)
library(ggplot2)

# Helper function to evaluate SVR model
evaluate_svr_model <- function(station_id, season = 'wet') {
  # Load test data and model
  test_path <- paste0('data/test_', station_id, '_', season, '.csv')
  model_path <- paste0('models/SVR_', station_id, '_', season, '.rds')

  test_data <- read.csv(test_path)
  svr_model <- readRDS(model_path)

  # Predict
  predictions <- predict(svr_model, test_data)

  # Calculate goodness-of-fit metrics
  obs <- test_data$Simulated
  sim <- predictions

  metrics <- list(
    NSE = NSE(sim, obs),
    R2  = cor(sim, obs)^2,
    RMSE = rmse(sim, obs),
    PBIAS = pbias(sim, obs)
  )

  # Plot observed vs predicted
  plot_df <- data.frame(Month = 1:length(obs), Observed = obs, Predicted = sim)
  p <- ggplot(plot_df, aes(x = Month)) +
    geom_line(aes(y = Observed), color = 'blue') +
    geom_line(aes(y = Predicted), color = 'red') +
    labs(title = paste("SVR Prediction for Station", station_id, "(", season, ")"),
         y = "Monthly Flow", x = "Month") +
    theme_minimal()

  # Save plot and metrics
  plot_path <- paste0("results/SVR_plot_", station_id, "_", season, ".png")
  ggsave(plot_path, plot = p, width = 8, height = 4)

  metrics_path <- paste0("results/SVR_metrics_", station_id, "_", season, ".csv")
  write.csv(as.data.frame(metrics), metrics_path, row.names = FALSE)

  print(paste("Evaluation complete. Metrics and plot saved for station", station_id))
  return(metrics)
}
# run
source("scripts/03_model_evaluation.R")
evaluate_svr_model("7195800", season = "wet")
