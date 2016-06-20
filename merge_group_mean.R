## Merge Data, Group by and calculate means.

## Merges the training and the test sets to create one data set.

FullSet <- rbind(X_test,X_train)

cat("\nMerged Training and Test data sets are found in variable FullSet, (step 1, 3 and 4)")

#Extracts only the measurements on the mean and standard deviation for each measurement.
# Get column names
FullNames <-  names(FullSet)
# Get column names having "subject" or "activity" or "mean without a letter behind", or "std" in the name.
MeanStdNames <- grep("subject|activity|mean[^F]|std",FullNames, value = TRUE)
# subset the merged dataset using the column names returned by the Regex
DataSet <- FullSet[MeanStdNames]

cat("\nMean and Stardand deviation related variables are found in variable DataSet, (step2)")

## From the data set in step 4, creates a second, 
## independent tidy data set with the average of each variable 
## for each activity and each subject.
GroupedSet <- group_by(DataSet, activity, subject)
MeansDataSet <- summarize_each(tbl=GroupedSet,funs(mean))

# Add Mean_ in front of each column name starting from column 3. (skip activity and subject)
x <- names(MeansDataSet)
for (i in 3:length(x)) {
        x[i] <- paste0("Mean_",x[i])} 
names(MeansDataSet) <- x

write.table(MeansDataSet,file = "MeansDataSet.txt", row.names=FALSE)
write.table(MeansDataSet,file = "MeansDataSet.csv", sep=",", row.names=FALSE)
cat("\nThe final results are stored in MeansDataSet variable. (step 5)")
cat("\nMeansDataSet.csv file has been created in your working directory.")
