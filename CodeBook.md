---
title: "getdata009_Course Assignment_CODEBOOK"
author: "amungi"
date: "Sunday, November 23, 2014"
output: html_document
---

Original Data:

File Downloaded: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data Title: Human Activity Recognition Using Smartphones Dataset

Description:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The original dataset includes the following files:
=========================================

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- Folder: 'train'
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- Folder: 'test'
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.


=========================

Approach used for Course Assignment (variables used and transformations performed):


1) For the assignment, the files under the folders "Inertial Signals" were ignored since they were not required
for any step of the assignment

2) Key Steps:

# Step 1: Merge the training and the test sets to create one data set.

# Step 1.2: Read all the relevant dataset files into data frames

# Files do not contain headers


# Step 1.2.1: Read activity labels, with 6 observations
# The two columns in the data file "./UCI HAR Dataset/activity_labels.txt" are: Activity ID and Activity Name
activitylabels_df: Data frame used to read the data file "./UCI HAR Dataset/activity_labels.txt"

# Step 1.2.2: Read the list of all features, with 561 observations
# The two columns in the data file "./UCI HAR Dataset/features.txt" are Feature ID and Feature Name
features_df: Data frame used to read the data file "./UCI HAR Dataset/features.txt"

# Step 1.2.2.1 : Clean the Feature Names

A combination of make.names, mutate and str_sub operations used to clean the feature names and make them more descriptive


# Step 1.2.3 : Read the training dataset, with 7352 observations

Xtrain_df: Data frame used to read the file "./UCI HAR Dataset/train/X_train.txt"

ytrain_df: Data frame used to read the file "./UCI HAR Dataset/train/y_train.txt"

subjecttrain_df: Data frame used to read the file "./UCI HAR Dataset/train/subject_train.txt"

Xtest_df: Data frame used to read the file "./UCI HAR Dataset/test/X_test.txt"

ytest_df: Data frame used to read the file "./UCI HAR Dataset/test/y_test.txt"

subjecttest_df: Data frame used to read the file "./UCI HAR Dataset/test/subject_test.txt"


# Step 1.3 : Merge the training and test data sets into one merged dataset with 10299 observations


merged_X_df: Data frame used to store the merged result of rbind(Xtrain_df, Xtest_df)

merged_y_df: Data frame used to store the merged result of rbind(ytrain_df, ytest_df)

merged_subject_df: Data frame used to store the merged result of rbind(subjecttrain_df, subjecttest_df)

merged_dataset: Data frame used to store the merged result of cbind(merged_y_df, merged_X_df) and cbind(merged_subject_df, merged_dataset)


# Step 1 Complete: Training and test sets (merged_X_df, merged_y_df, merged_subject_df) are merged into one merged dataset


# Step 2 : Extract only the measurements on the mean and standard deviation for each measurement
# Returns a dataframe of 86 variables containing measurements on the mean ("mean") and standard deviations ("std")

features_mean : Character vector stores the feature names containing "mean"

features_std : Character vector stores the feature names containing "std" (standard deviation)

selected_features : Character vector storing the combination of features_mean, features_std

mean_std_measure_df : Data frame which stores the subset of merged_dataset based on selected_features

merged_mean_std_measure_df : Data frame which stores the result of cbind(merged_y_df, mean_std_measure_df) and cbind(merged_subject_df, merged_mean_std_measure_df)

# Step 2 Complete

# Step 3 : Use descriptive activity names to name the activities in the data set from Step 2

merged_mean_std_measure_df is mutated to add an activity column, populate it with activity descriptions, and remove the Activity_ID column

# Step 3 Complete

# Step 4 : Appropriately label the data set with descriptive variable names

# Based on the feature name cleanup done in Step 1.2.2.1 above, the variable names are clean
# and follow a naming convention which makes it easy to determine what each variable is.

# Step 4 Complete

# Step 5 : Create a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

meltdata : Data frame storing the melted data from merged_mean_std_measure_df By: Subject and Activity using selected_features

# Tidy data set tidy_avg_data is calculated as the average of each variable (selected feature) for each activity and each subject, using the following formula:
tidy_avg_data <- aggregate(value ~ variable + Activity + Subject_ID, data = meltdata, mean)

This creates a long form tidy dataset with:
Column 1 = Variable (a listing of each of the 86 variables containing mean and standard deviation)
Column 2 = Activity (each of the 6 activities, listed as activity name)
Column 3 = Subject ID (each of the 30 subjects from whom data was collected)
Column 4 = Value (mean or average value of the variable listed in the observation)

