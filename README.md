CleaningProj
============

This repository contains an R script and documentation for extracting a subset of measurements from and tidying a 
Samsung data set of phone motion sensor data.
It represents the course project for the "Getting and Cleaning Data" course.

Description of the original Samsung data:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Location of the original Samsung data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Once the tidy data set of selected measurements is generated, an initial analysis is done: a tidy data set of averages is
generated for each measurement by subject and activity. 

### Downloading the repository

This repository is located in Github and can be downloaded using the git clone command to create 
the CleaningProj repository in the current directory.

```
git clone https://github.com/mojobob/CleaningProj.git
```

The repository contains three files: 
- **README.md** - this file
- **CodeBook.md** - a description of variables in the tidy data set file that will be produced
- **run_analysis.R** - R script that produces the tidy data set and runs an initial analysis

### Initial state of R working directory (before running the script)

The `run_analysis.R` script does not assume any data is initially present in the R working directory and
will only overwrite files that match the names of the two tidy data sets being produced. That is, it is safe to 
use the repository directory containing the script as the R working directory.

To generate the tidy data sets, start R, set the working directory (if needed), and run the script.

```
source("path-to-script"/run_analysis.R)
```

If the original Samsung data set is already present in the `UCI HAR Dataset` directory
in the R working directory (probably from a previous run of the script), that data will be processed.
If the directory is not present, the script will download the original Samsung data from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

then unzip it into the working directory as the `UCI HAR Dataset` directory.
Obviously, Internet access is necessary to initially obtain the data. 

### Final state of the working directory

When the script completes, the working directory will contain additional files:
- **UciHarMeansAndStdDevs.txt** - the tidy version of the mean and standard deviation measurements extracted from the Samsung data
- **UciHarMeansOfMeansAndStdDevs.txt** - a tidy data set containing the averages by subject and activity for each variable (Step 5 of the assignment)
- **UCI HAR Dataset** - a directory containing the original downloaded Samsung data

### Structure of the Samsung data

When the script terminates, the original Samsung data is contained in the `UCI HAR Dataset` directory. 
See the `README.txt` file in that directory
for a description of the basic experiments used to generate the data and listing the
contents of the other files in the data set. The `features_info.txt` describes the measurements in each
row of the data set (the `X_` files).

The data are based on measurements from accelerometer and gyroscope sensors in a Samsung phone for subjects (i.e., people)
doing specific types of physical activities (e.g., walking). The direct measurements
used to generate the data in the data set are time series from the phone sensors. The measurements in each
observation (row) of the data set represent something derived from the original time series for a specific
subject doing a specific activity. For instance, measurements for the
minimum and maximum values in a time series are included. There are also frequency domain values based on 
FFT (Fast Fourier Transform) analysis of the original time series measurements.

### Our goal and why we produce a wide tidy data set

Our goal in processing the original Samsung data set is to extract into a single row of a new tidy data set
the measurements that involve a mean or standard deviation for a single observation of a subject doing an activity.
See http://vita.had.co.nz/papers/tidy-data.pdf for a description of how to tidy a data set.

We chose to produce a tidy data set in the "wide" format, where several related measurements are presented as
columns in a single observation (row). The reason for doing this is that there can be several observations
of a single subject doing the same activity. For instance, a single subject might have been measured while walking multiple times.
The measurements in a single row relate to exactly one observation. If we chose
the "long" version of a tidy data set where typically a single measuremnt appears in each row, we would need
to introduce a sequence number to distinguish between the first and second time a particular subject did
the same activity.

### How the original pieces of Samsung data fit together

The Samsung data set is quite fragmented, with subject and activity ids held separately 
(in `subject_` and `y_` files, respectively) from the measurements (in `X_` files), 
and the measurement files are split into `training` and `test` parts.

