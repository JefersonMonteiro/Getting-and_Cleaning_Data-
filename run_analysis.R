#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Library for reading text files
library(data.table)
library(reshape2)

#Processing the test data

activitylabels<-read.table("UCI HAR Dataset/activity_labels.txt")

#Descriptive names to labels columns
names(activitylabels)<-c("Activity.Id","Activity")

#Read
featurelist<-read.table("UCI HAR Dataset/features.txt")

# Read In test data

testsubjects<-read.table("UCI HAR Dataset/test/subject_test.txt")

names(testsubjects)<-"Subject.Id"

testdataset<-read.table("UCI HAR Dataset/test/X_test.txt")

names(testdataset)<-featurelist$V2

testactivities<-read.table("UCI HAR Dataset/test/Y_test.txt")

# rename the column name of test_activities
names(testactivities)<-"Activity.Id"

#  bind the test data set
testset<-cbind(testsubjects,testdataset,testactivities)

# Take only columns [mean, std and Subject.Id, Activity.Id]
slicedtestset <<- testset[,grepl("Subject.Id|Activity.Id|mean\\(\\)|std\\(\\)",colnames(testset))]

# Add descriptive activity names
finaltestset<-merge(slicedtestset,activitylabels,all=TRUE)

# Read In training data

trainsubjects<-read.table("UCI HAR Dataset/train/subject_train.txt")

names(trainsubjects)<-"Subject.Id"

traindataset<-read.table("UCI HAR Dataset/train/X_train.txt")

names(traindataset)<-featurelist$V2

trainactivities<-read.table("UCI HAR Dataset/train/Y_train.txt")

# Rename the column name of train_activities
names(trainactivities)<-"Activity.Id"

# bind the train data set
trainset<-cbind(trainsubjects,traindataset,trainactivities)

# Take only columns [mean, std and Subject.Id, Activity.Id]
slicedtrainset <<- trainset[,grepl("Subject.Id|Activity.Id|mean\\(\\)|std\\(\\)",colnames(trainset))]

# Descriptive activity names

finaltrainset<-merge(slicedtrainset,activitylabels,all=TRUE)

# Merge test and train dataset

data<-merge(finaltestset,finaltrainset,all=TRUE)

# Produce a tidy dataset

averagecolumns<-colnames(data[,3:68])

melteddata<- melt(data,id=c("Subject.Id","Activity"),measure.vars=averagecolumns)

tidydataset <- dcast(melteddata, Subject.Id + Activity ~ variable, mean)

# Write the Tidy Dataset

write.table(tidydataset, file = "TidyDataSet.txt", row.names= FALSE)

