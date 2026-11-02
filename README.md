# ✈️ Airline Passenger Forecasting using R

This project focuses on time series analysis and forecasting of monthly international airline passengers using R. It utilizes historical data to identify trends and seasonal patterns, applying statistical and forecasting models to predict future passenger numbers.

**📈 Methodology**
--
Data Preparation: Loading the Excel dataset into R and converting it into a time series object (ts).

Exploratory Data Analysis (EDA): Visualizing the data to check for underlying trends, seasonality, and variance.

Modeling: Applying appropriate time series forecasting models (such as ARIMA or Exponential Smoothing).

Evaluation & Forecasting: Generating predictions and visualizing future passenger trends.

**💡 Key Findings**
--
Upward Trend: Historical data between 1949 and 1955 demonstrates a consistent long-term upward trend in international airline passenger volume.

Strong Seasonality: Passenger numbers exhibit a clear annual repeating seasonal pattern, with peak travel volume consistently occurring during summer months.

Increasing Variance: The amplitude of seasonal fluctuations increases over time alongside the rising trend, indicating multiplicative characteristics in the underlying series.

## 📂 Project Structure

- `Monthly_International_Airline_Passengers_1949_1955(1).xlsx`: The dataset containing monthly passenger counts from 1949 to 1955.
- `Airline forecasting.R`: The main R script containing data preprocessing, exploratory data analysis, model building, and evaluation.
- `Screenshot 2026-11-02 232115.png`: Visual outputs/plots generated during the forecasting process.

## 🛠️ Prerequisites & Libraries

Make sure you have [R](https://www.r-project.org/) and [RStudio](https://posit.co/downloads/) installed. The following R packages are required to run the analysis:

```r
install.packages("readxl")
install.packages("forecast")
install.packages("tseries")
install.packages("ggplot2")
