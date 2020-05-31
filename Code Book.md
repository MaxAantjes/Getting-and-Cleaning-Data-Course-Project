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
##  [1] "subject.id"                                                
##  [2] "activity"                                                  
##  [3] "time.body.accelerometer.mean.x"                            
##  [4] "time.body.accelerometer.mean.y"                            
##  [5] "time.body.accelerometer.mean.z"                            
##  [6] "time.body.accelerometer.std.x"                             
##  [7] "time.body.accelerometer.std.y"                             
##  [8] "time.body.accelerometer.std.z"                             
##  [9] "time.gravity.accelerometer.mean.x"                         
## [10] "time.gravity.accelerometer.mean.y"                         
## [11] "time.gravity.accelerometer.mean.z"                         
## [12] "time.gravity.accelerometer.std.x"                          
## [13] "time.gravity.accelerometer.std.y"                          
## [14] "time.gravity.accelerometer.std.z"                          
## [15] "time.body.accelerometer.jerk.mean.x"                       
## [16] "time.body.accelerometer.jerk.mean.y"                       
## [17] "time.body.accelerometer.jerk.mean.z"                       
## [18] "time.body.accelerometer.jerk.std.x"                        
## [19] "time.body.accelerometer.jerk.std.y"                        
## [20] "time.body.accelerometer.jerk.std.z"                        
## [21] "time.body.gyroscope.mean.x"                                
## [22] "time.body.gyroscope.mean.y"                                
## [23] "time.body.gyroscope.mean.z"                                
## [24] "time.body.gyroscope.std.x"                                 
## [25] "time.body.gyroscope.std.y"                                 
## [26] "time.body.gyroscope.std.z"                                 
## [27] "time.body.gyroscope.jerk.mean.x"                           
## [28] "time.body.gyroscope.jerk.mean.y"                           
## [29] "time.body.gyroscope.jerk.mean.z"                           
## [30] "time.body.gyroscope.jerk.std.x"                            
## [31] "time.body.gyroscope.jerk.std.y"                            
## [32] "time.body.gyroscope.jerk.std.z"                            
## [33] "time.body.accelerometer.magnitude.mean"                    
## [34] "time.body.accelerometer.magnitude.std"                     
## [35] "time.gravity.accelerometer.magnitude.mean"                 
## [36] "time.gravity.accelerometer.magnitude.std"                  
## [37] "time.body.accelerometer.jerk.magnitude.mean"               
## [38] "time.body.accelerometer.jerk.magnitude.std"                
## [39] "time.body.gyroscope.magnitude.mean"                        
## [40] "time.body.gyroscope.magnitude.std"                         
## [41] "time.body.gyroscope.jerk.magnitude.mean"                   
## [42] "time.body.gyroscope.jerk.magnitude.std"                    
## [43] "frequency.body.accelerometer.mean.x"                       
## [44] "frequency.body.accelerometer.mean.y"                       
## [45] "frequency.body.accelerometer.mean.z"                       
## [46] "frequency.body.accelerometer.std.x"                        
## [47] "frequency.body.accelerometer.std.y"                        
## [48] "frequency.body.accelerometer.std.z"                        
## [49] "frequency.body.accelerometer.mean.frequency.x"             
## [50] "frequency.body.accelerometer.mean.frequency.y"             
## [51] "frequency.body.accelerometer.mean.frequency.z"             
## [52] "frequency.body.accelerometer.jerk.mean.x"                  
## [53] "frequency.body.accelerometer.jerk.mean.y"                  
## [54] "frequency.body.accelerometer.jerk.mean.z"                  
## [55] "frequency.body.accelerometer.jerk.std.x"                   
## [56] "frequency.body.accelerometer.jerk.std.y"                   
## [57] "frequency.body.accelerometer.jerk.std.z"                   
## [58] "frequency.body.accelerometer.jerk.mean.frequency.x"        
## [59] "frequency.body.accelerometer.jerk.mean.frequency.y"        
## [60] "frequency.body.accelerometer.jerk.mean.frequency.z"        
## [61] "frequency.body.gyroscope.mean.x"                           
## [62] "frequency.body.gyroscope.mean.y"                           
## [63] "frequency.body.gyroscope.mean.z"                           
## [64] "frequency.body.gyroscope.std.x"                            
## [65] "frequency.body.gyroscope.std.y"                            
## [66] "frequency.body.gyroscope.std.z"                            
## [67] "frequency.body.gyroscope.mean.frequency.x"                 
## [68] "frequency.body.gyroscope.mean.frequency.y"                 
## [69] "frequency.body.gyroscope.mean.frequency.z"                 
## [70] "frequency.body.accelerometer.magnitude.mean"               
## [71] "frequency.body.accelerometer.magnitude.std"                
## [72] "frequency.body.accelerometer.magnitude.mean.frequency"     
## [73] "frequency.body.accelerometer.jerk.magnitude.mean"          
## [74] "frequency.body.accelerometer.jerk.magnitude.std"           
## [75] "frequency.body.accelerometer.jerk.magnitude.mean.frequency"
## [76] "frequency.body.gyroscope.magnitude.mean"                   
## [77] "frequency.body.gyroscope.magnitude.std"                    
## [78] "frequency.body.gyroscope.magnitude.mean.frequency"         
## [79] "frequency.body.gyroscope.jerk.magnitude.mean"              
## [80] "frequency.body.gyroscope.jerk.magnitude.std"               
## [81] "frequency.body.gyroscope.jerk.magnitude.mean.frequency"    
## [82] "angle.time.body.accelerometer.mean.gravity"                
## [83] "angle.time.body.accelerometer.jerk.mean.gravity.mean"      
## [84] "angle.time.body.gyroscope.mean.gravity.mean"               
## [85] "angle.time.body.gyroscope.jerk.mean.gravity.mean"          
## [86] "angle.x.gravity.mean"                                      
## [87] "angle.y.gravity.mean"                                      
## [88] "angle.z.gravity.mean"

```

## Raw Data

The raw data is available in a zip file which can be retrieved [through this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) (download starts immediately). The analysis is based on the 8 text files listed below. The first file contains the activity labels corresponding to the Y_test files; the second contains the variable names corresponding to the X_test files; the third and sixth contain the subject IDs of the participants; the fourth and seventh contain the measurements for each participant during testing and training respectively; the fifth and eigth contain the activity numbers during testing and training respectively. 

```{r Text Files containing Raw Data}
## [1] "UCI HAR Dataset/activity_labels.txt"    
## [2] "UCI HAR Dataset/features.txt"           
## [3] "UCI HAR Dataset/test/subject_test.txt"  
## [4] "UCI HAR Dataset/test/X_test.txt"        
## [5] "UCI HAR Dataset/test/y_test.txt"        
## [6] "UCI HAR Dataset/train/subject_train.txt"
## [7] "UCI HAR Dataset/train/X_train.txt"      
## [8] "UCI HAR Dataset/train/y_train.txt"
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


