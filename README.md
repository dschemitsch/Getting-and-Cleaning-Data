# Getting-and-Cleaning-Data
Getting and Cleaning Data final

Below is a descripion of how the code works. The steps follow those in the final's instructions, and are broken down into sub-steps that describe each line of code. They are also included as comments withing the code itself.
1: Merge the training and the test sets to create one data set
          1.1: download the activity labels for future reference
          1.2: download the activity labels for the test data (y_test.txt) and append the row number for future reference
          1.3: download the variables used on the feature vector (features.txt), which will be the column names for the data
          1.4: download the test data (X_test.txt) and make the column names the variable found in "features"
          1.5: download the IDs for the subjects used in the test case (9 individuals)
          1.6: download the train data (X_train.txt) and make the column names the variable found in "features"
          1.7: download the activity labels for the train data (y_train.txt) and append the row number for future reference                 (Add 2947 since this file will be bound to the test data, which has 2947 rows. This will maintain the original                order of the data)
          1.8: download the IDs for the subjects used in the training case (21 individuals)
          1.9: bind  by column the data, activity labels, and subject IDs for the test and training sets; then bind the                     complete test and training sets together by row; then reorder the column for convenience so that the row,                    activity_id, and subject_id columns are on the left side of the data set.
2: Extract only the measurements on the mean and standard deviation for each measurements.
          2.1: create indices (i) for columns that should be in the final tidy data set: columns containing "mean" or                       "std" as well as the row, activity_id, and subject_id columns. 
          2.2: subset the data on these indices.
          
3: Create descriptive activity names to name the activities in the data set. 
          3.1: change the class of the activity_id column from numeric to character so we can use the str_replace_all       f                function. 
          3.2: replace the numerals with their descriptive counterparts
4: Appropriately labels the data set with descriptive variable names
          4.1: This is followed throughout the file.
5: Create the tidy dataset using the aggregate function
          5.1: The data we are aggregating the mean for are those containing "mean" or "std" (4 through 82), and we are                     grouping it by subject_id and activity_id.
