##===================================================================================
# HUMAN ACTIVITY RECOGNITION USING SMARTPHONES DATA SET
# Creation of a tidy data set
# SOURCE OF DATA: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, 
# Luca Oneto and Xavier Parra
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##===================================================================================

## (1) Download the '.zip' file and extract the data in the working directory
fileName<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileName,destfile="dataset.zip")
unzip("dataset.zip") ## Extract the data set in the working directory. 
                     ## A new directory called "UCI HAR Dataset" will appear in the wd.

## (2) Load and merge the training ('tr') and the test ('te') sets to 
## create one data set ('data.set')
var.names<-read.table("./UCI HAR Dataset/features.txt")
activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
sub.tr<-read.table("./UCI HAR Dataset/train/subject_train.txt")
set.tr<-read.table("./UCI HAR Dataset/train/X_train.txt")
act.tr<-read.table("./UCI HAR Dataset/train/y_train.txt")
sub.te<-read.table("./UCI HAR Dataset/test/subject_test.txt")
set.te<-read.table("./UCI HAR Dataset/test/X_test.txt")
act.te<-read.table("./UCI HAR Dataset/test/y_test.txt")

data.set<-rbind(cbind(sub.te,act.te,set.te),cbind(sub.tr,act.tr,set.tr))
rm(sub.tr,set.tr,act.tr,sub.te,set.te,act.te) ## remove unnecesary variables created

## (3) Rename the variables
colnames(data.set)[1:2]<-c("subject","activity")
labels<-as.character(var.names[,2])
for(i in 3:dim(data.set)[2]){colnames(data.set)[i]<-labels[i-2]}; rm(i,labels)

## (4) Extract only the measurements on the mean ('mean()') and standard deviation 
## ('std()') for each measurement
con<-as.logical(grepl("mean()",var.names[,2],fixed=TRUE)+
                      grepl("std()",var.names[,2],fixed=TRUE))
data.set<-data.set[,c(TRUE,TRUE,con)];rm(con)

## (5) Rename levels of activity
for(i in 1:2) data.set[,i]<-as.factor(data.set[,i]); rm(i) ## set as factor
levels(data.set$activity)<-activity[,2]

## (6) Create a second data set (data.set2) with the average of each variable 
## for each activity and each subject.
dlist<-split(data.set[,3:dim(data.set)[2]],f=list(data.set$subject,data.set$activity))
data<-t(sapply(dlist,colMeans))
A<-as.factor(rep(1:30,times=6));B<-as.factor(rep(1:6,each=30))
data.set2<-data.frame("subject"=A,"activity"=B,data)
levels(data.set2$activity)<-activity[,2];row.names(data.set2)<-NULL
rm(A,B,data,dlist,activity,var.names) ## remove unnecesary variables created

## (7) Create a '.txt' file with the data set created in step 5 ('data_set2.txt'):
write.table(data.set2,file="data_set2.txt",row.name=FALSE)
