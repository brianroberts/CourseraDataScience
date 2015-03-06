library(dplyr)
library(reshape)

## Set working directory

## Download and unzip file
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(data_url, destfile="./Dataset.zip", method="curl")
unzip("./Dataset.zip", exdir="./")

## create data.tables ##

## activity_labels
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, sep=" ", fill=TRUE)
names(activity_labels) <- c("id","activity_name")

## features
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, sep=" ", fill=TRUE)

## X_test
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, fill=TRUE)
names(X_test) <- make.names(as.character(features[,2]))

## subject_test
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, fill=TRUE)
names(subject_test) <- c("subject_id")

## y_test
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, fill=TRUE)
names(y_test) <- c("activity_id")

## cbind the 3 test files together
test <- cbind(subject_test, y_test, X_test[,c(grep("mean", names(X_test)), grep("std", names(X_test)))])

## X_train
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, fill=TRUE)
names(X_train) <- make.names(as.character(features[,2]))

## subject_train
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, fill=TRUE)
names(subject_train) <- c("subject_id")

## y_train
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, fill=TRUE)
names(y_train) <- c("activity_id")

## cbind the 3 test files together
train <- cbind(subject_train, y_train, X_train[,c(grep("mean", names(X_train)), grep("std", names(X_train)))])

## MERGE:
full <- rbind(test, train)
full <- merge(full, activity_labels, by.x="activity_id", by.y="id")

## write table
write.table(full, file="./out.txt", row.names=F)

# averages
fullMelt <- melt(full, id=c(1:2,82), measure.vars=c(3:81))
subject.activity <- group_by(fullMelt, subject_id, activity_name, variable)
summarise(subject.activity, mean(value))
mean.by.subject.activity<-summarise(subject.activity, mean(value))