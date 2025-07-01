# SOC303 R Script for in-class examples
# version 4: updated 04/10/25 at line 495

### load in the GSS RData file available on our Canvas page ###
# ("specify file location/specify file name")
# sometimes R requires backslashes \ revised to forwardslashes /
load("E:/1_UK/2_Teaching/SOC303/Data/GSS.RData")

# now you should have a data frame located in your workspace with 64555 obs. and 13 variables
# all data frames are recognized by their assigned or given names
# this data frame is named GSS, which was assigned based on the file name

### let's explore the data frame and begin making sense of these data ###

# list all variables included in a data frame
# output will appear in your Console
ls(GSS)

# take a peak at what the data frame looks like
# this command prints the first six rows
head(GSS)
# this command prints the last  six rows
tail(GSS)

### summarize the data frame ###
# univariate descriptive statistics

# let's follow a similar example as we did with our class data in Excel
# we will summarize educational attainment, like we did with year in college
# in this GSS data frame this variable is a column named "educ_deg"
# Note: R uses a $ sign to recognize when a variable name appears in a command

### frequency tables ###
# table(specify data frame$specify variable)
table(GSS$educ_deg)

# results should have appeared in your Console that look like the following
#   0     1     2     3     4
# 13925 19307 15364 10840 5119

# the numbers on the top are the respective variable's values
# sometimes these values are intuitive, like with age in years
# often these values are not intuitive, like in this case with educ_deg

# variable labels are helpful, but this can get complex for beginners
# I will add variable labels, and other data management tasks as we develop our basic statistical skills

# here I add variable labels to a new variable I call educ_cat to help make sense of these data
GSS$educ_cat <- factor(GSS$educ_deg,
                       levels = c(0,1,2,3,4),
                       labels = c("<HS","HS","some college","BA","Graduate Degree"))

# let's run the table command again but for edu_cat
table(GSS$educ_cat)

# see the difference? results in your console should now look as follows
#   <HS   HS   some college    BA   Graduate Degree 
#  13925 19307    15364      10840        5119

# table proportions 
prop.table(table(GSS$educ_cat))

# table percentages by converting proportions 
prop.table(table(GSS$educ_cat))*100

### Bar Charts ###
# barplot(table(specify data frame$specify variable))
barplot(table(GSS$educ_cat))

# a bar chart should have appeared in you plot window

# let's change the y axis dimensions to better fit the data
barplot(table(GSS$educ_cat),ylim=c(0,25000))

# means
mean(GSS$educ_cat)
# recall, we recoded edu_deg numbers into categories/labels
# edu_cat is what R calls a factor variable

#let's use the original edu_deg variable that has numeric values
mean(GSS$educ_deg)

# median: same issue as above
median(GSS$educ_deg)

### let's work with an interval-ratio variable, age in years
table(GSS$age)

prop.table(table(GSS$age))

### Histograms ###
hist(GSS$age)

# let's customize our histogram
hist((GSS$age),ylim=c(0,1500),breaks=72,
main="Age Distribution: GSS 1972-2022",xlab="age")

# central tendency
mean(GSS$age)
median(GSS$age)

### 
# Dispersion
###

# Note: this example code is to produce output for learning outcome
# let's overlay a density curve to the age histogram from above to consider the skew
#same plot as above, but switch y axis from frequency count to probability
hist((GSS$age),probability=TRUE,ylim=c(0,0.025),breaks=72,
  main="Age Distribution: GSS 1972-2022",xlab="age")
# specifying normal density curve to fit the age distribution
x<-seq(min(GSS$age),max(GSS$age),length=100)
y<-dnorm(x,mean=mean(GSS$age),sd=sd(GSS$age))
# add the curve to the histogram
lines(x,y,lwd=2)
# add mean and median lines to consider skew in relation to central tendency
abline(v = mean(GSS$age),lwd=2)
abline(v = median(GSS$age),lwd=2,lty=2)

###
# Range
###
# let's explore another variable, household size
range(GSS$hhsize)

# first, let's look at it's frequency distribution and measures of central tendency
table(GSS$hhsize)
mean(GSS$hhsize)
median(GSS$hhsize)

# next, let's produce a histogram, with density curve, and mean and median indicators
# see how copy and pasted code above and replace "age" with "hhsize", adjusted ylim
hist((GSS$hhsize),probability=TRUE,ylim=c(0,0.6),breaks=16,
     main="Household Size Distribution: GSS 1972-2022",xlab="Number of People in Household")
