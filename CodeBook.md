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
This section of code uses gsub() to:  
1: removes all punctuation characters and replaces them with dots.  
2: removes multiple dots (i.e 2 or more) and replace with a single dot.  
3: remove dots from the end of the feature names.  

    # Sanitize the feature names and add them to the feature.names table

    # Step - THis is optional
        #misc, this is used to get a translation of the feature names in the tidy data
        # can then be added to the code book
    # remove more unused objects to conserve mem

    Note: names: the names have been modified to conform to the R object naming conventions
    so that they can be imported and used in R without error.

    give a couple of examples

    Otherwise they are unchanged from the form in feature_names.txt file of the source data
    The meaning of the various features variables are provided in the features.txt file of the source data


## Step 5b: Give
    # convert the activity labels to human readable form 
    #create a table that contains the activity labels and their respective codes from the "activity_labels.txt" file
    #give the columns of the activity.labels data frame suitable names

#Step 6
    # create subset of ONLY the mean and standard deviation (std) columns
        # obtain the required rows from the complete dataset
        # use these rows to create the tidy data

#Step 7
    # rename the Activity.Name column of the tidy.dataset
    gsub() calls

# Step 8 - Produce final tidy data file 
    #sort the tidy dataset by Subject ID then write the output to a CSV file.

