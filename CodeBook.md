Code book for the Data Set
==========================

This code book documents the data in the data set produced by `run_analysis.R` and saved in `UciHarMeansAndStdDevs.txt`.
The data set is based on measurements in the `UCI HAR Dataset` (i.e., the Samsung data).

Description of the original Samsung data:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Location of the original Samsung data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Column definitions in the data set

| Col # | Variable | UCI HAR Basis | Description |
| ----- | :------- | :-------- | :---------- |
| 1 | **Subject** | *subject files* |  |
| 2 | **Activity** | *activity files* |  |
| 3 | **timeBodyAccMeanX** | tBodyAcc-mean()-X |  |
| 4 | **timeBodyAccMeanY** | tBodyAcc-mean()-Y |  |
| 5 | **timeBodyAccMeanZ** | tBodyAcc-mean()-Z |  |
| 6 | **timeBodyAccStdDevX** | tBodyAcc-std()-X |  |
| 7 | **timeBodyAccStdDevY** | tBodyAcc-std()-Y |  |
| 8 | **timeBodyAccStdDevZ** | tBodyAcc-std()-Z |  |
| 9 | **timeGravityAccMeanX** | tGravityAcc-mean()-X |  |
| 10 | **timeGravityAccMeanY** | tGravityAcc-mean()-Y |  |
| 11 | **timeGravityAccMeanZ** | tGravityAcc-mean()-Z |  |
| 12 | **timeGravityAccStdDevX** | tGravityAcc-std()-X |  |
| 13 | **timeGravityAccStdDevY** | tGravityAcc-std()-Y |  |
| 14 | **timeGravityAccStdDevZ** | tGravityAcc-std()-Z |  |
| 15 | **timeBodyAccJerkMeanX** | tBodyAccJerk-mean()-X |  |
| 16 | **timeBodyAccJerkMeanY** | tBodyAccJerk-mean()-Y |  |
| 17 | **timeBodyAccJerkMeanZ** | tBodyAccJerk-mean()-Z |  |
| 18 | **timeBodyAccJerkStdDevX** | tBodyAccJerk-std()-X |  |
| 19 | **timeBodyAccJerkStdDevY** | tBodyAccJerk-std()-Y |  |
| 20 | **timeBodyAccJerkStdDevZ** | tBodyAccJerk-std()-Z |  |
| 21 | **timeBodyGyroMeanX** | tBodyGyro-mean()-X |  |
| 22 | **timeBodyGyroMeanY** | tBodyGyro-mean()-Y |  |
| 23 | **timeBodyGyroMeanZ** | tBodyGyro-mean()-Z |  |
| 24 | **timeBodyGyroStdDevX** | tBodyGyro-std()-X |  |
| 25 | **timeBodyGyroStdDevY** | tBodyGyro-std()-Y |  |
| 26 | **timeBodyGyroStdDevZ** | tBodyGyro-std()-Z |  |
| 27 | **timeBodyGyroJerkMeanX** | tBodyGyroJerk-mean()-X |  |
| 28 | **timeBodyGyroJerkMeanY** | tBodyGyroJerk-mean()-Y |  |
| 29 | **timeBodyGyroJerkMeanZ** | tBodyGyroJerk-mean()-Z |  |
| 30 | **timeBodyGyroJerkStdDevX** | tBodyGyroJerk-std()-X |  |
| 31 | **timeBodyGyroJerkStdDevY** | tBodyGyroJerk-std()-Y |  |
| 32 | **timeBodyGyroJerkStdDevZ** | tBodyGyroJerk-std()-Z |  |
| 33 | **timeBodyAccMagMean** | tBodyAccMag-mean() |  |
| 34 | **timeBodyAccMagStdDev** | tBodyAccMag-std() |  |
| 35 | **timeGravityAccMagMean** | tGravityAccMag-mean() |  |
| 36 | **timeGravityAccMagStdDev** | tGravityAccMag-std() |  |
| 37 | **timeBodyAccJerkMagMean** | tBodyAccJerkMag-mean() |  |
| 38 | **timeBodyAccJerkMagStdDev** | tBodyAccJerkMag-std() |  |
| 39 | **timeBodyGyroMagMean** | tBodyGyroMag-mean() |  |
| 40 | **timeBodyGyroMagStdDev** | tBodyGyroMag-std() |  |
| 41 | **timeBodyGyroJerkMagMean** | tBodyGyroJerkMag-mean() |  |
| 42 | **timeBodyGyroJerkMagStdDev** | tBodyGyroJerkMag-std() |  |
| 43 | **freqBodyAccMeanX** | fBodyAcc-mean()-X |  |
| 44 | **freqBodyAccMeanY** | fBodyAcc-mean()-Y |  |
| 45 | **freqBodyAccMeanZ** | fBodyAcc-mean()-Z |  |
| 46 | **freqBodyAccStdDevX** | fBodyAcc-std()-X |  |
| 47 | **freqBodyAccStdDevY** | fBodyAcc-std()-Y |  |
| 48 | **freqBodyAccStdDevZ** | fBodyAcc-std()-Z |  |
| 49 | **freqBodyAccJerkMeanX** | fBodyAccJerk-mean()-X |  |
| 50 | **freqBodyAccJerkMeanY** | fBodyAccJerk-mean()-Y |  |
| 51 | **freqBodyAccJerkMeanZ** | fBodyAccJerk-mean()-Z |  |
| 52 | **freqBodyAccJerkStdDevX** | fBodyAccJerk-std()-X |  |
| 53 | **freqBodyAccJerkStdDevY** | fBodyAccJerk-std()-Y |  |
| 54 | **freqBodyAccJerkStdDevZ** | fBodyAccJerk-std()-Z |  |
| 55 | **freqBodyGyroMeanX** | fBodyGyro-mean()-X |  |
| 56 | **freqBodyGyroMeanY** | fBodyGyro-mean()-Y |  |
| 57 | **freqBodyGyroMeanZ** | fBodyGyro-mean()-Z |  |
| 58 | **freqBodyGyroStdDevX** | fBodyGyro-std()-X |  |
| 59 | **freqBodyGyroStdDevY** | fBodyGyro-std()-Y |  |
| 60 | **freqBodyGyroStdDevZ** | fBodyGyro-std()-Z |  |
| 61 | **freqBodyAccMagMean** | fBodyAccMag-mean() |  |
| 62 | **freqBodyAccMagStdDev** | fBodyAccMag-std() |  |
| 63 | **freqBodyBodyAccJerkMagMean** | fBodyBodyAccJerkMag-mean() |  |
| 64 | **freqBodyBodyAccJerkMagStdDev** | fBodyBodyAccJerkMag-std() |  |
| 65 | **freqBodyBodyGyroMagMean** | fBodyBodyGyroMag-mean() |  |
| 66 | **freqBodyBodyGyroMagStdDev** | fBodyBodyGyroMag-std() |  |
| 67 | **freqBodyBodyGyroJerkMagMean** | fBodyBodyGyroJerkMag-mean() |  |
| 68 | **freqBodyBodyGyroJerkMagStdDev** | fBodyBodyGyroJerkMag-std() |  |

The end of the table.

