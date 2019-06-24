##############################################################################
# Step 0 - download and upzip files, read data
##############################################################################

# download data and unzip
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip")
datapath<-"UCI HAR Dataset"


# read training data
trainingsubj <- read.table(file.path(datapath, "train", "subject_train.txt"))
trainingX <- read.table(file.path(datapath, "train", "X_train.txt"))
trainingY <- read.table(file.path(datapath, "train", "y_train.txt"))

# read test data
testsubj <- read.table(file.path(datapath, "test", "subject_test.txt"))
testX <- read.table(file.path(datapath, "test", "X_test.txt"))
testY<- read.table(file.path(datapath, "test", "y_test.txt"))

# read features (as.is is set to TRUE to prevent from converting to factors)
features <- read.table(file.path(datapath, "features.txt"), as.is = TRUE)

# read activity labels
activities <- read.table(file.path(datapath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")


##############################################################################
# Step 1 - Merge the training and the test sets to create one data set
##############################################################################

# concatenate individual data tables to make single data table
mydf <- rbind(
  cbind(trainingsubj, trainingX, trainingY),
  cbind(testsubj, testX, testY)
)


# assign column names
colnames(mydf) <- c("subject", features[, 2], "activity")


##############################################################################
# Step 2 - Extract only the measurements on the mean and standard deviation
#          for each measurement
##############################################################################

# keep only subject, activity and features of mean and std
mydf <- mydf[, grepl("subject|activity|mean|std", colnames(mydf))]

# remove individual data tables to save memory
rm(trainingsubj, trainingX, trainingY, 
   testsubj, testX, testY)

mydf$activity<-activities[mydf$activity,2]
##############################################################################
# Step 3 - Use descriptive activity names to name the activities in the data
#          set
##############################################################################

# Uses descriptive activity names to name the activities in the data set
mydf$activity<-activities[mydf$activity,2]

##############################################################################
# Step 4 - Appropriately label the data set with descriptive variable names
##############################################################################

# get column names
mydfcols <- colnames(mydf)

# remove "()" and "-"
mydfcols<-gsub("[()-]","",mydfcols)

# expand abbreviations and correct typo
mydfCols <- gsub("^f", "frequencyDomain", mydfCols)
mydfCols <- gsub("^t", "timeDomain", mydfCols)
mydfCols <- gsub("Acc", "Accelerometer", mydfCols)
mydfCols <- gsub("Gyro", "Gyroscope", mydfCols)
mydfCols <- gsub("Mag", "Magnitude", mydfCols)
mydfCols <- gsub("Freq", "Frequency", mydfCols)
mydfCols <- gsub("BodyBody", "Body", mydfCols)

# use new labels as column names
colnames(mydf) <- mydfCols

##############################################################################
# Step 5 - Create a second, independent tidy set with the average of each
#          variable for each activity and each subject
##############################################################################

# group by subject and activity and summarise using mean
library(dplyr)
tidy <- mydf %>% 
  group_by(subject, activity) %>%
  summarise_all(mean)

#creating a tidy dataset file  
write.table(tidy, file.path(getwd(), "getting_cleaning_data_course_project", "tidydataset.txt"), row.names = FALSE)