# Getting and Cleaning Data Course Project

This repository contains the R script and documentation required for the Coursera Course "Getting and Cleaning Data"
The dataset used comes from this website: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The script run_analysis.R does the following actions:
* it checks whether the data set is downloaded and unzipped. If not, it will download and/or unzip the data set.
* it combines all the different datasets into dataset
* it extracts only the Mean and Std measurements
* it renames the activity names to something more descriptive
* it relables the data set with more descriptive variable names
* creates a "tidy_data_set.txt" file from the above data set.