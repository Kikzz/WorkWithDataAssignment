# Getting and Cleaning Data assignment submission
This is my submission for Getting and Cleaning Data Course Project.
Please read the instructions below to get started.


## Versions used
R version 3.2.4 (2016-03-10)   
dplyr v.0.4.3    
tidyr v.0.4.1  

##R Scripts in use

- **run_analysis.R**: Main script that calls the other scripts listed below.  
-- **loadLibraries.R**: Loads *dplyr* and *tidyr* libraries.  
-- **get_files.R**: Downloads the files needed for the analysis and unzips them in your working directory.  
-- **load_files.R**: Loads the needed files into tbl_df variables.  
-- **tidy_Data.R**: Does some cleanup.  
-- **merge_group_mean.R**: merges datasets, makes groups and calculates means, and exports results as a .csv file into your working directory.  
-- **Cleanup.R**: Removes created temporary variables, leaving only results.  


## Instructions
Copy the scripts listed above in your R working directory.  
Type in R prompt: *source("run_analysis.R")*  
If you run this for the first time, answer "y" to *get data* and *"load data"* questions.  
If you answer "y" to the question about cleaning variables, the script will only leave 3 of the variables that it created in your global environment (Dataset, FullSet and MeansDataSet).  
You can answer anything else if you want to see all variables that the script has used. This takes some memory though so you might want to remove them afterwards.  
Cleanup can be run manually with *source("Cleanup.R")*.


## Review results
After cleanup, the script will have created 3 variables in your global environment:

* **FullSet**: Merged *Train* and *Test* tidy data set.  
* **DataSet**: Subset of FullSet, containing only variables related to mean and standard deviation (in addition to subject and activity).  
* **MeansDataSet**: Final results, containing the mean for each measurement, grouped by activity and subject.

In addition to that, you will find **MeansDataSet.txt** and  **MeansDataSet.csv** files in your working directory containing the contents of MeansDataSet variable. (The csv file opens nicely in a table in github).
