#### Program: Data Science by HarvardX
#### Course 6: Wrangling


### Assessments on edX
### Section 1: Data Import (Part 1)

##Q1:Which of the following is NOT part of the data wrangling process?
(a) Importing data into R; (b) Formatting dates/times;
(c) Checking correlations between your variables; (d) Tidying data
Answer: (c) Data analyses, such as checking correlations or creating visualizations,
are done AFTER the data has been processed into a tidy format.
Explanation: Importing data, formatting dates and times, and tidying data are all parts of the data wrangling process.
Checking correlations between your variables is a data analysis that is completed after the data has been processed into a tidy format.

##Q2:Which files could be opened in a basic text editor? Select ALL that apply.
(a) data.txt; (b) data.csv; (c) data.xlsx; (d) data.tsv
Answer: (a), (b), and (c) because Microsoft Excel files (.xls) cannot be read with any basic text editor
Explanation: .txt, .csv, and .tsv files can all be opened by any basic text editor.
Microsoft Excel files (.xlsx) use a proprietary format that can't be viewed with a basic text editor.

##Q3:You want to analyze a file containing race finish times for a recent marathon.
##Q3:You open the file in a basic text editor and see lines that look like the following:
initials,state,age,time
vib,MA,61,6:01
adc,TX,45,5:45
kme,CT,50,4:19
(a) A comma-delimited file without a header; (b) A tab-delimited file with a header
(c) A white space-delimited file without a header; (d) A comma-delimited file with a header
Answer: (d) This file has a header that describes the contents of each column. Values are separated by commas.
Explanation: This file has a header that describes the contents of each column. Values are separated by commas.

##Q4:Assume the following is the full path to the directory that a student wants to use as their working directory in R:
"/Users/student/Documents/projects/"
##Q4:Which of the following lines of code CANNOT set the working directory to the desired "projects" directory?
(a) setwd("~/Documents/projects/"); (b) setwd("/Users/student/Documents/projects/")
(c) setwd(/Users/student/Documents/projects/); (d)dir <- "/Users/student/Documents/projects" setwd(dir)
Answer: (c) This code will not work. You need to use quotation marks when providing a full path to the working directory.
Explanation: setwd(/Users/student/Documents/projects/) will not work because you need to use quotations marks
when providing a full path to the working directory.

##Q5:We want to copy the "murders.csv" file from the dslabs package into an existing folder "data",
##Q5:which is located in our HarvardX-Wrangling projects folder. We first enter the code below into our RStudio console.
getwd()
[1] "C:/Users/UNIVERSITY/Documents/Analyses/HarvardX-Wrangling"
filename <- "murders.csv"
path <- system.file("extdata", package = "dslabs")
##Q5:Which of the following commands would NOT successfully copy “murders.csv” into the folder “data”?
(a) file.copy(file.path(path, "murders.csv"), getwd())
(b) setwd("data") > file.copy(file.path(path, filename), getwd()) 
(c) file.copy(file.path(path, "murders.csv"), file.path(getwd(), "data"))
(d) file.location <- file.path(system.file("extdata", package = "dslabs"), "murders.csv")
file.destination <- file.path(getwd(), "data")
file.copy(file.location, file.destination) 
Answer: (a) This command does NOT copy the “murders.csv” file into your “data” folder;
instead it copies it into the parent directory, “HarvardX-Wrangling”.
You need to specify the “data” folder, either by changing the working directory or by adding it to the file path.
Explanation: file.copy(file.path(path, "murders.csv"), getwd()) does NOT copy the “murders.csv” file into your “data” folder;
instead it copies it into the parent directory, “HarvardX-Wrangling”. You need to specify the “data” folder,
either by changing the working directory or by adding it to the file path.
The other commands all correctly copy the "murders.csv" file into your "data" folder.

##Q6:You are not sure whether the murders.csv file has a header row. How could you check this?
##Q6:Select ALL that apply.
(a) Open the file in a basic text editor.
(b) In the RStudio “Files” pane, click on your file, then select “View File”.
(c) Use the command read_lines (remembering to specify the number of rows with the n_max argument).
Answer: (a) and (c)
Explanation:All three choices are ways to inspect the header.

##Q7:What is one difference between read_excel() and read_xlsx()?
(a) read_excel() also reads meta-data from the excel file, such as sheet names, while read_xlsx() only reads the first sheet in a file.
(b) read_excel() reads both .xls and .xlsx files by detecting the file format from its extension, while read_xlsx() only reads .xlsx files.
(c) read_excel() is part of the readr package, while read_xlsx() is part of the readxl package and has more options.
(d) read_xlsx() has been replaced by read_excel() in a recent readxl package update.
Answer: (b) You can use read_excel for both .xls and .xlsx files, while read_xlsx only reads .xlsx files.
Explanation: The difference between these fuctions is that you can use read_excel() for both .xls and .xlsx files,
while read_xlsx() only reads .xlsx files.

##Q8:You have a file called “times.txt” that contains race finish times for a marathon. The first four lines of the file look like this:
initials,state,age,time
vib,MA,61,6:01
adc,TX,45,5:45
kme,CT,50,4:19
##Q8:Which line of code will NOT produce a tibble with column names “initials”, “state”, “age”, and “time”?
(a) race_times <- read_csv("times.txt")
(b) race_times <- read.csv("times.txt")
(c) race_times <- read_csv("times.txt", col_names = TRUE)
(d) race_times <- read_delim("times.txt", delim = “,”)
Answer: (b) This code will import the comma-separated values table called “times.txt”,
but the base R function read.csv does not produce a tibble. It creates a data frame.
Explanation: race_times <- read.csv("times.txt") will import the comma-separated values table called “times.txt”,
but the base R function read.csv does not produce a tibble. It creates a data frame.

##Q9:You also have access to marathon finish times in the form of an Excel document named “times.xlsx”.
##Q9:In the Excel document, different sheets contain race information for different years.
##Q9:The first sheet is named “2015”, the second is named “2016”, and the third is named “2017”.
##Q9:Which line of code will NOT import the data contained in the “2016” tab of this Excel sheet?
(a) times_2016 <- read_excel("times.xlsx", sheet = 2)
(b) times_2016 <- read_xlsx("times.xlsx", sheet = “2”)
(c) times_2016 <- read_excel("times.xlsx", sheet = "2016")
(d) times_2016 <- read_xlsx("times.xlsx", sheet = 2)
Answer: (b) When the sheet argument is contained within quotes, the function expects a sheet name.
There is no sheet named “2” in this spreadsheet, so the code will not work.
Explanation: In times_2016 <- read_xlsx("times.xlsx", sheet = “2”) , the sheet argument is contained within quotes,
and the function expects a sheet name. There is no sheet named “2” in this spreadsheet, so the code will not work.

##Q10:You have a comma-separated values file that contains the initials, home states, ages, and race finish times for marathon runners.
##Q10:The runners’ initials contain three characters for the runners’ first, middle, and last names (for example, “KME”).
##Q10:You read in the file using the following code.
race_times <- read.csv(“times.csv”)
##Q10:What is the data type of the initials in the object race_times?
(a) integers; (b) characters; (c) factors; (d)logical
Answer: (c) If you don’t supply the argument stringsAsFactors = F,
the read.csv function will automatically convert characters to factors.
Explanation: Although the initials look like character strings, read.csv automatically converts characters to factors
unless you specify stringsAsFactors=FALSE.

##Q11:Which of the following is NOT a real difference between the readr import functions and the base R import functions?
(a) The import functions in the readr package all start as read_, while the import functions for base R all start with read.
(b) Base R import functions automatically convert character columns to factors.
(c) The base R import functions can read .csv files, but cannot read files with other delimiters, such as .tsv files, or fixed-width files.
(d) Base R functions import data as a data frame, while readr functions import data as a tibble.
Answer: (c) This statement is false. The base R import functions can read files with other
delimiters like .tsv using read.delim and can read fixed-width files using read.fwf.


##Q12:You read in a file containing runner information and marathon finish times using the following code.
race_times <- read.csv(“times.csv”, stringsAsFactors = F)
##Q12:What is the class of the object race_times?
(a) data frame; (b) tibble; (c) matrix; (d) vector
Answer: (a) The read.csv function generates a data frame containing these data.

