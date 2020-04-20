#### Program: Data Science by HarvardX
#### Course 6: Wrangling


### Assessments on edX
### Section 1: Data Import (Part 1)

## Question 1: Which of the following is NOT part of the data wrangling process?
# (a) Importing data into R; (b) Formatting dates/times; (c) Checking correlations between your variables; (d) Tidying data
# Answer: (c) Data analyses, such as checking correlations or creating visualizations, are done AFTER the data has been processed into a tidy format.

## Question 2: Which files could be opened in a basic text editor? Select ALL that apply.
# (a) data.txt; (b) data.csv; (c) data.xlsx; (d) data.tsv
# Answer: (a), (b), and (c) because Microsoft Excel files (.xls) cannot be read with any basic text editor

## Question 3: You want to analyze a file containing race finish times for a recent marathon.
## Question 3: You open the file in a basic text editor and see lines that look like the following:
# initials,state,age,time
# vib,MA,61,6:01
# adc,TX,45,5:45
# kme,CT,50,4:19
# (a) A comma-delimited file without a header; (b) A tab-delimited file with a header
# (c) A white space-delimited file without a header; (d) A comma-delimited file with a header
# Answer: (d) This file has a header that describes the contents of each column. Values are separated by commas.

## Question 4: Assume the following is the full path to the directory that a student wants to use as their working directory in R:
## Question 4: "/Users/student/Documents/projects/"
## Question 4: Which of the following lines of code CANNOT set the working directory to the desired "projects" directory?
# (a) setwd("~/Documents/projects/"); (b) setwd("/Users/student/Documents/projects/")
# (c) setwd(/Users/student/Documents/projects/); (d)dir <- "/Users/student/Documents/projects" setwd(dir)
# Answer: (c) This code will not work. You need to use quotation marks when providing a full path to the working directory.

## Question 5: We want to copy the "murders.csv" file from the dslabs package into an existing folder "data",
## Question 5: which is located in our HarvardX-Wrangling projects folder. We first enter the code below into our RStudio console.
# getwd() > "C:/Users/UNIVERSITY/Documents/Analyses/HarvardX-Wrangling"
# filename <- "murders.csv"
# path <- system.file("extdata", package = "dslabs")
## Question 5: Which of the following commands would NOT successfully copy “murders.csv” into the folder “data”?
# (a) file.copy(file.path(path, "murders.csv"), getwd())
# (b) setwd("data") > file.copy(file.path(path, filename), getwd()) 
# (c) file.copy(file.path(path, "murders.csv"), file.path(getwd(), "data"))
# (d1) file.location <- file.path(system.file("extdata", package = "dslabs"), "murders.csv")
# (d2) file.destination <- file.path(getwd(), "data")
# (d3) file.copy(file.location, file.destination) 
# Answer: (a) This command does NOT copy the “murders.csv” file into your “data” folder; instead it copies it into the parent directory, “HarvardX-Wrangling”.
# Answer: (a) You need to specify the “data” folder, either by changing the working directory or by adding it to the file path.

## Question 6: You are not sure whether the murders.csv file has a header row. How could you check this?
## Question 6: Select ALL that apply.
# (a) Open the file in a basic text editor.
# (b) In the RStudio “Files” pane, click on your file, then select “View File”.
# (c) Use the command read_lines (remembering to specify the number of rows with the n_max argument).
# Answer: (a) and (c)

## Question 7: What is one difference between read_excel() and read_xlsx()?
# (a) read_excel() also reads meta-data from the excel file, such as sheet names, while read_xlsx() only reads the first sheet in a file.
# (b) read_excel() reads both .xls and .xlsx files by detecting the file format from its extension, while read_xlsx() only reads .xlsx files.
# (c) read_excel() is part of the readr package, while read_xlsx() is part of the readxl package and has more options.
# (d) read_xlsx() has been replaced by read_excel() in a recent readxl package update.
# Answer: (b) You can use read_excel for both .xls and .xlsx files, while read_xlsx only reads .xlsx files.

## Question 8: You have a file called “times.txt” that contains race finish times for a marathon. The first four lines of the file look like this:
# initials,state,age,time
# vib,MA,61,6:01
# adc,TX,45,5:45
# kme,CT,50,4:19
## Question 8: Which line of code will NOT produce a tibble with column names “initials”, “state”, “age”, and “time”?
# (a) race_times <- read_csv("times.txt")
# (b) race_times <- read.csv("times.txt")
# (c) race_times <- read_csv("times.txt", col_names = TRUE)
# (d) race_times <- read_delim("times.txt", delim = “,”)
# Answer: (b) This code will import the comma-separated values table called “times.txt”,
# Answer: (b) but the base R function read.csv does not produce a tibble. It creates a data frame.

