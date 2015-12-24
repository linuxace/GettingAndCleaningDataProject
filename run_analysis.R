# Getting and Cleaning Data Course Project
# This script takes in the following test files: subject_test.txt, X_test.txt and y_test.txt
# It also takes in the following training files: subject_train.txt, X_train.txt and y_train.txt
# From this data, it cleans it, assigns variable (column) names, replaces activity numbers with 
# activity descriptions, extracts only mean and std for each measure.  This is output in a new
# tidy dataset named tidy_data.txt which summarizes the based on the mean for each subject and 
# activity.

# Add appropriate libraries
library(dplyr)

# Make a vector of columns we are interested in in extracting as well as clean column names
# based on the feature list.
# Make platform agnostic path to file an read into features df
featuresfile <- file.path("UCI HAR Dataset", "features.txt")
features <- read.table(featuresfile)

# Read in the training files and create platform agnostic file paths for each file
trainsubjectfile <- file.path("UCI HAR Dataset", "train", "subject_train.txt")
traindatafile <- file.path("UCI HAR Dataset", "train", "X_train.txt")
trainactivityfile <- file.path("UCI HAR Dataset", "train", "y_train.txt")
testsubjectfile <- file.path("UCI HAR Dataset", "test", "subject_test.txt")
testdatafile <- file.path("UCI HAR Dataset", "test", "X_test.txt")
testactivityfile <- file.path("UCI HAR Dataset", "test", "y_test.txt")
trainsubject <- read.table(trainsubjectfile)
traindata <- read.table(traindatafile)
trainactivity <- read.table(trainactivityfile)
testsubject <- read.table(testsubjectfile)
testdata <- read.table(testdatafile)
testactivity <- read.table(testactivityfile)

# Assign column names
names(features) <- c("id", "feature")

# Extract rows that only contain mean and std measures
features <- features[grep("(std\\(\\)|mean\\(\\))", features$feature, perl=TRUE),]

# Store numbers to be used to extract appropriate columns from full data
columnnums <- features$id

# Store feature names and transform them into more standard and meaningful column names
# Add subject and activity.
columnnames <- as.character(features$feature)

# Remove feature df
rm("features")

# Coerce existing column names into something more reasonable
columnnames <- sub('^t', 'tm', columnnames)
columnnames <- sub('\\(\\)', '', columnnames)
columnnames <- sub('^f', 'ftt', columnnames)
columnnames <- gsub('-', '', columnnames)
columnnames <- tolower(columnnames)
columnnames <- sub('bodybody', 'body', columnnames)
columnnames <- c(c("subject","activity"),columnnames)

# Extract proper columns from the train and test datasets
traindata <- traindata[columnnums]
testdata <- testdata[columnnums]

# Remove columnnums
rm("columnnums")

# Bind the columns for all train data and all test data together
traindata <- cbind(trainsubject, trainactivity, traindata)
testdata <- cbind(testsubject, testactivity, testdata)

# Remove the test and train subject and activity df
rm("trainsubject", "trainactivity", "testsubject", "testactivity")

# Merge all the rows from train and test data
all <- rbind(traindata, testdata)

# Remove test and train data frames
rm("traindata", "testdata")

# Add appropriate column names
names(all) <- columnnames

# Make activity a factor from and integer vector and add appropriate labels
all$activity <- cut(all$activity, breaks = 6, labels = c("walking", "walking upstairs", "walking downstairs", 
                                                         "sitting", "standing", "laying"))
# Group all data by activity and subject
final <- group_by(all, activity, subject) %>%
  summarize_each(funs(mean))

rm("all")

# Write the tidy data to a text file
write.table(final, "tidy_data.txt")