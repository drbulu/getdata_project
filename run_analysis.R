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

# combine the test and training datasets to get the complete dataset
whole.dataset <- rbind(test.dataset, train.dataset)


#annotating data frame(s) 
    # (or you could do this AFTER merging,to save some cycles)
    # after all, the order of columns is the SAME!

    # 1: preparing the annotations
    #need to import info from features and activity 
feature.names <- read.table( paste(dataDir, "features.txt", sep="/") )
 # give the feature names data frame columns nice names
names(feature.names) <- c("feature.ID", "Name")
 # clean up the feature.names entries

#sanitized.feature.names

#This should hopefully work :)
# 1: removes all punctuation characters and replaces them with dots
    # sanitized.feature.names <- gsub("[[:punct:]]", ".", feature.names#Name)
# 2: removes multiple dots (in this case, two or more)
    # sanitized.feature.names <-  gsub("[\\.]{2,3}", "", feature.names#Name)
# 3: remove the terminal dot
    # sanitized.feature.names <- gsub("(\\.)$", "", feature.names#Name)

# help from regex: http://stat.ethz.ch/R-manual/R-patched/library/base/html/regex.html

activity.labels <- read.table( paste(dataDir, "activity_labels.txt", sep="/") )

    #give the columns of the activity.labels data frame suitable names
names(activity.labels) <- c("Activity.ID", "Activity.Name")

# apply()

    # need to format the feature.names into variable names that are acceptable for R
        # using a file that utilises Grep capabilities: see course_prject.R

    # 2: using the annotations
        # a) dataset columns

        # this creates a sanitised feature.names vector that can be used to annotate
            # the column names e.g. 
    
        # names(test.dataset) <- c( "Subject.ID", "Activity.Name", outputOfThisFunction() )
    
        # b) the human-readable names of the Activity.Name column
            # use Grep routines + activity.labels

# Next step: combine train.dataset and test.dataset
    # check the required syntax
    # a) 
        # combined.dataset <- rbind(test.dataset, train.dataset)
    # b) using merge() somehow ???

# create subset of ONLY the mean and SD columns
  # extract the columns that have the word Mean i.e. [Mm]ean
  # using subset() carefully

    # this will help: length(grep("mean|std", feature.names$feat.name))
    # possible solution:  tidy.dataset <- whole.dataset[ , grep("mean|std", feature.names$Name) ]

# Sort the datasets (probably optional)
    # first by Subject.ID - probably useful :)
    # then by Activity.Name
    # use order: http://stackoverflow.com/questions/1296646/how-to-sort-a-dataframe-by-columns-in-r
    # test this idea with an example dataset first!!!

# then cat the output to a CSV file :) :)

#instructions to test the 
print("test data: ") ; nrow(test.dataset) ; ncol(test.dataset)
print("training data: "); nrow(train.dataset); ncol(train.dataset)
print("Activity labels: "); nrow(activity.labels); ncol(activity.labels)

