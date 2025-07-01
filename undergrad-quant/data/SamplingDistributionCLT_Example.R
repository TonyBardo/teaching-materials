# sampling distribution and CLT example
# PPT 7 slide 34

load("E:/1_UK/2_Teaching/SOC303/Data/GSS.RData")

attach(GSS)

#computing "population" sd to use in SE equation
sdpop<-sd(age)
sdpop
#####################################
par(mfrow=c(4,2))
h=hist(age)
h$density = h$counts/sum(h$counts)
#####################################
n <- 1000                           # set number of samples
smpl_age2 <- rep(NA,n)              # randomly select
for(i in 1:n){
  smpl2 <- sample(age,2)            # sample size
  smpl_age2[i]<-mean(smpl2)         # compute means from sampling
}
a=hist(smpl_age2)                   # save means as a histogram 
a$density = a$counts/sum(a$counts)  

se2<-sdpop/sqrt(2)
se2
#####################################
n <- 1000
smpl_age5 <- rep(NA,n)
for(i in 1:n){
  smpl5 <- sample(age,5)
  smpl_age5[i]<-mean(smpl5)
}
b=hist(smpl_age5)
b$density = b$counts/sum(b$counts)

se5<-sdpop/sqrt(5)
se5
#####################################
n <- 1000
smpl_age10 <- rep(NA,n)
for(i in 1:n){
  smpl10 <- sample(age,10)
  smpl_age10[i]<-mean(smpl10)
}
c=hist(smpl_age10)
c$density = c$counts/sum(c$counts)

se10<-sdpop/sqrt(10)
se10
#####################################
n <- 1000
smpl_age30 <- rep(NA,n)
for(i in 1:n){
  smpl30 <- sample(age,30)
  smpl_age30[i]<-mean(smpl30)
}
d=hist(smpl_age30)
d$density = d$counts/sum(d$counts)

se30<-sdpop/sqrt(30)
se30
#####################################
n <- 1000
smpl_age50 <- rep(NA,n)
for(i in 1:n){
  smpl50 <- sample(age,50)
  smpl_age50[i]<-mean(smpl50)
}
e=hist(smpl_age50)
e$density = e$counts/sum(e$counts)

se50<-sdpop/sqrt(50)
se50
#####################################
n <- 1000
smpl_age100 <- rep(NA,n)
for(i in 1:n){
  smpl100 <- sample(age,100)
  smpl_age100[i]<-mean(smpl100)
}
f=hist(smpl_age100)
f$density = f$counts/sum(f$counts)

se100<-sdpop/sqrt(100)
se100
#####################################
n <- 1000
smpl_age500 <- rep(NA,n)
for(i in 1:n){
  smpl500 <- sample(age,500)
  smpl_age500[i]<-mean(smpl500)
}
g=hist(smpl_age500)
g$density = g$counts/sum(g$counts)

se500<-sdpop/sqrt(500)
se500
#####################################
mean(age)

par(mfrow=c(4,2))

plot(h,freq=FALSE,xlim=c(18,89),xlab="Ages in population",ylab="Frequency",main="")
plot(a,freq=FALSE,xlim=c(18,89),xlab="Mean Ages, n=2",ylab="Frequency",main="")
plot(b,freq=FALSE,xlim=c(18,89),xlab="Mean Ages, n=5",ylab="Frequency",main="")
plot(c,freq=FALSE,xlim=c(18,89),xlab="Mean Ages, n=10",ylab="Frequency",main="")
plot(d,freq=FALSE,xlim=c(18,89),xlab="Mean Ages, n=30",ylab="Frequency",main="")
plot(e,freq=FALSE,xlim=c(18,89),xlab="Mean Ages, n=50",ylab="Frequency",main="")
plot(f,freq=FALSE,xlim=c(18,89),xlab="Mean Ages, n=100",ylab="Frequency",main="")
plot(g,freq=FALSE,xlim=c(18,89),xlab="Mean Ages, n=500",ylab="Frequency",main="")
#####################################