x<-seq(min(GSS$hhsize),max(GSS$hhsize),length=100)
y<-dnorm(x,mean=mean(GSS$hhsize),sd=sd(GSS$hhsize))
lines(x,y,lwd=2)
abline(v = mean(GSS$hhsize),lwd=2)
abline(v = median(GSS$hhsize),lwd=2,lty=2)

###
# Interquartile Range (IQR)
###

# we can compute the IQR for hhs
q1 <- quantile(GSS$hhsize, 0.25)
q3 <- quantile(GSS$hhsize, 0.75)
iqr_hhs <- q3 - q1
print(iqr_hhs)
# or just use the IQR command
IQR(GSS$hhsize)

# box plots are useful for depicting IQR and identifying outliers
boxplot(GSS$hhsize,main="Household Size Distribution: GSS 1972-2022")

###
# variance
###

# we can compute the variance of hhs
varinace_hhs<-sum((GSS$hhsize - mean(GSS$hhsize))^2)/(length(GSS$hhsize)-1)
print(varinace_hhs)
# or just use the var command
var(GSS$hhsize)

###
# Standard Deviation
###

# we can compute the standard deviation for hhs
std_dev_hhs<-sqrt(sum((GSS$hhsize - mean(GSS$hhsize))^2)/(length(GSS$hhsize)-1))
print(std_dev_hhs)
# or just use the sd command
sd(GSS$hhsize)

###
# Computing Descriptive Statistics for Summary Table
##

# Happiness: ordinal variable
prop.table(table(GSS$happy))

# Age: interval-ratio variable
# see how the summary command provides many different statistics
summary(GSS$age)
sd(GSS$age)

# Female: nominal variable (binary, means only two categories)
# this is a special case where only need to report one category, 
# because remainder is intuitive (sums to 100%, see Descriptive Table)
mean(GSS$female)

# White: nominal variable (binary)
mean(GSS$white)

# Educational Attainment: ordinal variable
prop.table(table(GSS$educ_deg))

# Married: nominal variable (binary)
mean(GSS$married)

# Household Size: interval-ratio variable
summary(GSS$hhsize)
sd(GSS$hhsize)

# Political Party Affiliation: nominal variable
prop.table(table(GSS$polit_party))

### End Descriptive Example for Summary Table ###

########################Inferential Statistics##################################
load("E:/1_UK/2_Teaching/SOC303/Data/GSS.RData")
# First, attaching GSS like with Netflix data 
attach(GSS)


### 
#Confidence Intervals (CI) 
##

# sample mean with unknown parameters

# generate variables to insert in CI equation
xbar<-mean(age)  #sample mean
sd<-sd(age)      #sample standard deviation
n=64555   #sample size
se<-sd/sqrt(n)   #standard error of the mean

# compute confidence intervals for mean age at different alpha levels 
# 99% CI alpha = .01, 95% = .05, 90% = .10

# compute 99% CI
# first, compute margin of error (MoE)
moe99<-2.58*se
# compute upper bound interval
ci99U<-xbar+moe99
# compute lower bound interval
ci99L<-xbar-moe99

# compute 95% CI
# first, compute margin of error (MoE)
moe95<-1.96*se
# compute upper bound interval
ci95U<-xbar+moe95
# compute lower bound interval
ci95L<-xbar-moe95

# compute 90% CI
# first, compute margin of error (MoE)
moe90<-1.65*se
# compute upper bound interval
ci90U<-xbar+moe90
# compute lower bound interval
ci90L<-xbar-moe90

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

#######################Bivariate Statistics#####################################

load("E:/1_UK/2_Teaching/SOC303/Data/GSS.RData")
# First, attaching GSS like with Netflix data 
attach(GSS)

###
# Crosstabulation 
###
# examine two variables simultaneously, to begin to explore their association
# see how approaches may differ in terms of level of measurement(s)

# continuous-continuous
# let's examine educational attainment by birth-year (cohort)
# hypothesis: it's reasonable to expect that mean years of educational attainment
# have increased among those who were born in relatively more recent years

# Recall, these GSS data are from 1972-2022
summary(year)
# with 34 unique random samples between 1972-2022 
num_unique_values<-length(unique(year))
num_unique_values

# Birth years for respondents range from 1883-2004
summary(cohort)

# Let's look at the distribution of education in the whole sample

# frequency count 
table(educ_yrs)
# histogram of frequency count
hist(educ_yrs)
# adjust y-axis in plot
hist(educ_yrs,ylim=c(0,25000))

# it can be helpful to consider in terms of proportions
prop.table(table(educ_yrs))
# use "probability=TRUE" command for continuous variables
hist(educ_yrs,probability=TRUE)
# adjust y-axis in plot
hist(educ_yrs,probability=TRUE,ylim=c(0,1))
# adjust y-axis in plot however you want
hist(educ_yrs,probability=TRUE,ylim=c(0,0.5))

