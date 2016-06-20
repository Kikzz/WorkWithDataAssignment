## run_analysis.R

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

# Merges test and train datasets, groups by acticity and subject, and calculates means for each column.
# Also exports the final results into a csv file.
source("merge_group_mean.R")

## Cleanup
n <- readline(prompt="Do you want to remove temporary variables from memory? (y/n)\n")
if (n=="y"){
        source("Cleanup.R")
}
rm(n)