The combination of columns 1 thru 4 (Variable, Activity, Subject ID and Average Value) forms 1 observation as a tidy data set
The overall tidy data set contains 15480 observations.

# The tidy data set is written to a file using write.table() and excluding row names 
write.table(tidy_avg_data, "./getdata009_tidy_avg_dataset.txt", row.names = FALSE)

=========================

The 86 Variables containing Standard Deviation and Mean, included in selected_features:

"tBodyAcc.mean.X"
"tBodyAcc.mean.Y"
"tBodyAcc.mean.Z"                    
"tGravityAcc.mean.X"
"tGravityAcc.mean.Y"
"tGravityAcc.mean.Z"                 
"tBodyAccJerk.mean.X"
"tBodyAccJerk.mean.Y"
"tBodyAccJerk.mean.Z"                
"tBodyGyro.mean.X"
"tBodyGyro.mean.Y"
"tBodyGyro.mean.Z"                   
"tBodyGyroJerk.mean.X"
"tBodyGyroJerk.mean.Y"
"tBodyGyroJerk.mean.Z"               
"tBodyAccMag.mean"
"tGravityAccMag.mean"
"tBodyAccJerkMag.mean"               
"tBodyGyroMag.mean"
"tBodyGyroJerkMag.mean"
"fBodyAcc.mean.X"                    
"fBodyAcc.mean.Y"
"fBodyAcc.mean.Z"
"fBodyAcc.meanFreq.X"                
"fBodyAcc.meanFreq.Y"
"fBodyAcc.meanFreq.Z"
"fBodyAccJerk.mean.X"                
"fBodyAccJerk.mean.Y"
"fBodyAccJerk.mean.Z"
"fBodyAccJerk.meanFreq.X"            
"fBodyAccJerk.meanFreq.Y"
"fBodyAccJerk.meanFreq.Z"
"fBodyGyro.mean.X"                   
"fBodyGyro.mean.Y"
"fBodyGyro.mean.Z"
"fBodyGyro.meanFreq.X"               
"fBodyGyro.meanFreq.Y"
"fBodyGyro.meanFreq.Z"
"fBodyAccMag.mean"                   
"fBodyAccMag.meanFreq"
"fBodyBodyAccJerkMag.mean"
"fBodyBodyAccJerkMag.meanFreq"       
"fBodyBodyGyroMag.mean"
"fBodyBodyGyroMag.meanFreq"
"fBodyBodyGyroJerkMag.mean"          
"fBodyBodyGyroJerkMag.meanFreq"
"angle.tBodyAccMean.gravity"
"angle.tBodyAccJerkMean.gravityMean" 
"angle.tBodyGyroMean.gravityMean"
"angle.tBodyGyroJerkMean.gravityMean"
"angle.X.gravityMean"                
"angle.Y.gravityMean"
"angle.Z.gravityMean"
"tBodyAcc.std.X"                     
"tBodyAcc.std.Y"
"tBodyAcc.std.Z"
"tGravityAcc.std.X"                  
"tGravityAcc.std.Y"
"tGravityAcc.std.Z"
"tBodyAccJerk.std.X"                 
"tBodyAccJerk.std.Y"
"tBodyAccJerk.std.Z"
"tBodyGyro.std.X"                    
"tBodyGyro.std.Y"
"tBodyGyro.std.Z"
"tBodyGyroJerk.std.X"                
"tBodyGyroJerk.std.Y"
"tBodyGyroJerk.std.Z"
"tBodyAccMag.std"                    
"tGravityAccMag.std"
"tBodyAccJerkMag.std"
"tBodyGyroMag.std"                   
"tBodyGyroJerkMag.std"
"fBodyAcc.std.X"
"fBodyAcc.std.Y"                     
"fBodyAcc.std.Z"
"fBodyAccJerk.std.X"
"fBodyAccJerk.std.Y"                 
"fBodyAccJerk.std.Z"
"fBodyGyro.std.X"
"fBodyGyro.std.Y"                    
"fBodyGyro.std.Z"
"fBodyAccMag.std"
"fBodyBodyAccJerkMag.std"
"fBodyBodyGyroMag.std"
"fBodyBodyGyroJerkMag.std"

In the above variables, the following short forms are used:
1) prefix 't' denotes time 
2) prefix 'f' indicates frequency
3) Acc = Accelerometer
4) Gyro = Gyroscope
5) X, Y, Z = x,y,z axes of 3D geometry
6) Jerk = body linear acceleration and angular velocity derived in time
7) Mag = magnitude
8) std = Standard Deviation
9) mean = Mean or average
10) angle: Angle between 2 vectors

END OF CODEBOOK