## Question 9: You also have access to marathon finish times in the form of an Excel document named “times.xlsx”.
## Question 9: In the Excel document, different sheets contain race information for different years.
## Question 9: The first sheet is named “2015”, the second is named “2016”, and the third is named “2017”.
## Question 9: Which line of code will NOT import the data contained in the “2016” tab of this Excel sheet?
# (a) times_2016 <- read_excel("times.xlsx", sheet = 2)
# (b) times_2016 <- read_xlsx("times.xlsx", sheet = “2”)
# (c) times_2016 <- read_excel("times.xlsx", sheet = "2016")
# (d) times_2016 <- read_xlsx("times.xlsx", sheet = 2)
# Answer: (b) When the sheet argument is contained within quotes, the function expects a sheet name.
# Answer: (b) There is no sheet named “2” in this spreadsheet, so the code will not work.

## Question 10: You have a comma-separated values file that contains the initials, home states, ages, and race finish times for marathon runners.
## Question 10: The runners’ initials contain three characters for the runners’ first, middle, and last names (for example, “KME”).
## Question 10:You read in the file using the following code.
# race_times <- read.csv(“times.csv”)
## Question 10: What is the data type of the initials in the object race_times?
# (a) integers; (b) characters; (c) factors; (d)logical
# Answer: (c) If you don’t supply the argument stringsAsFactors = F, the read.csv function will automatically convert characters to factors.

## Question 11: Which of the following is NOT a real difference between the readr import functions and the base R import functions?
# (a) The import functions in the readr package all start as read_, while the import functions for base R all start with read.
# (b) Base R import functions automatically convert character columns to factors.
# (c) The base R import functions can read .csv files, but cannot read files with other delimiters, such as .tsv files, or fixed-width files.
# (d) Base R functions import data as a data frame, while readr functions import data as a tibble.
# Answer: (c) This statement is false. The base R import functions can read files with other
# Answer: (c) delimiters like .tsv using read.delim and can read fixed-width files using read.fwf.

## Question 12: You read in a file containing runner information and marathon finish times using the following code.
# race_times <- read.csv(“times.csv”, stringsAsFactors = F)
## Question 12: What is the class of the object race_times?
# (a) data frame; (b) tibble; (c) matrix; (d) vector
# Answer: (a) The read.csv function generates a data frame containing these data.

## Question 13: Select the answer choice that summarizes all of the actions that the following lines of code can perform.
## Question 13: Please note that the url below is an example and does not lead to data.
# url <- "https://raw.githubusercontent.com/MyUserName/MyProject/master/MyData.csv "
# dat <- read_csv(url)
# download.file(url, "MyData.csv")
# (a) Create a tibble in R called dat that contains the information contained in the csv file stored on Github and save that tibble to the working directory.
# (b1) Create a matrix in R called dat that contains the information contained in the csv file stored on Github.
# (b2) Download the csv file to the working directory and name the downloaded file “MyData.csv”.
# (c1) Create a tibble in R called dat that contains the information contained in the csv file stored on Github.
# (c2) Download the csv file to the working directory and randomly assign it a temporary name that is very likely to be unique.
# (d1) Create a tibble in R called dat that contains the information contained in the csv file stored on Github.
# (d2) Download the csv file to the working directory and name the downloaded file “MyData.csv”.
# Answer: (d) The read_csv command creates the tibble in R and the download.file command
# Answer: (d) downloads the csv file from the internet to the working directory with the specified name.


### Section 1: Data Import (Part 2)
### Use the readr package in the tidyverse library: library(tidyverse)

## Question 14: Inspect the file at the following URL:
# http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data
## Question 14: Which readr function should be used to import this file?
# (a) read_table(); (b)read_csv(); (c) read_csv2(); (d) read_tsv(); (e) None of the above
# Answer: (b) this is a comma-separated value file.

## Question 15: Check the documentation for the readr function you chose in the previous question to learn about its arguments.
## Question 15: Determine which arguments you need to the file from the previous question:
# url <- "http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"
## Question 15: Does this file have a header row? Does the readr function you chose need any additional arguments to import the data correctly?
# (a) Yes, there is a header. No arguments are needed.
# (b) Yes, there is a header. The header=TRUE argument is necessary.
# (c) Yes, there is a header. The col_names=TRUE argument is necessary.
# (d) No, there is no header. No arguments are needed.
# (e) No, there is no header. The header=FALSE argument is necessary.
# (f) No, there is no header. The col_names=FALSE argument is necessary.
# Answer: (f) There are no variable names in the first row, and the correct argument to skip the header in readr is col_names=FALSE.

## Question 16: Inspect the imported data from the previous question.
# How many rows are in the dataset?
# Answer: 569
# How many columns are in the dataset?
# Answer: 32


### Assessments on edX
### Section 2: Tidy Data

## Question 1: 












