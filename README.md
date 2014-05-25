# README

This contains background info about the project

## Context:
* General background reading: http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/
* Description of dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
 
## Aim of project:
The aim of the current excercise is to generate a script, called run_analysis.R, that will use the information in the source dataset to construct a tidy data subset. This tidy set consists only of the variables that represent the mean and standard deviation (std) of other variables contained within the source dataset.

## Implementation instructions
The project is comprised of a number of components: 
1) The **run_analysis.R** script: This is run in the R environment to process the source data and produce the tidy data.
2) The code book: This is supplied as the **CodeBook.md** file, which provides:
    a) An outline of the steps used by the run_analysis.R script to produce the data  
    b) The rationale behind those steps.  
3) This readme file :)

## Note
Note: it is important to run the script in a working directory that contains the script if you call the **list.files()** command in the R console and you cannot see the "UCI HAR Dataset"... things will not work out for you.   

Before you can run run_analysis.R you need to:   
1. Download the dataset at this link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip   
2. Unzip the dataset in your working directory.