library(reshape2)
library(plyr)

filename <- "Course3UCIHARDataset.zip"

## If the zip or dataset is not present, download/unzip the dataset:
if (!file.exists(filename)){
	donwloadURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
	download.file(donwloadURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
	unzip(filename) 
}


# Task 1: Merges the training and the test sets to create one data set
#---------------------------------------------------------------------

#read in all data sets
trainingSetX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainingSetY <- read.table("UCI HAR Dataset/train/y_train.txt")
trainingSetSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")

testSetX <- read.table("UCI HAR Dataset/test/X_test.txt")
testSetY <- read.table("UCI HAR Dataset/test/y_test.txt")
testSetSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# creates the data sets for x, y and subject
dataSetX <- rbind(trainingSetX, testSetX)
dataSetY <- rbind(trainingSetY, testSetY)
dataSetSubject <- rbind(trainingSetSubject, testSetSubject)



# Task 2: Extracts only the measurements on the mean and standard deviation for each measurement
#-----------------------------------------------------------------------------------------------

features <- read.table("UCI HAR Dataset/features.txt")

# get only columns with mean() or std() in their names
featuresMeanAndStd <- grep("-(mean|std)\\(\\)", features[, 2])

# subset only the mean and std columns
dataSetX <- dataSetX[, featuresMeanAndStd]

# rename the column names
names(dataSetX) <- features[featuresMeanAndStd, 2]


# Task 3: Uses descriptive activity names to name the activities in the data set
#-------------------------------------------------------------------------------

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")

# input the right activity labels
dataSetY[, 1] <- activityLabels[dataSetY[, 1], 2]

# rename the column name
names(dataSetY) <- "activity"


# Task 4: Appropriately labels the data set with descriptive variable names
#--------------------------------------------------------------------------

# rename the column name
names(dataSetSubject) <- "subject"

# combine all data sets into one data set
combinedDataSet <- cbind(dataSetX, dataSetY, dataSetSubject)


# Task 5: From the data set in step 4, creates a second, independent tidy data set with 
#		  the average of each variable for each activity and each subject
#---------------------------------------------------------------------------------------

tidyDataSet <- ddply(combinedDataSet, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(tidyDataSet, "tidy_data_set.txt", row.name=FALSE)
