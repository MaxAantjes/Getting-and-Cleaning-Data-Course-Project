---
title: "Code Book"
author: "Max Aantjes"
date: "30/05/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Source and Experimental Study Design

The data used in this data set was collected by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto from the Università degli Studi di Genova. The study involved 30 volunteers performing 6 different activities whilst wearing smartphones on their waists. The researchers measured linear acceleration and angular velicity throug the use of embedded acceleremoters and gyroscopes.  Detailed information can be found in their publication below:

*Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).*

## Variables

A list of variables can be found below. The first variable **(subject.id)** is a factor variable whith identification numbers for each of the 30 participants. The second variable **(activity)** is a factor variable containing the 6 different activities performed **(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)**. All other variables are continuous variables reflecting either means or standard deviations of different measures of acceleration or velocity in directions X, Y and Z (further details can be found in their respective names).

```{r Variable Names, echo = FALSE, message = FALSE}
td = tempdir()
temp = tempfile(tmpdir=td, fileext=".zip")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
names <- as.vector(unzip(temp, list=TRUE)$Name)
library(dplyr)

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
feat_low <- tolower(names(data)) ## set to lower case for grep function.
mean <- grep("mean", feat_low) ## find columns in data with mean.
std <- grep("std", feat_low) ## find columns in data with std.
columns <- sort(c(1, 2, c(mean, std))) ## List of columns we want
data_mean_std <- data[, columns]

## label the activities in the data set.
data_mean_std <- mutate(data_mean_std, label =
               factor(data_mean_std[[2]], labels = act[[2]]))

## Inspect features in notepad ++ to check for abbreviations
## Create function to change variable names in bulk.
change_name <- function(x, original, new) {
        for(i in 1:length(original)) {
        x <- gsub(original[i], new[i], x)
        }
        return(x)
}

## Apropriately label the data set with descriptive variable names.
original <- c("label", "Gyro", "^t", "^f", "Mag", "Acc", 
        "\\.mean\\.*", "\\.std\\.*", "Freq\\.*", "Jerk", 
        "angle\\.", "tBody", "BodyBody", "Mean\\.", ".gravity",
        "meangravity", "X", "Y", "Z", "\\.", "subjectID")
new <- c("activity", " gyroscope ", "time ", "frequency ",
        "magnitude ", " accelerometer ", "mean ", "std ",
        "frequency ", "jerk ", "angle ", "time body", "body", 
        "mean ", "gravity ", "mean gravity", "X ", "Y ", "Z ", "",
        "subject id")
names(data_mean_std) <- tolower(trimws(change_name(names(data_mean_std), 
                        original, new)))
names(data_mean_std) <- gsub(" ", ".", names(data_mean_std))
print(names(data_mean_std))
```

## Raw Data

The raw data is available in a zip file which can be retrieved [through this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) (download starts immediately). The analysis is based on the 8 text files listed below. The first file contains the activity labels corresponding to the Y_test files; the second contains the variable names corresponding to the X_test files; the third and sixth contain the subject IDs of the participants; the fourth and seventh contain the measurements for each participant during testing and training respectively; the fifth and eigth contain the activity numbers during testing and training respectively. 

```{r Text Files containing Raw Data, echo=FALSE}
print(names[c(1, 2, 16, 17, 18, 30, 31, 32)])
```


## Summary Choices

First, the measurements taken during the tests and training were merged.Next, the variables measuring means and standard deviations where extracted. The subject ID and activity variable were then converted into factor variables. Furthermore, the variable names were tidied by running a vector of 'original' and 'new' (replacement) character strings through the following gsub loop function:

```{r, Name_Change Function}
change_name <- function(x, original, new) {
        for(i in 1:length(original)) {
        x <- gsub(original[i], new[i], x)
        }
        return(x)
}
```

Finally, the group_by and summarise_if function were used to generate a narrow data set, which reflects the mean values of the continuous variables for a given action per participant. The data was stacked in this way to preserve readibility, as the prior data set already had 88 variables. The full code used, including comments can be found in the run_analysis.R file. 


