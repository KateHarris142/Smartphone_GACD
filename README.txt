############ README ##################

############ Notes when running the code: ###########
The data can either be downloaded if needed (default setting). However if already downloaded and available on a local disk, comment out lines 5-7, to make the running of the program quicker and not waste space on your hard drive.

The code also sets the working directory from the directory you runs this code in to the directory containing the data. If this is done manually, please comment out line 10.

############## Data gathering strategy: ##############
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. "
(Details have been taken from the README.txt file available with the raw data download inside "UCI HAR Dataset". Please see this document for further details.)

The signals were split (using a noise filter) into signals from the body and signals due to gravity. Those due to gravity are identified with "gravity" in the variable name. The rest of signals due to the motion of the subject. 


The time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz.
The frequency domain signals ( prefix 'f' to indicate frequency) are found by applying a Fast Fourier Transform (FFT) to the time domain signals.


############## Tidying/coding strategy: ##################
The data sets are loaded and the data checked for missing values.
The training and test sets have been put together to create one table containing all the variables, and all of the subjects measurements for each activity.
Once combined, the variables were labeled.
Then only the column containing data on either the mean or standard deviation are selected.
Then the data is split into subject id, then activity, and the means for each variable calculated. 
This data is then put back into a data frame.
In the activity variable the numbers realting to activity are converted into the descriptive name for the activity (i.e. 1 -> WALKING)
The variables names are then edited to make more descriptive.
The final table is written out in a .txt file and can be found in the same directory as the "run_analysis.R" code is run.

Full descriptions of all of the columnas can be found in the cookbook.
