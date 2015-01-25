# Getting and Cleaning Data: Course Project

This github repository contains the R script run_analysis.R and associated project files for the Coursea Course: Getting and Cleaning Data.

## The Original Raw Data

See the CodeBook for links to the original raw data used. The train and test data sets were merged to create one data set with 561 features. 

For the final tidy data set, only 86 of the 561 features were extracted and the mean for each subject and activity type calculated.

## About run_analysis.R

To properly run the script run_analysis.R, the raw data sets must be located in the working directory. The required file stucture and files are:

* UCI HAR Dataset/features.txt
* UCI HAR Dataset/y_train.txt
* UCI HAR Dataset/X_train.txt
* UCI HAR Dataset/subject_train.txt
* UCI HAR Dataset/y_test.txt
* UCI HAR Dataset/X_test.txt
* UCI HAR Dataset/subject_test.txt

A final tidy.txt file will be created in the working directory once the script has properly executed.

## CodeBook

Please refer to codeBook.MD for detailed information about the raw data set and specific extracted features.
