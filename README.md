---
title: "README"
author: "Yann BURY"
date: "Sunday, August 24, 2014"
output: md
---

#RUN ANALYSIS CODE

##Intro

The main purpose of this script is to merge two sets of accelerometers datas extracted from a Galaxy S smartphone (The experiment was run during 6 activities and on 30 subjects).


The merged dataset is then manipulated to obtain a set of tidy data.

The tidy data set is then exploited (mean calulation with grouping on subject and activiy)


## SCRIPT EXPLAINATION

### STEP 0 : Initialization 

we read the feature table using read.table.

### STEP 1 : Merges the training and the test sets to create one data set.

We load both test_x and train_x and merge them with rbind.

### STEP 2 :STEP 2 : Extracts only the measurements on the mean and standard deviation for each measurement. 

We then only keep the columns containing "mean" or "std" in the merged set.

We use the grep function to find the columns names matching our need.

We then remove the columns containing "meanFreq".

### STEP 2.5 : Merge the Y and subject together and then merge it with the measurements

The script then merges the train_y and test_y datasets using the same method as in STEP 1.

Sames thing with test_subject & train_subject.

We then merge these two datasets with the one created in STEP 1 using the cbind function.

### STEP 3 : Uses descriptive activity names to name the activities in the data set

Activities explicit names are then loadaed and matched with the numeric activity id with the merge function.

### STEP 4 : Appropriately labels the data set with descriptive variable names. 

At this step the column names are cleaned :

- Removal of special characters
- Lower case.

### STEP 5 : Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Finally, we calculate the mean of each variable, grouped by subject and activity; using the ddply function of the plyr package.