##Q13:Select the answer choice that summarizes all of the actions that the following lines of code can perform.
##Q13:Please note that the url below is an example and does not lead to data.
url <- "https://raw.githubusercontent.com/MyUserName/MyProject/master/MyData.csv "
dat <- read_csv(url)
download.file(url, "MyData.csv")
(a) Create a tibble in R called dat that contains the information contained in the csv file stored on Github
and save that tibble to the working directory.
(b) Create a matrix in R called dat that contains the information contained in the csv file stored on Github.
Download the csv file to the working directory and name the downloaded file “MyData.csv”.
(c) Create a tibble in R called dat that contains the information contained in the csv file stored on Github.
Download the csv file to the working directory and randomly assign it a temporary name that is very likely to be unique.
(d) Create a tibble in R called dat that contains the information contained in the csv file stored on Github.
Download the csv file to the working directory and name the downloaded file “MyData.csv”.
Answer: (d) The read_csv command creates the tibble in R and the download.file command
downloads the csv file from the internet to the working directory with the specified name.


### Section 1: Data Import (Part 2)
### Use the readr package in the tidyverse library: library(tidyverse)

##Q14:Inspect the file at the following URL:
http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data
##Q14:Which readr function should be used to import this file?
(a) read_table(); (b)read_csv(); (c) read_csv2(); (d) read_tsv(); (e) None of the above
Answer: (b) this is a comma-separated value file.

##Q15:Check the documentation for the readr function you chose in the previous question to learn about its arguments.
##Q15:Determine which arguments you need to the file from the previous question:
url <- "http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"
##Q15:Does this file have a header row? Does the readr function you chose need any additional arguments to import the data correctly?
(a) Yes, there is a header. No arguments are needed.
(b) Yes, there is a header. The header=TRUE argument is necessary.
(c) Yes, there is a header. The col_names=TRUE argument is necessary.
(d) No, there is no header. No arguments are needed.
(e) No, there is no header. The header=FALSE argument is necessary.
(f) No, there is no header. The col_names=FALSE argument is necessary.
Answer: (f) There are no variable names in the first row, and the correct argument to skip the header in readr is col_names=FALSE.

##Q16:Inspect the imported data from the previous question.
##Q16:How many rows are in the dataset?
Answer: 569
Code: url <- "http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"
          df <- read_csv(url, col_names = FALSE)
          nrow(df)
##Q16:How many columns are in the dataset?
Answer: 32
Code: ncol(df)




### Assessments on edX
### Section 2: Tidy Data - Reshaping Data (Part 1)

##Q1:A collaborator sends you a file containing data for three years of average race finish times.
age_group,2015,2016,2017
20,3:46,3:22,3:50
30,3:50,3:43,4:43
40,4:39,3:49,4:51
50,4:48,4:59,5:01
##Q1:Are these data considered “tidy” in R? Why or why not?
(a) Yes. These data are considered “tidy” because each row contains unique observations.
(b) Yes. These data are considered “tidy” because there are no missing data in the data frame.
(c) No. These data are not considered “tidy” because the variable “year” is stored in the header.
(d) No. These data are not considered “tidy” because there are not an equal number of columns and rows.
Answer: (c) The year is a variable and should be stored as a column instead of across multiple columns in the header.
Explanation: These data are not tidy because year is a variable and should be stored as a column
instead of across multiple columns in the header.

##Q2:Below are four versions of the same dataset. Which one is in a tidy format?
Answer: (a) and a piece of the dataset is listed below (listing all options will take a lot of space)
state      abb region  population total
Alabama     AL	South	4779736	  135
Alaska      AK   West 	710231	  19
Explanation: In tidy format, each observation has its own row, and each variable has its own column.

##Q3:Your file called “times.csv” has age groups and average race finish times for three years of marathons.
age_group,2015,2016,2017
20,3:46,3:22,3:50
30,3:50,3:43,4:43
40,4:39,3:49,4:51
50,4:48,4:59,5:01
##Q3:You read in the data file using the following command.
d <- read_csv("times.csv")
##Q3:Which commands will help you “tidy” the data?
(a) tidy_data <- d %>% gather(year, time, `2015`:`2017`)
(b) tidy_data <- d %>% spread(year, time, `2015`:`2017`)
(c) tidy_data <- d %>% gather(age_group, year, time, `2015`:`2017`)
(d) tidy_data <- d %>% gather(time, `2015`:`2017`)
Answer: (a) This code will gather the years from 2015 to 2017 into a single column and
create a single column called “time” that contains the time for each age group and each year.
Explanation: tidy_data <- d %>% gather(year, time, `2015`:`2017`)
This code will gather the years from 2015 to 2017 into a single column and create a single column called “time”
that contains the time for each age group and each year.

##Q4:You have a dataset on U.S. contagious diseases, but it is in the following wide format:
head(dat_wide) (NOT all observations are listed below)
state year population HepatitisA Mumps Polio Rubella
Alabama 1990    4040587      86	   19    76    1
Alabama 1991    4066003      39	   14    65    0
##Q4:You want to transform this into a tidy dataset, with each row representing an observation of the incidence
of each specific disease (as shown below):
head(dat_tidy) (NOT all observations are listed below)
state   year  population  disease  count
Alabama 1990	4040587 HepatitisA	86
Alabama 1991	4066003 HepatitisA	39
##Q4:Which of the following commands would achieve this transformation to tidy the data?
##Q4:Pay attention to the column names.
(a) dat_tidy <- dat_wide %>% gather (key = count, value = disease, HepatitisA, Rubella)
(b) dat_tidy <- dat_wide %>% gather(key = count, value = disease, -state, -year, -population)
(c) dat_tidy <- dat_wide %>% gather(key = disease, value = count, -state)
(d) dat_tidy <- dat_wide %>%gather(key = disease, value = count, HepatitisA:Rubella)
Answer: (d) 

##Q5:You have successfully formatted marathon finish times into a tidy object called tidy_data.
##Q5:The first few lines are shown below. (NOT all observations are listed below)
age_group year   time
20        2015   03:46
30        2015   03:50
##Q5:Select the code that converts these data back to the wide format, where each year has a separate column.
(a) tidy_data %>% spread(time, year)
(b) tidy_data %>% spread(year, time)
(c) tidy_data %>% spread(year, age_group)
(d) tidy_data %>% spread(time, year, `2015`:`2017`)
Answer: (b) This code tells the function to create new columns for each year and spread the time values over those cells.

##Q6:You have the following dataset:
head(dat)
state   abb region    	var   people
Alabama  AL  South population 4779736
Alabama  AL  South  	total 	  135
##Q6:You would like to transform it into a dataset where population and total are each their own column (shown below):
state      abb region population total
Alabama     AL  South	4779736   135
Alaska      AK   West 	 710231    19
##Q6:Which code would best accomplish this?
(a) dat_tidy <- dat %>% spread(key = var, value = people)
(b) dat_tidy <- dat %>% spread(key = state:region, value = people)
(c) dat_tidy <- dat %>% spread(key = people, value = var)
(d) dat_tidy <- dat %>% spread(key = region, value = people)
Answer: (a) In this command, you properly specify that the column “var” will be used as the new column names,
and that the column “people” should be spread into these two columns.

##Q7:A collaborator sends you a file containing data for two years of average race finish times, "times.csv":
age_group,2015_time,2015_participants,2016_time,2016_participants
20,3:46,54,3:22,62
30,3:50,60,3:43,58
40,4:39,29,3:49,33
50,4:48,10,4:59,14
##Q7:You read in the data file:
d <- read_csv("times.csv")
##Q7:Which of the answers below best makes the data tidy?
(a) tidy_data <- d %>% gather(key = “key”, value = “value”, -age_group) %>%
separate(col = key, into = c(“year”, “variable_name”), sep = “.”) %>% spread(key = variable_name, value = value)
(b) tidy_data <- d %>% gather(key = “key”, value = “value”, -age_group) %>%
separate(col = key, into = c(“year”, “variable_name”), sep = “_”) %>% spread(key = variable_name, value = value)
(c) tidy_data <- d %>% gather(key = “key”, value = “value”) %>%
separate(col = key, into = c(“year”, “variable_name”), sep = “_”) %>% spread(key = variable_name, value = value)
(d) tidy_data <- d %>% gather(key = “key”, value = “value”, -age_group) %>%
separate(col = key, into = “year”, sep = “_”) %>% spread(key = year, value = value)
Answer: (b) This column gathers the column names 2015_time, 2015_participants, 2016_time, and 2016_participants into one column called “key”,
with the values for each stored in the column “value.” The key column is then separated into two columns, “year” and “variable_name”.
The two entries for “variable_name”, time and participants, are then spread into their own columns.

