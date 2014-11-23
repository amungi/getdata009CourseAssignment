getdata009CourseAssignment
==========================

Course Assignment for getdata-009 Getting and Cleaning Data course

---
title: "README.md - getdata009 - Course Assignment"
author: "amungi"
date: "Sunday, November 23, 2014"
output: html_document
---


# getdata009 - Course Assignment

# Assignment Instructions:
# You should create one R script called run_analysis.R 
# that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.



# Solution:

# Assumptions:
# This script does not set the working directory, and does not download or extract the dataset files
# The working directory for your R environment is already set before invoking this script.
# The dataset zip file is already downloaded to your local machine
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# The dataset zip file is extracted / unzipped to create the base dataset directory "UCI HAR Dataset"
# The base dataset directory "UCI HAR Dataset" is located within the working directory
# The relative locations of sub-folders and files within the directory "UCI HAR Dataset" are the same as the original zip file


# Step 1: Merge the training and the test sets to create one data set.

# Step 1.1 Load required libraries - stringr, dplyr, tidyr, reshape2

# Step 1.2: Read all the relevant dataset files into data frames
# Files do not contain headers
# Use read.table so that multiple whitespaces in the files can be easily handled during reading

# Step 1.2.1: Read activity labels, with 6 observations
# The two columns in the data file are Activity ID and Activity Name

# Step 1.2.2: Read the list of all features, with 561 observations
# The two columns in the data file are Feature ID and Feature Name

# Step 1.2.2.1 : Clean the Feature Names

# Convert each Feature Name into a syntactically valid name
# Replace "..." with "." in each Feature Name
# Replace ".." with "." in each Feature Name
# If a feature name ends with a "." then remove the ending "."

# Step 1.2.2.1 is Complete : Features data (features_df) is now clean


# Step 1.2.3 : Read the training dataset, with 7352 observations

# Step 1.2.3.1 : Read X_train.txt
# Add column names as per the Feature Names

# Step 1.2.3.2 : Read y_train.txt
# Add column name = "Activity_ID", since the values refer to activity labels

# Step 1.2.3.3 : Read subject_train.txt
# Add column name = "Subject_ID", since it denotes the subject who performed the activity

# Step 1.2.4: Read the test dataset, with 2947 observations

# Step 1.2.4.1 : Read X_test.txt
# Add column names as per the Feature Names

# Step 1.2.4.2 : Read y_test.txt
# Add column name = "Activity_ID", since the values refer to activity labels

# Step 1.2.4.3 : Read subject_test.txt
# Add column name = "Subject_ID", since it denotes the subject who performed the activity

# Step 1.3 : Merge the training and test data sets into one merged dataset with 10299 observations

# Step 1.3.1 : Create a new merged dataset by taking the training dataset and adding the rows from the test dataset

# Step 1.3.1.1 : Merge training set (Xtrain) and test set (Xtest), in that order

# Step 1.3.1.2 : Merge training activities (ytrain) and test activities (ytest), in that order

# Step 1.3.1.3 : Merge training subjects (subjecttrain) and test subjects (subjecttest), in that order

# Step 1.3.2: Create a new Merged dataset and combine - merged_y_df and merged_X_df, in that order

# Step 1.3.3: Combine - merged_subject_df and merged_dataset, in that order, to add the subject ID to the merged dataset

# Step 1 Complete: Training and test sets (merged_X_df, merged_y_df, merged_subject_df) are merged into one merged dataset


# Step 2 : Extract only the measurements on the mean and standard deviation for each measurement
# Returns a dataframe of 86 variables containing measurements on the mean ("mean") and standard deviations ("std")

# Step 2 Complete

# Step 3 : Use descriptive activity names to name the activities in the data set from Step 2

# Add a new Activity column to the merged_mean_std_measure_df, and initialize it to the Activity_ID
# Replace the Activity IDs in the new Activity column by lookup of the Activity Names from activitylabels_df
# Remove the Activity_ID column from merged_mean_std_measure_df

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

# Tidy data set tidy_avg_data is calculated as the average of each variable (selected feature)
# for each activity and each subject

# The tidy data set is written to a file using write.table() and excluding row names 
