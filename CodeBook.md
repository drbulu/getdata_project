# Code Book

## Step 1: 
The script first checks to see if the data directory exists as a subdir of working dir. 
The script will present an error message if you do not have a subdirectory called **/UCI HAR Dataset** in your working directory that contains all of the files that you need.
Please ensure that your working directory has the required data.

## Step 2:
Make the path names required for the import of the files needed to construct the test and training data sets.

## Step 3:
Read the data into the local R environment using the file paths constructed in Step 2.

## Step 4:
1. Combine the test and training datasets to get the complete dataset. This is stored in a variable called ***whole.dataset***
2. Remove redundant objects from the environment to conserve memory, since they will not be used by the script from this point onwards.

## Step 5: 
Name the columns of the combined dataset columns in R acceptable format. 
The input list of variable names is sourced from **feature.txt** and stored in the _**feature.names**_ variable.    

This section of code uses **gsub()** to:  
1: removes all punctuation characters and replaces them with dots.  
2: removes multiple dots (i.e 2 or more) and replace with a single dot.  
3: remove dots from the end of the feature names.  

The sanitized feature names are then used to create the **sanitized.feature.names** variable. This is so that the feature names conform to the R variable naming conventions so that they can be imported and used in R without error. Aside from these modifications they are identical to the original names in **features.txt**.  

This section of code also creates a translation table to make it more convenient to compare the sanitized feature names created by the script with the corresponding original feature names extracted from **features.txt**. Note: only the feature names of variables describing **mean** and **standard deviation (std)** values have been included, since only this data will be in the final output data set.

These values are:
1. Exported to a CSV file called **sanitized_mean_feat_names.csv** in the working directory
2. This file can be used in conjunction with the **feature_info.txt** file in the **/UCI HAR Dataset** subdirectory.

## Step 6:
Create subset of the combined dataset that includes _ONLY_ the **mean** and **standard deviation (std)** features. This is stored in a variable called ***tidy.dataset***.    

## Step 7:
Make values of the ***Activity.Name*** in the tidy dataset more human readable by:
1. Creating a table containing the activity labels and their respective ID information from the "activity_labels.txt" file.   
2. Using this table with **gsub()** to convert the Activity name values from numbers to words.  

Note: the ***Activity.Name*** values represent the different activities described in the README.txt file in the **/UCI HAR Dataset** subdirectory.

## Step 8: 
Sort the tidy dataset by the **Subject.ID** column, representing each of the 30 subjects in the study (see **README.txt** as per _Step 7_. This is stored in the ***sorted.tidy.data*** variable.   
Produce the final tidy dataset as a CSV file by writing the sorted to the **tidy_data.csv** file.