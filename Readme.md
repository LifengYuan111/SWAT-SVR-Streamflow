# Hybrid SWAT-SVR Streamflow Prediction Model

This repository provides an implementation of a hybrid hydrological modeling approach that integrates the **Soil and Water Assessment Tool (SWAT)** with **Support Vector Regression (SVR)** to improve monthly streamflow prediction accuracy at multiple gauge stations.

The work is based on the methods and findings published in:

- **PLOS ONE (2021)**: [A hybrid SWAT-SVR model for improving streamflow prediction](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0248489)
- **Water (2022)**: [Development of a wavelet-enhanced SWAT-WSVR model for monthly flow simulation](https://www.mdpi.com/2073-4441/14/17/2649)

## 📌 Overview

The project enhances SWAT-simulated streamflow by post-processing its outputs using machine learning:
- **SVR** models correct systematic biases and improve accuracy
- Seasonal separation (wet/dry) is used to address hydroclimatic heterogeneity
- Model performance is evaluated using **NSE**, **R²**, **PBIAS**, **RMSE**, and **RSR**

## 📂 Repository Structure

```bash
SWAT-SVR-Streamflow/
├── data/
│   └── all_stations_all_month.csv  # Observed & SWAT-simulated monthly data for multiple stations
├── scripts/
│   ├── 01_data_preprocessing.R     # Load and split data into wet/dry seasons
│   ├── 02_model_training.R         # Train SVR model for one station
│   ├── 03_model_evaluation.R       # Evaluate SVR performance on test data
│   ├── 04_utilities.R              # Batch run SVR for multiple stations
│   └── 05_run_station_pipeline.R   # Helper functions (e.g., plotting, metrics)
├── models/                         # Trained SVR model objects (optional)
├── results/                        # Output plots and validation metrics
├── README.md
