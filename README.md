Project background:
In this file, we'll explain the background of this project and talk you through the script that was used to complete it. For the code book that describes the different variables in the dataset that results from this script, see the file 'CodeBook.md'.

The script was written for the course project of the 'Getting and Cleaning Data' course on Coursera, offered by Johns Hopkins University. The purpose is to show ones ability to collect, work with, and clean a data set. The data set that is used was gathered in the context of a research project aiming at recognizing human activity using a smartphone. More information about this project can be founde here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data is offered in a .zip-file which contains several .txt-files and folders. Because the data was used in several machine learning articles, it has been split into a test and training dataset. The raw data (i.e. acceleration signals measured at 128 measurement points over time) can be found in the 'Inertial Signals'-folders. For the assignmnent, this data is not needed, as it already has been used for calculating various features, which are provided in separate files. In addition to these files, several files containing information on subject id's, features measured and labels is provided. 

The following files are used for this assignment:
(1) 'features.txt': List of all features.
(2) 'activity_labels.txt': Links the class labels with their activity name.
(3) 'train/X_train.txt': Training set.
(4) 'train/y_train.txt': Training labels.
(5) 'test/X_test.txt': Test set.
(6) 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

The script:
The only package that we load before we execute the steps needed for this assignment is the dplyr package. In addition, you can set your working directory anywhere you like, all directory paths in this code will be relative to this working directory. Below we will explain the different steps taken in order to create the two datasets that were required for the assignment. According to this assignment, the script needs to execute five main steps. These steps can indeed found in our script, although we did not follow the exact order of steps as specified in the assignment: the step in which only the measurements on the mean and standard deviation are extracted -being the second step in the assignment- is actually the fifth step in our script. Each step is marked in our script.

STEP 1:
Step 1 entails downloading the data from the server and unzipping it. For this, we first create a data folder in the current working directory, but only if this folder does not exist yet. So, the script checks if the folder already exists. If not, the folder is created. Then, the .zip-file is downloaded using the URL provided in the assignment. Here as well, we check if the file wasn't already downloaded before, to minimize server load. Lastly, we unzip the file. Unzipping creates a folder in the created data folder with the name 'UCI HAR Dataset'. This folder contains the files neccessary for the assignment.

STEP 2:
In the second step, we merge the training and test sets (files (3) to (6) in the above list) to create one data set. This data set is named "dta". For this code to work, a temporary dataframe (tmp) is created that is removed once the code is executed. The code combines the lapply-function (with read.table as the function that is executed) with the list.files-function. The latter function lists all files in the directory specified, and is set-up in such a way that it only returns files with an .txt-extension (we use the gsub-function for this). Through pasting the directory with the yielded file-names, R knows where and what to look for. We also use the list.files function to assign names (without the .txt-extension) to the different objects in the list that is returned by the lapply-function. Lastly, the list2env-function creates the data objects in the global R environment, so these can be processed in subsequent steps. This block of code is applied to files in the test and the train folders. To avoid issues related to columns having similar names in the last substep of step 2, the data.frames that are read in this step are assigned column headers where neccessary. In the last substep of this step, the dta dataset is created through combining the rbind and cbind functions that put the read datasets together. Once this dataset is created, the source datasets are removed from the environment.

STEP 3:
The third step is relatively straightforward: the labels for each activity are specified in the file "acticity_labels.txt" (file (2)). Hence, this file is read first and we assign the relevant column headers to the resulting dataframe. Then, this dataframe is merged with the dta dataframe created in the previous step using the key that was provided by the y_test.txt and y_train.txt files that were merged in the dta dataframe in the previous step. Because this key is not needed any longer and the merge-function moved this key to the first column of the dta dataframe, we remove this column using the [-1] subset. Also, the activity_labels object is removed from the environment once it is no longer needed at the end of this step.

STEP 4:
This step resembles the previous step. Hitherto, some of the variable names in the dataset already got descriptive names in the previous steps, but the main chunk (i.e. the data stemming from the X_test.txt and X_train.txt files merged in the dta dataframe in step 2) still has "unfriendly" labels (i.e. V1, V2, etc). We use the labels provided in the "features.txt"-file (file (1)) to fix this (this file contains a complete list of variables for each feature vector). This file is read first, and then the list of labels in this file is combined with the labels "subject_id" (first column) and "activity" (last column). The resulting vector contains all the columnnames in the dta dataframe, which then is assigned as columnnames to this dataframe. Once this is done, the features-object is removed from the environment.

STEP 5:
As specified in the assignment, only measurements on the mean and standard deviation for each measurement are considered relevant. In the fifth step this is taken care of by using a regular expression that filters -next to the subject_id and the acticity- all columns that contain mean() or std() in their names (std stands for standard deviation). The result is a tidy dta dataframe: each row contains the means and standard deviations for the different measurements related to one of the many observations at a certain time point of one of the 30 participants conducting a certain activity.

STEP 6:
It is in this last step that the tidy-package is used: by grouping by subject_id and activity, we use the "summarise_all"-function of this package in order to create the required summary. The dimensions of this dataset indicate that it has 180 rows, which matches with 30 respondents each conducting 6 activities.