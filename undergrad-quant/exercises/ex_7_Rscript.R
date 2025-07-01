#####################SOC303 R Script for Netflix exercise 7#####################

# load in the Netflix RData file available on our Canvas page ###
load("D:/1_UK/2_Teaching/SOC303/Data/Netflix/netflix_survey.RData")

# attach the dataframe
attach(netflix_survey)

################################################################################

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

#####################################Task A#####################################

###
# Continuous-continuous
###

# 2a. Bivariate plot of Continuous variable 1a by Continuous variable 1b

# Example code for a continuous variable by continuous variable plot, scattergram
# plot(VarName1,VarName2)

# Consider some modifications and/or additional options
# plot(VarName1,VarName2,ylab="YVarName",xlab="XVarName",main="Title")

# see here for help with the plot command
help(plot)

# Insert your group's code to generate a scattergram plot below:


#####################################Task B#####################################

###
# Continuous-Nominal
###

# 3. Nominal variable category n

# Insert your group's code to obtain the within-group frequency count of a 
# continuous variable below:

# Insert your group's code to obtain the within-group proportion of a 
# continuous variable below:


# 4a. Histograms: Continuous variable frequency by binary nominal variable

# Example code:
# hist(ContVarName[NomVarName==0]) 
# hist(ContVarName[NomVarName==1])

# make the Y and X axes the same in each histogram so comparisons are fair
# hist(ContVarName[NomVarName==0],ylim=c(#,#),xlim=c(#,#)) 
# hist(ContVarName[NomVarName==1],ylim=c(#,#),xlim=c(#,#))

# Consider some modifications and/or additional options
# same as with example provided above for the plot command

# see here for help with the hist command
help(hist)

# Insert your group's code to generate histograms that depict a continuous 
# variable's frequency by a binary nominal variable below:


# 5a. Histograms: Continuous variable proportions by binary nominal variable

# Example code:
# hist(ContVarName[NomVarName==0],probability=TRUE) 
# hist(ContVarName[NomVarName==1],probability=TRUE)

# make the Y axis range from 0 to 1, the full range of possible probabilities
# hist(ContVarName[NomVarName==0],probability=TRUE,ylim=c(0,1)) 
# hist(ContVarName[NomVarName==1],probability=TRUE,ylim=c(0,1))

# make the X axes the same in each histogram for ease of comparison
# hist(ContVarName[NomVarName==0],probability=TRUE,ylim=c(0,1),xlim=c(#,#)) 
# hist(ContVarName[NomVarName==1],probability=TRUE,ylim=c(0,1),xlim=c(#,#))

# Insert your group's code to generate histograms that depict a continuous 
# variable's within-group proportions below:


# 6.Insert your group's code to compute the within-group mean and standard
# deviation of a continuous variable below:


# 7f. Insert your group's code for a hypothesis test to compare group means


#####################################Task C#####################################

###
# Nominal/Ordinal-Nominal
###


# 9. Bivariate contingency table

# Example code for bivariate contingency table
# cell frequencies only
# table(Var1Name,Var2Name)
# cell frequencies with row and column sums
# addmargins(table(Var1Name,Var2Name))
# cell proportions of total
# prop.table(table(Var1Name,Var2Name))
# cell proportions of total with row and column sums
# addmargins(prop.table(table(Var1Name,Var2Name)))
# within var2 proportions
# addmargins(prop.table(table(Var1Name,Var2Name),2),1)
# within var1 proportions
# addmargins(prop.table(table(Var1Name,Var2Name),1),2)
# Note, Var1=row, Var2=column 

# Insert your group's code to generate a bivariate contingency table below:

# 9a. cell frequencies and marginal sums

# 9b. within-Var2 proportions

###
#Chi-squared test of independence 
###

# 10f. 

# Example code for chi-squared test of independence 
# generate a new variable to store the bivariate contingency table
# var1_by_var2<-table(Var1Name,Var2Name)
# var1_by_var2

# use the chisq.test function to run the test 
# chisq.test(var1_by_var2)

# Insert your group's code to estimate a chi-squared test of independence below:

