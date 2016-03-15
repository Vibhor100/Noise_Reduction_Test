## install the package
  source("http://bioconductor.org/biocLite.R")
  biocLite("limma")

##load the package
  library(limma)

## Step1 -- Get data
#Read the test samples from data table and combine them to a data frame
  setwd("C:\\Users\\Vibhor\\Documents\\GitHub\\gsoc2016\\data_test") #Change accordingly!
  test <- read.table(file="SCONES_test.tsv", sep="\t", header=TRUE)#read data from .csv file
  str(test) #check the summary of test
  testsample1 <- test[,4]  
  testsample2 <- test[,5]
  df <- data.frame(testsample1, testsample2)

##Step2 - Quality Assessment of raw Data
#Perform initial data visualization to view the intensity distribution of two given arrays samples 
  plot(density(df[,1], na.rm=TRUE ), main= "NonNormalize_Data")
  polygon(density(df[,1], na.rm=TRUE), border="blue")
  lines(density(df[,2],na.rm=TRUE))
  polygon(density(df[,2], na.rm=TRUE),  border="green")

##Step3 - Normalization (noise reduction)
  df <- as.matrix(df)
  dfNorm <- normalizeBetweenArrays(df, method= "cyclicloess", cyclic.method="pairs")
#Since, the logRatio signal values are already given so we will proceed to normalizeBetweenArrays 
#which is being used to Normalizes expression intensities so that the intensities or log-ratios 
#have similar distributions across a set of arrays
#We used the cyclicloess normalization method because it can both remove noise
#and retain signal most effectively among other known methods (examples: Quantile, scale)

#Quality assessment after Normalization
  plot(density(dfNorm[,1], na.rm=TRUE ), main= "Normalized_Data")
  polygon(density(dfNorm[,1], na.rm=TRUE), border="blue")
  lines(density(dfNorm[,2],na.rm=TRUE))
  polygon(density(dfNorm[,2], na.rm=TRUE),  border="green")

#It clearly shows from the density graphs that the noise has been reduced.