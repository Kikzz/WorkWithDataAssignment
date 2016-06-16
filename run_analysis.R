## run_analysis.R

## Set base working directory ("users/user"/datasciencecoursera/WorkWithDataAssignment).
## This is the directory where this file and other needed R scripts are located.
## Change it if needed.
## Works on OSX, not tested on windows system. Replace if needed.
setwd(file.path(path.expand("~"),"datasciencecoursera","WorkWithDataAssignment"))

# load needed libraries
source("loadLibraries.R")

# download files into working directory
n <- readline(prompt="Download files? (y/n)\n")
if (n=="y"){ source("get_files.R") }
rm(n)
# load needed files into memory
n <- readline(prompt="Do you want to load data from files into R? (y/n)\n")
if (n == "y"){
        cat("This will take some time... Sit back, relax and enjoy!\n")
        rm(n)
source("load_files.R")
}

# Cleans up and formats the data
source("tidy_Data.R")


## Merges the training and the test sets to create one data set.

FullSet <- rbind(TestSet,TrainSet)

cat("\nMerged Training and Test data sets are found in variable FullSet, (step 1, 3 and 4)")

#Extracts only the measurements on the mean and standard deviation for each measurement.
# Get column names
FullNames <-  names(FullSet)
# Get column names having "subject" or "activity" or "mean without a letter behind", or "std" in the name.
MeanStdNames <- grep("subject|activity|mean[^aA-zZ]|std",FullNames, value = TRUE)
# subset the merged dataset using the column names returned by the Regex
DataSet <- FullSet[MeanStdNames]
# replace "-" with "_" and remove "()" from column names.
names(DataSet) <- gsub("-","_",names(DataSet))
names(DataSet) <- gsub("\\()","",names(DataSet))

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

write.table(MeansDataSet,file = "MeansDataSet.csv", sep = ",", row.names=FALSE)
cat("\nThe final results are stored in MeansDataSet variable. (step 5)")
cat("\nMeansDataSet.csv file has been created in your working directory.")



## Cleanup
n <- readline(prompt="Do you want to remove temporary variables from memory? (y/n)\n")
if (n=="y"){
rm(FullNames,GroupedSet,MeanStdNames,TestSet,TrainSet,X_test,X_train,activitylabels,features,i,raw_X_test,raw_X_train,raw_subject_test,raw_subject_train,raw_y_test,raw_y_train,subject_test,subject_train,testLabels,trainLabels,x,y_test,y_train,n,Variables,filepath,loadFiles,paths,toDf,toTbl)
}