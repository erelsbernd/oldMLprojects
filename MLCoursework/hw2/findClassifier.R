#read in data
library(readr)
library(MASS)
library(ggplot2)
library(caret)
library(e1071)
source("/Users/erelsbernd/Documents/IowaState/IowaStateSpring2017/cs474/hw2/BoxMTest.R")
#library(E1071)
#magic04 <- read_csv("http://archive.ics.uci.edu/ml/machine-learning-databases/magic/magic04.data", col_names = FALSE)
#View(magic04)

magic04 <- read.table("/Users/erelsbernd/Documents/IowaState/IowaStateSpring2017/cs474/hw2/magic04.data",header=FALSE,sep=",")
View(magic04)

#set x and class labels
x <- as.matrix(magic04[1:10])
labels <- magic04[,11]

#test first if the class means are significantly different
res.manova<-manova(as.matrix(x)~labels)
summary(res.manova,test="Wilks")

#Df   Wilks approx F num Df den Df    Pr(>F)    
#labels        1 0.67248   925.81     10  19009 < 2.2e-16 ***
#  Residuals 19018                                             
#---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Assumptions for LDA and QDA
# 1) Does each class come from Multivariate normal?
library(MVN)
hzTest(as.matrix(x[labels=="g",]), cov = FALSE, qqplot = TRUE)
#Henze-Zirkler's Multivariate Normality Test 
#--------------------------------------------- 
#data : as.matrix(x[labels == "g", ]) 
#
#HZ      : 12.72769 
#p-value : 0 
#
#Result  : Data are not multivariate normal. 
#--------------------------------------------- 

hzTest(as.matrix(x[labels=="h",]), cov = FALSE, qqplot = TRUE)
#Henze-Zirkler's Multivariate Normality Test 
#--------------------------------------------- 
#data : as.matrix(x[labels == "h", ]) 
#
#HZ      : 19.22318 
#p-value : 0 
#
#Result  : Data are not multivariate normal. 
#--------------------------------------------- 

#hzTest says for both g and h, data is not multivariate normal

#2) Homogeinity of var-covar matrices
BoxMTest(x,labels)
#------------------------------------------------
#  MBox       Chi-sqr.         df        P
#------------------------------------------------
#  49830.3950 49799.6093          55       0.0000
#------------------------------------------------
#  Covariance matrices are significantly different.
#BoxMTest says covariance matrices are significantly different