# Let's look at the distribution of education by cohort
# frequency count: crosstab
table(cohort,educ_yrs)
# too many birth years (cohorts) to print in results
# change settings
options(max.print=10000)
# now try
table(cohort,educ_yrs)

# Next, let's compute the mean years of education in the whole sample
mean(educ_yrs) # 12.98
sd(educ_yrs) # 3.19

# cohort-specific mean
# compute mean by cohort and store in new variable
educ_mean_by_cohort<-aggregate(educ_yrs~cohort,FUN=mean)
educ_mean_by_cohort
# scattergram
plot(educ_mean_by_cohort,ylim=c(5,15),ylab=("Mean Years of Education"),
     xlab=("Birth Cohort"),
     main=("Mean Years of Education by Birth Cohort: GSS 1972-2022 N=64,555"))

# it looks like mean years of education has increased among more recent cohorts
# we can test this hypothesis, but we that requires some relatively more complex
# methods that we will build up to

# continuous-nominal
# let's consider whether mean years of education differs between two groups
# males vs females

# frequency count: corsstab
table(female,educ_yrs)
# mean and sd by sex
# males
mean(educ_yrs[female==0])
sd(educ_yrs[female==0])
# females
mean(educ_yrs[female==1])
sd(educ_yrs[female==1])
# histogram of frequency count...
# males
hist(educ_yrs[female==0],ylim=c(0,15000),xlab=("Years of Education"),
     main=("Males: Years of Education (mean=13.11, sd=3.34)"))
# add a reference line for male mean years of education
abline(v=mean(educ_yrs[female==0]),lty=2,lwd=2)
# females
hist(educ_yrs[female==1],ylim=c(0,15000),xlab=("Years of Education"),
     main=("Females: Years of Education (mean=12.87, sd=3.06)"))
# add a reference line for female mean years of education
abline(v=mean(educ_yrs[female==1]),lty=2,lwd=2)

# it can be helpful to consider in terms of proportions
options(digits=2)
prop.table(table(female,educ_yrs))
# use "probability=TRUE" command for continuous variables
# males
hist(educ_yrs[female==0],probability=TRUE,ylim=c(0,1),xlab=("Years of Education"),
     ylab=("Proportion"),main=("Males: Years of Education (mean=13.11, sd=3.34)"))
abline(v=mean(educ_yrs[female==0]),lty=2,lwd=2)
# females
hist(educ_yrs[female==1],probability=TRUE,ylim=c(0,1),xlab=("Years of Education"),
     ylab=("Proportion"),main=("Females: Years of Education (mean=12.87, sd=3.06)"))
abline(v=mean(educ_yrs[female==1]),lty=2,lwd=2)

# sex-specific mean
# compute mean by sex and store in new variable
educ_by_sex<-tapply(educ_yrs,female,mean)
educ_by_sex # male: 13.11, female: 12.87
barplot(educ_by_sex,ylim=c(0,20),ylab=("Years of Education"),
        names.arg=c("Male","Female"),main=("Mean Years of Education by Sex"))


# the difference in mean years of education by sex (male/female) is small, but 
# it could be statistically significant

# Hypothesis: mean years of education is greater among males vs females
# one-tailed two-sample t-test
options(digits=4)
t.test(educ_yrs~female,alternative="greater")

# Why is such a small difference statistically significant?
# we're working with a huge sample size (N=64555)

# recall, the SE, and hence MoE, are a function of sample size
# as sample size increases the SE decreases and precision increases

# let's check out the 95% CI for male and female mean years of education
# male
t.test(educ_yrs[female==0],conf.level=(0.95)) # (13.07,13.15)
# female
t.test(educ_yrs[female==1],conf.level=(0.95)) # (12.84,12.90)

# a more important question, is whether a statistically significant result is
# meaningful


# ordinal-nominal
# lets consider happiness among males vs females

# First, let's look at the distribution of happiness in the whole sample

# frequency count
table(happy)
# bar chart of frequency count
barplot(table((happy)),ylim=c(0,40000))

# it can be helpful to consider in terms of proportions
prop.table(table(happy))

# in order to make a barplot of proportions for an ordinal variable we can 
# compute and store those in a new variable 
prop_happy<-prop.table(table(happy))
# and then plot the new variable with proportions
barplot(prop_happy)
# there are many commands to change how plots look
# ylim=c(lowernum,uppernum) changes the y axis dimensions
# names.arg gives labels to the xvar categories in the plot
barplot(prop_happy,ylim=c(0,1),
        names.arg=c("not too happy","pretty happy","very happy"))

