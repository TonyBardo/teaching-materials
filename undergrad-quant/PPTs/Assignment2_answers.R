x<-c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22)
age<-c(9,18,18,18,18,19,19,19,19,19,20,20,20,20,20,20,20,20,21,22,23,34)
age_OurFirm<-c(9,18,18,18,18,19,19,19,19,19,20,20,20,20,20,20,20,20,21,22,23,34)
age_FirmX<-c(7,10,11,16,17,18,19,19,20,20,21,23,22,26,28,30,33,35,37,39,40,42)

table(age)
mean(age) # 19.82
sd(age) # 4.09

SEage<-sd(age)/sqrt(length(age))
SEage # 0.87

MoEage<-2.831*SEage
MoEage # 2.47

lowerage<-mean(age) - MoEage
lowerage # 17.35

upperage<-mean(age) + MoEage
upperage # 22.29

# 95% CI
CI95age<-c(lowerage,upperage)
CI95age # (17.35,22.29)

t.test(age_OurFirm,age_FirmX,conf.level=(0.95)) 

#####################################Task A#####################################

###
# range vs sd
###

# see how range does not directly determine sd

# here is an age range greater than both our sample and Firm X
# with the same sample size (N=22)
mean(age_FirmX)
sd(age_FirmX)

HAge<-c(6,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,43)
mean(HAge)
sd(HAge)

###
# plot of mean age from samples with sd to see how average distance from mean
##

plot(age_OurFirm,x,xlim=c(0,50),ylab=("Frequency"))
abline(v=mean(age_OurFirm),lwd=2,lty=2)
segments(mean(age_OurFirm)-(sd(age_OurFirm))/2,11,mean(age_OurFirm)+(sd(age_OurFirm))/2,11,lwd=2)

plot(age_FirmX,x,xlim=c(0,50),ylab=("Frequency"))
abline(v=mean(age_FirmX),lwd=2,lty=2)
segments(mean(age_FirmX)-(sd(age_FirmX))/2,11,mean(age_FirmX)+(sd(age_FirmX))/2,11,lwd=2)

plot(HAge,x,xlim=c(0,50),ylab=("Frequency"))
abline(v=mean(HAge),lwd=2,lty=2)
segments(mean(HAge)-(sd(HAge))/2,11,mean(HAge)+(sd(HAge))/2,11,lwd=2)

#####################################Task D#####################################

###
# see how the 95% CIs for each respective sample mean age overlap
###

### FirmX's CI range
SEage_FirmX<-sd(age_FirmX)/sqrt(length(age_FirmX))
SEage_FirmX # 2.15
MoEage_FirmX<-2.831*SEage_FirmX
MoEage_FirmX # 6.08

# lower bound 95% CI
lowerage_FirmX<-mean(age_FirmX) - MoEage_FirmX
lowerage_FirmX # 18.15

# upper bound 95% CI
upperage_FirmX<-mean(age_FirmX) + MoEage_FirmX
upperage_FirmX # 30.31

### dimensions to plot CIs within
xlim <- c(0, 50)  # X-axis range
ylim <- c(0, 4)  # Y-axis range

# Create an empty plot
plot(NA, xlim = xlim, ylim = ylim,yaxt = "n",ylab=NA,xlab="Age")
segments(lowerage_FirmX,1.5,upperage_FirmX,1.5,lty=2,lwd=2)
segments(mean(age_FirmX),1.25,mean(age_FirmX),1.75,lwd=2,col="darkgrey")
segments(lowerage,2,upperage,2,lwd=2)
segments(mean(age),1.75,mean(age),2.25,lwd=2,col="darkgrey")
# add a legend
legend("topright",legend=c("Our Firm 95% CI","FirmX's 95% CI"),lty=c(1,2),
       lwd=c(2,2))


