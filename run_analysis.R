## Set up temporary directory and download zip file.
td = tempdir()
temp = tempfile(tmpdir=td, fileext=".zip")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
names <- as.vector(unzip(temp, list=TRUE)$Name)

## Use print(names) for a list of file names.
print(names)

## Read files and import data into R.
unzip(temp, exdir=td, overwrite=TRUE)
feat <- read.table(file.path(
        td, names[2]), col.names = c("", "features"))
act <- read.table(file.path(
        td, names[1]), col.names = c("", "activities"))
test_sub <- read.table(file.path(
        td, names[16]), col.names = "subjectID")
test_x <- read.table(file.path(
        td, names[17]), col.names = feat[[2]])
test_y <- read.table(file.path(
        td, names[18]), col.names = "label")
train_sub <- read.table(file.path(
        td, names[30]), col.names = "subjectID")
train_x <- read.table(file.path(
        td, names[31]), col.names = feat[[2]])
train_y <- read.table(file.path(
        td, names[32]), col.names = "label") 

## Delete temporary folder.
unlink(temp)

## Merge training and test sets to create 1 data set. 
combined_x <- rbind(train_x, test_x)
combined_y <- rbind(train_y, test_y)
subjectID <- rbind(test_sub, train_sub)
data <- cbind(subjectID, combined_y, combined_x)

## Extract the measurements on the mean and standard deviation and
## the label and IDnumber. 
feat_low <- tolower(feat[[2]]) ## set to lower case for grep function.
mean <- grep("mean", feat_low)+2 ## find columns in data with mean.
std <- grep("std", feat_low)+2 ## find columns in data with std.
columns <- order(c(1, 2, c(mean), c(std))) ## List of columns we want
data_mean_std <- data[, columns]

## label the activities in the data set.
library(dplyr)
data_mean_std <- mutate(data_mean_std, label =
               factor(data_mean_std[[2]], labels = act[[2]]))

## Apropriately label the data set with descriptive variable names.