# Now, let's examine happiness by sex (0=male,1=female)

# contingency tables are relatively more useful when working with categorical variables
# arrange so the "DV" is denoted by rows, and the "IV" is denoted by collumns 

# frequency count: crosstab
table(happy,female)
# provides row and column totals
addmargins(table(happy,female))
# bar chart of frequency count
#male
barplot(table(happy[female==0]),ylim=c(0,25000),main=("Happiness: Males"),
        names.arg=c("not too happy","pretty happy","very happy"))
#female
barplot(table(happy[female==1]),ylim=c(0,25000),main=("Happiness: Females"),
        names.arg=c("not too happy","pretty happy","very happy"))


# it can be helpful to consider in terms of proportions
options(digits=2)
prop.table(table(happy,female))
# provides row and column totals in proportions by default
addmargins(prop.table(table(happy,female)))
# provides column prportions and row margins
addmargins(prop.table(table(happy,female),2),1)


# in order to make a barplot of proportions for an ordinal variable we can 
# compute and store those in a new variable 
# let's do this now by sex (male,female)
# male
prop_happy_male<-prop.table(table(happy[female==0]))
barplot(prop_happy_male,ylim=c(0,1),main=("Happiness: Males"),
        names.arg=c("not too happy","pretty happy","very happy"))
# female
prop_happy_female<-prop.table(table(happy[female==1]))
barplot(prop_happy_female,ylim=c(0,1),main=("Happiness: Females"),
        names.arg=c("not too happy","pretty happy","very happy"))

###
#Chi-squared test of independence: nominal/ordinal-nominal/ordinal
###
happy_by_sex<-table(happy,female)
happy_by_sex

chisq.test(happy_by_sex)

#######################Bivariate Statistics Continued###########################

load("E:/1_UK/2_Teaching/SOC303/Data/GSS.RData")
load("D:/1_UK/2_Teaching/SOC303/Data/GSS.RData")
attach(GSS)

###
# Analysis of Variance (ANOVA): continuous-nominal
###
# frequency of education years by political party affiliation
table(polit_party,educ_yrs)
# mean and sd by party
# democrats
mean(educ_yrs[polit_party==1])
sd(educ_yrs[polit_party==1])
# other
mean(educ_yrs[polit_party==2])
sd(educ_yrs[polit_party==2])
# republican
mean(educ_yrs[polit_party==3])
sd(educ_yrs[polit_party==3])
# histogram of frequency count...
# democrat
hist(educ_yrs[polit_party==1],ylim=c(0,15000),xlab=("Years of Education"),
     main=("Democrats: Years of Education (mean=12.85, sd=3.33)"))
# add a reference line for male mean years of education
abline(v=mean(educ_yrs[polit_party==1]),lty=2,lwd=2)
# other
hist(educ_yrs[polit_party==2],ylim=c(0,15000),xlab=("Years of Education"),
     main=("Indep./Other: Years of Education (mean=12.57, sd=3.14)"))
# add a reference line for female mean years of education
abline(v=mean(educ_yrs[polit_party==2]),lty=2,lwd=2)
# republican
hist(educ_yrs[polit_party==3],ylim=c(0,15000),xlab=("Years of Education"),
     main=("Republicans: Years of Education (mean=13.36, sd=2.94)"))
# add a reference line for female mean years of education
abline(v=mean(educ_yrs[polit_party==3]),lty=2,lwd=2)


# it can be helpful to consider in terms of proportions
options(digits=2)
prop.table(table(polit_party,educ_yrs))
# use "probability=TRUE" command for continuous variables
# democrat
hist(educ_yrs[polit_party==1],ylim=c(0,1),probability=TRUE,
     xlab=("Years of Education"),
     main=("Democrats: Years of Education (mean=12.85, sd=3.33)"))
# add a reference line for male mean years of education
abline(v=mean(educ_yrs[polit_party==1]),lty=2,lwd=2)
# other
hist(educ_yrs[polit_party==2],ylim=c(0,1),probability=TRUE,
     xlab=("Years of Education"),
     main=("Indep./Other: Years of Education (mean=12.57, sd=3.14)"))
# add a reference line for female mean years of education
abline(v=mean(educ_yrs[polit_party==2]),lty=2,lwd=2)
# republican
hist(educ_yrs[polit_party==3],ylim=c(0,1),probability=TRUE,
     xlab=("Years of Education"),
     main=("Republicans: Years of Education (mean=13.36, sd=2.94)"))
# add a reference line for female mean years of education
abline(v=mean(educ_yrs[polit_party==3]),lty=2,lwd=2)

