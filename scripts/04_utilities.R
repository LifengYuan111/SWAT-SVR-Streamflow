
# 4_utilities.R
# Description: Helper functions for plotting, metrics, and data handling

# Load required libraries
library(ggplot2)
library(hydroGOF)

# Function to compute and return hydrologic performance metrics
compute_metrics <- function(simulated, observed) {
  list(
    NSE = NSE(simulated, observed),
    R2 = cor(simulated, observed)^2,
    RMSE = rmse(simulated, observed),
    PBIAS = pbias(simulated, observed),
    RSR = rmse(simulated, observed) / sd(observed)
  )
}

# Function to plot observed vs. predicted time series
plot_predictions <- function(obs, pred, title = "Observed vs Predicted", save_path = NULL) {
  df <- data.frame(Month = 1:length(obs), Observed = obs, Predicted = pred)

  p <- ggplot(df, aes(x = Month)) +
    geom_line(aes(y = Observed), color = 'blue', size = 1) +
    geom_line(aes(y = Predicted), color = 'red', size = 1) +
    labs(title = title, x = 'Month', y = 'Flow') +
    theme_minimal()

  if (!is.null(save_path)) {
    ggsave(save_path, plot = p, width = 8, height = 4)
  } else {
    print(p)
  }
}

# Function to split a dataset into train/test
split_train_test <- function(data, ratio = 0.8) {
  n <- nrow(data)
  split_idx <- floor(ratio * n)
  list(train = data[1:split_idx, ], test = data[(split_idx + 1):n, ])
}

