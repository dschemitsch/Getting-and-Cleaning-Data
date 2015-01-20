require(stringr)
require(data.table)
#temp <- tempfile()
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)

# 1: Merge the training and the test sets to create one data set------------

# 1.1: download the activity labels for future reference--------------
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity_label"))

# 1.2: download the activity labels for the test data (y_test.txt) and append the row number for future reference ----------
test_activity_labels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")
test_activity_labels$row <- as.numeric(rownames(test_activity_labels))


# 1.3: download the variables used on the feature vector (features.txt), which will be the column names for the data.----
features <- read.table("./UCI HAR Dataset/features.txt")

# 1.4: download the test data (X_test.txt) and make the column names the variable found in "features".-------------
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features[,2])

# 1.5: download the IDs for the subjects used in the test case (9 individuals). ----
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject_id")

# 1.6: download the train data (X_train.txt) and make the column names the variable found in "features".----------
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features[,2])

# 1.7: download the activity labels for the train data (y_train.txt) and append the row number for future reference (Add 2947 since this file will be bound to the test data, which has 2947 rows. This will maintain the original order of the data) ----------
train_activity_labels <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")
train_activity_labels$row <- (as.numeric(rownames(train_activity_labels))+2947)

# 1.8: download the IDs for the subjects used in the training case (21 individuals). ----
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject_id")



# 1.9: bind  by column the data, activity labels, and subject IDs for the test and training sets; then bind the complete test and training sets together by row; then reorder the column for convenience so that the row, activity_id, and subject_id columns are on the left side of the data set.-----
complete_test <- cbind(test_set, test_activity_labels, test_subjects)
complete_train <- cbind(train_set, train_activity_labels, train_subjects)
data <- rbind(complete_test, complete_train)
data <- data[c(563,562,564,1:561)]

# 2: Extract only the measurements on the mean and standard deviation for each measurements. First, create indices (i) for columns that should be in the final tidy data set: columns containing "mean" or "std" as well as the row, activity_id, and subject_id columns. Then, subset the data on these indices.---------
i <- c(1:3, n <- grep(c("mean|std"), names(data)))
data <- data[i]

# 3: Create descriptive activity names to name the activities in the data set. First, change the class of the activity_id column from numeric to character so we can use the str_replace_all function. Then, replace the numerals with their descriptive counterparts.------
data$activity_id <- as.character(as.numeric(data$activity_id))
data$activity_id <- str_replace_all(data$activity_id, "1", "WALKING")
data$activity_id <- str_replace_all(data$activity_id, "2", "WALKING_UPSTAIRS")
data$activity_id <- str_replace_all(data$activity_id, "3", "WALKING_DOWNSTAIRS")
data$activity_id <- str_replace_all(data$activity_id, "4", "SITTING")
data$activity_id <- str_replace_all(data$activity_id, "5", "STANDING")
data$activity_id <- str_replace_all(data$activity_id, "6", "LAYING")

# 4: Data set has been appropriately labeled with descriptive variable names throughout this process.-----------

# The data set is 82 columns wide, and the first three columns the identifiers. So, we will be finding the mean so the remaining columns, i.e. 4 through 82.
ncol(data)
names(data[1:4])
# 5: Create the tidy dataset using the aggregate function.------
# 5.1: The data we are aggregating the mean for are those containing "mean" or "std" (4 through 82), and we are grouping it by subject_id and activity_id.----------
data <- aggregate(x = data[4:82], by = list(data$subject_id, data$activity_id), FUN = mean)
names(data[1:4])

# 5.2: The names for subject_id and activity_id were changed to Group.1 and Group.2, respectively, so change them back.-------------
colnames(data)[1] <- "subject_id"
colnames(data)[2] <- "activity_description"

# Export the text file for upload to Coursera.
write.table(data, "./data.txt", row.name=FALSE)