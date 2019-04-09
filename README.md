#Steps taken to clean and reshape data

Read the files that contain the labels for activities.

Reading the data.

Read the data by identifying the subjects for test observations and renaming columns, the data for the test observations, and add the descriptions.

Read the activity type and rename columns, keep the columns Subject.Id, Activity, and columns containing mean.

Enter the description for the activity type to produce the final data, read the training data.
 
Merge the training and test data to create a data set (training and test data have the same format, they will be linked vertically).

Remode the merged data to produce the desired format for aggregating data.

Use the merge function to prepare data for aggregation.

Add data with the dcast function to produce the final data set (tidy).

Write to the txt file the set of tidy data in the Data folder.
