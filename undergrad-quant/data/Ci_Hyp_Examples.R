#######
# sampling distribution for mean age with different sample sizes
# pretending GSS is a population
# PPT 8 slides 7 - 17
#######

load("E:/1_UK/2_Teaching/SOC303/Data/GSS.RData")
attach(GSS)

# Define parameters
mu <- mean(age)          # Population mean
sigma <- sd(age)         # Population standard deviation
n1 <- 10                 # Sample size 10
n2 <- 30                # Sample size 30
n3 <- 100               # Sample size 100
SE1 <- sigma / sqrt(n1)  # Standard error for sample 10
SE2 <- sigma / sqrt(n2)  # Standard error for sample 50
SE3 <- sigma / sqrt(n3)  # Standard error for sample 100

# Create a sequence of sample means for plotting
x_values <- seq(18, 89, length=1000)  # Range of possible means
y_values1 <- dnorm(x_values, mean=mu, sd=SE1)  # Compute probability density for sample 10
y_values2 <- dnorm(x_values, mean=mu, sd=SE2)  # Compute probability density for sample 50
y_values3 <- dnorm(x_values, mean=mu, sd=SE3)  # Compute probability density for sample 100

# Plot the sampling distributions
plot(x_values, y_values1, type="l", col="black", lwd=2,
     main="Theoretical Sampling Distributions: Different Sample Sizes  
      (Age in Years: Mu = 46.45, sd = 17.62)",
     xlab="Sample Mean", ylab="Density",xlim=c(30,65),ylim=c(0,.25))
abline(v=mu, col="red", lwd=2, lty=2)  # Vertical line at mean
lines(x_values, y_values2,lwd=2,col="blue")
lines(x_values, y_values3,lwd=2,col="forestgreen")
abline(v=mu+SE1,col="black",lty=2)
abline(v=mu-SE1,col="black",lty=2)
abline(v=mu+SE2,col="blue",lty=2)
abline(v=mu-SE2,col="blue",lty=2)
abline(v=mu+SE3,col="forestgreen",lty=2)
abline(v=mu-SE3,col="forestgreen",lty=2)

#compute value for minus-plus 1 sd from mu
#n=10
msd1<-mu-SE1
psd1<-mu+SE1
msd1
psd1
abline(v=msd1)
abline(v=psd1)

#n=30
msd2<-mu-SE2
psd2<-mu+SE2
msd2
psd2
abline(v=msd2,col="blue")
abline(v=psd2,col="blue")

#n=100
msd3<-mu-SE3
psd3<-mu+SE3
msd3
psd3
abline(v=msd3,col="forestgreen")
abline(v=psd3,col="forestgreen")

# compute Z scores using modified equation
zn10<-(70.5-70)/(SE1)
print (zn10)
zn30<-(70.5-70)/(SE2)
print (zn30)
zn100<-(70.5-70)/(SE3)
print (zn100)

####
# Margin of Error (MoE)
###
### n=10
# alpha = 0.10
moe90<-1.65*SE1
moe90
# alpha = 0.05
moe95<-1.96*SE1
moe95
# alpha = 0.01
moe99<-2.58*SE1
moe99
### n=30
# alpha = 0.10
moe90n30<-1.65*SE2
moe90n30
# alpha = 0.05
moe95n30<-1.96*SE2
moe95n30
# alpha = 0.01
moe99n30<-2.58*SE2
moe99n30
###
### n=100
# alpha = 0.10
moe90n100<-1.65*SE3
moe90n100
# alpha = 0.05
moe95n100<-1.96*SE3
moe95n100
# alpha = 0.01
moe99n100<-2.58*SE3
moe99n100
###

###
# Confidence Intervals (CI)
###
# compute 90% CI: n=10
# upper bound
ci90U<-mean(age)+moe90
# lower bound
ci90L<-mean(age)-moe90

# compute 95% CI: n=10
# upper bound
ci95U<-mean(age)+moe95
# lower bound
ci95L<-mean(age)-moe95

# compute 99% CI: n=10
# upper bound
ci99U<-mean(age)+moe99
# lower bound
ci99L<-mean(age)-moe99
###


###plot CIs on theoretical sampling distribution

plot(x_values, y_values1, type="l", col="black", lwd=2,
     main="Theoretical Sampling Distribution: n=10 
      (Age in Years: Mu = 46.45, sd = 17.62)",
     xlab="Sample Mean", ylab="Density",xlim=c(30,65),ylim=c(0,.25))
abline(v=mu, col="red", lwd=2, lty=2)  # Vertical line at mean

abline(v=ci90U,col="darkgrey",lty=2,lwd=2)
abline(v=ci90L,col="darkgrey",lty=2,lwd=2)

abline(v=ci95U,col="darkgrey",lty=2,lwd=2)
abline(v=ci95L,col="darkgrey",lty=2,lwd=2)

abline(v=ci99U,col="darkgrey",lty=2,lwd=2)
abline(v=ci99L,col="darkgrey",lty=2,lwd=2)


### Let's consider 95% CIs by different sample size
# First, compute 95% CIs for n=30 and n=100
# compute 95% CI: n=30
# upper bound
ci95Un30<-mean(age)+moe95n30
# lower bound
ci95Ln30<-mean(age)-moe95n30

# compute 95% CI: n=100
# upper bound
ci95Un100<-mean(age)+moe95n100
# lower bound
ci95Ln100<-mean(age)-moe95n100

###plot CIs on theoretical sampling distribution
plot(x_values, y_values1, type="l", col="black", lwd=2,
     main="Theoretical Sampling Distributions: Different Sample Sizes  
      (Age in Years: Mu = 46.45, sd = 17.62)",
     xlab="Sample Mean", ylab="Density",xlim=c(30,65),ylim=c(0,.25))
abline(v=mu, col="red", lwd=2, lty=2)  # Vertical line at mean
lines(x_values, y_values2,lwd=2,col="blue")
lines(x_values, y_values3,lwd=2,col="forestgreen")

abline(v=ci95U,col="black",lty=2,lwd=2)
abline(v=ci95L,col="black",lty=2,lwd=2)

abline(v=ci95Un30,col="blue",lty=2,lwd=2)
abline(v=ci95Ln30,col="blue",lty=2,lwd=2)

abline(v=ci95Un100,col="forestgreen",lty=2,lwd=2)
abline(v=ci95Ln100,col="forestgreen",lty=2,lwd=2)


###
#Warning: now considering GSS as sample data, not population like above
###

### confidence interval command: skip the math
t.test(age, conf.level=(0.90)) #specify the confidence level
t.test(age, conf.level=(0.95))
t.test(age, conf.level=(0.99))

### confidence intervals for proportion: nominal and ordinal variables
# slightly different equations, but you get the point by now
# so we will skip the math and just use the R command (prop.test)

# binary (0,1): nominal or ordinal variables
# first, identify number of successes 
table(female)
# prop.test(number of success,sample size)
prop.test(35973,64555, conf.level=(0.95))

# this gets more complicated when more than two categories, here is one way...
# first, identify number of responses in each category
# happiness: (1) not too happy, (2) pretty happy, (3) very happy: ordinal
table(happy)
# generate a variable to save number of responses in each category
responses <- c(8751,36159,19645)  # Frequency of responses in each category
# generate a variable to save sample size
n<-sum(responses) #one way to do this, but could just type in the sample size
# compute confidence intervals for each category
ci_list <- lapply(responses, function(x) prop.test(x, n, conf.level = 0.95)$conf.int)
# see results
ci_list

################################################################################
# computing 95% confidence intervals for mean height based on different sample sizes

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

