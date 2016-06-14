##join y_test and activitylabels

## Test data set  
names(y_test) <- "activity_id"
testLabels <- merge(y_test, activitylabels, by.x="activity_id", by.y="Id")
names(X_test) <- features$feature
X_test$activity <- testLabels$activity
X_test$subject <- subject_test$V1
TestSet <- X_test


## Train data set
names(y_train) <- "activity_id"
trainLabels <- merge(y_train, activitylabels, by.x="activity_id", by.y="Id")
names(X_train) <- features$feature
X_train$activity <- trainLabels$activity
X_train$subject <- subject_train$V1
TrainSet <- X_train

## Cleanup: Removes all variables except TestSet and TrainSet
rm(list=ls()[! ls() %in% c("TestSet", "TrainSet")])
