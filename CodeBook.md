#Code Book

The original description of the data can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#  
This document describes the transformations that have been made to the data. For the meaning of the data, please refer to the link above.  
A short description is available here:  https://github.com/Kikzz/WorkWithDataAssignment/blob/master/Dataset_ReadMe.md

The original data set can be obtained here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The whole process is automatized by running the command **source(run\_analysis.R)**  
The data will be downloaded too, so you don't need to get it manually.

## 1. Files
The root folder for paths mentioned below is "UCI HAR Dataset" where the files have beendownloaded and unzipped by **get\_files.R**.  
The files in subdirectories "/Inertial Signals" have not been processed in this exercise, since the files mentioned above contain already aggregated data from those. 

**./activity_labels.txt** Contains text values for activities used in y\_test and y\_train  
**./features.txt** Contains the names of the columns for X\_test.txt and X\_train.txt files.  
**./test/X_test.txt** Contains the test data set aggregated from the measurements.  
**./test/y_test.txt** Contains the list of activities for the test set.  
**./test/subject_test.txt** Contains the subject Id for each row of the test set.  
**./train/X_train.txt** Contains the train data set aggregated from the measurements.  
**./train/y_train.txt** Contains the list of activities for the train set.  
**./train/subject_train.txt** Contains the subject Id for each row of the train set.  

## 2. Data load
The data is loaded into R by sourcing script **load\_Data.R**  

The files above are loaded in R into variables having the name of the text files without path information and without the ".txt" extension.  
We therefore have now the following variables in memory:  
- activitylabels  
- features  
- X_test  
- y_test  
- subject_test  
- X_train  
- y_train  
- subject_train  

### Data load Methods

#### As delimited file  
The files in the root directory (activity_labels.txt and features.txt) have been loaded into R as delimited files.   

**activitylabels**:  
- read with read.delim, using blank space as separator, no headers and assigning column names "Id" and "activity" in that order.  
- transformed do a dplyr data frame with tbl_df  
  
**features**: 
- read with read.delim, using blank space as separator, no headers and assigning column names "Id" and "feature" in that order.  
- transformed do a dplyr data frame with tbl_df  
  
#### Row by row  
The files in subdirectories could not be read as delimited files because there was some leading spaces at the beginning of the file.  
The import is done in 3 steps:  
1. Store each file in a vector. Each row is an element of the vector.  
2. Transform the resulting variable into a dataframe  
3. Transform the dataframe into dplyr's tbl_df  
  
##### Function loadFiles(filepath, extension = ".txt")
This function inserts given text files located in "filepath" to R row by row using read.lines function. This eliminates the leading spaces in the files. 
The data is stored in a variable having the same name as the file without the ".txt" extension. In addition to that, a prefix "raw\_" has been added. (e.g. the data from X\_test.txt is stored into variable raw\_X\_test).  
  
##### Function toDf(x)  
This funtion transforms the "raw" vector into a data frame.  
A new variable is created for each raw variable, without the "raw_" prefix. 
The variable is created using assign() function so we can specify the name dynamically. The attribute pos=1 alloes us to specify that we want the vsriable to be created in our Global environment.  
  
##### Function toTbl(x)
This function converts the data.frame from the previous step to a tbl_df object.

## 3. Data cleansing
The data is cleaned up by sourcing **tidy_Data.R** script.  

### features data frame
The features$feature column is extracted into **feat** vector.  
It contains the names of the columns for the final data set. Basically the abbreviations have been expanded so that the data can be understood more easily.  

This vector's elements are cleaned up in the following way:  

1. Replace "-" by "_".  
2. Remove parenthesis.  
3. Replace "," by "_".  
4. Expand names starting with "t" to start with "time_".  
5. Expand names starting with "f" to start with "freq_".  
6. Expand "Acc" to "\_Accelerometer_".  
7. Expand "Mag" to "\_Magnitude_".  
8. Expand "Gyro" to "\_Gyroscopic_".  
9. Replace "BodyBody" with "Body". (Some elements seemed to have this issue).  
10. Replace possibly created double underscores "\__" by a single one "\_".  
  
### Assign features as column names to X\_test and X\_train.  
The resulting **feat** vector is assigned to names(X\_test) and names(X\_train), so we get the column names for the measurements.   
  
### y\_test and y\_train activities labels
Activities are identified by an identifier (from 1 to 6) in y\_test and y\_train dataframes.  
The corresponding names are found in activity\_id data frame.  
A new variable **testLabels** is created by merging **y\_test** and **activitylabels** variables, using **activity\_id** and **Id** as keys.  
  
### Adding activity and subject columns to X\_test and X\_train
Columns **activity** and **subject** are added to the measurements data sets by simply assigning the wanted vectors to new columns.  

- X\_test\$activity <- testLabels\$activity  
- X\_test\$subject <- subject_test\$V1 (subject column names have not been changed, we only  get the values from the 1st column V1).  

## 4. Merging test and train datasets into one dataset, subsetting it and performing calculations
These steps are done with script **merge\_group\_mean.R**.  
  
### Merge data sets  
Test and train datasets are first merged using rbind command.  

- FullSet <- rbind(X\_test,X\_train)

### Subset data sets
We only want to keep data having calculations about means and standard deviations.  
Of course we also want to keep the activity names and subjects.  
This is done by running a grep function on the column names.  
The search pattern being: column name contains "subject" OR "activity" OR "mean" OR "std".

1. FullNames <-  names(FullSet)  
2. MeanStdNames <- grep("subject|activity|mean|std",FullNames, value = TRUE)  

The resulting **MeanStdNames** vector is then used for subsetting the original merged data set.  

- DataSet <- FullSet[MeanStdNames]  

### Grouping data set
The data set is grouped by activity and subject.

- GroupedSet <- group_by(DataSet, activity, subject)

### Calculating mean for each group.
This is done with dplyr function summarize_each, which works like summarize, but on the whole table's columns and not only on a specified column.  

- MeansDataSet <- summarize_each(tbl=GroupedSet,funs(mean))  

### Renaming columns
Finally, the last step is to rename the calculated MeansDataSet columns to have a "Mean\_" prefix 

### Exporting to csv
A comma separated MeansDataSet.csv file will be created in your working directory.


## 5. Variable Cleanup
All intermediary variables that the run_analysys.R script has created can be removed by sourcing **Cleanup.R** script.  
This will leave only 3 variables in memory resulting from the script (all your own variables will be preserved).
