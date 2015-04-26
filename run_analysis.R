#########################
# This code takes in the trianing and test dataset and for the variables conatining data 
# on the mean or standard deviation, finds the average of those variables for of the 
# acitivties for each subject 
#########################

# The data is downloaded and unziped.
# If you require the data from the site use the below lines, changing the destfile path as needed. 
# If you alreadty have the data on a local disk, comment out the following 3 lines and skip to line 15 and change file name as needed.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="smartphone",method="curl")
unzip("smartphone")

# sets the directory to work in which contains the data
setwd("UCI Har Dataset")

#load in the training files, data, labels and subject
trainX <- read.table("./train/X_train.txt",header=FALSE)
train_labs <- read.table("./train/y_train.txt",header=FALSE)
train_sub <- read.table("./train/subject_train.txt",header=FALSE)

#load in the test files, data, labels and subject
testX <- read.table("./test/X_test.txt",header=FALSE)
test_labs <- read.table("./test/y_test.txt",header=FALSE)
test_sub <- read.table("./test/subject_test.txt",header=FALSE)

# Combine into loaded files into single data.frames, one for the test set, 
# and one for the training set
train <- as.data.frame(cbind(train_labs,train_sub,trainX))
test <- as.data.frame(cbind(test_labs,test_sub,testX))

dat <- rbind(train,test)

# Upload and edit\tidy the column names
featuresFile <- as.vector(read.table("features.txt",header=FALSE))
features <- tolower(as.character(featuresFile[,2]))

# Add column names to each data.frame
headings <- c("activity","subject",features)
colnames(dat) <- headings

# Selects the columns which only have mean or std in the heading name
meanStdCol <- c(grep("mean",headings),grep("std",headings))
dat <- dat[,c(1,2,meanStdCol)]

# The following section loops through the number of subjects and for each subject, through 
# the activity (still decribed by a numebr at this point), and finds the means of each 
# variable for eachactivity and for subject.
# The vaiables are then put into a data frame and the loop repeats, binding the next row 
# onto the data frame until all subjects have been added.
newTab <- matrix(1,75)
newTab2 <- data.frame()

for(i in 1:30){
     ind <- which(dat[,2] == i) 
     dat2 <- dat[min(ind):max(ind),]
     for(j in 1:6){
         ind2 <- which(dat2[,1] == j)
         dat3 <- dat2[c(ind2),]
         newTab <- as.vector(apply(dat3,2,mean))
         newTab2 <- rbind(newTab2,newTab)
      }
      
}
newTab2 <- as.data.frame(newTab2)
cnames <- colnames(dat)

# Add more detailed descriptive column names, further details for the meanign of the 
# variables can be found in the codebook
cnames <- gsub("-","",cnames)
cnames <- gsub("\\(","",cnames)
cnames <- gsub("\\)","",cnames)
cnames <- gsub(",","",cnames)
cnames <- sub("^t","time",cnames)
cnames <- sub("^f","freq",cnames)
cnames <- sub("bodybody","body",cnames)
cnames <- sub("anglexgravitymean","anglegravitymeanx",cnames)
cnames <- sub("angleygravitymean","anglegravitymeany",cnames)
cnames <- sub("anglezgravitymean","anglegravitymeanz",cnames)
cnames <- sub("anglet","angletime",cnames)

colnames(newTab2) <- c(cnames)

# Convert the numbers in the activity row to the descriptive activity
activity <- as.data.frame(read.table("./activity_labels.txt",header=FALSE))
colnames(activity) <- c("number","action")
numb_dat <- as.numeric(newTab2[,1])
newTab2$activity <- activity$action[numb_dat]

# Finally the table is written out in the format required
write.table(newTab2,file="../tidyData_ActivitySmartPhone.txt",row.name=FALSE,append=FALSE, sep=" ")
