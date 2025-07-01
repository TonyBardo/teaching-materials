# simple random sampling variability
# simulated example
# PPT 13 slide 8

# Set seed for reproducibility
set.seed(123)

# --- 1. Create population data ---
n_pop <- 10000
x_pop <- runif(n_pop, 0, 10)
true_beta0 <- 2
true_beta1 <- 0.5
sigma <- 2  # standard deviation of error term

# Add noise (error term)
error <- rnorm(n_pop, mean = 0, sd = sigma)
y_pop <- true_beta0 + true_beta1 * x_pop + error

# --- 2. Plot population relationship ---
plot(x_pop, y_pop, pch = 16, col = rgb(0, 0, 0, 0.1), main = "Sampling Variability in Regression: Impact of Error Term", xlab = "X", ylab = "Y")
abline(true_beta0, true_beta1, col = "blue", lwd = 2)  # true regression line

# --- 3. Take multiple samples and fit regressions ---
n_samples <- 30
sample_size <- 100

for (i in 1:n_samples) {
  index <- sample(1:n_pop, sample_size)
  x_sample <- x_pop[index]
  y_sample <- y_pop[index]
  
  model <- lm(y_sample ~ x_sample)
  abline(model, col = rgb(1, 0, 0, 0.3))  # red lines = sample regressions
}

legend("topleft", legend = c("True line", "Sample regressions"), col = c("blue", rgb(1, 0, 0, 0.5)), lty = 1, lwd = 2)

###
# Now let's modify the above example by removing the error term (i.e., error=0)
##
# Set seed for reproducibility
set.seed(123)

# --- 1. Create population data ---
n_pop <- 10000
x_pop <- runif(n_pop, 0, 10)
true_beta0 <- 2
true_beta1 <- 0.5
sigma <- 2  # standard deviation of error term

# No noise (error term = 0)
error <- rep(0, n_pop)
y_pop <- true_beta0 + true_beta1 * x_pop + error

# --- 2. Plot population relationship ---
plot(x_pop, y_pop, pch = 16, col = rgb(0, 0, 0, 0.1), main = "Sampling Variability in Regression Without an Error Term", xlab = "X", ylab = "Y")
abline(true_beta0, true_beta1, col = "blue", lwd = 2)  # true regression line

# --- 3. Take multiple samples and fit regressions ---
n_samples <- 30
sample_size <- 100

for (i in 1:n_samples) {
  index <- sample(1:n_pop, sample_size)
  x_sample <- x_pop[index]
  y_sample <- y_pop[index]
  
  model <- lm(y_sample ~ x_sample)
  abline(model, col = rgb(1, 0, 0, 0.3))  # red lines = sample regressions
}

legend("topleft", legend = c("True line", "Sample regressions"), col = c("blue", rgb(1, 0, 0, 0.5)), lty = 1, lwd = 2)
