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
### Section 2: Tidy Data - Reshaping Data (Part 1)

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


### Section 2: Tidy Data - Reshaping Data (Part 2)
### Use the following libraries for these questions: library(tidyverse) + library(dslabs)

## Q9: Examine the built-in dataset co2.
## Q9: This dataset comes with base R, not dslabs - just type co2 to access the dataset.
## Q9: Is co2 tidy? Why or why not?
# (a) co2 is tidy data: it has one year for each row.
# (b) co2 is tidy data: each column is a different month.
# (c) co2 is not tidy: there are multiple observations per column.
# (d1) co2 is not tidy: to be tidy we would have to wrangle it to have three columns (year, month and value),
# (d2) and then each co2 observation would have a row.
# Answer: (d)

## Q10: Run the following command to define the co2_wide object:
## co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>% 
    setNames(1:12) %>%
    mutate(year = as.character(1959:1997))
## Q10: Use the gather() function to make this dataset tidy. Call the column with the CO2 measurements co2 and call the month column month.
## Q10: Name the resulting object co2_tidy. Which code would return the correct tidy format?
# (a) co2_tidy <- gather(co2_wide,month,co2,year)
# (b) co2_tidy <- gather(co2_wide,co2,month,-year)
# (c) co2_tidy <- gather(co2_wide,co2,month,year)
# (d) co2_tidy <- gather(co2_wide,month,co2,-year)
# Answer: (d)      
  
## Q11: Use co2_tidy to plot CO2 versus month with a different curve for each year:
## co2_tidy %>% ggplot(aes(as.numeric(month), co2, color = year)) + geom_line()
## Q11: What can be concluded from this plot?
# (a) CO2 concentrations increased monotonically (never decreased) from 1959 to 1997.
# (b) CO2 concentrations are highest around May and the yearly average increased from 1959 to 1997.
# (c) CO2 concentrations are highest around October and the yearly average increased from 1959 to 1997.
# (d) Yearly average CO2 concentrations have remained constant over time.
# (e) CO2 concentrations do not have a seasonal trend.
# Answer: (b)
  
## Q12: Load the admissions dataset from dslabs, which contains college admission information
## Q12: for men and women across six majors, and remove the applicants percentage column:  
## library(dslabs)
    data(admissions)
    dat <- admissions %>% select(-applicants)
## Your goal is to get the data in the shape that has one row for each major, like this:
# major  men   women
# A      62    82		
# B      63    68		
# C      37    34 
## Q12: Which command could help you to wrangle the data into the desired format?
# (a) dat_tidy <- spread(dat, major, admitted)
# (b) dat_tidy <- spread(dat, gender, major)
# (c) dat_tidy <- spread(dat, gender, admitted)
# (d) dat_tidy <- spread(dat, admitted, gender)
# Answer: (c)
    
## Q13: Now use the admissions dataset to create the object tmp, which has columns major, gender, key and value:
## tmp <- gather(admissions, key, value, admitted:applicants)
## tmp
## Q13: Combine the key and gender and create a new column called column_name to get a variable with the following values:
## Q13: admitted_men, admitted_women, applicants_men and applicants_women. Save the new data as tmp2.
## Q13: Which command could help you to wrangle the data into the desired format?
# (a) tmp2 <- spread(tmp, column_name, key, gender)
# (b) tmp2 <- gather(tmp, column_name, c(gender,key))
# (c) tmp2 <- unite(tmp, column_name, c(gender, key))
# (d) tmp2 <- spread(tmp, column_name, c(key,gender))
# (e) tmp2 <- unite(tmp, column_name, c(key, gender))     
# Answer: (e)      
    
## Q14: Which function can reshape tmp2 to a table with six rows and five columns named major,
## Q14: admitted_men, admitted_women, applicants_men and applicants_women?
# (a) gather(); (b) spread(); (c) separate(); (d) unite()
# Answer: (b)


### Assessments on edX
### Section 2: Tidy Data - Combining Tables
    
