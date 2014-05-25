# This is the R script for processing the UCI HAR Dataset. Please consult CodeBook.md for data processing outline

#Step 1:
dataDir  <- "./UCI HAR Dataset"
dataOption <- c("test", "train")

if(!file.exists(dataDir)){
        stop('The "UCI HAR Dataset" subdirectory was not found!')
}

#Step 2:
    # Factory functions to make the paths to the data files to import
pathToFile <- function(x, y, z) { paste(x, y, z, sep="/") }
makeSubjectPath <- function(nameVar){
    fileName <- paste("subject_", nameVar, ".txt", sep="")
    dataPath <- pathToFile(dataDir, nameVar, fileName)
    return (dataPath)
}
makeXPath <- function(nameVar){
    fileName <- paste("X_", nameVar, ".txt", sep="")
    dataPath <- pathToFile(dataDir, nameVar, fileName)
    return (dataPath)
}
makeYPath <- function(nameVar){
    fileName <- paste("y_", nameVar, ".txt", sep="")
    dataPath <- pathToFile(dataDir, nameVar, fileName)
    return (dataPath)
}

    # the optional paths for the different files, depending on which dirOption selected
    # this will synthesis the "test" or "train" filenames depending on the nameVar flag

    #make the path names for the test data set
testDir <- dataOption[1]
testSubjectFile <- makeSubjectPath(testDir)
testXFile <- makeXPath(testDir)
testYFile <- makeYPath(testDir)

    #make the path names for the training data set 
trainDir <- dataOption[2]
trainSubjectFile <- makeSubjectPath(trainDir)
trainXFile <- makeXPath(trainDir)
trainYFile <- makeYPath(trainDir)

#Step 3:
    # read the data into R
    #test data
test.subject <- read.table(testSubjectFile)
test.X <- read.table(testXFile)
test.y <- read.table(testYFile)
    #training data
train.subject <- read.table(trainSubjectFile)
train.X <- read.table(trainXFile)
train.y <- read.table(trainYFile)

# Step 4:
    # This is where we combine the elements dataset into a single data frame
test.dataset <- cbind(test.subject, test.y, test.X)
train.dataset <- cbind(train.subject, train.y, train.X)

    # combine the test and training datasets to get the complete dataset
whole.dataset <- rbind(test.dataset, train.dataset)

    # removing redundant objects from the environment to conserve memory!
rm(test.dataset, train.dataset, train.subject, train.X, train.y, 
   test.subject, test.X, test.y, trainDir, trainSubjectFile, 
   trainXFile, trainYFile, testDir, testSubjectFile, testXFile, testYFile
   )

#Step 5: - 
    # Naming the dataset columns in a format acceptable by R
    # Obtain feature names
feature.names <- read.table( paste(dataDir, "features.txt", sep="/") )
    # give the feature names data frame columns nice names
names(feature.names) <- c("feature.ID", "Name")
 
    # clean up the feature.names entries
 
    # 1: removes all punctuation characters and replaces them with dots
Sanitized.Name <- gsub("[[:punct:]]", ".", feature.names$Name)
    # 2: removes multiple dots (i.e 2 or more) and replace with a single dot
Sanitized.Name <- gsub("[\\.]{2,5}", ".", Sanitized.Name)
    # 3: remove dots from the end of the feature names
Sanitized.Name <- gsub("(\\.)+$", "", Sanitized.Name)

    # Sanitize the feature names and add them to the feature.names table
sanitized.feature.names <- cbind(feature.names, Sanitized.Name)

    # Step - THis is optional
        #misc, this is used to get a translation of the feature names in the tidy data
        # can then be added to the code book
sanitized.mean.rows <- grep("[Mm]ean|std", as.character(sanitized.feature.names$Sanitized.Name))
sanitized.Means <- sanitized.feature.names[sanitized.mean.rows,]
write.csv(sanitized.Means, file = "sanitized.means.csv", row.names=F)

    # Sanitized.Name contents are factors, need to coerse to characters for this to work :)
names(whole.dataset) <- c( "Subject.ID", "Activity.Name", as.character(sanitized.feature.names$Sanitized.Name) )

    # remove more unused objects to conserve mem
rm(sanitized.feature.names, sanitized.mean.rows, sanitized.Means, Sanitized.Name)

# Step 5b: Give 
    # convert the activity labels to human readable form 
    #create a table that contains the activity labels and their respective codes from the "activity_labels.txt" file
activity.labels <- read.table( paste(dataDir, "activity_labels.txt", sep="/") )
    #give the columns of the activity.labels data frame suitable names
names(activity.labels) <- c("Activity.ID", "Activity.Name")

#Step 6
    # create subset of ONLY the mean and standard deviation (std) columns
        # obtain the required rows from the complete dataset
meanCols <- grep("[Mm]ean|std", names(whole.dataset))

    # use these rows to create the tidy data
tidyCol <- c(1:2, meanCols)
tidy.dataset <- whole.dataset[, tidyCol]

#Step 7
    # rename the Activity.Name column of the tidy.dataset
tidy.dataset$Activity.Name <- gsub( as.numeric( activity.labels$Activity.ID[1] ), 
                                    as.character( activity.labels$Activity.Name[1] ), 
                                    tidy.dataset$Activity.Name)
tidy.dataset$Activity.Name <- gsub( as.numeric( activity.labels$Activity.ID[2] ), 
                                    as.character( activity.labels$Activity.Name[2] ), 
                                    tidy.dataset$Activity.Name)
tidy.dataset$Activity.Name <- gsub( as.numeric( activity.labels$Activity.ID[3] ), 
                                    as.character( activity.labels$Activity.Name[3] ), 
                                    tidy.dataset$Activity.Name)
tidy.dataset$Activity.Name <- gsub( as.numeric( activity.labels$Activity.ID[4] ), 
                                    as.character( activity.labels$Activity.Name[4] ), 
                                    tidy.dataset$Activity.Name)
tidy.dataset$Activity.Name <- gsub( as.numeric( activity.labels$Activity.ID[5] ), 
                                    as.character( activity.labels$Activity.Name[5] ), 
                                    tidy.dataset$Activity.Name)
tidy.dataset$Activity.Name <- gsub( as.numeric( activity.labels$Activity.ID[6] ), 
                                    as.character( activity.labels$Activity.Name[6] ), 
                                    tidy.dataset$Activity.Name)

# Step 8
    #sort the tidy dataset by Subject ID
sorted.tidy.data <- tidy.dataset[order(tidy.dataset$Subject.ID),]

# then cat the output to a CSV file :) :)
write.csv(sorted.tidy.data, file = "tidy_data.csv", row.names=F)

