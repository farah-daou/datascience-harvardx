#### Program: Data Science by HarvardX
#### Course 6: Wrangling


### Assessments on edX
### Section 1: Data Import (Part 1)

## Q1: Which of the following is NOT part of the data wrangling process?
# (a) Importing data into R; (b) Formatting dates/times; (c) Checking correlations between your variables; (d) Tidying data
# Answer: (c) Data analyses, such as checking correlations or creating visualizations, are done AFTER the data has been processed into a tidy format.

## Q2: Which files could be opened in a basic text editor? Select ALL that apply.
# (a) data.txt; (b) data.csv; (c) data.xlsx; (d) data.tsv
# Answer: (a), (b), and (c) because Microsoft Excel files (.xls) cannot be read with any basic text editor

## Q3: You want to analyze a file containing race finish times for a recent marathon.
## Q3: You open the file in a basic text editor and see lines that look like the following:
# initials,state,age,time
# vib,MA,61,6:01
# adc,TX,45,5:45
# kme,CT,50,4:19
# (a) A comma-delimited file without a header; (b) A tab-delimited file with a header
# (c) A white space-delimited file without a header; (d) A comma-delimited file with a header
# Answer: (d) This file has a header that describes the contents of each column. Values are separated by commas.

## Q4: Assume the following is the full path to the directory that a student wants to use as their working directory in R:
## Q4: "/Users/student/Documents/projects/"
## Q4: Which of the following lines of code CANNOT set the working directory to the desired "projects" directory?
# (a) setwd("~/Documents/projects/"); (b) setwd("/Users/student/Documents/projects/")
# (c) setwd(/Users/student/Documents/projects/); (d)dir <- "/Users/student/Documents/projects" setwd(dir)
# Answer: (c) This code will not work. You need to use quotation marks when providing a full path to the working directory.

## Q5: We want to copy the "murders.csv" file from the dslabs package into an existing folder "data",
## Q5: which is located in our HarvardX-Wrangling projects folder. We first enter the code below into our RStudio console.
# getwd() > "C:/Users/UNIVERSITY/Documents/Analyses/HarvardX-Wrangling"
# filename <- "murders.csv"
# path <- system.file("extdata", package = "dslabs")
## Q5: Which of the following commands would NOT successfully copy “murders.csv” into the folder “data”?
# (a) file.copy(file.path(path, "murders.csv"), getwd())
# (b) setwd("data") > file.copy(file.path(path, filename), getwd()) 
# (c) file.copy(file.path(path, "murders.csv"), file.path(getwd(), "data"))
# (d1) file.location <- file.path(system.file("extdata", package = "dslabs"), "murders.csv")
# (d2) file.destination <- file.path(getwd(), "data")
# (d3) file.copy(file.location, file.destination) 
# Answer: (a) This command does NOT copy the “murders.csv” file into your “data” folder; instead it copies it into the parent directory, “HarvardX-Wrangling”.
# Answer: (a) You need to specify the “data” folder, either by changing the working directory or by adding it to the file path.

## Q6: You are not sure whether the murders.csv file has a header row. How could you check this?
## Q6: Select ALL that apply.
# (a) Open the file in a basic text editor.
# (b) In the RStudio “Files” pane, click on your file, then select “View File”.
# (c) Use the command read_lines (remembering to specify the number of rows with the n_max argument).
# Answer: (a) and (c)

## Q7: What is one difference between read_excel() and read_xlsx()?
# (a) read_excel() also reads meta-data from the excel file, such as sheet names, while read_xlsx() only reads the first sheet in a file.
# (b) read_excel() reads both .xls and .xlsx files by detecting the file format from its extension, while read_xlsx() only reads .xlsx files.
# (c) read_excel() is part of the readr package, while read_xlsx() is part of the readxl package and has more options.
# (d) read_xlsx() has been replaced by read_excel() in a recent readxl package update.
# Answer: (b) You can use read_excel for both .xls and .xlsx files, while read_xlsx only reads .xlsx files.

