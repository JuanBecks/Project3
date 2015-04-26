### Brief Explanation

The goal of this R script is to convert raw data into a tidy dataset.  In a nutshell, this R code 
takes a number of files from the UCI HAR Dataset, assigns column names, combines datasets, re-names 
columns, retains columns of interest (mean and standard devation measures), takes an average of each 
remaining column for each subject and activity, and then outputs this data in a tidy fashion to a text file. 
The program makes use of the plyr and dplyr libraries. 

For additional details, please read the comments within the R script.

