install.packages("dplyr")
library(dplyr)

##To check if archive already exists / unzip

setwd("C:/Users/Kathrynmcdonald/Desktop/Working Directory/Getting and Cleaning data assignment/UCI HAR Dataset")

if(!file.exists("UCI HAR Dataset")) {
  if(!file.exists("dataset.zip")){
    fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file (fileURL, "dataset.zip", method="curl")
  }
  unzip("dataset.zip")
}


##To list files within the folder
list.files("UCI HAR Dataset")

##To read the data description
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

##To read the activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

##To read the test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

##To read the train data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

##To merge the training and test datasets
X_combined <- rbind(x_train, x_test)
Y_combined <- rbind(y_train, y_test)
Subject_combined <- rbind(subject_train, subject_test)

Merged_Data <- cbind(X_combined, Y_combined, Subject_combined)
Merged_Data

##Extracts only the measurements on the mean and stdev for each measurement
Clean_Data <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
Clean_Data

##Create descriptive activity names
Clean_Data$code<-activities[Clean_Data$code, 2]
Clean_Data$code

##Labels for datasets
names(Clean_Data)[2] = "activity"
names(Clean_Data)<-gsub("Acc", "Accelerometer", names(Clean_Data))
names(Clean_Data)<-gsub("Gyro", "Gyroscope", names(Clean_Data))
names(Clean_Data)<-gsub("BodyBody", "Body", names(Clean_Data))
names(Clean_Data)<-gsub("Mag", "Magnitude", names(Clean_Data))
names(Clean_Data)<-gsub("^t", "Time", names(Clean_Data))
names(Clean_Data)<-gsub("^f", "Frequency", names(Clean_Data))
names(Clean_Data)<-gsub("tBody", "TimeBody", names(Clean_Data))
names(Clean_Data)<-gsub("-mean()", "Mean", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("-std()", "STD", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("-freq()", "Frequency", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("angle", "Angle", names(Clean_Data))
names(Clean_Data)<-gsub("gravity", "Gravity", names(Clean_Data))
names(Clean_Data)

##Creating an independent tidy data set with average of each variable / activity / subject
Final_Data <- Clean_Data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Final_Data, "Final_Data_KathrynMcDonald2.txt", row.name=FALSE)
str(Final_Data)
Final_Data