##Q8:You are in the process of tidying some data on heights, hand length, and wingspan for basketball players in the draft.
##Q8:Currently, you have the following:
head(stats)
key               value
allen_height      75
allen_hand_length 8.25
allen_wingspan	  79.25
bamba_height      83.25
bamba_hand_length 9.75
bamba_wingspan    94
##Q8:Select all of the correct commands below that would turn this data into a “tidy” format
with columns "height", "hand_length" and "wingspan".
(a) tidy_data <- stats %>%
  separate(col = key, into = c("player", "variable_name"), sep = "_", extra = "merge") %>% 
  spread(key = variable_name, value = value)
(b) tidy_data <- stats %>%
  separate(col = key, into = c("player", "variable_name1", "variable_name2"), sep = "_", fill = "right") %>% 
  unite(col = variable_name, variable_name1, variable_name2, sep = "_") %>% 
  spread(key = variable_name, value = value)
(c) tidy_data <- stats %>%
  separate(col = key, into = c("player", "variable_name"), sep = "_") %>% 
  spread(key = variable_name, value = value)
Answer: (a) This is an efficient way to separate the key column into two new columns, “player” and “variable_name”,
while keeping the full variable names using the extra command.


### Section 2: Tidy Data - Reshaping Data (Part 2)
### Use the following libraries for these questions: library(tidyverse) + library(dslabs)

##Q9:Examine the built-in dataset co2.
##Q9:This dataset comes with base R, not dslabs - just type co2 to access the dataset.
##Q9:Is co2 tidy? Why or why not?
(a) co2 is tidy data: it has one year for each row.
(b) co2 is tidy data: each column is a different month.
(c) co2 is not tidy: there are multiple observations per column.
(d) co2 is not tidy: to be tidy we would have to wrangle it to have three columns (year, month and value),
and then each co2 observation would have a row.
Answer: (d)
Explanation: These data are not tidy because month is a variable and should be stored as a column
instead of across multiple columns in the header. There are also multiple observations per row, and each observation should be a different row.

##Q10:Run the following command to define the co2_wide object:
co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>% 
    setNames(1:12) %>%
    mutate(year = as.character(1959:1997))
##Q10:Use the gather() function to make this dataset tidy. Call the column with the CO2 measurements co2 and call the month column month.
##Q10:Name the resulting object co2_tidy. Which code would return the correct tidy format?
(a) co2_tidy <- gather(co2_wide,month,co2,year)
(b) co2_tidy <- gather(co2_wide,co2,month,-year)
(c) co2_tidy <- gather(co2_wide,co2,month,year)
(d) co2_tidy <- gather(co2_wide,month,co2,-year)
Answer: (d)      
Explanation: gather takes 4 arguments: (1) the data, (2) the name of the key column,
(3) the name of the value column, and optionally (4) the names of any columns not to gather.
We want to collect the months as the key and CO2 as the value while keeping the year column as-is. 

##Q11:Use co2_tidy to plot CO2 versus month with a different curve for each year:
co2_tidy %>% ggplot(aes(as.numeric(month), co2, color = year)) + geom_line()
##Q11:What can be concluded from this plot?
(a) CO2 concentrations increased monotonically (never decreased) from 1959 to 1997.
(b) CO2 concentrations are highest around May and the yearly average increased from 1959 to 1997.
(c) CO2 concentrations are highest around October and the yearly average increased from 1959 to 1997.
(d) Yearly average CO2 concentrations have remained constant over time.
(e) CO2 concentrations do not have a seasonal trend.
Answer: (b)
Explanation: In every year, the highest CO2 level is around May.
The line legend shows that earlier years had lower CO2 levels and that CO2 levels generally increase relative to the previous year.
The most recent years have the highest CO2.
  
##Q12:Load the admissions dataset from dslabs, which contains college admission information
for men and women across six majors, and remove the applicants percentage column:  
library(dslabs)
data(admissions)
dat <- admissions %>% select(-applicants)
##Q12:Your goal is to get the data in the shape that has one row for each major, like this:
major  men   women
A      62    82		
B      63    68		
C      37    34 
##Q12:Which command could help you to wrangle the data into the desired format?
(a) dat_tidy <- spread(dat, major, admitted)
(b) dat_tidy <- spread(dat, gender, major)
(c) dat_tidy <- spread(dat, gender, admitted)
(d) dat_tidy <- spread(dat, admitted, gender)
Answer: (c)
Explanation: spread takes 3 arguments: (1) the data frame, (2) the key to spread across columns,
and (3) the value to put in individual cells of the table.
    
##Q13:Now use the admissions dataset to create the object tmp, which has columns major, gender, key and value:
tmp <- gather(admissions, key, value, admitted:applicants)
tmp
##Q13:Combine the key and gender and create a new column called column_name to get a variable with the following values:
admitted_men, admitted_women, applicants_men and applicants_women. Save the new data as tmp2.
##Q13 Which command could help you to wrangle the data into the desired format?
(a) tmp2 <- spread(tmp, column_name, key, gender)
(b) tmp2 <- gather(tmp, column_name, c(gender,key))
(c) tmp2 <- unite(tmp, column_name, c(gender, key))
(d) tmp2 <- spread(tmp, column_name, c(key,gender))
(e) tmp2 <- unite(tmp, column_name, c(key, gender))     
Answer: (e)
Explanation: unite takes 3 arguments: (1) the data frame, (2) the name of the new column to create,
and (3) a vector of the columns to unite with an underscore, in order.
    
##Q14:Which function can reshape tmp2 to a table with six rows and five columns named major,
admitted_men, admitted_women, applicants_men and applicants_women?
(a) gather(); (b) spread(); (c) separate(); (d) unite()
Answer: (b)
Explanation: spread(tmp2, column_name, value)




### Assessments on edX
### Section 2: Tidy Data - Combining Tables
    
##Q1:You have created data frames tab1 and tab2 of state population and election data, similar to our module videos:
> tab1
state   	     population
Alabama             4779736
Alaska     	         710231
Arizona    	        6392017
Delaware     	     897934
District of Columbia 601723
> tab2
state  electoral_votes
Alabama      9
Alaska       3
Arizona     11
California  55
Colorado     9
Connecticut  7
> dim(tab1)
[1] 5 2
> dim(tab2)
[1] 6 2
##Q1:What are the dimensions of the table dat, created by the following command?
dat <- left_join(tab1, tab2, by = “state”)
(a) 3 rows by 3 columns
(b) 5 rows by 2 columns
(c) 5 rows by 3 columns
(d) 6 rows by 3 columns
Answer: (c) When we use a left_join command, all rows in the left-hand table (in this case, tab1)
are retained in the final table, so we expect to have five rows.
In addition, columns from both tables will be included in the final “dat” table so we expect to have three columns.

##Q2:We are still using the tab1 and tab2 tables shown in question 1.
What join command would create a new table “dat” with three rows and two columns?
(a) dat <- right_join(tab1, tab2, by = “state”)
(b) dat <- full_join(tab1, tab2, by = “state”) 
(c) dat <- inner_join(tab1, tab2, by = “state”) 
(d) dat <- semi_join(tab1, tab2, by = “state”) 
Answer: (d) The semi_join command takes tab1 and limits it to states that are also in tab2, without adding the additional columns in tab2.
This gives us three rows (states in both tables) and two columns (state and population, the two columns in tab1).
    
##Q3:Which of the following are real differences between the join and bind functions?
##Q3:Please select all correct answers.
(a) Binding functions combine by position, while join functions match by variables.
(b) Joining functions can join datasets of different dimensions, but the bind functions must match
on the appropriate dimension (either same row or column numbers).
(c) Bind functions can combine both vectors and dataframes, while join functions work for only for dataframes.
(d) The join functions are a part of the dplyr package and have been optimized for speed,
while the bind functions are inefficient base functions.
Answer: (a) and (c) 
    
