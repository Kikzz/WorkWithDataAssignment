## get_files.R
## 1. create and set working directory
## 2. download needed files
## 3. 

setwd("~/datasciencecoursera")

## Create working directory if it doesn't exist
if(!file.exists("./WorkWithDataAssignment")){dir.create("./WorkWithDataAssignment")}

## set working directory
setwd("./WorkWithDataAssignment")

## download files into working directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",method="curl",dest="data.zip")

## unzip the file. This cretates a "UCI HAR Dataset" directory and unzips all files into it.
unzip(zipfile="data.zip")
