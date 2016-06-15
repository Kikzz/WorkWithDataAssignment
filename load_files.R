## /!\ N.B commands work on OSX, not on windows. /!\
## Your working directory needs to be the directory where "UCI HAR Dataset" directory is located
n <- readline(prompt="Do you want to load data from files into R? (y/n)\n")
if (n == "y"){
        cat("This will take some time... Sit back, relax and enjoy!\n")
        rm(n)
        
        ## Function for loading files into memory
        loadFiles <- function(filepath, extension = ".txt"){
                ## Loads files ending in "extension" into variables named as the filename without the extension.
                ## We start at j=2 so we skip the root direcrory "UCI HAR Dataset", since we loaded it separately.
                cat("\nLoading Raw Data\n")
                VarNames <- vector(mode="character")
                files <- vector(mode="character")
                # Based on directory listing, we are interested only in folders 2 and 4, hence j in c(2,4)
                # Replace with j in 2:length(filepath) to get all files except from root directory.        
                # j in 1:length(filepath) if you want also root directory.               
                for (j in c(2,4)){
                        files <- dir(filepath[j],paste0(extension,"$"))
                        for (i in 1:length(files))  {
                                VarName <-  paste0("raw_",sub(extension,"",files[i]))
                                assign(VarName,readLines(paste0(filepath[j],files[i])), pos=1)
                                VarNames <- c(VarNames,VarName)
                                cat("#")
                        }
                }
                VarNames
        }
        
        ## Function that enters raw data into data frames
        toDf <- function(x){
                cat("\nLoading raw data into dataframes\n")
                for (i in 1:length(x))
                {
                        temp <- textConnection(get(x[i]))
                        assign(sub("raw_","",x[i]),read.table(temp), pos=1)
                        Variables[i] <<- sub("raw_","",x[i])
                        cat("#")
                }
        }
        
        ## Function that converts data frames into tbl_df
        toTbl <- function(x) {
                ## Removes leading and trailing spaces, and loads contents into dataframes. 
                ## Dataframes are named as x
                cat("\nConverting to tbl_df\n")
                for (i in 1:length(x))
                {
                        if(is.data.frame(get(x[i]))){
                                assign(sub("raw_","",x[i]), tbl_df(get(x[i])), pos=1)
                        }        
                        cat("#")
                }
        }
        
        
        ## Load features and labels into dataframes
        filepath <- "./UCI HAR Dataset"
        features <- read.delim(paste0(filepath,"/features.txt"),sep=" ", header=FALSE, col.names=c("Id","feature"))
        features <- tbl_df(features)
        activitylabels <- read.delim(paste0(filepath,"/activity_labels.txt"),sep=" ", header=FALSE, col.names =c("Id","activity"))
        activitylabels <- tbl_df(activitylabels)
        
        cat("\nRoot directory loaded...\n")
        
        Variables <- vector(mode = "character")
        
        ## Load files row by row into vectors
        filepath <- "./UCI HAR Dataset"
        paths <- paste0(list.dirs(filepath),"/")
        Variables <- loadFiles(paths)
        cat("\nRaw Data loaded...\n")
        
        ## insert raw data into to dataframes
        toDf(Variables)
        cat("\nRaw data inserted to dataframe...\n")
        toTbl(Variables)
        cat("\nDataframes converted to tbl_df...\n\n")
        
} 



