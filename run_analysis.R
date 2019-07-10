# Downloading And Extracting dataset

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
nameOfFile <- "completedataset.zip"
download.file(fileUrl,nameOfFile,method = "curl")
unzip(nameOfFile)
## dply library
library(dplyr)


# Assigning Variables to data

features <- read.table("C:/Users/Super/Desktop/UCI HAR DATASET/UCI HAR DATASET/features.txt",col.names = c("n","functions"))
activities <- read.table("C:/Users/Super/Desktop/UCI HAR DATASET/UCI HAR Dataset/activity_labels.txt",col.names = c("code","activity"))
subjectTest <- read.table("C:/Users/Super/Desktop/UCI HAR DATASET/UCI HAR Dataset/test/subject_test.txt",col.names = "subject")
xTest <- read.table("C:/Users/Super/Desktop/UCI HAR DATASET/UCI HAR Dataset/test/X_test.txt",col.names = features$functions)
yTest <- read.table("C:/Users/Super/Desktop/UCI HAR DATASET/UCI HAR Dataset/test/y_test.txt",col.names = "code")
subjectTrain <- read.table("C:/Users/Super/Desktop/UCI HAR DATASET/UCI HAR Dataset/train/subject_train.txt",col.names = "subject")
xTrain <- read.table("C:/Users/Super/Desktop/UCI HAR DATASET/UCI HAR Dataset/train/X_train.txt",col.names = features$functions)
yTrain <- read.table("C:/Users/Super/Desktop/UCI HAR DATASET/UCI HAR Dataset/train/y_train.txt",col.names = "code")

# Merging in 1 dataset
xData <- rbind(xTrain,xTest)
yData <- rbind(yTrain,yTest)
subjectData <- rbind(subjectTrain,subjectTest)
mergingData <- cbind(subjectData,yData,xData)

# Extracting onle the measurements on the mean and std

tidyDataSet <- mergingData%>%select(subject,code,contains("mean"),contains("std"))
tidyDataSet$code <- activities[tidyDataSet$code,2]

# labels the dataset with variables names

names(tidyDataSet)[2]="activity"
names(tidyDataSet)<-gsub("Acc", "Accelerometer", names(tidyDataSet))
names(tidyDataSet)<-gsub("Gyro", "Gyroscope", names(tidyDataSet))
names(tidyDataSet)<-gsub("BodyBody", "Body", names(tidyDataSet))
names(tidyDataSet)<-gsub("Mag", "Magnitude", names(tidyDataSet))
names(tidyDataSet)<-gsub("^t", "Time", names(tidyDataSet))
names(tidyDataSet)<-gsub("^f", "Frequency", names(tidyDataSet))
names(tidyDataSet)<-gsub("tBody", "TimeBody", names(tidyDataSet))
names(tidyDataSet)<-gsub("-mean()", "Mean", names(tidyDataSet), ignore.case = TRUE)
names(tidyDataSet)<-gsub("-std()", "STD", names(tidyDataSet), ignore.case = TRUE)
names(tidyDataSet)<-gsub("-freq()", "Frequency", names(tidyDataSet), ignore.case = TRUE)
names(tidyDataSet)<-gsub("angle", "Angle", names(tidyDataSet))
names(tidyDataSet)<-gsub("gravity", "Gravity", names(tidyDataSet))

finalDataSet <- tidyDataSet%>% 
  group_by(subject,activity) %>% 
  summarise_all(funs(mean))
write.table(finalDataSet,"FinalData.txt",row.names = FALSE)

# checking
tbl_df(finalDataSet)