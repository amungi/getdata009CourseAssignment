# getdata009 - Course Assignment
# author: amungi

# Assignment Instructions:
# You should create one R script called run_analysis.R 
# that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

# Soluton:

# Assumptions:
# This script does not set the working directory, and does not download or extract the dataset files
# The working directory for your R environment is already set before invoking this script.
# The dataset zip file is already downloaded to your local machine
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# The dataset zip file is extracted / unzipped to create the base dataset directory "UCI HAR Dataset"
# The base dataset directory "UCI HAR Dataset" is located within the working directory
# The relative locations of sub-folders and files within the directory "UCI HAR Dataset" are the same as the original zip file

# Step 1: Merge the training and the test sets to create one data set.

# Step 1.1 Load required libraries
library(stringr)
library(dplyr)
library(tidyr)
library(reshape2)


# Step 1.2: Read all the relevant dataset files into data frames

# Files do not contain headers
# Use read.table so that multiple whitespaces in the files can be easily handled during reading

# Step 1.2.1: Read activity labels, with 6 observations
# The two columns in the data file are Activity ID and Activity Name
activitylabels_df <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("ActivityID","ActivityName"))

# Step 1.2.2: Read the list of all features, with 561 observations
# The two columns in the data file are Feature ID and Feature Name
features_df <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, col.names = c("FeatureID","FeatureName"))

# Step 1.2.2.1 : Clean the Feature Names

# Convert each Feature Name into a syntactically valid name
features_df$FeatureName <- make.names(features_df$FeatureName)

# Replace "..." with "." in each Feature Name
features_df <- mutate(features_df, FeatureName = sub("...",".",features_df$FeatureName,fixed = TRUE))

# Replace ".." with "." in each Feature Name
features_df <- mutate(features_df, FeatureName = sub("..",".",features_df$FeatureName,fixed = TRUE))

# If a feature name ends with a "." then remove the ending "."
features_df <- mutate(features_df, FeatureName = ifelse((str_sub(FeatureName,-1,-1) == "."), str_sub(FeatureName,1,-2), FeatureName))

# Step 1.2.2.1 is Complete : Features data (features_df) is now clean


# Step 1.2.3 : Read the training dataset, with 7352 observations

# Step 1.2.3.1 : Read X_train.txt
# Add column names as per the Feature Names
Xtrain_df <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = features_df$FeatureName)

# Step 1.2.3.2 : Read y_train.txt
# Add column name = "Activity_ID", since the values refer to activity labels
ytrain_df <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = c("Activity_ID"))

# Step 1.2.3.3 : Read subject_train.txt
# Add column name = "Subject_ID", since it denotes the subject who performed the activity
subjecttrain_df <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = c("Subject_ID"))


# Step 1.2.4: Read the test dataset, with 2947 observations

# Step 1.2.4.1 : Read X_test.txt
# Add column names as per the Feature Names
Xtest_df <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = features_df$FeatureName)

# Step 1.2.4.2 : Read y_test.txt
# Add column name = "Activity_ID", since the values refer to activity labels
ytest_df <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = c("Activity_ID"))

# Step 1.2.4.3 : Read subject_test.txt
# Add column name = "Subject_ID", since it denotes the subject who performed the activity
subjecttest_df <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = c("Subject_ID"))


# Step 1.3 : Merge the training and test data sets into one merged dataset with 10299 observations

# Step 1.3.1 : Create a new merged dataset by taking the training dataset and adding the rows from the test dataset

# Step 1.3.1.1 : Merge training set (Xtrain) and test set (Xtest), in that order

merged_X_df <- rbind(Xtrain_df, Xtest_df)

# Step 1.3.1.2 : Merge training activities (ytrain) and test activities (ytest), in that order

merged_y_df <- rbind(ytrain_df, ytest_df)

# Step 1.3.1.3 : Merge training subjects (subjecttrain) and test subjects (subjecttest), in that order

merged_subject_df <- rbind(subjecttrain_df, subjecttest_df)

# Step 1.3.2: Create a new Merged dataset and combine - merged_y_df and merged_X_df, in that order

merged_dataset <- cbind(merged_y_df, merged_X_df)

# Step 1.3.3: Combine - merged_subject_df and merged_dataset, in that order, to add the subject ID to the merged dataset

merged_dataset <- cbind(merged_subject_df, merged_dataset)


# Step 1 Complete: Training and test sets (merged_X_df, merged_y_df, merged_subject_df) are merged into one merged dataset


# Step 2 : Extract only the measurements on the mean and standard deviation for each measurement
# Returns a dataframe of 86 variables containing measurements on the mean ("mean") and standard deviations ("std")
features_mean <- c(grep("mean", features_df$FeatureName, ignore.case = TRUE, value = TRUE))
features_std <- c(grep("std", features_df$FeatureName, ignore.case = TRUE, value = TRUE))
selected_features <- c(features_mean, features_std)
mean_std_measure_df <- select(merged_dataset, one_of(selected_features))

merged_mean_std_measure_df <- cbind(merged_y_df, mean_std_measure_df)
merged_mean_std_measure_df <- cbind(merged_subject_df, merged_mean_std_measure_df)

# Step 2 Complete

# Step 3 : Use descriptive activity names to name the activities in the data set from Step 2

# Add a new Activity column to the merged_mean_std_measure_df, and initialize it to the Activity_ID
merged_mean_std_measure_df <- mutate(merged_mean_std_measure_df, Activity = Activity_ID)

# Replace the Activity IDs in the new Activity column by lookup of the Activity Names from activitylabels_df
merged_mean_std_measure_df$Activity <- activitylabels_df[merged_mean_std_measure_df$Activity_ID,2]

# Remove the Activity_ID column from merged_mean_std_measure_df
merged_mean_std_measure_df <- select(merged_mean_std_measure_df, -Activity_ID)

# Step 3 Complete

# Step 4 : Appropriately label the data set with descriptive variable names

# Based on the feature name cleanup done in Step 1.2.2.1 above, the variable names are clean
# and follow a naming convention which makes it easy to determine what each variable is.

# Additional descriptions are provided in the accompanying CodeBook.

# Step 4 Complete

# Step 5 : Create a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

# Melt the data merged_mean_std_measure_df By: Subject and Activity
# Variables containing mean and standard deviation measures are the "selected features"
meltdata <- melt(merged_mean_std_measure_df, id = c("Subject_ID","Activity"), measure.vars = selected_features)

# Tidy data set tidy_avg_data is calculated as the average of each variable (selected feature) for each activity and each subject
tidy_avg_data <- aggregate(value ~ variable + Activity + Subject_ID, data = meltdata, mean)

# The tidy data set is written to a file using write.table() and excluding row names 
write.table(tidy_avg_data, "./getdata009_tidy_avg_dataset.txt", row.names = FALSE)

# Script COMPLETED