## Q8: You have a file called “times.txt” that contains race finish times for a marathon. The first four lines of the file look like this:
# initials,state,age,time
# vib,MA,61,6:01
# adc,TX,45,5:45
# kme,CT,50,4:19
## Q8: Which line of code will NOT produce a tibble with column names “initials”, “state”, “age”, and “time”?
# (a) race_times <- read_csv("times.txt")
# (b) race_times <- read.csv("times.txt")
# (c) race_times <- read_csv("times.txt", col_names = TRUE)
# (d) race_times <- read_delim("times.txt", delim = “,”)
# Answer: (b) This code will import the comma-separated values table called “times.txt”,
# Answer: (b) but the base R function read.csv does not produce a tibble. It creates a data frame.

## Q9: You also have access to marathon finish times in the form of an Excel document named “times.xlsx”.
## Q9: In the Excel document, different sheets contain race information for different years.
## Q9: The first sheet is named “2015”, the second is named “2016”, and the third is named “2017”.
## Q9: Which line of code will NOT import the data contained in the “2016” tab of this Excel sheet?
# (a) times_2016 <- read_excel("times.xlsx", sheet = 2)
# (b) times_2016 <- read_xlsx("times.xlsx", sheet = “2”)
# (c) times_2016 <- read_excel("times.xlsx", sheet = "2016")
# (d) times_2016 <- read_xlsx("times.xlsx", sheet = 2)
# Answer: (b) When the sheet argument is contained within quotes, the function expects a sheet name.
# Answer: (b) There is no sheet named “2” in this spreadsheet, so the code will not work.

## Q10: You have a comma-separated values file that contains the initials, home states, ages, and race finish times for marathon runners.
## Q10: The runners’ initials contain three characters for the runners’ first, middle, and last names (for example, “KME”).
## Q10:You read in the file using the following code.
# race_times <- read.csv(“times.csv”)
## Q10: What is the data type of the initials in the object race_times?
# (a) integers; (b) characters; (c) factors; (d)logical
# Answer: (c) If you don’t supply the argument stringsAsFactors = F, the read.csv function will automatically convert characters to factors.

## Q11: Which of the following is NOT a real difference between the readr import functions and the base R import functions?
# (a) The import functions in the readr package all start as read_, while the import functions for base R all start with read.
# (b) Base R import functions automatically convert character columns to factors.
# (c) The base R import functions can read .csv files, but cannot read files with other delimiters, such as .tsv files, or fixed-width files.
# (d) Base R functions import data as a data frame, while readr functions import data as a tibble.
# Answer: (c) This statement is false. The base R import functions can read files with other
# Answer: (c) delimiters like .tsv using read.delim and can read fixed-width files using read.fwf.

## Q12: You read in a file containing runner information and marathon finish times using the following code.
# race_times <- read.csv(“times.csv”, stringsAsFactors = F)
## Q12: What is the class of the object race_times?
# (a) data frame; (b) tibble; (c) matrix; (d) vector
# Answer: (a) The read.csv function generates a data frame containing these data.

## Q13: Select the answer choice that summarizes all of the actions that the following lines of code can perform.
## Q13: Please note that the url below is an example and does not lead to data.
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

## Q14: Inspect the file at the following URL:
# http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data
## Q14: Which readr function should be used to import this file?
# (a) read_table(); (b)read_csv(); (c) read_csv2(); (d) read_tsv(); (e) None of the above
# Answer: (b) this is a comma-separated value file.

## Q15: Check the documentation for the readr function you chose in the previous question to learn about its arguments.
## Q15: Determine which arguments you need to the file from the previous question:
# url <- "http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"
## Question 15: Does this file have a header row? Does the readr function you chose need any additional arguments to import the data correctly?
# (a) Yes, there is a header. No arguments are needed.
# (b) Yes, there is a header. The header=TRUE argument is necessary.
# (c) Yes, there is a header. The col_names=TRUE argument is necessary.
# (d) No, there is no header. No arguments are needed.
# (e) No, there is no header. The header=FALSE argument is necessary.
# (f) No, there is no header. The col_names=FALSE argument is necessary.
# Answer: (f) There are no variable names in the first row, and the correct argument to skip the header in readr is col_names=FALSE.

