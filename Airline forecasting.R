airline_matrix <- matrix(
  c(
    112,118,132,129,121,135,148,148,136,119,104,118,
    115,126,141,135,125,149,170,170,158,133,114,140,
    145,150,178,163,172,178,199,199,184,162,146,166,
    171,180,193,181,183,218,230,242,209,191,172,194,
    196,196,236,235,229,243,264,272,237,211,180,201,
    204,188,235,227,234,264,302,293,259,229,203,229,
    242,233,267,269,270,315,364,347,312,274,237,278
  ),
  nrow = 7,
  ncol = 12,
  byrow = TRUE
)

rownames(airline_matrix) <- 1949:1955

colnames(airline_matrix) <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

airline_matrix
airline_matrix_ts<-ts(as.vector(t(airline_matrix)), 
                      start = c(1949,1),
                      frequency = 12)
print(airline_matrix_ts)
class(airline_matrix_ts)
start(airline_matrix_ts)
end(airline_matrix_ts)
frequency(airline_matrix_ts)
length(airline_matrix_ts)
summary(airline_matrix_ts)
plot(airline_matrix_ts, xlab="x", ylab="y", col="blue",lwd=2)
dev.off()
decompose(airline_matrix_ts, type = "multiplicative")

plot(decompose(airline_matrix_ts, type = "multiplicative"))

airline_matrix_df <- data.frame(
  Year = rep(1949:1955, each = 12),
  Month = rep(c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"),
              times = 7),
  Passengers = as.vector(t(airline_matrix))
)

airline_matrix_df
summary(airline_matrix_df$Passengers)
monthly_status<-aggregate(Passengers ~ Month, data = airline_matrix_df,
                          FUN = function(x) c(Mean = mean(x), SD = sd(x)))
print(monthly_status)
pdf("boxplot.pdf", height= 6,width= 6)
boxplot(Passengers~Month, data= airline_matrix_df, xlab= "Month", ylab= "Number of passengers", col= "blue")
dev.off()  
library(forecast)
fit<-ets(airline_matrix_ts)  
summary(fit)
forecast_ets<-forecast(fit, h=7)
forecast_ets
plot(forecast_ets, xlabs= "Year", ylab="passengers", col="black")
jan_1956 <- forecast_ets$mean[1] / 1000
jul_1956 <- forecast_ets$mean[7] / 1000

cat("January 1956 forecast:", jan_1956, "thousand passengers\n")
cat("July 1956 forecast:", jul_1956, "thousand passengers\n")
accuracy(fit)
t <- 1:length(airline_matrix_ts)
trend_model <- lm(as.numeric(airline_matrix_ts) ~ t)
summary(trend_model)
# Convert the time-series/matrix data to a numeric vector
y <- as.numeric(airline_matrix_ts)

# Create monthly time index
t <- 1:length(y)

# Fit quadratic time-trend model using least squares
quadratic_model <- lm(y ~ t + I(t^2))

# Display model results
summary(quadratic_model)
linear_model <- lm(y ~ t)
quadratic_model <- lm(y ~ t + I(t^2))

# Load package
library(tseries)


# =========================================
# 1. Extract residuals
# =========================================

res_linear <- residuals(linear_model)
res_quadratic <- residuals(quadratic_model)


# =========================================
# 2. LJUNG-BOX TEST
#    H0: No autocorrelation
# =========================================

lb_linear <- Box.test(
  res_linear,
  lag = 12,
  type = "Ljung-Box"
)

lb_quadratic <- Box.test(
  res_quadratic,
  lag = 12,
  type = "Ljung-Box"
)


# =========================================
# 3. SHAPIRO-WILK TEST
#    H0: Residuals are normally distributed
# =========================================

sw_linear <- shapiro.test(res_linear)

sw_quadratic <- shapiro.test(res_quadratic)


# =========================================
# 4. RUNS TEST
#    H0: Residuals are random
# =========================================

# Convert residuals into positive/negative categories
linear_sign <- factor(
  ifelse(res_linear >= 0, "Positive", "Negative")
)

quadratic_sign <- factor(
  ifelse(res_quadratic >= 0, "Positive", "Negative")
)

runs_linear <- runs.test(linear_sign)

runs_quadratic <- runs.test(quadratic_sign)


# =========================================
# 5. Display results
# =========================================

lb_linear
sw_linear
runs_linear

lb_quadratic
sw_quadratic
runs_quadratic
                            