# Political Party Affiliation-specific mean
# compute mean by sex and store in new variable
educ_by_polit<-tapply(educ_yrs,polit_party,mean)
educ_by_polit # democrat: 12.85, other: 12.57, republican: 13.36
barplot(educ_by_polit,ylim=c(0,20),ylab=("Years of Education"),
        names.arg=c("Democrat","Other","Republican"),
        main=("Mean Years of Education by Political Party Affiliation"))

### Total Sum of Squares (SST)
# square each data point: by group example
dem_sqr<-(educ_yrs[polit_party==1]*educ_yrs[polit_party==1]) # democrat 
ind_sqr<-(educ_yrs[polit_party==2]*educ_yrs[polit_party==2]) # independent/other 
rep_sqr<-(educ_yrs[polit_party==3]*educ_yrs[polit_party==3]) # republican 
# sum each squared data point: by group example 
sum_dem_sqr<-sum(dem_sqr) # 5571665
sum_ind_sqr<-sum(ind_sqr) # 1856215
sum_rep_sqr<-sum(rep_sqr) # 4096261
sum_sqr=sum_dem_sqr+sum_ind_sqr+sum_rep_sqr
sum_sqr # 11524141
# square each data point: all together example
edu_sqr=educ_yrs*educ_yrs
# sum each squared data point: all together example
sum_edu_sqr<-sum(edu_sqr)
sum_edu_sqr # 11524141

# find the total sample size (N)
N<-length(educ_yrs)

# find the grand mean
mean_grand<-mean(educ_yrs)
mean_grand # 12.98
# square the grand mean
mean_grand_sqr<-mean_grand*mean_grand
mean_grand_sqr

# find the SST
SST<-(sum_sqr)-N*mean_grand_sqr
SST

# the above example shows how SST is computed step by step
# below shows how SST can be computed more efficiently
SST_equation<-sum((educ_yrs-mean(educ_yrs))^2)
SST_equation

### Sum of Squares Between (SSB)
# find the number of cases in each group
n_dem<-length(dem_sqr) # 31615
n_ind<-length(ind_sqr) # 11050
n_rep<-length(rep_sqr) # 21890

# find each group-specific mean
mean_dem<-mean(educ_yrs[polit_party==1]) # democrat 
mean_dem # 12.85
mean_ind<-mean(educ_yrs[polit_party==2]) # independent/other 
mean_ind # 12.57
mean_rep<-mean(educ_yrs[polit_party==3]) # republican 
mean_rep # 13.36

# subtract the grand mean from the group mean
dif_dem_mean=mean_dem-mean_grand
dif_ind_mean=mean_ind-mean_grand
dif_rep_mean=mean_rep-mean_grand
# square the differences in the group vs grand means
dif_dem_mean_sqr<-dif_dem_mean^2 # 0.016
dif_ind_mean_sqr<-dif_ind_mean^2 # 0.162
dif_rep_mean_sqr<-dif_rep_mean^2 # 0.147

# multiply group size by group squared differences, respectively
dem_n_dif<-n_dem*dif_dem_mean_sqr #  492.07
ind_n_dif<-n_ind*dif_ind_mean_sqr # 1792.52
rep_n_dif<-n_rep*dif_rep_mean_sqr # 3219.37

# find the SSB
SSB<-dem_n_dif + ind_n_dif + rep_n_dif
SSB

# the above example shows how SSB is computed step by step
# below shows how SSB can be computed more efficiently
group_means<-tapply(educ_yrs,polit_party,mean)
group_counts<-table(polit_party)
SSB_equation<-sum(group_counts*(group_means-mean_grand)^2)
SSB_equation

### Sum of Squares Within (SSW)
# for each group, sum each value and square
# we already did this
sum_dem_sqr # 5571665
sum_ind_sqr # 1856215
sum_rep_sqr # 4096261

# find the group total 
dem_total<-sum(educ_yrs[polit_party==1]) # 406277
ind_total<-sum(educ_yrs[polit_party==2]) # 138929
rep_total<-sum(educ_yrs[polit_party==3]) # 292429

# square the group total
dem_total_sqr<-dem_total^2 # 165061000729
ind_total_sqr<-ind_total^2 #  19301267041
rep_total_sqr<-rep_total^2 #  85514720041

# divide squared group total by group size
divn_dem_total<-dem_total_sqr/n_dem # 5220971.08
divn_ind_total<-ind_total_sqr/n_ind # 1746721.00
divn_rep_total<-rep_total_sqr/n_rep # 3906565.56

