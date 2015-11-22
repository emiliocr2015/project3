## README FILE 
## Human Activity Recognition Using Smartphones Dataset

### Purpose
The purpose of this project is to obtain a transformed and tidy subset of the original data coming from the 'Human Activity Recognition Using Smartphones Dataset' [1], available in the url "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones".
The data come from an experiment carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist, capturing the 3-axial linear acceleration  and 3-axial angular velocity (a vector of measurements each one) for each observation.The obtained data set has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

### Files

* README.md: R markdown file with an explanation of how the R script works.
* CodeBook.md: R markdown file with a brief description of each variable contained in the data sets created. 
* run_analysis.R: R script file with the code instructions for downloading the original data, load it into R and transformed it in a suitable way explained below.

### Script description ('run_analysis.R')
In order to create the new data sets, it is only needed to run the script 'run_analysis.R'. The code included in this file will download the data directly from the internet and transform it in the proper way. The script will follow these steps:

1. First of all, the original data will be downloaded from the web page, and extracted (original file comes in a '.zip' format). The  compressed file includes one directory called 'UCI HAR Dataset', which has all the data needed.
1. The files for the training set ('X training.txt') an test set ('X test.txt') will be loaded into the R enviroment and merged into just one data set ("data.set"). Other files will be also loaded in order to create two aditional variables with the subject index number ('subject train.txt' and 'subject test.txt') and the activity code ('y train.txt' and 'y test txt'). In addition, two other files will be loaded ('features.txt' and 'activity_labels.txt') with the labels for the measurement variables and the activities, that will be used later. 
1. The variables (columns) in "data.set" will be renamed (using the information in the file 'features.txt'), so they are easily identified.
1. Only the measurement variables on means and standard deviations (identified as 'means()' and 'std()') in "data.set" will be keeped, being removed the remainders. 
1.Levels of the factor variable "activity" will be also renamed with a proper description for each one (file 'activity_labels.txt').
1. Finally, a second dataset ("data.set2") will be created,including just the average value for each variable (measurements), for each subject and each activity. A text file will be created with this second data set ("data_set2.txt").

### Inputs
The files included in the original dataset that will be used by the script "run_analysis.R" are the following:

* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

### Output
The outputs of the code are 2 data frames: 

* data.set (10.299x68): the first tidy data set created. the first and second column are two factor variables representing the subject and the activity, respectively. the following 66 columns are measurent variables from the list included in 'var.names', but extracting only those on the mean (name ended with 'mean()') and standard deviation (ended with 'std()').          
* data.set2 (180x68): This second data set includes the average value for each measurement for each subject and for each activitity. As with 'data.set', the first two columns are factor variables representig the subjects and the activity, and the following 66 columns, the average for each subject and activity of each measurent included in 'data.set'. Given that we have 30 subjects and 6 activities, the total number of rows is 30x6=180.

A brief description of each variable is shown in the Code Book.

### Notes
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
