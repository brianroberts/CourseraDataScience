# Data Cleaning assignment

Everything is contained in the R script run_analysis.R

run_analysis.R does the following:

download the file to ./data directory
unzip file
read the following files into data.tables:
  - activity_labels
  - features
  - X_test
  - subject_test
  - y_test
  - X_train
  - subject_train
  - y_train

Column names are created for the X_test and X_train data.tables using the vector of names from the features table
The test and train tables, respectively, are combined using cbind (while selecting only the columns matching 'mean' 
or 'std' in the X_* tables) and then the two new data.tables are combined using rbind

The script then writes out the file for uploading.

To create the data set of averages, the script melts the full data set with ids of subject id, activity id and 
activity name and measures of all other columns, then uses the dplyr functions group_by and summarize to
group by subject id and activity name and variable and taking the mean of value.