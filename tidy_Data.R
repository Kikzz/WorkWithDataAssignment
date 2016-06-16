##  tidyData.R   ##
# Gets activity Names based on Activity ID
# Adds labels to measurments columns  
# Adds activity names to measurements data set (activity column)
# Adds subject information to subject column
# Adds a column that tells if the data comes from test or train data set.
# Returns TestSet and TrainSet data frames
# Removes all objects in memory except TestSet and TrainSet (if user confirms)


## features cleanup.
feat <- features$feature
feat <- gsub("-","_",feat)
feat <- gsub("\\()","",feat)
feat <- gsub("\\,","_",feat)
feat <- sub("^t","time_", feat)
feat <- sub("^f","freq_", feat)
feat <- sub("Acc","_Accelerometer_", feat)
feat <- sub("Mag","_Magnitude", feat)
feat <- sub("Gyro","_Gyroscope_", feat)
feat <- sub("BodyBody","Body", feat)
feat <- sub("__","_", feat)

## Test data set  

## Get plain text labels for activities
names(y_test) <- "activity_id"
testLabels <- merge(y_test, activitylabels, by.x="activity_id", by.y="Id")
## Assign features as column names to X_test
names(X_test) <- feat
## Add activities and subject columns to X_test
X_test$activity <- testLabels$activity
X_test$subject <- subject_test$V1


## Train data set (same as test set)
names(y_train) <- "activity_id"
trainLabels <- merge(y_train, activitylabels, by.x="activity_id", by.y="Id")
names(X_train) <- feat
X_train$activity <- trainLabels$activity
X_train$subject <- subject_train$V1



