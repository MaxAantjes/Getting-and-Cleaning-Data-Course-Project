## Set up temporary directory for zip file.
td = tempdir()
temp = tempfile(tmpdir=td, fileext=".zip")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
names <- as.vector(unzip(temp, list=TRUE)$Name)
## Use print(names) for a list of file names.
print(names)
## Read particular file and import data into R.
unzip(temp, files= names[7], exdir=td, overwrite=TRUE)
fpath = file.path(td, names[7])
read.csv(fpath)
## Remove temporary file.
unlink(temp)
