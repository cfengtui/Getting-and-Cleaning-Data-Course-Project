## Usage of the script

The script is to create a tidy data set for [UCI HAR Dataset]

## Initial data for research
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

## The following files from the initial dataset is used:
  1. ***features.txt*** - descriptions for features measured
  2. ***X_train.txt*** - measurements of the features in training set 
  3. ***y_train.txt*** - activity (from 1 to 6) for each measurement from the training set
  4. ***subject_train.txt*** - subject (volunteer) id from the training set
  5. ***X_test.txt*** - measurements of the features in test set
  6. ***y_test.txt*** - activity (from 1 to 6) for each measurement from the test set
  7. ***subject_test.txt*** - subject (volunteer) id for each measurement from the test set

## How script works
This script consists of six parts:
1. Download data, upzip files and load data into R
2. Merge training data and test data to a singel data set
3. Extract only the measurements on the mean and standard deviation for each measurement
4. Appropriately label the data set with descriptive variable names
5. Create a independent tidy set with the average of each variable for each activity and each subject
