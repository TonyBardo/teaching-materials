#SOC 303: Ex5_PPT: In-class coin toss exercise
# Exercise 5 R script

###
#Trial A: 10 tosses of a coin
###

# First, let's consider what the theoretical probability distribution looks like

# Generate a sequence of all possible successes (0 to 10 heads)
xA=seq(0,10,by=1) # This creates a vector from 0 to 10 by whole numbers

# Calculate the binomial probabilities for each possible success
yA<-dbinom(xA,10,0.5)

# Plot the binomial probability distribution
plot(xA,yA,ylab="Probability",xlab="Number of Successes (Heads)",
     main="Binomial Probability Distribution (Trial A: 10 Coin Flips)",ylim=c(0,0.3))
     abline(h=252*(.5^5*.5^5),lty=2) #binomial mass function pH = 5 choose 10

###Now, let's check out our data from class

#Create a vector that contains each student's sample proportion from trial A
TAprops<-c(0.4,0.7,0.9,0.9,0.8,0.6,0.3,0.5,0.5,0.6,0.4,0.7,0.2,0.4,0.3,0.6,0.7,0.2)

#use a histogram to show sample proportion distribution
hist(TAprops,main="Trial A, 10 Coin Flips: Sample Proportions",
     xlab="Propotion Heads",breaks=10,xlim=c(0,1),ylim=c(0,10))

#let's compare more closely to a standard normal distribution
#converting to kernel density for sample proportions to show approximation to normal
kdeTA<-density(TAprops)
plot(kdeTA,main="Trial A, 10 Coin Flips: Sample Proportions",
     xlab="Propotion Heads",ylim=c(0,15),xlim=c(0,1))

#overlay the theoretical normal distribution
sdA=sqrt(0.5*(1-0.5)/10)
curve(dnorm(x,mean=0.5,sd=sdA),add=TRUE,from=0,to=1,lty=2)


###
#Trial B: 30 tosses of a coin
###

# First, let's consider what the theoretical probability distribution looks like

# Generate a sequence of all possible successes (0 to 30 heads)
xB=seq(0,30,by=1) # This creates a vector from 0 to 30 by whole numbers

# Calculate the binomial probabilities for each possible success
yB<-dbinom(xB,30,0.5)

# Plot the binomial probability distribution
plot(xB,yB,ylab="Probability",xlab="Number of Successes (Heads)",
     main="Binomial Probability Distribution (Trial B: 30 Coin Flips)",ylim=c(0,0.3))
     abline(h=155117520*(.5^15*.5^15),lty=2) #binomial mass function pH = 15 choose 30

###Now, let's check out our data from class
     
#Create a vector that contains each student's sample proportion from trial B
TBprops<-c(0.40,0.50,0.50,0.47,0.47,0.57,0.47,0.50,0.43,0.40,0.63,0.47,0.47,0.47,0.46,0.50,0.56,0.50)

#use a histogram to show sample proportion distribution
hist(TBprops,main="Trial B, 30 Coin Flips: Sample Proportions",
     xlab="Propotion Heads",breaks=30,xlim=c(0,1),ylim=c(0,15))

#let's compare more closely to a standard normal distribution
#converting to kernel density for sample proportions to show approximation to normal
kdeTB<-density(TBprops)

plot(kdeTB,main="Trial B, 30 Coin Flips: Sample Proportions",
     xlab="Propotion Heads",ylim=c(0,15),xlim=c(0,1))

#overlay the theoretical normal distribution
sdB=sqrt(0.5*(1-0.5)/30)
curve(dnorm(x,mean=0.5,sd=sdB),add=TRUE,from=0,to=1,lty=2)