##Q4:We have two simple tables, shown below, with columns x and y:
> df1
x     y    
a     a    
b     a    
> df2
x     y    
a     a    
a     b  
##Q4:Which command would result in the following table?
> final
x     y    
b     a
(a) final <- union(df1, df2)
(b) final <- setdiff(df1, df2)
(c) final <- setdiff(df2, df1)
(d) final <- intersect(df1, df2)
Answer: (b) The setdiff() command returns rows in df1 but not df2, which matches our table final. 


## Introduction to Questions 5-7
Install and load the Lahman library. This library contains a variety of datasets related to US professional baseball.
We will use this library for the next few questions and will discuss it more extensively in the Regression course.
For now, focus on wrangling the data rather than understanding the statistics.
The Batting data frame contains the offensive statistics for all baseball players over several seasons.
Filter this data frame to define top as the top 10 home run (HR) hitters in 2016:

library(Lahman)
top <- Batting %>% 
      filter(yearID == 2016) %>%
      arrange(desc(HR)) %>%    # arrange by descending HR count
      slice(1:10)    # take entries 1-10
top %>% as_tibble()
    
Also Inspect the Master data frame, which has demographic information for all players:
Master %>% as_tibble()    

##Q5:Use the correct join or bind function to create a combined table of the names and statistics of the top 10 home run (HR) hitters for 2016.
##Q5:This table should have the player ID, first name, last name, and number of HR for the top 10 players. Name this data frame top_names.
##Q5:Identify the join or bind that fills the blank in this code to create the correct table:
top_names <- top %>% ___________________ %>%
      select(playerID, nameFirst, nameLast, HR)
##Q5:Which bind or join function fills the blank to generate the correct table?
(a) rbind(Master); (b) cbind(Master); (c) left_join(Master) correct
(d) right_join(Master); (e) full_join(Master); (f) anti_join(Master)      
Answer: (c)
Code: top_names <- top %>% left_join(Master) %>% select(playerID, nameFirst, nameLast, HR)
      top_names
      
##Q6:Inspect the Salaries data frame. Filter this data frame to the 2016 salaries,
then use the correct bind join function to add a salary column to the top_names
data frame from the previous question. Name the new data frame top_salary. Use this code framework:
top_salary <- Salaries %>% filter(yearID == 2016) %>%
        ______________ %>%
        select(nameFirst, nameLast, teamID, HR, salary)
##Q6:Which bind or join function fills the blank to generate the correct table?
(a) rbind(top_names); (b) cbind(top_names); (c) left_join(top_names)
(d) right_join(top_names); (e) full_join(top_names): (f) anti_join(top_names)
Answer: (d) 
Code: top_salary <- Salaries %>% filter(yearID==2016) %>%
      right_join(top_names) %>%
      select(nameFirst, nameLast, teamID, HR, salary)
      top_salary
      
##Q7:Inspect the AwardsPlayers table. Filter awards to include only the year 2016.
##Q7:How many players from the top 10 home run hitters won at least one award in 2016? Use a set operator.
Answer: 3  
Code: Awards_2016 <- AwardsPlayers %>% filter(yearID == 2016)
      length(intersect(Awards_2016$playerID, top_names$playerID))
##Q7:How many players won an award in 2016 but were not one of the top 10 home run hitters in 2016?
Use a set operator.
Answer: 44
Code: length(setdiff(Awards_2016$playerID, top_names$playerID))




### Assessments on edX
### Section 2: Tidy Data -  Web Scraping    

## Introduction: Questions 1-3
Load the following web page, which contains information about Major League Baseball payrolls,
into R: https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm

library(rvest)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)

We learned that tables in html are associated with the table node.  Use the html_nodes()
function and the table node type to extract the first table. Store it in an object nodes:
nodes <- html_nodes(h, "table")
      
The html_nodes() function returns a list of objects of class xml_node. We can see the content of each one using,
for example, the html_text() function.
You can see the content for an arbitrarily picked component like this:
html_text(nodes[[8]])
      
If the content of this object is an html table, we can use the html_table() function to convert it to a data frame:
html_table(nodes[[8]])
You will analyze the tables from this HTML page over questions 1-3.     

      
##Q1:Many tables on this page are team payroll tables, with columns for rank, team, and one or more money values.
##Q1:Convert the first four tables in nodes to data frames and inspect them.
##Q1:Which of the first four nodes are tables of team payroll?
##Q1:Check all correct answers. Look at table content, not column names.
(a) None of the above;(b) Table 1; (c) Table 2; (d) Table 3; (e) Table 4
Answer: (c), (d), and (e)
Code: sapply(nodes[1:4], html_table)    # 2, 3, 4 give tables with payroll info
      
##Q2:For the last 3 components of nodes, which of the following are true? (Check all correct answers.)
##Q2:Check all correct answers.
(a) All three entries are tables.
(b) All three entries are tables of payroll per team.
(c) The last entry shows the average across all teams through time, not payroll per team.
(d) None of the three entries are tables of payroll per team.      
Answer: (a) and (c)
Code: html_table(nodes[[length(nodes)-2]])
      html_table(nodes[[length(nodes)-1]])
      html_table(nodes[[length(nodes)]])
      
##Q3:Create a table called tab_1 using entry 10 of nodes. Create a table called tab_2 using entry 19 of nodes.
##Q3:Note that the column names should be c("Team", "Payroll", "Average"). You can see that these column names
are actually in the first data row of each table,
and that tab_1 has an extra first column No. that should be removed so that the column names for both tables match.
##Q3:Remove the extra column in tab_1, remove the first row of each dataset, and change the column names
for each table to c("Team", "Payroll", "Average").
##Q3:Use a full_join() by the Team to combine these two tables.
##Q3:How many rows are in the joined data table?      
Answer: 58      
Code: tab_1 <- html_table(nodes[[10]])
      tab_2 <- html_table(nodes[[19]])
      col_names <- c("Team", "Payroll", "Average")
      tab_1 <- tab_1[-1, -1]
      tab_2 <- tab_2[-1,]
      names(tab_2) <- col_names
      names(tab_1) <- col_names
      full_join(tab_1,tab_2, by = "Team")     
  
      
## Introduction: Questions 4 and 5
The Wikipedia page on opinion polling for the Brexit referendum, in which the United Kingdom voted to leave the European Union in June 2016,
contains several tables. One table contains the results of all polls regarding the referendum over 2016:    
Use the rvest library to read the HTML from this Wikipedia page (make sure to copy both lines of the URL):     
library(rvest)
library(tidyverse)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"

##Q4:Assign tab to be the html nodes of the "table" class.
##Q4:How many tables are in this Wikipedia page?
Answer: 39
Code: tab <- read_html(url) %>% html_nodes("table")
      length(tab)
      
##Q5:Inspect the first several html tables using html_table() with the argument fill=TRUE
(you can read about this argument in the documentation).
##Q5:Find the first table that has 9 columns with the first column named "Date(s) conducted".
##Q5:What is the first table number to have 9 columns where the first column is named "Date(s) conducted"?
Answer: 5
Code: Inspect the column names of table 5 with this code (you can substitute other integers for 5 to confirm this is correct):
      tab[[5]] %>% html_table(fill = TRUE) %>% names()    # inspect column names


     

### Assessments on edX
### Section 3: String Processing (Part 1)

##Q1:Which of the following is NOT an application of string parsing?
(a) Removing unwanted characters from text.
(b) Extracting numeric values from text.
(c) Formatting numbers and characters so they can easily be displayed in deliverables like papers and presentations.
(d) Splitting strings into multiple values.
Answer: (c) Formatting text and numbers for deliverables is not an application of string parsing.
String parsing is used as part of the data wrangling process.


