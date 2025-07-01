# SOC303 R Script for Exercise 6: confidence interval construction
# and hypothesis testing

# updated 03/27/2025

###
# generate a new variable to store your sample of ages
###

# try my example first
TonysAges<-c(20,18,18,18,19)

# generate your own variable to store your sample of ages


# compute the mean age of my example
mean(TonysAges) #18.6

# compute the mean age of your sample


# compute the sd of my sample mean
sd(TonysAges) # 0.8944272

# compute the sd of your sample mean


###
# generate new variables to store your sample mean and standard deviation
##

# try this with my sample mean first
TonysAges_mean<-mean(TonysAges)
TonysAges_mean # should be same as computed above (18.6)

# now generate a new variable to store your sample mean


# try this with my the sd of my sample mean first
TonysAges_sd<-sd(TonysAges)
TonysAges_sd # should be same as computed above (0.8944272)

# now generate a new variable to store the sd of your sample mean


###
# generate new variables to store the SE of your sample mean and the margin of error (MoE)
### 

# try this example for the SE of my sample mean first
TonysAges_SE<-sd(TonysAges)/sqrt(length(TonysAges)) 
TonysAges_SE # 0.4

# now generate a new variable to store the SE of your sample mean


#try this example for the MoE for my sample mean first
# let's set alpha=0.05. n=5, so t=2.776
TonysAges_MoE<-2.776*TonysAges_SE
TonysAges_MoE

# now make a new variable for your MoE
# let's set alpha=0.05. n=5, so t=2.776


###
# construct a confidence 95% interval (CI) for your sample mean
### 

# try this example of a 95% CI for my sample mean first

# lower bound interval
TonysAges_CI_lower<-TonysAges_mean - TonysAges_MoE
TonysAges_CI_lower # 17.4896

# upper bound interval
TonysAges_CI_upper<-TonysAges_mean + TonysAges_MoE
TonysAges_CI_upper # 19.7104


# now generate new lower and upper bound variables to store the results for your sample mean

# lower bound interval


# upper bound interval


###
# combine lower and upper bound intervals into one variable to store the CI
##

# try this example to store my 95% CI first

TonysAges_CI<-c(TonysAges_CI_lower,TonysAges_CI_upper)
TonysAges_CI # 95% CI(17.4896,19.7104)


# now combine your lower and upper bound intervals into one variable to store your 95% CI


###
# use the R command to estimate a 95% CI for a sample mean
###

# try this example to estimate a 95% CI with my sample first
t.test(TonysAges,conf.level=(0.95)) # (17.48942,19.71058)
# very close, but not exact match, compared to above
# because of rounding with t-table due to small sample


# now use the R command to construct a 95% CI for your sample



# Check your results with what you computed on the paper worksheet, 
# and make any adjustments if you find that you made some computational errors


################################################################################

###
# Hypothesis testing: one-sample
###

### run the examples below, and the replicate with your own data
### write your code below mine in this RScript and save your modifications

# sample mean: two-tailed with known population parameters
# based on CI exercise in class with Netflix data

# set alpha at 0.05
# other common values in social sciences are 0.01 and 0.10

# known parameters
sigma<-4.09 # population standard deviation
mu_0<-19.82 # population mean

# sample data
JF_ages<-c(34,21,23,22,19)
n<-length(JF_ages) #sample size
JF_ages_mean<-mean(JF_ages)

# compute the test statistic (Z-score)
JF_ages_Z<-(JF_ages_mean - mu_0)/(sigma/sqrt(n))
JF_ages_Z

# compute the p-value
JF_ages_p<-2*(1-pnorm(abs(JF_ages_Z)))
JF_ages_p

# interpret the results
alpha_0.05<-0.05 # significance level

if (JF_ages_p < alpha_0.05) {
  print("Reject the null hypothesis: The sample mean is significantly different from the population mean.")
}else{
  print("Fail to reject the null hypothesis: No significant difference between the sample mean and the population mean")
}

# What if we set alpha at 0.01, 99% significance level
alpha_0.01<-0.01 # significance level

if (JF_ages_p < alpha_0.01) {
  print("Reject the null hypothesis: The sample mean is significantly different from the population mean.")
}else{
  print("Fail to reject the null hypothesis: No significant difference between the sample mean and the population mean")
}

