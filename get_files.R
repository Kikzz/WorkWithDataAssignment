## get_files.R

## 1. download the zip file as data.zip into working directory
## 2. unzip data.zip into working directory
## 3. Remove zip file from HDD

## download files into working directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",method="curl",dest="data.zip")

## unzip the file. This cretates a "UCI HAR Dataset" directory and unzips all files into it.
unzip(zipfile="data.zip")

## deletes data.zip from hard drive
unlink("data.zip")