## Q1: You have created data frames tab1 and tab2 of state population and election data, similar to our module videos:
# tab1
# state   	     population
# Alabama             4779736
# Alaska     	         710231
# Arizona    	        6392017
# Delaware     	     897934
# District of Columbia 601723
# tab2
# state  electoral_votes
# Alabama      9
# Alaska       3
# Arizona     11
# California  55
# Colorado     9
# Connecticut  7
# dim(tab1)
# [1] 5 2
# dim(tab2)
# [1] 6 2
## Q1: What are the dimensions of the table dat, created by the following command?
## dat <- left_join(tab1, tab2, by = “state”)
# (a) 3 rows by 3 columns
# (b) 5 rows by 2 columns
# (c) 5 rows by 3 columns
# (d) 6 rows by 3 columns
# Answer: (c) When we use a left_join command, all rows in the left-hand table (in this case, tab1) are retained in the final table, so we expect to have five rows.
# Answer: (c) In addition, columns from both tables will be included in the final “dat” table so we expect to have three columns.

## Q2: We are still using the tab1 and tab2 tables shown in question 1. What join command would create a new table “dat” with three rows and two columns?
# (a) dat <- right_join(tab1, tab2, by = “state”)
# (b) dat <- full_join(tab1, tab2, by = “state”) 
# (c) dat <- inner_join(tab1, tab2, by = “state”) 
# (d) dat <- semi_join(tab1, tab2, by = “state”) 
# Answer: (d) The semi_join command takes tab1 and limits it to states that are also in tab2, without adding the additional columns in tab2.
# Answer: (d)This gives us three rows (states in both tables) and two columns (state and population, the two columns in tab1).
    
## Q3:Which of the following are real differences between the join and bind functions?
## Q3: Please select all correct answers.
# (a) Binding functions combine by position, while join functions match by variables.
# (b) Joining functions can join datasets of different dimensions, but the bind functions must match on the appropriate dimension (either same row or column numbers).
# (c) Bind functions can combine both vectors and dataframes, while join functions work for only for dataframes.
# (d) The join functions are a part of the dplyr package and have been optimized for speed, while the bind functions are inefficient base functions.
# Answer: (a) and (c) 
    
## Q4: We have two simple tables, shown below, with columns x and y:
# df1
# x     y    
# a     a    
# b     a    
# df2
# x     y    
# a     a    
# a     b  
## Q4: Which command would result in the following table?
# final
# x     y    
# b     a
# (a) final <- union(df1, df2)
# (b) final <- setdiff(df1, df2)
# (c) final <- setdiff(df2, df1)
# (d) final <- intersect(df1, df2)
# Answer: (b) The setdiff() command returns rows in df1 but not df2, which matches our table final. 


## Introduction to Questions 5-7
## Install and load the Lahman library. This library contains a variety of datasets related to US professional baseball.
## We will use this library for the next few questions and will discuss it more extensively in the Regression course. For now, focus on wrangling the data rather than understanding the statistics.
## The Batting data frame contains the offensive statistics for all baseball players over several seasons.  Filter this data frame to define top as the top 10 home run (HR) hitters in 2016:
## library(Lahman)
    top <- Batting %>% 
      filter(yearID == 2016) %>%
      arrange(desc(HR)) %>%    # arrange by descending HR count
      slice(1:10)    # take entries 1-10
    top %>% as_tibble()
    
## Also Inspect the Master data frame, which has demographic information for all players:
## Master %>% as_tibble()    

## Q5: Use the correct join or bind function to create a combined table of the names and statistics of the top 10 home run (HR) hitters for 2016.
## Q5: This table should have the player ID, first name, last name, and number of HR for the top 10 players. Name this data frame top_names.
## Q5: Identify the join or bind that fills the blank in this code to create the correct table:
## top_names <- top %>% ___________________ %>%
      select(playerID, nameFirst, nameLast, HR)
## Q5: Which bind or join function fills the blank to generate the correct table?
# (a) rbind(Master); (b) cbind(Master); (c) left_join(Master) correct
# (d) right_join(Master); (e) full_join(Master); (f) anti_join(Master)      
# Answer: (c)
# Answer: (c) top_names <- top %>% left_join(Master) %>% select(playerID, nameFirst, nameLast, HR)
# Answer: (c) top_names
      
## Q6:Inspect the Salaries data frame. Filter this data frame to the 2016 salaries, then use the correct bind join function to add a salary column to the top_names
## Q6: data frame from the previous question. Name the new data frame top_salary. Use this code framework:
## top_salary <- Salaries %>% filter(yearID == 2016) %>%
        ______________ %>%
        select(nameFirst, nameLast, teamID, HR, salary)
