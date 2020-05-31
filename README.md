# Getting-and-Cleaning-Data-Course-Project
This project is my contribution to the Getting and Cleaning Data Course Project of the John Hopkins Data University Science Specialization. The code for generating a tidy data set can be found in the run.analysis.R file. Details on the raw data, variables and data summary choices can be found in the Code Book.md file.  

# Explanation of run.analysis.R
The code will perform the following tasks in order:
* *set up temporary directory*: A temporary directory is set up in the working directory; the raw files are downloaded and stored in the temporary directory; dplyr is loaded (this package is required for the subsequent analysis).  
* *import data into R*: 8 text files containing are imported as tables into R. The files are imported through subsetting the names list of files in the temporary directory. For actual names of the raw files, see the Code Book.dm file. 
* *Delete the temporary folder*: The temporary folder is deleted. 
* *Merging of tables*: the rows of training and test tables (6 files total) are merged using the rbind command. The resulting three merged tables are merged into a new table using the cbind command. 
* *Selection of Variables of Interest*: the collumns containing mean and standard deviation information are identified using the grep function on the variable list (accessible through the names function). Those columns in addition to participant id and label (later activity) are then subsetted. 
* *Labeling* label is transformed into a factor variable with its 6 integer values being bound to character strings. 
* *Tidying Names* Names are tidied through a loop gsub function called change_name. All variable names are changed to lower case and any spaces are replaced with periods to simplify the process of calling and reading variables.
* *Generate Narrow Data Set* A narrow data set is created using the group_by and summarise_if functions. This data set reflects the mean of the continuous variables for each activity per participant. The data set is saved as a .txt file in the working directory. 

# Acknowledgements
Zip file extraction based on: https://hydroecology.net/downloading-extracting-and-reading-files-in-r/  
Raw data is taken from the following publication: *Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).*
