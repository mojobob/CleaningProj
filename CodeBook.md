Code book for the Means and Standard Deviations Data Set
========================================================

This code book documents the data in the data set produced by `run_analysis.R` and saved in `UciHarMeansAndStdDevs.txt`.
The data set is based on measurements in the `UCI HAR Dataset` (i.e., the Samsung data).

Description of the original Samsung data:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Location of the original Samsung data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The description of the measurements and variables for the original Samsung data - the code book for the original data - can be
be found in the `features_info.txt` and `README.txt` files in the `UCI HAR Dataset` directory. The `UCI HAR Dataset`
directory is part of the downloaded data and will be visible in the R working directory after the `run_analysis.R`
script has been run.

### What was extracted from the Samsung data set

The original Samsung data was broken into test and training subsets by randomly assigning the
30 subjects to one of the two groups. Our generated data removes this distinction and combines
the test and training data into a single block with no differentiation between the subsets.

The generated data set includes only measurements from the Samsung data that are a mean or
standard deviation. We actually filtered the columns of interest by looking for `-std(` or
`-mean(` appearing in the column name (in `features.txt`). There were additional columns in the Samsung data that
included the substring "mean" in their names (e.g., "meanFreq"), but we did not include those 
because they did not seem to be a value that was solely a mean or standard deviation.

### Transformations of measurements

We did not modify any of the actual measurement values extracted from the Samsung data. All unit 
information in the original data set still applies to the generated data set. Since all of the
original measurements are expressed as normalized values bounded within [-1,1], it will also
be the case for all columns in the generated data, with the exception of the `Subject` and `Activity`
columns.

The activity codes in the Samsung `y_` files were added as the `Activity` column to each observation and
converted from numeric ids in the 1-6 range to their descriptive equivalent (WALKING, WALKING_UPSTAIRS, 
WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING, respectively)

The `Subject` column was also added. It is the subject (i.e., person) identifier (in the range 1-30)
from the position-dependent Samsung `subject_` files.

### Making the data set tidy

See http://vita.had.co.nz/papers/tidy-data.pdf for a description of how to tidy a data set.

In the generated data set, all measurements in a row correspond to a single observation. That is,
one instance of a specific subject doing a specific activity. All (and only) 
relevant data for the observation is located in the same table. There are no positional dependencies 
between tables. Each column contains a single measurement.

We chose to represent the observations (rows) in a wide format because there were several observations
of the same subject doing the same activity. The measurements in a single row are all derived
from a single time series of readings from accelerometer and gyroscope sensors in a Samsung
phone. If we instead used a long format in which each measurement is in a separate row with
an identifier for the variable it represents, we would have needed to introduce a sequence
identifier to associate a measure with, for instance, the second observation
of subject 4 walking rather than the third observation. 

### Column definitions in the generated data set

The columns in the generated data set are labeled with descriptive names. We tried to keep the
labels concise to simplify scripts used to process the data set, but also have enough information
to provide some meaning for the column.

We applied simple string transformations to the original column names in the `features.txt` file
to build the column names used in the generated data set.
- The initial 't' or 'f' used to denote time domain and frequency domain measurements were replaced
with 'time' or 'freq'
- Instances of '-std()' were replaced with 'StdDev' to indicate a standard deviation measurement
- Instances of '-mean()' were replaced with 'Mean' to indicate a mean measurement
- Hyphens, '-', in the name were removed
- Some column names contained 'BodyBody'. These were reduced to 'Body'

The `features_info.txt` file in the `UCI HAR Dataset` directory provides a good explanation
of the meanings of the column names as descriptions of the actual measurements. For instance, the column 
name 'timeBodyAccJerkMeanX' indicates
a time domain measurement that is the mean of the 'X' component (in a 3-axis space) of the time 
derivative of the 'Body' component (as opposed to the 'Gravity' component) of acceleration. The
time derivative of acceleration is known as 'Jerk'.


The table below lists the columns generated data set and their basis in the `UCI HAR Dataset`.

