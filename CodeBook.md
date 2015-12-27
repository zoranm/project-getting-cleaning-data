---
title: "ProjectGettingAndCleaningData"
author: "zoran"
date: "26 Dec 2015"
output: md_document
---

# Overview

This project is focused on getting and cleaning data. It use case and experiments are decribed in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. This site also containts data that are used for training and testing.

# Data set description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

# Attribute Information:

For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

# Detailed description

The description of this project is structured according to several parts of the questions in the aiignment.

## Part1: Read in and merge of training and test datasets 

The first step is to read in training and test data sets and then merge them in one data set. Assuimg that the data was doanloaded outside R enviroment, one should first read in general datasets from the files:

* features.txt
* activity_labels.txt
These files are used for both trianing and test datasets

Then read in trianing and test data sets.

* subject_train.txt
* x_train.txt
* y_train.txt
* subject_test.txt
* x_test.txt
* y_test.txt

After reading in datasets, first combine different files from training datasets into one data set, and similarly with the test datasets. Once this is done, merge them together

## Part2: Extract only the measurements on the mean and standard deviation for each measurement.

One way of doing this is to create a logical vector that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others. This can then be used to subset the data sets with this data to keep only the necessary columns.

## Part3: Use descriptive activity names to name the activities in the data set

This can be done by merging data subset with the activityType table to inlude the descriptive activity names

## Part4: Appropriately labels the data set with descriptive variable names.

One way of doing this is to use gsub function (from grep R library) for pattern replacement to clean up the data labels.

## Part5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

Produce only a data set with the average of each veriable for each activity and subject. This can be done as a two step proces. First, create the second data set less the activityType column which was added earlier and then create tidyData set as required with the average of each variable for each activity and each subject.
