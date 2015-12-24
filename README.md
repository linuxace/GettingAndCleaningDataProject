###Running the Script
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
