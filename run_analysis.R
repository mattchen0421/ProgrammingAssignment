library(tidyverse)
features <- read.table("UCI HAR Dataset/features.txt",
                      col.colname = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt",
                         col.colname = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",
                           col.colname = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",
                     col.colname = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",
                     col.colname = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",
                            col.colname = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt",
                      col.colname = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",
                      col.colname = "code")

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merge <- cbind(subject, x, y)

tidydata <- merge %>%
    select(subject, code, contains("mean"), contains("std"))

tidydata$code <- activities[tidydata$code, 2]

colnames(tidydata)[2] = "activity"
colnames(tidydata)<-gsub("Acc", "Accelerometer", colnames(tidydata))
colnames(tidydata)<-gsub("Gyro", "Gyroscope", colnames(tidydata))
colnames(tidydata)<-gsub("BodyBody", "Body", colnames(tidydata))
colnames(tidydata)<-gsub("Mag", "Magnitude", colnames(tidydata))
colnames(tidydata)<-gsub("^t", "Time", colnames(tidydata))
colnames(tidydata)<-gsub("^f", "Frequency", colnames(tidydata))
colnames(tidydata)<-gsub("tBody", "TimeBody", colnames(tidydata))
colnames(tidydata)<-gsub("-mean()", "Mean", colnames(tidydata), ignore.case = TRUE)
colnames(tidydata)<-gsub("-std()", "STD", colnames(tidydata), ignore.case = TRUE)
colnames(tidydata)<-gsub("-freq()", "Frequency", colnames(tidydata), ignore.case = TRUE)
colnames(tidydata)<-gsub("angle", "Angle", colnames(tidydata))
colnames(tidydata)<-gsub("gravity", "Gravity", colnames(tidydata))

final <- tidydata %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(final, "FinalData.txt", row.name=FALSE)