| Col # | Variable | UCI HAR Dataset Source |
| ----- | :------- | :-------- |
| 1 | **Subject** | `subject_` files |
| 2 | **Activity** | `y_` files |
| 3 | **timeBodyAccMeanX** | tBodyAcc-mean()-X |
| 4 | **timeBodyAccMeanY** | tBodyAcc-mean()-Y |
| 5 | **timeBodyAccMeanZ** | tBodyAcc-mean()-Z |
| 6 | **timeBodyAccStdDevX** | tBodyAcc-std()-X |
| 7 | **timeBodyAccStdDevY** | tBodyAcc-std()-Y |
| 8 | **timeBodyAccStdDevZ** | tBodyAcc-std()-Z |
| 9 | **timeGravityAccMeanX** | tGravityAcc-mean()-X |
| 10 | **timeGravityAccMeanY** | tGravityAcc-mean()-Y |
| 11 | **timeGravityAccMeanZ** | tGravityAcc-mean()-Z |
| 12 | **timeGravityAccStdDevX** | tGravityAcc-std()-X |
| 13 | **timeGravityAccStdDevY** | tGravityAcc-std()-Y |
| 14 | **timeGravityAccStdDevZ** | tGravityAcc-std()-Z |
| 15 | **timeBodyAccJerkMeanX** | tBodyAccJerk-mean()-X |
| 16 | **timeBodyAccJerkMeanY** | tBodyAccJerk-mean()-Y |
| 17 | **timeBodyAccJerkMeanZ** | tBodyAccJerk-mean()-Z |
| 18 | **timeBodyAccJerkStdDevX** | tBodyAccJerk-std()-X |
| 19 | **timeBodyAccJerkStdDevY** | tBodyAccJerk-std()-Y |
| 20 | **timeBodyAccJerkStdDevZ** | tBodyAccJerk-std()-Z |
| 21 | **timeBodyGyroMeanX** | tBodyGyro-mean()-X |
| 22 | **timeBodyGyroMeanY** | tBodyGyro-mean()-Y |
| 23 | **timeBodyGyroMeanZ** | tBodyGyro-mean()-Z |
| 24 | **timeBodyGyroStdDevX** | tBodyGyro-std()-X |
| 25 | **timeBodyGyroStdDevY** | tBodyGyro-std()-Y |
| 26 | **timeBodyGyroStdDevZ** | tBodyGyro-std()-Z |
| 27 | **timeBodyGyroJerkMeanX** | tBodyGyroJerk-mean()-X |
| 28 | **timeBodyGyroJerkMeanY** | tBodyGyroJerk-mean()-Y |
| 29 | **timeBodyGyroJerkMeanZ** | tBodyGyroJerk-mean()-Z |
| 30 | **timeBodyGyroJerkStdDevX** | tBodyGyroJerk-std()-X |
| 31 | **timeBodyGyroJerkStdDevY** | tBodyGyroJerk-std()-Y |
| 32 | **timeBodyGyroJerkStdDevZ** | tBodyGyroJerk-std()-Z |
| 33 | **timeBodyAccMagMean** | tBodyAccMag-mean() |
| 34 | **timeBodyAccMagStdDev** | tBodyAccMag-std() |
| 35 | **timeGravityAccMagMean** | tGravityAccMag-mean() |
| 36 | **timeGravityAccMagStdDev** | tGravityAccMag-std() |
| 37 | **timeBodyAccJerkMagMean** | tBodyAccJerkMag-mean() |
| 38 | **timeBodyAccJerkMagStdDev** | tBodyAccJerkMag-std() |
| 39 | **timeBodyGyroMagMean** | tBodyGyroMag-mean() |
| 40 | **timeBodyGyroMagStdDev** | tBodyGyroMag-std() |
| 41 | **timeBodyGyroJerkMagMean** | tBodyGyroJerkMag-mean() |
| 42 | **timeBodyGyroJerkMagStdDev** | tBodyGyroJerkMag-std() |
| 43 | **freqBodyAccMeanX** | fBodyAcc-mean()-X |
| 44 | **freqBodyAccMeanY** | fBodyAcc-mean()-Y |
| 45 | **freqBodyAccMeanZ** | fBodyAcc-mean()-Z |
| 46 | **freqBodyAccStdDevX** | fBodyAcc-std()-X |
| 47 | **freqBodyAccStdDevY** | fBodyAcc-std()-Y |
| 48 | **freqBodyAccStdDevZ** | fBodyAcc-std()-Z |
| 49 | **freqBodyAccJerkMeanX** | fBodyAccJerk-mean()-X |
| 50 | **freqBodyAccJerkMeanY** | fBodyAccJerk-mean()-Y |
| 51 | **freqBodyAccJerkMeanZ** | fBodyAccJerk-mean()-Z |
| 52 | **freqBodyAccJerkStdDevX** | fBodyAccJerk-std()-X |
| 53 | **freqBodyAccJerkStdDevY** | fBodyAccJerk-std()-Y |
| 54 | **freqBodyAccJerkStdDevZ** | fBodyAccJerk-std()-Z |
| 55 | **freqBodyGyroMeanX** | fBodyGyro-mean()-X |
| 56 | **freqBodyGyroMeanY** | fBodyGyro-mean()-Y |
| 57 | **freqBodyGyroMeanZ** | fBodyGyro-mean()-Z |
| 58 | **freqBodyGyroStdDevX** | fBodyGyro-std()-X |
| 59 | **freqBodyGyroStdDevY** | fBodyGyro-std()-Y |
| 60 | **freqBodyGyroStdDevZ** | fBodyGyro-std()-Z |
| 61 | **freqBodyAccMagMean** | fBodyAccMag-mean() |
| 62 | **freqBodyAccMagStdDev** | fBodyAccMag-std() |
| 63 | **freqBodyAccJerkMagMean** | fBodyBodyAccJerkMag-mean() |
| 64 | **freqBodyAccJerkMagStdDev** | fBodyBodyAccJerkMag-std() |
| 65 | **freqBodyGyroMagMean** | fBodyBodyGyroMag-mean() |
| 66 | **freqBodyGyroMagStdDev** | fBodyBodyGyroMag-std() |
| 67 | **freqBodyGyroJerkMagMean** | fBodyBodyGyroJerkMag-mean() |
| 68 | **freqBodyGyroJerkMagStdDev** | fBodyBodyGyroJerkMag-std() |

