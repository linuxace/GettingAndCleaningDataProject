###run_analysis.R Operation
---
This script takes in the following files:

UCI HAR Dataset/features.txt
UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt
UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/y_test.txt

The feature.txt file is used to find all values that have mean() or std() in the name.  It then uses the found values to select the matching columns from the X_train.txt and X_test.txt files.  It also uses the values to build better column names and assigns those column names to the output dataset.  Next the script merges subjects, activities and data together from both the train and test dataset and files into one large dataset.  Finally, the script groups all data by subject and activity and summarizes the data by average.

---
###Running the Script
---
In order to run this script, you must make sure that the unzipped original smartphone data set folder is in the same directory on the same level as the run_analysis.R script.

ex.

..
run_analysis.R
UCI HAR Dataset

To run the script, make sure R's working directory is set to the same directory containing the script and data set folder.  You can set R's working directory to the correct directory using setwd().

ex.

setwd("C:\\Users\\test\\Documents")
setwd("/home/test/Documents")

Once everything is prepared simply run the following command using the R console.

source("run_analysis.R")

Enjoy!
