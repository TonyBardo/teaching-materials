# SRS distribution
# simulated example
# PPT 13 slide 9

set.seed(123)

# Use your specified population
n_pop <- 10000
x_pop <- runif(n_pop, 0, 10)
true_beta0 <- 2
true_beta1 <- 0.5
sigma <- 2
error <- rnorm(n_pop, 0, sigma)
y_pop <- true_beta0 + true_beta1 * x_pop + error

# Simulation parameters
n_samples <- 1000     # number of repeated samples
sample_size <- 100    # size of each sample
b1_estimates <- numeric(n_samples)
se_estimates <- numeric(n_samples)

# Run simulation: sample from the same population each time
for (i in 1:n_samples) {
  idx <- sample(1:n_pop, sample_size)
  x_sample <- x_pop[idx]
  y_sample <- y_pop[idx]
  
  model <- lm(y_sample ~ x_sample)
  b1_estimates[i] <- coef(model)[2]  # slope estimate
  se_estimates[i] <- summary(model)$coefficients[2, 2]  # SE of slope
}

# Plot histogram of b1 estimates
hist(b1_estimates,
     breaks = 40,
     col = "lightblue",
     freq = FALSE,
     main = "Sampling Distribution of Slope Estimates (b1)",
     xlab = "Estimated Slope")

# Overlay normal curve
curve(dnorm(x, mean = mean(b1_estimates), sd = sd(b1_estimates)), 
      col = "darkblue", lwd = 2, add = TRUE)

# Reference lines
abline(v = true_beta1, col = "black", lwd = 2, lty = 3)       # true β₁
abline(v = mean(b1_estimates), col = "darkgreen", lwd = 2, lty = 2)  # mean estimate

legend("topright", legend = c("True β1", "Mean of b1 estimates"),
       col = c("black", "darkgreen"), lty = c(3, 2), lwd = 2)

# Print summary
cat("True beta1: ", true_beta1, "\n")
cat("Mean of estimated b1: ", round(mean(b1_estimates), 4), "\n")
cat("Empirical SD of b1 estimates (sampling SD): ", round(sd(b1_estimates), 4), "\n")
cat("Average reported SE(b1): ", round(mean(se_estimates), 4), "\n")