## Q16: Inspect the imported data from the previous question.
# How many rows are in the dataset?
# Answer: 569
# How many columns are in the dataset?
# Answer: 32


### Assessments on edX
### Section 2: Tidy Data - Reshaping Data

## Q1: A collaborator sends you a file containing data for three years of average race finish times.
# age_group,2015,2016,2017
# 20,3:46,3:22,3:50
# 30,3:50,3:43,4:43
# 40,4:39,3:49,4:51
# 50,4:48,4:59,5:01
## Question 1: Are these data considered “tidy” in R? Why or why not?
# (a) Yes. These data are considered “tidy” because each row contains unique observations.
# (b) Yes. These data are considered “tidy” because there are no missing data in the data frame.
# (c) No. These data are not considered “tidy” because the variable “year” is stored in the header.
# (d) No. These data are not considered “tidy” because there are not an equal number of columns and rows.
# Answer: (c) The year is a variable and should be stored as a column instead of across multiple columns in the header.

## Q2: Below are four versions of the same dataset. Which one is in a tidy format?
# Answer: (a) and a piece of the dataset is listed below (listing all options will take a lot of space)
# state      abb region  population total
# Alabama     AL	South	4779736	  135
# Alaska      AK   West 	710231	  19

## Q3: Your file called “times.csv” has age groups and average race finish times for three years of marathons.
# age_group,2015,2016,2017
# 20,3:46,3:22,3:50
# 30,3:50,3:43,4:43
# 40,4:39,3:49,4:51
# 50,4:48,4:59,5:01
# You read in the data file using the following command.
# d <- read_csv("times.csv")
## Q3: Which commands will help you “tidy” the data?
# (a) tidy_data <- d %>% gather(year, time, `2015`:`2017`)
# (b) tidy_data <- d %>% spread(year, time, `2015`:`2017`)
# (c) tidy_data <- d %>% gather(age_group, year, time, `2015`:`2017`)
# (d) tidy_data <- d %>% gather(time, `2015`:`2017`)
# Answer: (a) This code will gather the years from 2015 to 2017 into a single column and
# Answer: (a) create a single column called “time” that contains the time for each age group and each year.

## Q4: You have a dataset on U.S. contagious diseases, but it is in the following wide format:
# head(dat_wide) (NOT all observations are listed below)
# state year population HepatitisA Mumps Polio Rubella
# Alabama 1990    4040587      86	   19    76    1
# Alabama 1991    4066003      39	   14    65    0
# You want to transform this into a tidy dataset, with each row representing an observation of the incidence of each specific disease (as shown below):
# head(dat_tidy) (NOT all observations are listed below)
# state   year  population  disease  count
# Alabama 1990	4040587 HepatitisA	86
# Alabama 1991	4066003 HepatitisA	39
## Q4: Which of the following commands would achieve this transformation to tidy the data?
## Q4: Pay attention to the column names.
# (a) dat_tidy <- dat_wide %>% gather (key = count, value = disease, HepatitisA, Rubella)
# (b) dat_tidy <- dat_wide %>% gather(key = count, value = disease, -state, -year, -population)
# (c) dat_tidy <- dat_wide %>% gather(key = disease, value = count, -state)
# (d) dat_tidy <- dat_wide %>%gather(key = disease, value = count, HepatitisA:Rubella)
# Answer: (d) 

## Q5: You have successfully formatted marathon finish times into a tidy object called tidy_data.
## Q5: The first few lines are shown below. (NOT all observations are listed below)
# age_group year   time
# 20        2015   03:46
# 30        2015   03:50
## Q5: Select the code that converts these data back to the wide format, where each year has a separate column.
# (a) tidy_data %>% spread(time, year)
# (b) tidy_data %>% spread(year, time)
# (c) tidy_data %>% spread(year, age_group)
# (d) tidy_data %>% spread(time, year, `2015`:`2017`)
# Answer: (b) This code tells the function to create new columns for each year and spread the time values over those cells.

