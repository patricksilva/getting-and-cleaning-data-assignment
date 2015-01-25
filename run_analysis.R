## run_analysis.R

## READ IN THE TRAIN DATA INTO ONE DATA SET AND APPROPRIATELY LABEL
## THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

# Read in the column names (features) for the x_train and x_test data sets

features <- read.table("UCI HAR Dataset/features.txt")

# Read in the Train data sets: y_train.txt, X_train.txt, subject_train.txt

# x_train contains the raw data collected by feature
# the column names (features) are found in the features data set and
# the columns renamed appropriately in the final x_train data set
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
colnames(x_train) <- features[, 2]

# y_train contains the ACTIVITIES for each data row in x_train
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

#subject_train contains the PARTICIPANT ID for each data row in x_train
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Column Bind the x_train, y_train and subject_train data sets
train <- cbind(y_train, x_train)
names(train)[1] <- "activityType"
train <- cbind(subject_train, train)
names(train)[1] <- "participantId"


## READ IN THE TEST DATA INTO ONE DATA SET AND APPROPRIATELY LABEL
## THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

# Read in the Test data sets: y_test.txt, X_test.txt, subject_text.txt

# x_test contains the raw data collected by feature
# the column names (features) are found in the features data set and
# the columns renamed appropriately in the final x_test data set
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(x_test) <- features[, 2]

# y_test contains the ACTIVITIES for each data row in x_train
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

#subject_test contains the PARTICIPANT ID for each data row in x_test
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Column Bind the x_test, y_test and subject_test data sets
test <- cbind(y_test, x_test)
names(test)[1] <- "activityType"
test <- cbind(subject_test, test)
names(test)[1] <- "participantId"


## MERGE THE TRAIN AND THE TEST DATA INTO ONE DATA SET

merged <- rbind(train, test)


## EXTRACT ONLY THE PARTICIPANT ID, ACTIVITY TYPE, MEAN AND STANDARD DEVIATION COLUMNS
finalCols <- c("participantId", "activityType", "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()", "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()", "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAcc-meanFreq()-X", "fBodyAcc-meanFreq()-Y", "fBodyAcc-meanFreq()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyAccJerk-meanFreq()-X", "fBodyAccJerk-meanFreq()-Y", "fBodyAccJerk-meanFreq()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyGyro-meanFreq()-X", "fBodyGyro-meanFreq()-Y", "fBodyGyro-meanFreq()-Z", "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyAccMag-meanFreq()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()", "fBodyBodyAccJerkMag-meanFreq()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroMag-meanFreq()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()", "fBodyBodyGyroJerkMag-meanFreq()", "angle(tBodyAccMean,gravity)", "angle(tBodyAccJerkMean),gravityMean)", "angle(tBodyGyroMean,gravityMean)", "angle(tBodyGyroJerkMean,gravityMean)", "angle(X,gravityMean)", "angle(Y,gravityMean)", "angle(Z,gravityMean)")

merged <- merged[, finalCols]

## USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE MERGED DATA SET

# Replaces the activity type integer ID with the appropriate string label (e.g. WALKING)

merged$activityType <- replace(merged$activityType, merged$activityType == 1, "WALKING")
merged$activityType <- replace(merged$activityType, merged$activityType == 2, "WALKING_UPSTAIRS")
merged$activityType <- replace(merged$activityType, merged$activityType == 3, "WALKING_DOWNSTAIRS")
merged$activityType <- replace(merged$activityType, merged$activityType == 4, "SITTING")
merged$activityType <- replace(merged$activityType, merged$activityType == 5, "STANDING")
merged$activityType <- replace(merged$activityType, merged$activityType == 6, "LAYING")

## CREATE FINAL TIDY DATA SET WITH THE MEAN OF EACH EXTRACTED FEATURE FOR EACH ACTIVITY AND EACH SUBJECT

tidy <- aggregate(merged[, -(1:2)], by=list(subject=merged$participantId, activity=merged$activityType), FUN=mean, na.rm=TRUE)
write.table(tidy, "tidy.txt", row.name=FALSE)