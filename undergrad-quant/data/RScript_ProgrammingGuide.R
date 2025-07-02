# SOC303 R: Programming guide for basic use and common commands

### before beginning an R session, making sure your workspace is clear can help
#   prevent errors, like accidentally working with the wrong data frame.
#   click the broom icons to clear out these spaces

### use written commands in the RScript to read the data frame into R 
#   helps prevent errors by allowing you to exactly retrace your steps

### read in the data frame ###
#   file location is denoted by the text that comes before the last slash in the
#   command below, which is specific to where you have the data saved
#   file name is denoted by the text that comes after the last slash in the 
#   command below, which is specific to the name that was assigned to the data
#   frame in the location where you have it saved. The text that follows the 
#   data frame's name is the file type. In this example we are working with an
#   RData file type, but data frames can be saved in many file types.

load("E:/1_UK/2_Teaching/SOC303/Data/GSS.RData")

### attach the data frame ###
#   this can make programming easier in many cases. For example, when a data
#   frame is attached you do not have to tell R what specific data frame you
#   want to work with nor use the $ symbol to denote variables 
#   "attach" is the command and the text within the brackets is the name of the 
#   data frame.
attach(GSS)

# see a list of variables in the data frame
ls(GSS)

#################### Descriptive Statistics: Common Commands ###################

###
# Frequency distribution
###

### frequency count
table(happy)
table(age)

### bar charts: nominal/ordinal variables
# First, must table the var
happy_count<-table(happy)
barplot(happy_count)

# histograms: interval-ratio variables
hist(age)

### frequency proportion
prop.table(table(happy))
prop.table(table(age))

### bar charts: nominal/ordinal variables
# First, must convert into proportions
happy_props<-prop.table(table(happy))
barplot(happy_props)


###
# Central tendency
###
 
# Mean
mean(age)

# Median
median(age)

# mode: simply the most frequent value(s), no R command

###
# Dispersion
###

#range
range(age)

#variance
var(age)

#standard deviation
sd(age)

###see how sd is just the sqrt of its var
sdage<-sqrt(var(age))
sdage

###
# Descriptive summary
###

summary(age)