##Q2:Which of the following commands would not give you an error in R?
(a) cat(" LeBron James is 6’8\" ")
(b) cat(' LeBron James is 6'8" ')
(c) cat(` LeBron James is 6'8" `)
(d) cat(" LeBron James is 6\’8" ")
Answer: (a) This would correctly print out your string. Because the string is enclosed in double quotes,
(“”), you must use an escape character before the inches symbol (“).
      
##Q3:Which of the following are advantages of the stringr package over string processing functions in base R?
Select all that apply.
(a) Base R functions are rarely used for string processing by data scientists so it’s not worth learning them.
(b) Functions in stringr all start with “str_”, which makes them easy to look up using autocomplete.
(c) Stringr functions work better with pipes.
(d) The order of arguments is more consistent in stringr functions than in base R.
Answer: (b), (c), and (d)

##Q4:You have a data frame of monthly sales and profits in R:
> head(dat)
# A tibble: 5 x 3
Month     Sales     Profit 
<chr>     <chr>     <chr>  
January   $128,568  $16,234
February  $109,523  $12,876
March     $115,468  $17,920
April     $122,274  $15,825
May       $117,921  $15,437
##Q4:Which of the following commands could convert the sales and profits columns to numeric? Select all that apply.
(a) dat %>% mutate_at(2:3, parse_number)
(b) dat %>% mutate_at(2:3, as.numeric)
(c) dat %>% mutate_all(parse_number)
(d) dat %>% mutate_at(2:3, funs(str_replace_all(., c("\\$|,"), ""))) %>% 
        mutate_at(2:3, as.numeric)
Answer: (a) and (d)
You can use the parse_number command to remove all non-numeric characters.
Combining this with the mutate_at command allows you to reformat column two and three (Sales and Profit).
You can use the str_replace_all command to replace both the “$” and “,” characters,
by specifying these in the “pattern” argument of the command.
Combining this function with the mutate_at command allows you to reformat both column two and three (Sales and Profit).
You then need to use the “as.numeric” command to convert these columns from character strings to numbers.
   
   
        

### Assessments on edX
### Section 3: String Processing (Part 2)

##Q1:In the video, we use the function not_inches to identify heights that were incorrectly entered
not_inches <- function(x, smallest = 50, tallest = 84) {
    inches <- suppressWarnings(as.numeric(x))
    ind <- is.na(inches) | inches < smallest | inches > tallest 
    ind
   }
##Q1:In this function, what TWO types of values are identified as not being correctly formatted in inches?
(a) Values that specifically contain apostrophes (‘), periods (.) or quotations (“).
(b) Values that result in NA’s when converted to numeric
(c) Values less than 50 inches or greater than 84 inches
(d) Values that are stored as a character class, because most are already classed as numeric.
Answer: (b) and (c)
  
##Q2:Which of the following arguments, when passed to the function not_inches(), would return the vector c(FALSE)?
(a) c(175)
(b) c(“5’8\””)
(c) c(70)
(d) c(85) (the height of Shaquille O'Neal in inches)
Answer: (c) The entry 70 can be converted to a numeric entry by as.numeric and is within the range that we set.
Therefore, the result of this function would be FALSE (i.e., our entry is correctly formatted in inches).

##Q3:Our function not_inches() returns the object ind. Which answer correctly describes ind?
(a) ind is a logical vector of TRUE and FALSE, equal in length to the vector x (in the arguments list).
TRUE indicates that a height entry is incorrectly formatted.
(b) ind is a logical vector of TRUE and FALSE, equal in length to the vector x (in the arguments list).
TRUE indicates that a height entry is correctly formatted.
(c) ind is a data frame like our reported_heights table but with an extra column of TRUE or FALSE.
TRUE indicates that a height entry is incorrectly formatted.
(d) ind is a numeric vector equal to reported_heights$heights but with incorrectly formatted heights replaced with NAs.
Answer:(a) Our function returns a logical vector, with TRUE indicating that a height entry is incorrectly formatted
and FALSE indicating that a height entry is formatted properly in inches.
We then use this logical vector to filter our raw_heights data to only show incorrectly formatted entries.
        
##Q4: Given the following code
> s
[1] "70"    "5 ft"   "4'11"    ""     "."    "Six feet"
##Q4:What pattern vector yields the following result?
str_view_all(s, pattern)
70
5 ft
4’11
.
Six feet
(a) pattern <- "\\d|ft"
(b) pattern <- "\d|ft"
(c) pattern <- "\\d\\d|ft"
(d)  pattern <- "\\d|feet"
Answer:(a) This regex identifies any numeric characters or the text “ft”

##Q5:You enter the following set of commands into your R console. What is your printed result?
animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[a-z]"
str_detect(animals, pattern)
(a)  TRUE
(b)  TRUE TRUE TRUE TRUE
(c)  TRUE TRUE TRUE FALSE
(d)  TRUE TRUE FALSE FALSE
Answer: (c) While your first three strings have at least one lowercase letter [a-z],
the string MONKEY does not have any lowercase letters and will return a FALSE.
        
##Q6:You enter the following set of commands into your R console. What is your printed result?
animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[A-Z]$"
str_detect(animals, pattern)
(a) FALSE FALSE FALSE FALSE
(b) FALSE FALSE TRUE TRUE
(c) FALSE FALSE FALSE TRUE
(d) TRUE TRUE TRUE FALSE
Answer: (c) Your regex pattern tells str_detect to look for an uppercase ([A-Z]) letter at the end of the string ($):
this is only true for the string “MONKEY”.
     
##Q7:You enter the following set of commands into your R console. What is your printed result?
animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[a-z]{4,5}"
str_detect(animals, pattern)
(a) FALSE TRUE TRUE FALSE
(b) TRUE TRUE FALSE FALSE
(c) FALSE FALSE FALSE TRUE
(d) TRUE TRUE TRUE FALSE
Answer: (a) Your regex command tells R to look for either 4 or 5 lowercase letters in a row anywhere in the string.
This is true for the animals “puppy” and “Moose”.
        
##Q8:Given the following code:
animals <- c("moose", "monkey", "meerkat", "mountain lion")
##Q8:Which TWO “pattern” vectors would yield the following result?
> str_detect(animals, pattern)
[1] TRUE TRUE TRUE TRUE
(a) pattern <- “mo*”
(b) pattern <- “mo?”
(c) pattern <- “mo+”
(d) pattern <- “moo*” 
Answer: (a) and (b)
This regex pattern looks for an “m” followed by zero or more “o” characters.
This is true for all strings in the animal vector.
This regex pattern looks for an “m” followed by zero or one “o” characters.
This is true for all strings in the animal vector. Even though “moose” has two “o”s after the “m”, it still matches the pattern.
        
##Q9:You are working on some data from different universities. You have the following vector:
> schools
[1] "U. Kentucky"                 "Univ New Hampshire"          "Univ. of Massachusetts"      "University Georgia"         
[5] "U California"                "California State University"
##Q9:You want to clean this data to match the full names of each university:
> final
[1] "University of Kentucky"      "University of New Hampshire" "University of Massachusetts" "University of Georgia"         
[5] "University of California"    "California State University"
##Q9:What of the following commands could accomplish this?
(a) schools %>% 
    str_replace("Univ\\.?|U\\.?", "University ") %>% 
    str_replace("^University of |^University ", "University of ")
(b) schools %>% 
    str_replace("^Univ\\.?\\s|^U\\.?\\s", "University ") %>% 
    str_replace("^University of |^University ", "University of ")
(c) schools %>% 
    str_replace("^Univ\\.\\s|^U\\.\\s", "University") %>% 
    str_replace("^University of |^University ", "University of ")
(d) schools %>% 
    str_replace("^Univ\\.?\\s|^U\\.?\\s", "University") %>% 
    str_replace("University ", "University of ")
Answer: (b) This code properly replaces all versions of “U”, “U.”, “Univ” and “Univ.” with “University” and then adds the word “of”.
        
##Q10:Rather than using the pattern_with_groups vector from the video, you accidentally write in the following code:
problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.](\\d*)$"
str_replace(problems, pattern_with_groups, "\\1'\\2")
##Q10:What is your result?
(a) [1] "5'3" "5'5" "6 1" "5 .11" "5, 12"
(b) [1] "5.3" "5,5" "6 1" "5 .11" "5, 12"
(c) [1] "5'3" "5'5" "6'1" "5 .11" "5, 12"
(d) [1] "5'3" "5'5" "6'1" "5’11" "5’12"
Answer: (a) Yes. You forgot to check for any spaces in your regex pattern.
While the first two entries of “problems” have commas and periods correctly replaced,
the last three entries are not identified as part of the pattern and are not replaced.
        
##Q11:You notice your mistake and correct your pattern regex to the following
problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.\\s](\\d*)$"
str_replace(problems, pattern_with_groups, "\\1'\\2")
##Q11:What is your result?
(a) [1] "5'3" "5'5" "6 1" "5 .11" "5, 12"
(b) [1] "5.3" "5,5" "6 1" "5 .11" "5, 12"
(c) [1] "5'3" "5'5" "6'1" "5 .11" "5, 12"
(d) [1] "5'3" "5'5" "6'1" "5’11" "5’12"
Answer: (c) The new regex pattern now checks for one character, either a comma, period or space,
between the first digit and the last one or two digits, and replaces it with an apostrophe (‘).
However, because your last two problem strings have additional space between the digits, they are not corrected.
        
##Q12:In our example, we use the following code to detect height entries that do not match our pattern of x’y”:
converted <- problems %>% 
  str_replace("feet|foot|ft", "'") %>% 
  str_replace("inches|in|''|\"", "") %>% 
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")
    
pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
index <- str_detect(converted, pattern)
converted[!index]
##Q12:Which answer best describes the differences between the regex string we use as an argument
in str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") and the regex string in pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"?
(a) The regex used in str_replace() looks for either a comma, period or space
between the feet and inches digits, while the pattern regex just looks for an apostrophe;
the regex in str_replace allows for one or more digits to be entered as inches, while the pattern regex only allows for one or two digits.
(b) The regex used in str_replace() allows for additional spaces between the feet and inches digits,
but the pattern regex does not.
(c) The regex used in str_replace() looks for either a comma, period or space between the feet and inches digits,
while the pattern regex just looks for an apostrophe; the regex in str_replace allows none or more digits to be entered as inches,
while the pattern regex only allows for the number 1 or 2 to be used.
(d) The regex used in str_replace() looks for either a comma, period or space between the feet and inches digits,
while the pattern regex just looks for an apostrophe; the regex in str_replace allows for none or more digits to be entered as inches,
while the pattern regex only allows for one or two digits.
Answer: (d) This answer describes two important differences in the str_replace() regex and the pattern regex.

##Q13:You notice a few entries that are not being properly converted using your str_replace() and str_detect() code:
yes <- c("5 feet 7inches", “5 7”)
no <- c("5ft 9 inches", "5 ft 9 inches")
s <- c(yes, no)
    
converted <- s %>% 
  str_replace("feet|foot|ft", "'") %>% 
  str_replace("inches|in|''|\"", "") %>% 
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")
    
pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
str_detect(converted, pattern)
[1]  TRUE TRUE FALSE FALSE
##Q13 It seems like the problem may be due to spaces around the words feet|foot|ft and inches|in.
What is another way you could fix this problem?
(a) converted <- s %>% 
    str_replace("\\s*(feet|foot|ft)\\s*", "'") %>% 
    str_replace("\\s*(inches|in|''|\")\\s*", "") %>% 
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")
(b) converted <- s %>% 
    str_replace("\\s+feet|foot|ft\\s+”, "'") %>% 
    str_replace("\\s+inches|in|''|\"\\s+", "") %>% 
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")
(c) converted <- s %>% 
    str_replace("\\s*|feet|foot|ft", "'") %>% 
    str_replace("\\s*|inches|in|''|\"", "") %>% 
   str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") 
(d) converted <- s %>% 
    str_replace_all(“\\s”, “”) %>% 
    str_replace("\\s|feet|foot|ft", "'") %>% 
    str_replace("\\s|inches|in|''|\"", "") %>% 
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")
Answer: (a)
It is not (c) Try again. Your regex says to replace either a space OR the word you want to replace.
For example, the text entry “5 feet 7inches” becomes “5’feet7inches” rather than “5’7””.
    
  
  
    
### Assessments on edX
### Section 3: String Processing (Part 3)

##Q1:
s <- c("5'10", "6'1\"", "5'8inches", "5'7.5")
tab <- data.frame(x = s)
##Q1:If you use the extract code from our video, the decimal point is dropped.
What modification of the code would allow you to put the decimals in a third column called “decimal”?
(a) extract(data = tab, col = x, into = c(“feet”, “inches”, “decimal”), 
    regex = "(\\d)'(\\d{1,2})(\\.)?"
(b) extract(data = tab, col = x, into = c("feet", "inches", "decimal"), 
    regex = "(\\d)'(\\d{1,2})(\\.\\d+)" 
(c) extract(data = tab, col = x, into = c("feet", "inches", "decimal"), 
    regex = "(\\d)'(\\d{1,2})\\.\\d+?"
(d) extract(data = tab, col = x, into = c("feet", "inches", "decimal"), 
    regex = "(\\d)'(\\d{1,2})(\\.\\d+)?")    
Answer: (d) In this code, you extract three groups: one digit for “feet”, one or two digits for “inches”,
and an optional decimal point followed by at least one digit for “decimal”.

##Q2:You have the following table, schedule:
> schedule
day		staff
Monday		Mandy, Chris and Laura
Tuesday		Steve, Ruth and Frank
##Q2:You want to turn this into a more useful data frame.
##Q2:Which two commands would properly split the text in the “staff” column into each individual name? Select ALL that apply.
(a) str_split(schedule$staff, ",|and")
(b) str_split(schedule$staff, ", | and ")
(c) str_split(schedule$staff, ",\\s|\\sand\\s")
(d) str_split(schedule$staff, "\\s?(,|and)\\s?")
Answer: (b) and (c)
This regex will correctly split each “staff” string into three names by properly accounting for the space
after the comma as well as the spaces before and after the “and”, but it’s not the only one.
This regex command is the same as the one above, except that the spaces are written as \\s, but it’s not the only one.

##Q3:You have the following table, schedule:
> schedule
day         staff
Monday   	Mandy, Chris and Laura
#Tuesday 	Steve, Ruth and Frank
##Q3:What code would successfully turn your “Schedule” table into the following tidy table?
> tidy
day     staff
<chr>   <chr>
Monday  Mandy
Monday  Chris
Monday  Laura
Tuesday Steve
Tuesday Ruth 
Tuesday Frank

(a) tidy <- schedule %>% 
    mutate(staff = str_split(staff, ", | and ")) %>% 
    unnest()
(b) tidy <- separate(schedule, staff, into = c("s1","s2","s3"), sep = “,”) %>% 
    gather(key = s, value = staff, s1:s3)
(c) tidy <- schedule %>% 
    mutate(staff = str_split(staff, ", | and ", simplify = TRUE)) %>% 
    unnest()
Answer: (a) The mutate command creates a column “staff”. Each row in the “staff” column is a character vector
of length three, with the names of each staff member. We unnest this character vector using the unnest() function from tidyr.
      
##Q4:Using the gapminder data, you want to recode countries longer than 12 letters in the region “Middle Africa”
to their abbreviations in a new column, “country_short”. Which code would accomplish this?
(a) dat <- gapminder %>% filter(region == "Middle Africa") %>% 
    mutate(recode(country, 
                      "Central African Republic" = "CAR", 
                      "Congo, Dem. Rep." = "DRC",
                      "Equatorial Guinea" = "Eq. Guinea"))
(b) dat <- gapminder %>% filter(region == "Middle Africa") %>% 
    mutate(country_short = recode(country, 
                                      c("Central African Republic", "Congo, Dem. Rep.", "Equatorial Guinea"),
                                      c("CAR", "DRC", "Eq. Guinea")))
(c) dat <- gapminder %>% filter(region == "Middle Africa") %>% 
    mutate(country = recode(country, 
                                "Central African Republic" = "CAR", 
                                "Congo, Dem. Rep." = "DRC",
                                "Equatorial Guinea" = "Eq. Guinea"))
(d) dat <- gapminder %>% filter(region == "Middle Africa") %>% 
    mutate(country_short = recode(country, 
                                      "Central African Republic" = "CAR", 
                                      "Congo, Dem. Rep." = "DRC",
                                      "Equatorial Guinea" = "Eq. Guinea"))
Answer: (d) This code properly recodes each country in a new column “country_short”.


## Instructions for Question 5 through8         
Import raw Brexit referendum polling data from Wikipedia:
library(rvest)
library(tidyverse)
library(stringr)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url) %>% html_nodes("table")
polls <- tab[[5]] %>% html_table(fill = TRUE)
You will use a variety of string processing techniques learned in this section to reformat these data.

##Q5:Some rows in this table do not contain polls.
You can identify these by the lack of the percent sign (%) in the Remain column.
##Q5:Update polls by changing the column names to
c("dates", "remain", "leave", "undecided", "lead", "samplesize", "pollster", "poll_type", "notes")
and only keeping rows that have a percent sign (%) in the remain column.
##Q5:How many rows remain in the polls data frame?
Answer: 129
Code: names(polls) <- c("dates", "remain", "leave", "undecided", "lead", "samplesize", "pollster", "poll_type", "notes")
      polls <- polls[str_detect(polls$remain, "%"), -9]
      nrow(polls)
      
##Q6:The remain and leave columns are both given in the format "48.1%": percentages out of 100% with a percent symbol.
##Q6:Which of these commands converts the remain vector to a proportion between 0 and 1?
##Q6:Check all correct answers.
(a) as.numeric(str_remove(polls$remain, "%"))
(b) as.numeric(polls$remain)/100
(c) parse_number(polls$remain)
(d) str_remove(polls$remain, "%")/100
(e) as.numeric(str_replace(polls$remain, "%", ""))/100
(f) parse_number(polls$remain)/100
Answer: (e) and (f)
      
##Q7:The undecided column has some "N/A" values. These "N/A"s are only present when the remain and
leave columns total 100%, so they should actually be zeros.
##Q7:Use a function from stringr to convert "N/A" in the undecided column to 0.
The format of your command should be function_name(polls$undecided, "arg1", "arg2").
##Q7:What function replaces function_name?
Answer: str_replace 
Code: str_replace or str_replace_all or str_replace() or str_replace_all()
##Q7:What argument replaces arg1? Omit the quotation marks.       
Answer: N/A
##Q7:What argument replaces arg2? Omit the quotation marks.
Answer: 0

##Q8:The dates column contains the range of dates over which the poll was conducted.
The format is "8-10 Jan" where the poll had a start date of 2016-01-08 and end date of 2016-01-10.
Some polls go across month boundaries (16 May-12 June).
##Q8:The end date of the poll will always be one or two digits, followed by a space,
followed by the month as one or more letters (either capital or lowercase).
In these data, all month abbreviations or names have 3, 4 or 5 letters.
##Q8:Write a regular expression to extract the end day and month from dates. Insert it into the skeleton code below:
temp <- str_extract_all(polls$dates, _____)
end_date <- sapply(temp, function(x) x[length(x)]) # take last element (handles polls that cross month boundaries)
##Q8:Which of the following regular expressions correctly extracts the end day and month when inserted into the blank in the code above?
##Q8:Check all correct answers.
(a) "\\d?\\s[a-zA-Z]?"
(b) "\\d+\\s[a-zA-Z]+"
(c) "\\d+\\s[A-Z]+"
(d) "[0-9]+\\s[a-zA-Z]+"
(e) "\\d{1,2}\\s[a-zA-Z]+"
(f) "\\d{1,2}[a-zA-Z]+"
(g) "\\d+\\s[a-zA-Z]{3,5}"
Answer: (b), (d), (e), and (g)

      

              
### Assessments on edX
### Section 4: Dates, Times, and Text Mining

Use the following libraries and options for coding questions:
library(dslabs)
library(lubridate)
options(digits = 3)    # 3 significant digits
IMPORTANT: Some of these exercises use dslabs datasets that were added in a July 2019 update.
Make sure your package is up to date with the command install.packages("dslabs").       
        
##Q1:Which of the following is the standard ISO 8601 format for dates?
(a) MM-DD-YY
(b) YYYY-MM-DD
(c) YYYYMMDD
(d) YY-MM-DD
Answer: (b) This is proper ISO 8601 formatting for dates.
Explanation: YYYY-MM-DD (year, month, day) is proper ISO 8601 formatting for dates.

##Q2:Which of the following commands could convert this string into the correct date format?
dates <- c("09-01-02", "01-12-07", "02-03-04")
(a) ymd(dates)
(b) mdy(dates)
(c) dmy(dates)
(d) It is impossible to know which format is correct without additional information.
Answer: (d) The formatting of these dates is ambiguous. They could be formatted as ymd, mdy or dmy.
We need more information about our data to be able to select the correct command.
        
##Q3: Load the brexit_polls data frame from dslabs:
data(brexit_polls)
##Q3: How many polls had a start date (startdate) in April (month number 4)?
Answer: 25
Code: sum(month(brexit_polls$startdate) == 4)
##Q3: Use the round_date() function on the enddate column with the argument unit="week".
How many polls ended the week of 2016-06-12?
##Q3: Read the documentation to learn more about round_date().
Answer: 13
Code: sum(round_date(brexit_polls$enddate, unit = "week") == "2016-06-12")
        
##Q4:Use the weekdays() function from lubridate to determine the weekday on which each poll ended (enddate).
##Q4:On which weekday did the greatest number of polls end?
(a)Monday; (b)Tuesday; (c)Wednesday; (d)Thursday; (e)Friday; (f)Saturday; (g)Sunday
Answer: (g)
Code: table(weekdays(brexit_polls$enddate))
       
##Q5:Load the movielens data frame from dslabs.
data(movielens)
##Q5:This data frame contains a set of about 100,000 movie reviews.
The timestamp column contains the review date as the number of seconds since 1970-01-01 (epoch time).
##Q5:Convert the timestamp column to dates using the lubridate as_datetime() function.
##Q5:Which year had the most movie reviews?
Answer: 2000
code: dates <- as_datetime(movielens$timestamp)
      reviews_by_year <- table(year(dates))    # count reviews by year
      names(which.max(reviews_by_year))    # name of year with most reviews
##Q5: Which hour of the day had the most movie reviews?
Answer: 20
code: reviews_by_hour <- table(hour(dates))    # count reviews by hour
      names(which.max(reviews_by_hour))    # name of hour with most reviews

      
##Introduction to Exercises 6 Through 12
Use these libraries and options:
library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)

#You can see the books and documents available in gutenbergr like this:
gutenberg_metadata

##Q6:Use str_detect() to find the ID of the novel Pride and Prejudice.
##Q6:How many different ID numbers are returned?
Answer: 6
Code: gutenberg_metadata %>%
      filter(str_detect(title, "Pride and Prejudice"))
        
##Q7:Notice that there are several versions of the book. The gutenberg_works() function
filters this table to remove replicates and include only English language works. Use this function to find the ID for Pride and Prejudice.
##Q7:What is the correct ID number?
##Q7:Read the gutenberg_works() documentation to learn how to use the function.
Answer: 1342
Code: gutenberg_works(title == "Pride and Prejudice")$gutenberg_id
        
##Q8:Use the gutenberg_download() function to download the text for Pride and Prejudice.
Use the tidytext package to create a tidy table with all the words in the text. Save this object as words.
##Q8:How many words are present in the book?
Answer: 122204
Code: book <- gutenberg_download(1342)
      words <- book %>% unnest_tokens(word, text)
      nrow(words)
        
##Q9:Remove stop words from the words object.
      Recall that stop words are defined in the stop_words data frame from the tidytext package.
##Q9:How many words remain?
Answer: 37246
Code: words <- words %>% anti_join(stop_words)
      nrow(words)
        
##Q10:After removing stop words, detect and then filter out any token that contains a digit from words.
##Q10:How many words remain?
Answer: 37180
Code: words <- words %>% filter(!str_detect(word, "\\d"))
      nrow(words)
        
##Q11:Analyze the most frequent words in the novel after removing stop words and tokens with digits.
##Q11:How many words appear more than 100 times in the book?
Answer: 23
Code: words %>% count(word) %>% filter(n > 100) %>% nrow() 
##Q11:What is the most common word in the book?
Answer: elizabeth
Code: words %>% count(word) %>% top_n(1, n) %>% pull(word)
##Q11:How many times does that most common word appear?
Answer: 597
Code: words %>% count(word) %>% top_n(1, n) %>% pull(n)
        
##Q12:Define the afinn lexicon:
afinn <- get_sentiments("afinn")
##Q12:Note that this command will trigger a question in the R Console asking if you want to download the AFINN lexicon.
Press 1 to select "Yes" (if using RStudio, enter this in the Console tab).
##Q12:Use this afinn lexicon to assign sentiment values to words.
Keep only words that are present in both words and the afinn lexicon. Save this data frame as afinn_sentiments.
##Q12:How many elements of words have sentiments in the afinn lexicon?
Answer: 6065
Code: afinn_sentiments <- inner_join(afinn, words)
      nrow(afinn_sentiments)
##Q12:What proportion of words in afinn_sentiments have a positive value?
Answer: 0.56
Code: mean(afinn_sentiments$value > 0)
##Q12:How many elements of afinn_sentiments have a value of 4?
Answer: 51
Code: sum(afinn_sentiments$value == 4)




### Assessments on edX
### Comprehensive Assessment: Puerto Rico Hurricane Mortality

##Q1:In the extdata directory of the dslabs package, you will find a PDF file containing
daily mortality data for Puerto Rico from Jan 1, 2015 to May 31, 2018. You can find the file like this:
fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package="dslabs")
##Q1: Find and open the file or open it directly from RStudio. On a Mac, you can type:
system2("open", args = fn)
##Q1:and on Windows, you can type:
system("cmd.exe", input = paste("start", fn))
##Q1:Which of the following best describes this file?
(a) It is a table. Extracting the data will be easy.
(b) It is a report written in prose. Extracting the data will be impossible.
(c) It is a report combining graphs and tables. Extracting the data seems possible.
(d) It shows graphs of the data. Extracting the data will be difficult.
Answer: (c)

##Q2:We are going to create a tidy dataset with each row representing one observation.
The variables in this dataset will be year, month, day and deaths.
##Q2:Use the pdftools package to read in fn using the pdf_text() function.
Store the results in an object called txt.
##Q2:Describe what you see in txt.
(a) A table with the mortality data.
(b) A character string of length 12. Each entry represents the text in each page. The mortality data is in there somewhere.
(c) A character string with one entry containing all the information in the PDF file.
(d) An html document.
Answer: (b)
Code: txt <- pdf_text(fn)

##Q3:Extract the ninth page of the PDF file from the object txt, then use the str_split() function
from the stringr package so that you have each line in a different entry. The new line character is \n. Call this string vector x.
##Q3:Look at x. What best describes what you see?
(a) It is an empty string.
(b) I can see the figure shown in page 1.
(c) It is a tidy table.
(d) I can see the table! But there is a bunch of other stuff we need to get rid of.
Answer: (d)
Code: x <- str_split(txt[9], "\n")
##Q3:What kind of object is x?
Answer: List
Code: class(x)
##Q3:How many entries does x have?
Answer: 1
Code: length(x)

##Q4:Define s to be the first entry of the x object.
##Q4:What kind of object is s?
Answer: character vector
Code: s <- x[[1]]
      class(s)
##Q4:How many entries does s have?
Answer: 40
Code: length(s)

##Q5:When inspecting the string we obtained above, we see a common problem: white space before and after the other characters.
Trimming is a common first step in string processing. These extra spaces will eventually make splitting the strings hard
so we start by removing them.
##Q5:We learned about the command str_trim() that removes spaces at the start or end of the strings.
Use this function to trim s and assign the result to s again.
##Q5:After trimming, what single character is the last character of element 1 of s?
##Q5:Your answer should be one character.
Answer: s
Code: s <- str_trim(s)
      s[1]    # print string, visually inspect last character

##Q6:We want to extract the numbers from the strings stored in s. However, there are a lot of non-numeric characters
that will get in the way. We can remove these, but before doing this we want to preserve the string
with the column header, which includes the month abbreviation.
##Q6:Use the str_which() function to find the row with the header. Save this result to header_index.
Hint: find the first string that matches the pattern "2015" using the str_which() function.
##Q6:What is the value of header_index?
Answer: 2
Code: header_index <- str_which(s, "2015")[1]
      header_index
      
##Q7:We want to extract two objects from the header row: month will store the month and header will store the column names.
##Q7:Save the content of the header row into an object called header,
then use str_split() to help define the two objects we need.
##Q7:What is the value of month?
##Q7:Use header_index to extract the row. The separator here is one or more spaces.
Also, consider using the simplify argument.
Answer: Sep
Code: tmp <- str_split(s[header_index], "\\s+", simplify = TRUE)
      month <- tmp[1]
      header <- tmp[-1]
      month 
##Q7:What is the third value in header?
Answer: 2017
Code: header[3]

##Q8:Notice that towards the end of the page defined by s you see a "Total" row followed
by rows with other summary statistics. Create an object called tail_index with the index of the "Total" entry.
##Q8:What is the value of tail_index?
Answer: 35
Code: tail_index  <- str_which(s, "Total")
      tail_index

##Q9:Because our PDF page includes graphs with numbers, some of our rows have just one number
      (from the y-axis of the plot). Use the str_count() function to create an object n with the count of numbers in each row.
##Q9:How many rows have a single number in them?
##Q9:You can write a regex for a number like this \\d+.
Answer: 2
Code: n <- str_count(s, "\\d+")
      sum(n == 1)

##Q10:We are now ready to remove entries from rows that we know we don't need.
The entry header_index and everything before it should be removed. Entries for which n is 1 should also be removed,
and the entry tail_index and everything that comes after it should be removed as well.
##Q10:How many entries remain in s?
Answer: 30
Code: out <- c(1:header_index, which(n==1), tail_index:length(s))
      s <- s[-out]
      length(s)
  
##Q11:Now we are ready to remove all text that is not a digit or space. Do this using regular expressions (regex)
and the str_remove_all() function.
##Q11:In regex, using the ^ inside the square brackets [] means not, like the ! means not in !=.
To define the regex pattern to catch all non-numbers, you can type [^\\d]. But remember you also want to keep spaces.
##Q11:Which of these commands produces the correct output?
(a)s <- str_remove_all(s, "[^\\d]")
(b)s <- str_remove_all(s, "[\\d\\s]")
(c)s <- str_remove_all(s, "[^\\d\\s]")
(d)s <- str_remove_all(s, "[\\d]")
Answer: (c)

##Q12:Use the str_split_fixed function to convert s into a data matrix with just the day and death count data:
s <- str_split_fixed(s, "\\s+", n = 6)[,1:5]
##Q12:Now you are almost ready to finish. Add column names to the matrix:
the first column should be day and the next columns should be the header. Convert all values to numeric.
Also, add a column with the month. Call the resulting object tab.
##Q12:What was the mean number of deaths per day in September 2015?
Answer: 75.26
Code: tab <- s %>% as_data_frame() %>% 
      setNames(c("day", header)) %>% mutate_all(as.numeric)
      mean(tab$"2015")
##Q12:What is the mean number of deaths per day in September 2016?
Answer: 79
Code: mean(tab$"2016")
##Q12:Hurricane María hit Puerto Rico on September 20, 2017. What was the mean number of deaths per day
from September 1-19, 2017, before the hurricane hit?
Answer: 83.73
Code: mean(tab$"2017"[1:19])
##Q12:What was the mean number of deaths per day from September 20-30, 2017, after the hurricane hit?
Answer: 121.5
Code: mean(tab$"2017"[20:30])

##Q13:Finish it up by changing tab to a tidy format, starting from this code outline:
tab <- tab %>% _____(year, deaths, -day) %>%
  mutate(deaths = as.numeric(deaths))
tab
##Q13:What code fills the blank to generate a data frame with columns named "day", "year" and "deaths"?
(a)separate; (b)unite; (c)gather; (d)spread
Answer: (c)

##Q14:Make a plot of deaths versus day with color to denote year. Exclude 2018 since we have no data.
Add a vertical line at day 20, the day that Hurricane María hit in 2017.
##Q14:Which of the following are TRUE? Check all correct answers.
(a)September 2015 and 2016 deaths by day are roughly equal to each other.
(b)The day with the most deaths was the day of the hurricane: September 20, 2017.
(c)After the hurricane in September 2017, there were over 100 deaths per day every day for the rest of the month.
(d)No days before September 20, 2017 have over 100 deaths per day.
Answer: (a), (c), and (d)
Code: tab %>% filter(year < 2018) %>% 
       ggplot(aes(day, deaths, color = year)) +
       geom_line() +
       geom_vline(xintercept = 20) +
       geom_point()

