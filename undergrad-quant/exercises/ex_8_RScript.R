# R script for Exercise 8

# Augmented Netflix Survey data with 1000 observations

load("D:/1_UK/2_Teaching/SOC303/PPTs/Exercises/8/Netflix_1000.RData")
attach(synthetic_data)

###
# recode comedy preference so greater value = greater preference
###

comedy_pref<-6-comedy

prop.table(table(comedy,comedy_pref))
plot(comedy,comedy_pref)


###
# Descriptive statistics for summary table
###

# Comedy Preference: ordinal
prop.table(table(comedy_pref))

# Comedy Preference: interval-ratio
summary(comedy_pref)
#don't forget to add the standard deviation to the table
sd(comedy_pref)

# compute the appropriate statistics to fill in the rest of the table
# use my examples in RScript_2 as a guide

# age: interval-ratio
summary(age)
sd(age)

# age: interval-ratio
summary(sage)
sd(sage)

# female: nominal (binary)
mean(female)

# gender: interval-ratio
summary(gender)
sd(gender)

# region: nominal
prop.table(table(region))

# rurality: nominal/ordinal
prop.table(table(rurality))

# ses: interval-ratio
summary(ses)
sd(ses)

# political: nominal
prop.table(table(political))

# anxiety: ordinal
prop.table(table(anxiety_cat))
# anxiety: binary
mean(anxiety_binary)

# depression: ordinal
prop.table(table(depression_cat))
# depression: binary
mean(depression_binary)

# attention: binary
mean(attention_binary)

###
# Let's try some linear regression models (LRM)
###

# turn off scientific notation if you want
options(scipen = 999) 

# First try some simple LRM

# continuous X
model<-lm(comedy_pref~age)
print(summary(model))

# binary x
model<-lm(comedy_pref~female)
print(summary(model))

# categorical x with 3-plus categories
# let's recode first
urban<-as.integer(rurality==1)
suburban<-as.integer(rurality==2)
rural<-as.integer(rurality==3)

# leave one category out as the reference group
model<-lm(comedy_pref~rural + urban)
print(summary(model))

###
# Build your own models
##


model<-lm(comedy_pref~rural + urban)
print(summary(model))



### which group can get highest R-squared 
### with theoretically justified model
### and interpret results

# recoding categorical variables
north<-as.integer(region==1)
east<-as.integer(region==2)
south<-as.integer(region==3)
west<-as.integer(region==4)

# demographics
model_1<-lm(comedy_pref~age + female + rural + urban + north + east + west + ses)
print(summary(model_1))

# subjective variables
model_2a<-lm(comedy_pref~age)
model_2b<-lm(comedy_pref~sage)
print(summary(model_2a))
print(summary(model_2b))





