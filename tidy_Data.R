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
feat <- sub("Acc","_Acc_", feat)
feat <- sub("Mag","_Mag", feat)
feat <- sub("Gyro","_Gyro_", feat)
feat <- sub("BodyBody","Body", feat)
feat <- sub("__","_", feat)

## Test data set  

## Get plain text labels for activities
names(y_test) <- "Id"
testLabels <- inner_join(y_test, activitylabels)

## Assign features as column names to X_test
names(X_test) <- feat
## Add activities and subject columns to X_test
#X_test$activity <- testLabels$activity
#X_test$subject <- subject_test$V1
X_test <- cbind(X_test,testLabels)
X_test <- cbind(X_test,subject_test)



## Train data set (same as test set)
names(y_train) <- "Id"
trainLabels <- inner_join(y_train, activitylabels)
names(X_train) <- feat
#X_train$activity <- trainLabels$activity
#X_train$subject <- subject_train$V1
X_train <- cbind(X_train,trainLabels)
X_train <- cbind(X_train,subject_train)
#X_train <- rename(X_train,subject=V1)
#X_train$activity_id <- NULL

