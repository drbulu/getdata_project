#interesting discussions
  # https://class.coursera.org/getdata-003/forum/thread?thread_id=203
  # help with Quiz 3 merging
    # https://class.coursera.org/getdata-003/forum/thread?thread_id=50

#list of functions to use

pathToFile <- function(x, y, z) { paste(x, y, z, sep="/") }

# The path variables. will use a relative path :). Global to the import functions
dataDir  <- "./UCI HAR Dataset"
dataOption <- c("test", "train") # select is the parameter required here

#the optional paths for the different files, depending on which dirOption selected
# this will synthesis the "test" or "train" filenames depending on the nameVar flag

#Factory functions to make the paths to the data files to import
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

#read the data into R
    #test data
test.subject <- read.table(testSubjectFile)
test.X <- read.table(testXFile)
test.y <- read.table(testYFile)
    #training data
train.subject <- read.table(trainSubjectFile)
train.X <- read.table(trainXFile)
train.y <- read.table(trainYFile)

# This is where we combine the elements dataset into a single data frame
    # may skip the head() call, just for testing
test.dataset <- cbind(test.subject, test.y, test.X) ; head(test.dataset)
train.dataset <- cbind(train.subject, train.y, train.X) ; head(train.dataset)

# remove the test.sub

# combine the test and training datasets to get the complete dataset
whole.dataset <- rbind(test.dataset, train.dataset)

# removing redundant objects from the environment to conserve memory!
rm(test.dataset, train.dataset, train.subject, train.X, train.y, 
   test.subject, test.X, test.y, trainDir, trainSubjectFile, 
   trainXFile, trainYFile, testDir, testSubjectFile, testXFile, testYFile
   )

#annotating data frame(s) 
    # (or you could do this AFTER merging,to save some cycles)
    # after all, the order of columns is the SAME!
    # 1: preparing the annotations
    #need to import info from features and activity 
feature.names <- read.table( paste(dataDir, "features.txt", sep="/") )
 # give the feature names data frame columns nice names
names(feature.names) <- c("feature.ID", "Name")
 
# clean up the feature.names entries
    # help from regex: http://stat.ethz.ch/R-manual/R-patched/library/base/html/regex.html

############reformat into a function!
    # 1: removes all punctuation characters and replaces them with dots
tmp <- gsub("[[:punct:]]", ".", feature.names$Name)
    # 2: removes multiple dots (i.e 2 or more) and replace with a single dot
tmp <- gsub("[\\.]{2,5}", ".", tmp)
    # 3: remove dots from the end of the feature names
Sanitized.Name <- gsub("(\\.)+$", "", tmp)

# Sanitize the feature names and add them to the feature.names table
sanitized.feature.names <- cbind(feature.names, Sanitized.Name)

# Sanitized.Name contents are factors, need to coerse to characters for this to work :)
names(whole.dataset) <- c( "Subject.ID", "Activity.Name", as.character(sanitized.feature.names$Sanitized.Name) )

# works up to here

# convert the activity labels to human readable form 
    #create a table that contains the activity labels and their respective codes from the "activity_labels.txt" file
activity.labels <- read.table( paste(dataDir, "activity_labels.txt", sep="/") )
    #give the columns of the activity.labels data frame suitable names
names(activity.labels) <- c("Activity.ID", "Activity.Name")


# create subset of ONLY the mean and standard deviation (std) columns
    # obtain the required rows from the complete dataset
meanCols <- grep("[Mm]ean|std", names(whole.dataset))

# use these rows to create the tidy data
tidyCol <- c(1:2, meanCols)
tidy.dataset <- whole.dataset[, tidyCol]

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

#sort the tidy dataset by Subject ID
sorted.tidy.data <- tidy.dataset[order(tidy.dataset$Subject.ID),]

# then cat the output to a CSV file :) :)
#write.table(tidy.dataset, file = "tidy_data.csv", quote = F, sep = ",")
#write.table(sorted.tidy.data, file = "tidy_data.csv", quote = F, sep = ",")

#misc, this is used to get a translation of the feature names in the tidy data
# can then be added to the code book
sanitized.mean.rows <- grep("[Mm]ean|std", as.character(sanitized.feature.names$Sanitized.Name))
sanitized.Means <- sanitized.feature.names[sanitized.mean.rows,] 