# subtract the divided squared group total from the squared values summed
# in other words, subtract the second from the first
dem_sub<-sum_dem_sqr-divn_dem_total # 350693.92
ind_sub<-sum_ind_sqr-divn_ind_total # 109494.00
rep_sub<-sum_rep_sqr-divn_rep_total # 189695.44

# find the SSW
SSW<-dem_sub+ind_sub+rep_sub # 649883.36

# the above example shows how SSW is computed step by step
# below shows how SSW can be computed more efficiently
SSW_equation<-sum((educ_yrs-group_means[polit_party])^2)
SSW_equation

# Also, once any two among SST, SSB, SSW, are known, the other can be solved
SSW_proof<-SST-SSB
SSW_proof; SSW

SSB_proof<-SST-SSW
SSB_proof; SSB
  
SST_proof<-SSW+SSB
SST_proof; SST

### find the degrees of freedom (df)
# number of groups
k=3

# degrees of freedom within (dfw)
dfw<-N-k
# degrees of freedom between (dfb)
dfb<-k-1

### find the mean square estimates

# mean square within (MSW)
MSW=SSW/dfw
MSW
# mean square between (MSB)
MSB=SSB/dfb
MSB

### find the F ratio
F=MSB/MSW
F

### one-way ANOVA function
aov(educ_yrs ~ polit_party)

# unbalanced model, so does not show results because they may be biased
# see results using the code below
model<-aov(educ_yrs ~ polit_party)
summary(model)

# SSB and SSW can be extracted from the ANOVA table
anova_table<-anova(model)
ssb <- anova_table[["Sum Sq"]][1]
ssb
ssw <- anova_table[["Sum Sq"]][2]
ssw

# The extracted SSB and SSW differ from what we computed because of different
# methods used by R due to the unbalanced design, but SST should be the same
sst=ssw+ssb
sst

### R-squared: proportion of variance explained by group differences
R2a=SSB/SST # 0.008
# also obtained by
R2b=1-(SSW/SST)

#######################Bivariate Statistics Continued###########################

load("E:/1_UK/2_Teaching/SOC303/Data/GSS.RData")
attach(GSS)

###
# Pearson's r: continuous-continuous association
###
# first let's check out a scattergram to see if any linear pattern
# let's consider years of education by cohort (birth year)
plot(cohort,educ_yrs,ylim=c(0,20))
# too many data points (N=64,555) to see pattern in association
# let's try the jitter function in r, reduces overplotting to enhance visualization
plot(jitter(cohort,amount=0.3),educ_yrs)
# sill difficult to see pattern, let's modify color and transparency
plot(jitter(cohort,amount=0.3),educ_yrs,pch = 10, col = rgb(0, 0, 1, 0.1))


# can also consider plotting a random sample with a smaller n from the overall sample
set.seed(123)  # for reproducibility
sample_index <- sample(1:length(cohort), 10000)  # draw 10k random cases

plot(jitter(cohort[sample_index], amount = 0.3), educ_yrs[sample_index],
     xlab = "Cohort (Jittered)", ylab = "Years of Education",
     main = "Subset Scatterplot with Jitter",
     pch = 10, col = rgb(0, 0, 1, 0.1))

### let's estimate Pearson's r correlation coefficient step by step

# compute means for x and y
mean_x<-mean(cohort)
mean_y<-mean(educ_yrs)

# compute deviations from the mean for x and y
dev_x<-cohort - mean_x
dev_y<-educ_yrs - mean_y

# sum of products of deviations
numerator<-sum(dev_x * dev_y)


# compute standard deviations for x and y
sd_x<-sd(cohort)
sd_y<-sd(educ_yrs)

# divide by product of standard deviations
denominator<-(length(cohort)-1) * sd_x * sd_y
# compute Pearson's r
r<-numerator / denominator 
r

### or you can just use the covariance command in r
cov_xy<-cov(cohort,educ_yrs)
r_covfun<-cov_xy/(sd_x * sd_y)
r_covfun

### or you can simply use the cor command in r  
cor(cohort,educ_yrs,method="pearson")

### let's see if this association, r, is statistically significant 

# fisher's z-transformation
z_prime<-0.5 * log((1+r)/(1-r))

# standard error
n<-length(cohort)
SE<-1/sqrt(n-3)

# z-statistic
z_stat<-z_prime/SE
z_stat

# two-tailed p-value
p_value<-2*(1-pnorm(abs(z_stat)))
p_value

# 95% CI for Fisher's Z
z_crit<-qnorm(0.975)
z_lower<-z_prime - z_crit * SE
z_upper<-z_prime + z_crit * SE

# convert CI back to r
r_lower<- (exp(2 * z_lower) - 1) / (exp(2 * z_lower) + 1)
r_upper <- (exp(2 * z_upper) - 1) / (exp(2 * z_upper) + 1)