David Hood, in a Coursera [forum thread](https://class.coursera.org/getdata-007/forum/thread?thread_id=49) provides 
an excellent diagram of how the data components fit together:

<img src="https://coursera-forum-screenshots.s3.amazonaws.com/ab/a2776024af11e4a69d5576f8bc8459/Slide2.png">

Note that although there are `Inertial Signals` directories with additional measurements contained with both
the test and training data, we do not include them in processing because these directories do not contain any
mean or standard deviation measurements of interest for the data set we are producing. They can safely be ignored.

### Description of the processing steps

The `run_analysis.R` script performs several operations on the original Samsung data to produce the tidy `UciHarMeansAndStdDevs.txt`
data set of mean and standard deviation measurements, and then the tidy `UciHarMeansOfMeansAndStdDevs.txt` data set
with averages over all observations of a particular subject doing a particular activity.

#### Ensure the original Samsung data is downloaded

If the `UCI HAR Dataset` directory does not exist in the R working directory, the zip file is downloaded and unpacked
as described previously. The data in the `UCI HAR Dataset` is not altered in any way by the script after unpacking.

#### Load the individual components of the Samsung data

Each interesting component of the Samsung data set (as shown in David Hood's diagram) is loaded into R as a
separate data frame.

#### Merge test and training observations

The test and training observations are then merged into a single block of observation. The blocks of test and training rows are simply 
concatenated. That is, every test and training observation appears as a separate row in the new merged data frame.
The test and training lists of subjects and activities need to be merged in exactly the same way so that the 
subject and activity associated with each observation is still in the correct position. Row order is used extensively in the 
Samsung data set.

#### Retain only the measurement columns that include means or standard deviations

The `features.txt` file in the Samsung data includes descriptive names for the measurement columns rather than
the numeric names (e.g., `V123`) that appear in the loaded measurement data. We filter the descriptive column
names for those that include `-mean(` or `-std(`. 66 columns satisfy the criteria. We do not include columns 
with names that just include `mean` as part of something else (e.g., `meanFreq` or `gravityMean`). Our reasoning is that we 
are only interested in columns that are a direct measurement of a mean or standard deviation.

Once we have identified the measurement columns of interest, we reduce the columns in our new data set to just those
columns. This is done through simple column selection. The number and order of observations (rows) does not change.

#### Convert the list of activity ids into a list of activity labels

The numeric activity ids have descriptive counterparts (e.g., 1 maps to `WALKING`). We convert the activity ids contained
in the merged `y_` files into the descriptive labels contained in the `activity_label.txt` using the `join` function
from the R plyr package. We need to use this funcion because the list of activity ids correlates with the actual
observation data based only on row number. The `join` function preserves the row order during the merge.
 
#### Attach the subject ids and activity labels as separate columns to each observation

Both the subject id and the activity label are held separately from the measurement data. The data in each row
of each of these frames correspond to the same observation. We concatenate the subject and activity label
as separate columns to the measurement data to form a complete, tidy set of variables corresponding to a single
observation.
 
#### Clean up and install the descriptive column names

The column names in `features.txt` are reasonably descriptive. They contain abbreviated information about whether
the measurement is in the time or frequency domain, what sensor is used, the axis or magnitude of the measurement,
and whether it is a mean or standard deviation. Our cleanup of the column names involves removing some superfluous
characters, like "()" and "-" and some abbreviation expansions to make the nature of the value more clear. We do not 
expand the abbreviated descriptions into long, wordy prose descriptions because they can impede viewing the data and 
complicate scripts used to process the data by forcing the use of long strings rather than comparatively short identifiers
for selecting specific measurements.

Once we have cleaned up the column names, we install them on the affected columns in our tidy data set.

#### Write the new data set to a file

The new, tidy data set is then written to the `UciHarMeansAndStdDevs.txt` file in the working directory.

### Subsequent analysis (Step 5)

Once the script writes the new data set to the working directory, a second tidy data set is generated from the
first. The new data set contains a row with averages of each measurement for each combination of subject activity.
That is, if subject 4 was measured while walking eight separate times, the row in the new data set for subject
4 walking would include the average of the eight measures for each column.

The new data set is written to the `UciHarMeansOfMeansAndStdDevs.txt` file in the working directory.

### How to load and view the generated data sets

The resulting data sets can be loaded into R using the `read.table()` with `header = TRUE`. For instance, to
load the data set containing all mean and standard deviation measurements into a variable named `data` and then
view some of the data, the following R commands can be used:

```
data <- read.table("UciHarMeansAndStdDevs.txt", header = TRUE)
View(data)
```

