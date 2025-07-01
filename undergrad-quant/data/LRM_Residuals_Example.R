# residuals with linear regression
# simulated example
# PPT 13 slides 10 and 11

# Set seed for reproducibility
set.seed(04202025)

# Simulate data
X <- seq(1, 10, length.out = 20)
true_intercept <- 50
true_slope <- 5
epsilon <- rnorm(20, mean = 0, sd = 5)
Y <- true_intercept + true_slope * X + epsilon

# Fit linear model
model <- lm(Y ~ X)
predicted_Y <- fitted(model)
residuals <- resid(model)
SEE <- sqrt(sum(residuals^2) / (length(Y) - 2))

# Set up plot
plot(X, Y,
     main = "Visualizing Residuals and Standard Error of the Estimate",
     xlab = "Hours Studied (X)",
     ylab = "Exam Score (Y)",
     pch = 19,
     col = "dodgerblue",
     ylim = range(c(Y, predicted_Y))
)

# Add regression line
abline(model, col = "darkorange", lwd = 2)

# Add residual lines
for (i in 1:length(X)) {
  segments(X[i], Y[i], X[i], predicted_Y[i], col = "gray", lty = 2)
}

# Add SEE annotation
text(x = 6, y = min(Y) - 5, labels = paste("SEE ≈", round(SEE, 2)), cex = 1.2)


###
# Standard Error of the Estimate (SEE)
##

# the SEE is the standard deviation 
SEE <- sqrt(sum(residuals^2) / (length(Y) - 2))
SEE

###
# R-squared: variance in Y explained by X
###

# Add these lines to your existing base R plot code

# Compute and print R-squared
rsq <- summary(model)$r.squared
rsq

# Add horizontal line at mean(Y) to show "null model"
abline(h = mean(Y), col = "black", lty = 3)
text(x = 9.5, y = mean(Y) + 1.5, labels = "Mean of Y", cex = 0.8, col = "black")

###
# let's consider R2 across two samples with different errors
##
# Set seed for reproducibility
set.seed(04202025)

# Simulated predictor
X <- seq(1, 10, length.out = 20)

# Function to simulate data with controllable noise
simulate_data <- function(X, noise_sd) {
  intercept <- 50
  slope <- 5
  epsilon <- rnorm(length(X), mean = 0, sd = noise_sd)
  Y <- intercept + slope * X + epsilon
  return(Y)
}

# Simulate low and high noise datasets
Y_low <- simulate_data(X, noise_sd = 3)
Y_high <- simulate_data(X, noise_sd = 10)

# Fit models
model_low <- lm(Y_low ~ X)
model_high <- lm(Y_high ~ X)

# Predicted values
Yhat_low <- predict(model_low)
Yhat_high <- predict(model_high)

# R-squared values
rsq_low <- summary(model_low)$r.squared
rsq_high <- summary(model_high)$r.squared

# Plot side-by-side
par(mfrow = c(1, 2))  # 1 row, 2 columns

# Low Noise Plot
plot(X, Y_low,
     main = paste("Low Noise\nHigh R² ≈", round(rsq_low, 2)),
     xlab = "X", ylab = "Y",
     pch = 19, col = "dodgerblue",
     ylim = range(c(Y_low, Y_high)))
abline(model_low, col = "darkorange", lwd = 2)
grid()

# High Noise Plot
plot(X, Y_high,
     main = paste("High Noise\nLow R² ≈", round(rsq_high, 2)),
     xlab = "X", ylab = "",
     pch = 19, col = "dodgerblue",
     ylim = range(c(Y_low, Y_high)))
abline(model_high, col = "darkorange", lwd = 2)
grid()

# Reset plotting area
par(mfrow = c(1, 1))
