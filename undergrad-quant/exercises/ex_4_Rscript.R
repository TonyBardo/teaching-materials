# SOC303 R Script for Netflix exercises
# Exercise 4 answers

### load in the Netflix RData file available on our Canvas page ###
load("E:/1_UK/2_Teaching/SOC303/Data/Netflix/netflix_survey.RData")

ls(netflix_survey)

###
# Attach the dataframe
###

# sometimes useful so you don't have to include the dataframe name every time you
# want to run a command, nor will you have to include the $ symbol for variables

# before dataframe attached, example
summary(netflix_survey$age)
# this won't work
summary(age)

# now let's attach the dataframe
attach(netflix_survey)
# now this works
summary(age)

###
# Descriptive statistics for summary table
###

# Comedy Preference: ordinal
prop.table(table(comedy))

# Comedy Preference: interval-ratio
summary(comedy)
#don't forget to add the standard deviation to the table
sd(comedy)

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