CI_95<-c(r_lower, r_upper)
CI_95

list(
  r = r,
  z_statistic = z_stat,
  p_value = p_value,
  CI_95 = c(r_lower, r_upper)
)

### or, you can simply use the cor.test command in r  
cor.test(cohort,educ_yrs,method="pearson")

### let's consider proportion of variance in education (Y) explained by
### cohort (x)
# R-squared
r2=r^2
r2

### correlation matrix
# entire GSS dataset
options(digits=1)
cor(GSS) # pearson's r is default

# or, select variables
cor(cbind(year,age,cohort,hhsize,educ_yrs))

#######################Bivariate Statistics Continued###########################

load("D:/1_UK/2_Teaching/SOC303/Data/GSS.RData")
attach(GSS)

###
# Simple linear regression model (LRM): continuous Y and any X association
###

# let's continue with our education ~ cohort example 
plot(jitter(cohort,amount=0.3),educ_yrs,pch = 10, col = rgb(0, 0, 1, 0.1))

# mean of Y: education
mean_educ<-mean(educ_yrs)
# mean of X: cohort
mean_cohort<-mean(cohort)

# calculate the slope b1
b1<-sum((cohort-mean_cohort)*(educ_yrs-mean_educ))/sum((cohort-mean_cohort)^2)
b1

# calculate the intercept b0
b0<-mean_educ-b1*mean_cohort
b0

# compute predicted values (Y-hat)
predicted_educ<-b0+b1*cohort

# Calculate Total Sum of Squares (TSS)
TSS<- sum((educ_yrs - mean_educ)^2)
TSS

# Calculate Explained Sum of Squares (ESS)
ESS<-sum((predicted_educ-mean_educ)^2)
ESS

# Calculate Residual Sum of Squares (RSS)
RSS<-sum((educ_yrs-predicted_educ)^2)
RSS

# Compute R-squared
R_square<-ESS/TSS
R_square

# or, we could just use the linear regression function in R
lm(educ_yrs~cohort)
# for additonal results try this
model<-lm(educ_yrs~cohort)
print(summary(model))
# suppress scientific notation if you want
options(scipen = 999) 
print(summary(model))

# add the regression line to the X Y plot
plot(jitter(cohort,amount=0.3),educ_yrs,pch = 10, col = rgb(0, 0, 1, 0.1))
abline(model,lwd=4)
summary(cohort)
# see how well the regression line fits the cohort-specific mean pattern
educ_mean_by_cohort<-aggregate(educ_yrs~cohort,FUN=mean)
educ_mean_by_cohort
# I stopped using jitter in the X,Y scatter plot because it takes too long
plot(cohort,educ_yrs)
# add the linear regression line
abline(model,lwd=4)
# add the cohort-specific mean education pattern
lines(educ_mean_by_cohort$cohort,educ_mean_by_cohort$educ_yrs,lty=2,lwd=4)

# Cohort-specific mean education pattern is non linear
# one way to address this is to add polynomial terms of X into the linear regression model
# polynomial terms of X for non-linear patterns
model_2<-lm(educ_yrs~poly(cohort,2))
print(summary(model_2))

# add the regression line from model with polynomial terms
# first we need to compute predicted values for the polynomial terms 
# by accounting for the two beta terms for cohort and cohort^2

# create a sequence of X (cohort) values over the range of X
cohort_seq <- sort(unique(cohort))
pred_data <- data.frame(
  cohort = cohort_seq,
  cohort2 = cohort_seq^2
)
# find the predicted values
predicted_vals <- predict(model_2, newdata = pred_data)

# re-run the previous plot
plot(jitter(cohort,amount=0.3),educ_yrs,pch = 10, col = rgb(0, 0, 1, 0.1))
# add the linear regression line
abline(model,lwd=4)
# add the cohort-specific mean education pattern
lines(educ_mean_by_cohort$cohort,educ_mean_by_cohort$educ_yrs,lty=2,lwd=4)
# overlay the regression line from the polynomial model
lines(cohort_seq, predicted_vals, col = "red", lwd = 4)

# let's try the polynomial transformation of X by hand
cohort_sqr<-cohort^2
# polynomial terms of X for non-linear patterns
model_2b<-lm(educ_yrs~cohort + cohort_sqr)
print(summary(model_2b))

### confidence intervals
# let's revisit the simple linear regression model
model<-lm(educ_yrs~cohort)
options(scipen = 999) 
print(summary(model))
confint(model, level = 0.95)

### practice interpretation with different types of Xs
ls(GSS)

