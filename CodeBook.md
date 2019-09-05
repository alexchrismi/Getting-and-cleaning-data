This is the codebook for the dta_mean file as requested in the assignment. We have used the example code book provided in Quiz 01 of the course (see https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf) as an example for constructing this code book. As described in the README.md-file, different files were merged in the process that led to the tidy dataset. The resulting variables in this dataset can be delineated in two groups: (1) data referring to research subjects and their activities carried out during the research project and (2) data that was derived from the motion sensors. With respect to group (1), the following two variables are included in the dataset.

subject_id (int, max length = 2)
        Subject Identifier

        0 .. 30. Unique identifier assigned to each research subject

activity (factor, max length = 18)
        Activity Label

        LAYING
        SITTING
        STANDING
        WALKING
        WALKING_DOWNSTAIRS
        WALKING_UPSTAIRS

With respect to group (2), a host of features -all denoting either the mean or standard deviation of a certain feature- is included. See the file 'features_info.txt' for more information. All variables are measured on a ratio scale, normlaized and bounded within [-1.1]. Some variables are measured along three dimensions (XYZ), others along one dimension. The variables are listed in the below:

Measurements along three (XYZ) dimensions:
	mean() + std():
	
	tBodyAcc-XYZ
	tGravityAcc-XYZ
	tBodyAccJerk-XYZ
	tBodyGyro-XYZ
	tBodyGyroJerk-XYZ

	mean(), std() + meanFreq():

	fBodyAcc-XYZ
	fBodyAccJerk-XYZ
	fBodyGyro-XYZ

Measurements along one dimension:

	mean() + std():
	tBodyAccMag
	tGravityAccMag
	tBodyAccJerkMag
	tBodyGyroMag
	tBodyGyroJerkMag

	mean() + std() + meanFreq():
	fBodyAccMag
	fBodyAccJerkMag
	fBodyGyroMag
	fBodyGyroJerkMag