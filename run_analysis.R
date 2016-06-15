## run_analysis.R

## Set base working directory (users/user/datasciencecoursera)
setwd("~/datasciencecoursera")
## Create actual working directory if it doesn't exist
if(!file.exists("./WorkWithDataAssignment")){dir.create("./WorkWithDataAssignment")}
## set working directory
setwd("./WorkWithDataAssignment")

# load needed libraries
source("loadLibraries.R")
# download files into working directory
n <- readline(prompt="Download files? (y/n)\n")
if (n=="y"){ source("get_files.R") }
rm(n)
# load needed files into memory
source("load_files.R")
# Cleans up and formats the data
source("tidy_Data.R")


## Merges the training and the test sets to create one data set.

FullSet <- rbind(TestSet,TrainSet)

cat("\nMerged Training and Test data sets are found in variable FullSet, (step 1, 3 and 4)")

#Extracts only the measurements on the mean and standard deviation for each measurement.

FullNames <-  names(FullSet)
MeanStdNames <- grep("mean[^aA-zZ]|std",FullNames, value = TRUE)
AllNames <- c("subject","activity",MeanStdNames)
DataSet <- FullSet[AllNames]
names(DataSet) <- gsub("-","_",names(DataSet))
names(DataSet) <- gsub("\\()","",names(DataSet))

cat("\nMean and Stardand deviation related variables are found in variable DataSet, (step2)")

## From the data set in step 4, creates a second, 
## independent tidy data set with the average of each variable 
## for each activity and each subject.
GroupedSet <- group_by(DataSet, activity, subject)
MeansDataSet <- summarize_each(tbl=GroupedSet,funs(mean))

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
rm(AllNames,FullNames,GroupedSet,MeanStdNames,TestSet,TrainSet,X_test,X_train,activitylabels,features,i,raw_X_test,raw_X_train,raw_subject_test,raw_subject_train,raw_y_test,raw_y_train,subject_test,subject_train,testLabels,trainLabels,x,y_test,y_train,n,Variables,filepath,loadFiles,paths,toDf,toTbl)
}