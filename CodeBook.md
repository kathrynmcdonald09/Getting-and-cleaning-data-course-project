# Final_Data_KathrynMcDonald2.txt data set description

## The Data set
The data set used for this assignment was `UCI HAR Dataset`. 
This was downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Files included in this data set are:
 - `test` folder;
 - `train` folder;
 - `activity_lables.txt`;
 - `features.txt`;
 - `features_info.txt`;
 - `README.txt`;

## Variables
The following variables were obtained using files from the `UCI HAR Dataset`.
- `features`
- `activities`
- `x_test`
- `y_test`
- `subject_test`
- `x_train`
- `y_train`
- `subject_train`

## Merging variables to make a single data set
To merge data, these variables were combined into:
- `X_combined`: row bind of `x_train` and `x_test`
- `Y_combined` : row bind of `y_train` and `y_test`
- `Subject_combined`: row bind of `subjects_train` and `subject_test`

And finally, 
- `Merged_Data` : column bind of `X_combined`, `Y_combined` and `Subject_combined`

## Isolating the measurements of mean and standard deviation
- `Clean_Data` is created from `Merged_Data` by subsetting to only include measurements of `mean` and `std`.

## Tidying the newly created `Clean_Data` 
To ensure reproducibility, all abbreviated activity names were corrected into full-names using the function `gsub`.

## Creating an independent tidy data set: `Final_Data`
The `Final_Data` data set includes the average of each variable for each activity and each subject. 
This data set is 180 ros and 88 columns
The file `Final_Data_KathrynMcDonald2.txt` was produced by the function `write.table`.
