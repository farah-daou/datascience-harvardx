####Program: Data Science by HarvardX
####Course 9: Capstone


###Assessments on edX
###Project Overview: MovieLens

You will use the following code to generate your datasets.
Develop your algorithm using the edx set.
For a final test of your final algorithm, predict movie ratings in the validation set (the final hold-out test set) as if they were unknown.
RMSE will be used to evaluate how close your predictions are to the true values in the validation set (the final hold-out test set).

Important: The validation data (the final hold-out test set) should NOT be used for training, developing, or selecting your algorithm and
it should ONLY be used for evaluating the RMSE of your final algorithm. You should split the edx data into separate training and test sets to design and test your algorithm.

Also remember that by accessing this site, you are agreeing to the terms of the edX Honor Code.
This means you are expected to submit your own work and can be removed from the course for substituting another student's work as your own.

Create train and validation sets
##########################################################
# Create edx set, validation set (final hold-out test set)
##########################################################

# Note: this process could take a couple of minutes

if(!require(tidyverse)) install.packages("tidyverse", repos = "http://cran.us.r-project.org")
if(!require(caret)) install.packages("caret", repos = "http://cran.us.r-project.org")
if(!require(data.table)) install.packages("data.table", repos = "http://cran.us.r-project.org")

library(tidyverse)
library(caret)
library(data.table)

# MovieLens 10M dataset:
# https://grouplens.org/datasets/movielens/10m/
# http://files.grouplens.org/datasets/movielens/ml-10m.zip

dl <- tempfile()
download.file("http://files.grouplens.org/datasets/movielens/ml-10m.zip", dl)

ratings <- fread(text = gsub("::", "\t", readLines(unzip(dl, "ml-10M100K/ratings.dat"))),
                 col.names = c("userId", "movieId", "rating", "timestamp"))

movies <- str_split_fixed(readLines(unzip(dl, "ml-10M100K/movies.dat")), "\\::", 3)
colnames(movies) <- c("movieId", "title", "genres")

# if using R 3.6 or earlier
movies <- as.data.frame(movies) %>% mutate(movieId = as.numeric(levels(movieId))[movieId],
                                            title = as.character(title),
                                            genres = as.character(genres))
# if using R 4.0 or later
movies <- as.data.frame(movies) %>% mutate(movieId = as.numeric(movieId),
                                            title = as.character(title),
                                            genres = as.character(genres))

movielens <- left_join(ratings, movies, by = "movieId")

# Validation set will be 10% of MovieLens data
set.seed(1, sample.kind="Rounding")
# if using R 3.5 or earlier, use `set.seed(1)` instead
test_index <- createDataPartition(y = movielens$rating, times = 1, p = 0.1, list = FALSE)
edx <- movielens[-test_index,]
temp <- movielens[test_index,]

# Make sure userId and movieId in validation set are also in edx set
validation <- temp %>% 
      semi_join(edx, by = "movieId") %>%
      semi_join(edx, by = "userId")

# Add rows removed from validation set back into edx set
removed <- anti_join(temp, validation)
edx <- rbind(edx, removed)

rm(dl, ratings, movies, test_index, temp, movielens, removed)


##Q1:How many rows and columns are there in the edx dataset?
Number of rows:9000055
Number of columns:6
Code:
dim(edx)

##Q2:
How many zeros were given as ratings in the edx dataset?
Answer:0
Code:
edx %>% filter(rating == 0) %>% tally()
How many threes were given as ratings in the edx dataset?
Answer:2121240
Code:
edx %>% filter(rating == 3) %>% tally()

##Q3:How many different movies are in the edx dataset?
Answer:10677
Code:
n_distinct(edx$movieId)

##Q4:How many different users are in the edx dataset?
Answer:69878
Code:
n_distinct(edx$userId)

##Q5:How many movie ratings are in each of the following genres in the edx dataset?
Drama:3910127
Comedy:3540930
Thriller:2325899
Romance:1712100
#Hint: Hint (1 of 1): One option is to use the str_detect function from the stringr package.
#The separate_rows function from the tidyr package can also be used, although it will be much slower.
Code:
# str_detect
genres = c("Drama", "Comedy", "Thriller", "Romance")
sapply(genres, function(g) {
    sum(str_detect(edx$genres, g))
})
          
# separate_rows, much slower!
edx %>% separate_rows(genres, sep = "\\|") %>%
    group_by(genres) %>%
    summarize(count = n()) %>%
    arrange(desc(count))

##Q6:Which movie has the greatest number of ratings?
Forrest Gump; Jurassic Park; Pulp Fiction; The Shawshank Redemption; Speed 2: Cruise Control
Answer:Pulp Fiction
Code:
edx %>% group_by(movieId, title) %>%
	summarize(count = n()) %>%
	arrange(desc(count))

##Q7:What are the five most given ratings in order from most to least?
(a)4, 3, 5, 3.5, 2
(b)3.5, 4.5, 1, 3, 5
(c)0.5, 5, 1, 4.5, 1.5
(d)5, 3, 1, 4.5, 3.5
(e)2, 3.5, 5, 3, 4
Answer:(a)
Code:
edx %>% group_by(rating) %>% summarize(count = n()) %>% top_n(5) %>%
	arrange(desc(count))

##Q8:True or False: In general, half star ratings are less common than whole star ratings
(e.g., there are fewer ratings of 3.5 than there are ratings of 3 or 4, etc.).
True; False
Answer:True
Code:
Numerically, this can be determined using this code:
edx %>% group_by(rating) %>% summarize(count = n())
Visually, this can be seen using the following code:
edx %>%
	group_by(rating) %>%
	summarize(count = n()) %>%
	ggplot(aes(x = rating, y = count)) +
	geom_line()
	
	