# continuous X
model_eduyear<-lm(educ_yrs~year)
options(scipen = 999) 
print(summary(model_eduyear))
confint(model_eduyear, level = 0.95)

# see how well the regression line fits the year-specific mean pattern
educ_mean_by_year<-aggregate(educ_yrs~year,FUN=mean)
educ_mean_by_year

# what does the linear association between education and year look like?
# empty plot with appropriate dimensions for X (year) and y (education)
plot(year,educ_yrs,pch=NA,main="Linear Regression Line Fitted Over Year-Specific Mean Education")
# year-specific mean of education
points(educ_mean_by_year$year,educ_mean_by_year$educ_yrs,pch=2)
# add the linear regression line
abline(model_eduyear,lwd=2)

# binary x
model_edurace<-lm(educ_yrs~white)
options(scipen = 999) 
print(summary(model_edurace))
confint(model_edurace, level = 0.95)

# categorical x with 3+ categories

# first I am going to recode political party affiliation (polit_party), so R
# recognizes it as a categorical variable with 3 categories (Dem,Ind,Rep)
partyafil<-factor(polit_party,levels=c("1","2","3"),labels=c("Dem","Ind","Rep"))

# let's start by using Republican (Rep) as the reference category  
model_edupolit<-lm(educ_yrs~relevel(factor(partyafil),ref="Rep"))
options(scipen = 999) 
print(summary(model_edupolit))
confint(model_edupolit, level = 0.95)

# let's switch the reference category to Democrat
model_edupolit<-lm(educ_yrs~relevel(factor(partyafil),ref="Dem"))
options(scipen = 999) 
print(summary(model_edupolit))
confint(model_edupolit, level = 0.95)

# let's see what happens if we don't treat X as a categorical variable
model_edupolit<-lm(educ_yrs~polit_party)
options(scipen = 999) 
print(summary(model_edupolit))
confint(model_edupolit, level = 0.95)

summary(polit_party)

#######################Multivariate Statistics#################################

load("E:/1_UK/2_Teaching/SOC303/Data/GSS.RData")
attach(GSS)

###
# multiple linear regression model (LRM)
###

model_1<-lm(educ_yrs~white)
options(scipen = 999) 
print(summary(model_1))

# partyafil<-factor(polit_party,levels=c("1","2","3"),labels=c("Dem","Ind","Rep"))
model_2<-lm(educ_yrs~relevel(factor(partyafil),ref="Dem"))
options(scipen = 999) 
print(summary(model_2))

model_3<-lm(educ_yrs~white + relevel(factor(partyafil),ref="Dem"))
options(scipen = 999) 
print(summary(model_3))

# interaction terms
# let's try this with the same variables, but we will break them down into individual
# indicators that will hopefully make this a bit more intuitive

# create indicator variables for political party affiliation
dem <- as.integer(polit_party == 1)
ind <- as.integer(polit_party == 2)
rep <- as.integer(polit_party == 3)

# create interaction terms for white and political party affiliation
white_dem<-white * dem
white_ind<-white * ind
white_rep<-white * rep

# linear regression model with interaction terms
model_4<-lm(educ_yrs~white + rep + white_rep + ind  + white_ind)
options(scipen = 999) 
print(summary(model_4))

# let's run model 4 again using some different code 
# and plot the predicted values to aid interpretation

model_4b<-lm(educ_yrs~white + rep + ind + white:rep + white:ind)
options(scipen = 999) 
print(summary(model_4b))

# create a prediction grid for all combinations of Xs
# All combinations of race and party
new_data <- expand.grid(
  white = c(0, 1),
  rep = c(0, 1),
  ind = c(0, 1)
)

# Remove logically impossible combinations (e.g., both republican and independent = 1)
new_data <- subset(new_data, !(rep == 1 & ind == 1))

# add interaction terms
new_data$white_rep <- new_data$white * new_data$rep
new_data$white_ind <- new_data$white * new_data$ind

# get predicted values
new_data$predicted_education <- predict(model_4b, newdata = new_data)

# add labels for plotting
new_data$party <- with(new_data, ifelse(rep == 1, "Republican",
                                        ifelse(ind == 1, "Independent", "Democrat")))
new_data$race <- ifelse(new_data$white == 1, "White", "Non-white")

# plot the predicted values

barplot(
  height = new_data$predicted_education,
  names.arg = paste(new_data$race, new_data$party, sep = "\n"),
  col = c("gray70", "gray40", "skyblue", "steelblue", "tan", "goldenrod"),
  ylim = c(0, max(new_data$predicted_education) + 1),
  ylab = "Predicted Years of Education",
  main = "Predicted Education by Race and Party"
)

















