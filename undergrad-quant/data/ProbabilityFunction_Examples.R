#Coin flip example: PPT 7 slide 15 to 19
# What is the probability of getting exactly 10 heads in 20 flips?

# v1: you can work through the math like on a calculator
prob_10_heads_v1 <- choose(20, 10) * (0.5^10) * (0.5^(20-10))
print(prob_10_heads_v1)

# v2: you can also work out the math like denoted in the equation
# create variables to reflect the parameters
n<-20 # number of random trials (coin flips)
k<-10 # number of successes (heads)
p<-0.5 # probability of success (heads) on each trial

# and calculate the binomial probability by using the dbinom function
prob_10_heads_v2<-dbinom(k, size = n, prob = p)
print(prob_10_heads_v2)

###
# what does the distribution of probabilities for all possible successes look like?
##

# Generate a sequence of all possible successes (0 to 20 heads)
x=seq(0,20,by=1) # This creates a vector from 0 to 20 by whole numbers

# Calculate the binomial probabilities for each possible success
y<-dbinom(x,20,.5)

# Plot the binomial probability distribution
plot(x,y,ylab="Probability",xlab="Number of Successes (Heads)",
main="Binomial Probability Distribution (20 Coin Flips)",ylim=c(0,.2))
abline(h=184756*(.5^10*.5^10),lty=2)

###
# Let's see what binomial probability distributions look like when probability of 
# success is less vs greater than 0.5: slide 20
##

# probability of success greater than 0.5
y_greater<-dbinom(x,20,.8)

# Plot the binomial probability distribution
plot(x,y_greater,ylab="Probability",xlab="Number of Successes (hypothetical)",
     main="Binomial Probability Distribution (20 Random Trials: Probability of Success=0.8)",
     ylim=c(0,.5))

# probability of success less than 0.5
y_less<-dbinom(x,20,.2)

# Plot the binomial probability distribution
plot(x,y_less,ylab="Probability",xlab="Number of Successes (hypothetical)",
     main="Binomial Probability Distribution (20 Random Trials: Probability of Success=0.2)",
     ylim=c(0,.5))

################################################################################

# Height example PPT 7: slide 23 - 27

x=seq(55,85) # range of possible means for plotting X axis
y=dnorm(x,mean=70,sd=3) # population parameters for computing normal density function
plot(x,y,type="l",main="Normal Probability Distribution (Height in Inches: mu=70 and sd=3)",
     ylab="Density",xlab="Height in Inches",lwd=2)
abline(v=70, lwd=2, lty=2)  # Vertical line at mean
abline(v=67, lwd=2, lty=2, col="grey") # Vertical line at mean - sd
abline(v=73, lwd=2, lty=2, col="grey") # Vertical line at mean + sd

#######
# sampling distribution for mean height with different sample sizes
# PPT 7: slide 34

# Define parameters
mu <- 70      # Population mean
sigma <- 3    # Population standard deviation
n1 <- 10      # Sample size 100
n2 <- 100      # Sample size 500
n3 <- 500      # Sample size 1000
SE1 <- sigma / sqrt(n1)  # Standard error for sample 100
SE2 <- sigma / sqrt(n2)  # Standard error for sample 500
SE3 <- sigma / sqrt(n3)  # Standard error for sample 1000

# Create a sequence of sample means for plotting
x_values <- seq(68, 72, length=1000)  # Range of possible means
y_values1 <- dnorm(x_values, mean=mu, sd=SE1)  # Compute probability density for sample 100
y_values2 <- dnorm(x_values, mean=mu, sd=SE2)  # Compute probability density for sample 500
y_values3 <- dnorm(x_values, mean=mu, sd=SE3)  # Compute probability density for sample 1000

# Plot the sampling distribution
plot(x_values, y_values1, type="l", col="black", lwd=2,
     main="Sampling Distributions for Different Sample Sizes (Height in inches: Mu = 70, sd = 3)",
     xlab="Sample Mean (inches)", ylab="Density",ylim=c(0,3))
abline(v=mu, col="red", lwd=2, lty=2)  # Vertical line at mean
lines(x_values, y_values2,lwd=2,col="blue")
lines(x_values, y_values3,lwd=2,col="forestgreen")

# compute Z scores using modified equation
zn10<-(70.5-70)/(SE1)
print (zn10)
zn100<-(70.5-70)/(SE2)
print (zn100)
zn500<-(70.5-70)/(SE3)
print (zn500)

# computing 95% confidence intervals for mean height based on differnt sample sizes

### n = 10 ###
# 95% upper bound CI: alpha = 0.05 so Z = 1.96
# compute margin of error (MoE)
moe10<-1.96*(3/sqrt(10))
# compute upper bound interval 
ci10U<-70+moe10
abline(v=ci10U, col="black", lwd=2, lty=2)  # Vertical line at upper bound 
# compute lower bound interval
ci10L<-70-moe10
abline(v=ci10L, col="black", lwd=2, lty=2)  # Vertical line at lower bound 

### n = 100 ###
# 95% upper bound CI: alpha = 0.05 so Z = 1.96
# compute margin of error (MoE)
moe100<-1.96*(3/sqrt(100))
# compute upper bound interval 
ci100U<-70+moe100
abline(v=ci100U, col="blue", lwd=2, lty=2)  # Vertical line at upper bound 
# compute lower bound interval
ci100L<-70-moe100
abline(v=ci100L, col="blue", lwd=2, lty=2)  # Vertical line at lower bound 

### n = 500 ###
# 95% upper bound CI: alpha = 0.05 so Z = 1.96
# compute margin of error (MoE)
moe500<-1.96*(3/sqrt(500))
# compute upper bound interval 
ci500U<-70+moe500
abline(v=ci500U, col="forestgreen", lwd=2, lty=2)  # Vertical line at upper bound 
# compute lower bound interval
ci500L<-70-moe500
abline(v=ci500L, col="forestgreen", lwd=2, lty=2)  # Vertical line at lower bound 


#normal density function
x1=seq(-10,10,by=0.01)
x2=seq(-10,10,by=0.01)
x3=seq(-10,10,by=0.01)
y1=dnorm(x1)
y2=dnorm(x2,mean=3,sd=2)
y3=dnorm(x3,mean=-3,sd=0.5)

plot(x1,y1,type="l",lwd=2,ylab="Density",xlab="",xlim=c(-10,10),ylim=c(0,0.8))
lines(x2,y2,lwd=2,lty=2)
lines(x3,y3,lwd=2,lty=3)
legend("topright",c("N(0,1)","N(3,2)","N(-3,0.5)"),lwd=c(2,2,2),lty=c(1,2,3))


#IQ example
x=seq(50,150)
y=dnorm(x,mean=100,sd=15)

plot(x,y,type="l",main="IQ with mean=100 and sd=15",ylab="Density",xlab="IQ")
abline(v=125,lty=2)

#IQ example
x=seq(50,150)
y=dnorm(x,mean=100,sd=15)



abline(v=125,lty=2)
