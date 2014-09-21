#
# R script for building a tidy data set of mean and standard deviation measurements extracted
# from a data set of phone sensor measurements from Samsung phones.
# 
# A subsequent analysis is done to get averages of the individual measures
# for each combination of test subject and activity.
#

#
# Download and unpack the original Samsung phone data if it is not already present
#

# The source of the raw data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# The root directory name for the unzipped data - in the working directory
dataDir <- "UCI HAR Dataset"

# Only download the raw data if the directory where it would be downloaded does not yet exist
if (!file.exists(dataDir)) {
	# Download the raw, zipped data into a temporary file
	zipFile <- tempfile(fileext = ".zip")
	download.file(fileUrl, destfile = zipFile, method = "curl")

	# Unzip the raw data into the working directory - overwrite any existing files since they are the same
	unzip(zipFile, overwrite = TRUE)

	# Delete the temporary zip file
	unlink(zipFile)
}

#
# Load the raw data into R objects
#

# Read each component of the data set
allFeatures    <- read.table(file.path(dataDir, "features.txt"),        stringsAsFactors = FALSE)
activityLabels <- read.table(file.path(dataDir, "activity_labels.txt"), stringsAsFactors = FALSE)
xTest          <- read.table(file.path(dataDir, "test", "X_test.txt"))
yTest          <- read.table(file.path(dataDir, "test", "y_test.txt"))
subjectTest    <- read.table(file.path(dataDir, "test", "subject_test.txt"))
xTrain         <- read.table(file.path(dataDir, "train", "X_train.txt"))
yTrain         <- read.table(file.path(dataDir, "train", "y_train.txt"))
subjectTrain   <- read.table(file.path(dataDir, "train", "subject_train.txt"))

#
# Extract interesting measurements and construct a tidy data set
#

# We use the plyr library for joining data
library(plyr)

# Merge the test and train data to a single data set - just concatenate the rows
xAll <- rbind(xTest, xTrain)
yAll <- rbind(yTest, yTrain)
subjectAll <- rbind(subjectTest, subjectTrain)

# Identify the features that explicitly involve the mean or standard deviation in the name (e.g. "fBodyAcc-std()-X").
# We exclude "meanFreq()" and "angle" measurements (e.g., "angle(X,gravityMean)")
features <- allFeatures[grepl("-(mean|std)\\(", allFeatures$V2), ]

# Build a reduced data set with only the columns containing mean or standard deviation measurements
xMeanStd <- xAll[ , features$V1]

# Convert the activity codes to activity labels
# Note that 'join' preserves the order of the activity codes in yAll, unlike 'merge'
xActivities <- join(yAll, activityLabels, by = "V1")

# Attach the subject ids and activity labels as additional columns for each record in the test and training data
tidyWide <- cbind(subjectAll$V1, xActivities$V2, xMeanStd)

# Clean up the measurement names to remove noise characters and be more descriptive
featureDescs <- features$V2
featureDescs <- sub("-mean\\(\\)", "Mean", featureDescs)
featureDescs <- sub("-std\\(\\)", "StdDev", featureDescs)
featureDescs <- sub("^f", "freq", featureDescs)
featureDescs <- sub("^t", "time", featureDescs)
featureDescs <- sub("BodyBody", "Body", featureDescs)
featureDescs <- sub("-", "", featureDescs)

# Install the more descriptive column names (including names for the two added columns)
names(tidyWide) <- c("Subject", "Activity", featureDescs)

# Save the tidy data set to a file
write.table(tidyWide, "UciHarMeansAndStdDevs.txt", row.names = FALSE)

#
# Use the tidy data set just created to construct a new wide, tidy data set with the means of 
# each variable for each subject by activity.
#
# We 'melt' the incoming data set to rows with only one subject, activity, and measurement.
# The rows are then grouped by subject, activity, and measurement. A mean for the measurement
# values is generated for each group and the resulting frame is 'dcast' back to a wide format 
# with each row representing a single subject and activity and the means for all measurements. 
#

library(reshape2)
tidyLong <- melt(tidyWide, id = c("Subject", "Activity"))
avgsData <- dcast(tidyLong, Subject + Activity ~ variable, mean)

# Save the constructed data set to a file
write.table(avgsData, "UciHarMeansOfMeansAndStdDevs.txt", row.names = FALSE)