## Q6: Which bind or join function fills the blank to generate the correct table?
# (a) rbind(top_names); (b) cbind(top_names); (c) left_join(top_names)
# (d) right_join(top_names); (e) full_join(top_names): (f) anti_join(top_names)
# Answer: (d)      
      
## Q7: Inspect the AwardsPlayers table. Filter awards to include only the year 2016.
## Q7: How many players from the top 10 home run hitters won at least one award in 2016? Use a set operator.
# Answer: 3      
## Q7: How many players won an award in 2016 but were not one of the top 10 home run hitters in 2016? Use a set operator.
# Answer: 44




### Assessments on edX
### Section 2: Tidy Data -  Web Scraping    

## Introduction: Questions 1-3
## Load the following web page, which contains information about Major League Baseball payrolls,
## into R: https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm

      ## library(rvest)
## url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
## h <- read_html(url)

## We learned that tables in html are associated with the table node.  Use the html_nodes()
## function and the table node type to extract the first table. Store it in an object nodes:
## nodes <- html_nodes(h, "table")
      
## The html_nodes() function returns a list of objects of class xml_node. We can see the content of each one using, for example, the html_text() function.
## You can see the content for an arbitrarily picked component like this:
##  html_text(nodes[[8]])
      
##  If the content of this object is an html table, we can use the html_table() function to convert it to a data frame:
##  html_table(nodes[[8]])
##  You will analyze the tables from this HTML page over questions 1-3.     

      
## Q1: Many tables on this page are team payroll tables, with columns for rank, team, and one or more money values.
## Q1: Convert the first four tables in nodes to data frames and inspect them.
## Q1: Which of the first four nodes are tables of team payroll?
## Q1: Check all correct answers. Look at table content, not column names.
# (a) None of the above;(b) Table 1; (c) Table 2; (d) Table 3; (e) Table 4
# Answer: (c), (d), and (e)
      sapply(nodes[1:4], html_table)    # 2, 3, 4 give tables with payroll info
      
## Q2: For the last 3 components of nodes, which of the following are true? (Check all correct answers.)
## Q2: Check all correct answers.
# (a) All three entries are tables.
# (b) All three entries are tables of payroll per team.
# (c) The last entry shows the average across all teams through time, not payroll per team.
# (d) None of the three entries are tables of payroll per team.      
# Answer: (a) and (c)
      html_table(nodes[[length(nodes)-2]])
      html_table(nodes[[length(nodes)-1]])
      html_table(nodes[[length(nodes)]])
      
## Q3: Create a table called tab_1 using entry 10 of nodes. Create a table called tab_2 using entry 19 of nodes.
## Q3: Note that the column names should be c("Team", "Payroll", "Average"). You can see that these column names are actually in the first data row of each table,
## Q3: and that tab_1 has an extra first column No. that should be removed so that the column names for both tables match.
## Q3: Remove the extra column in tab_1, remove the first row of each dataset, and change the column names for each table to c("Team", "Payroll", "Average").
## Q3: Use a full_join() by the Team to combine these two tables.
## Q3: How many rows are in the joined data table?      
# Answer: 58      
      tab_1 <- html_table(nodes[[10]])
      tab_2 <- html_table(nodes[[19]])
      col_names <- c("Team", "Payroll", "Average")
      tab_1 <- tab_1[-1, -1]
      tab_2 <- tab_2[-1,]
      names(tab_2) <- col_names
      names(tab_1) <- col_names
      full_join(tab_1,tab_2, by = "Team")     
      
## Introduction: Questions 4 and 5
## The Wikipedia page on opinion polling for the Brexit referendum, in which the United Kingdom voted to leave the European Union in June 2016,
## contains several tables. One table contains the results of all polls regarding the referendum over 2016:    
## Use the rvest library to read the HTML from this Wikipedia page (make sure to copy both lines of the URL):     
      library(rvest)
      library(tidyverse)
      url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"

## Q4: Assign tab to be the html nodes of the "table" class.
## Q4: How many tables are in this Wikipedia page?
# Answer: 39  
      
## Q5: Inspect the first several html tables using html_table() with the argument fill=TRUE (you can read about this argument in the documentation).
## Q5: Find the first table that has 9 columns with the first column named "Date(s) conducted".
## Q5:What is the first table number to have 9 columns where the first column is named "Date(s) conducted"?
# Answer: 5