## Q6: You have the following dataset:
# head(dat)
# state   abb region    	var   people
# Alabama  AL  South population 4779736
# Alabama  AL  South  	total 	  135
## Q6: You would like to transform it into a dataset where population and total are each their own column (shown below):
# state      abb region population total
# Alabama     AL  South	4779736   135
# Alaska      AK   West 	 710231    19
## Q6: Which code would best accomplish this?
# (a) dat_tidy <- dat %>% spread(key = var, value = people)
# (b) dat_tidy <- dat %>% spread(key = state:region, value = people)
# (c) dat_tidy <- dat %>% spread(key = people, value = var)
# (d) dat_tidy <- dat %>% spread(key = region, value = people)
# Answer: (a) In this command, you properly specify that the column “var” will be used as the new column names,
# Answer: (a) and that the column “people” should be spread into these two columns.

## Q7: A collaborator sends you a file containing data for two years of average race finish times, "times.csv":
# age_group,2015_time,2015_participants,2016_time,2016_participants
# 20,3:46,54,3:22,62
# 30,3:50,60,3:43,58
# 40,4:39,29,3:49,33
# 50,4:48,10,4:59,14
# You read in the data file:
# d <- read_csv("times.csv")
## Q7: Which of the answers below best makes the data tidy?
# (a1) tidy_data <- d %>% gather(key = “key”, value = “value”, -age_group) %>%
# (a2) separate(col = key, into = c(“year”, “variable_name”), sep = “.”) %>% spread(key = variable_name, value = value)
# (b1) tidy_data <- d %>% gather(key = “key”, value = “value”, -age_group) %>%
# (b2) separate(col = key, into = c(“year”, “variable_name”), sep = “_”) %>% spread(key = variable_name, value = value)
# (c1) tidy_data <- d %>% gather(key = “key”, value = “value”) %>%
# (c2) separate(col = key, into = c(“year”, “variable_name”), sep = “_”) %>% spread(key = variable_name, value = value)
# (d1) tidy_data <- d %>% gather(key = “key”, value = “value”, -age_group) %>%
# (d2) separate(col = key, into = “year”, sep = “_”) %>% spread(key = year, value = value)
# Answer: (b) This column gathers the column names 2015_time, 2015_participants, 2016_time, and 2016_participants into one column called “key”,
# Answer: (b) with the values for each stored in the column “value.” The key column is then separated into two columns, “year” and “variable_name”.
# Answer: (b) The two entries for “variable_name”, time and participants, are then spread into their own columns.

## Q8: You are in the process of tidying some data on heights, hand length, and wingspan for basketball players in the draft.
## Q8: Currently, you have the following:
# head(stats)
# key               value
# allen_height      75
# allen_hand_length 8.25
# allen_wingspan	  79.25
# bamba_height      83.25
# bamba_hand_length 9.75
# bamba_wingspan    94
## Q8: Select all of the correct commands below that would turn this data into a “tidy” format with columns "height", "hand_length" and "wingspan".
# (a) tidy_data <- stats %>%
  separate(col = key, into = c("player", "variable_name"), sep = "_", extra = "merge") %>% 
  spread(key = variable_name, value = value)
# (b) tidy_data <- stats %>%
  separate(col = key, into = c("player", "variable_name1", "variable_name2"), sep = "_", fill = "right") %>% 
  unite(col = variable_name, variable_name1, variable_name2, sep = "_") %>% 
  spread(key = variable_name, value = value)
# (c) tidy_data <- stats %>%
  separate(col = key, into = c("player", "variable_name"), sep = "_") %>% 
  spread(key = variable_name, value = value)
# Answer: (a) This is an efficient way to separate the key column into two new columns, “player” and “variable_name”,
# Answer: (a) while keeping the full variable names using the extra command.



