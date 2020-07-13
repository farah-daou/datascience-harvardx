####Program: Data Science by HarvardX
####Course 8: Machine Learning


###Assessments on edX
###Section 1: Introduction to Machine Learning 

##Q1:True or False: A key feature of machine learning is that the algorithms are built with data.
Answer:True
  
##Q2:True or False: In machine learning, we build algorithms that take feature values (X) and train a model
using known outcomes (Y) that is then used to predict outcomes when presented with features without known outcomes.
Answer:T




###Assessments on edX
###Section 2.1: Basics of Evaluating Machine Learning Algorithms

The following questions all ask you to work with the dataset described below.
The reported_heights and heights datasets were collected from three classes taught in the Departments of Computer Science and Biostatistics,
as well as remotely through the Extension School. The Biostatistics class was taught in 2016 along with an online version offered by the Extension School.
On 2016-01-25 at 8:15 AM, during one of the lectures, the instructors asked student to fill in the sex and height questionnaire that populated the reported_heights dataset.
The online students filled out the survey during the next few days, after the lecture was posted online.
We can use this insight to define a variable which we will call type, to denote the type of student, inclass or online.

The code below sets up the dataset for you to analyze in the following exercises:
  
library(dslabs)
library(dplyr)
library(lubridate)
data(reported_heights)

dat <- mutate(reported_heights, date_time = ymd_hms(time_stamp)) %>%
  filter(date_time >= make_date(2016, 01, 25) & date_time < make_date(2016, 02, 1)) %>%
  mutate(type = ifelse(day(date_time) == 25 & hour(date_time) == 8 & between(minute(date_time), 15, 30), "inclass","online")) %>%
  select(sex, type)

y <- factor(dat$sex, c("Female", "Male"))
x <- dat$type

Q1:The type column of dat indicates whether students took classes in person ("inclass") or online ("online").
What proportion of the inclass group is female? What proportion of the online group is female?
Enter your answer as a percentage or decimal (eg "50%" or "0.50") to at least the hundredths place.
Answer: In class=0.667 ; Online=0.378
Code: dat %>% group_by(type) %>% summarize(prop_female = mean(sex == "Female"))

Q2:In the course videos, height cutoffs were used to predict sex. Instead of using height, use the type variable to predict sex.
Use what you learned in Q1 to make an informed guess about sex based on the most prevalent sex for each type.
Report the accuracy of your prediction of sex. You do not need to split the data into training and test sets.
Enter your accuracy as a percentage or decimal (eg "50%" or "0.50") to at least the hundredths place.
Answer: 0.63
Code:
y_hat <- ifelse(x == "online", "Male", "Female") %>% 
  factor(levels = levels(y))
mean(y_hat==y)

Q3:Write a line of code using the table() function to show the confusion matrix between y_hat and y.
Use the exact format function(a, b) (note the spacing!) for your answer and do not name the columns and rows.
Type the line of code below:
Answer:table(y_hat, y)

Q4:What is the sensitivity of this prediction? You can use the sensitivity() function from the caret package.
Enter your answer as a percentage or decimal (eg "50%" or "0.50") to at least the hundredths place.
Answer:0.382
Code: library(caret)
sensitivity(y_hat, y)

Q5:What is the specificity of this prediction? You can use the specificity() function from the caret package.
Enter your answer as a percentage or decimal (eg "50%" or "0.50") to at least the hundredths place.
Answer:0.841
Code:library(caret)
specificity(y_hat, y)

Q6:What is the prevalence (% of females) in the dat dataset defined above?
Enter your answer as a percentage or decimal (eg "50%" or "0.50") to at least the hundredths place.
Answer:0.453
Code:mean(y == "Female")


We will practice building a machine learning algorithm using a new dataset, iris, that provides multiple predictors for us to use to train.
To start, we will remove the setosa species and we will focus on the versicolor and virginica iris species using the following code:
  
library(caret)
data(iris)
iris <- iris[-which(iris$Species=='setosa'),]
y <- iris$Species
The following questions all involve work with this dataset.

Q7:First let us create an even split of the data into train and test partitions using createDataPartition() from the caret package.
The code with a missing line is given below:
set.seed(2)    # if using R 3.6 or later, use set.seed(2, sample.kind="Rounding")
# line of code
test <- iris[test_index,]
train <- iris[-test_index,]
Which code should be used in place of # line of code above?
(a)test_index <- createDataPartition(y,times=1,p=0.5)
(b)test_index <- sample(2,length(y),replace=FALSE)
(c)test_index <- createDataPartition(y,times=1,p=0.5,list=FALSE)
(d)test_index <- rep(1,length(y))
Answer:(c)
Explanation: test_index <- createDataPartition(y,times=1,p=0.5,list=FALSE) is the best answer because the createDataPartition() function has a number of parameters
that allow the user to specify a test/training partition by the percentage of data that goes to training.
Indexes should be created on the outcome and not a predictor. See the associated help file.
Note: for this question, you may ignore any warning message generated by the code. If you have R 3.6 or later, you should always use the sample.kind argument in set.seed for this course.

Q8:Next we will figure out the singular feature in the dataset that yields the greatest overall accuracy when predicting species.
You can use the code from the introduction and from Q7 to start your analysis.
Using only the train iris dataset, for each feature, perform a simple search to find the cutoff that produces the highest accuracy,
predicting virginica if greater than the cutoff and versicolor otherwise. Use the seq function over the range of each feature by intervals of 0.1 for this search.
Which feature produces the highest accuracy?
(a)Sepal.Length; (b)Sepal.Width; (c)Petal.Length; (d)Petal.Width
Answer:(c)
Code:
foo <- function(x){
    rangedValues <- seq(range(x)[1],range(x)[2],by=0.1)
    sapply(rangedValues,function(i){
      y_hat <- ifelse(x>i,'virginica','versicolor')
      mean(y_hat==train$Species)
    })
  }
predictions <- apply(train[,-5],2,foo)
sapply(predictions,max)	

Q9:For the feature selected in Q8, use the smart cutoff value from the training data to calculate overall accuracy in the test data.
What is the overall accuracy?
Answer:0.90
Code:
predictions <- foo(train[,3])
rangedValues <- seq(range(train[,3])[1],range(train[,3])[2],by=0.1)
cutoffs <-rangedValues[which(predictions==max(predictions))]

y_hat <- ifelse(test[,3]>cutoffs[1],'virginica','versicolor')
mean(y_hat==test$Species)

Q10:Notice that we had an overall accuracy greater than 96% in the training data, but the overall accuracy was lower in the test data. This can happen often if we overtrain.
In fact, it could be the case that a single feature is not the best choice. For example, a combination of features might be optimal.
Using a single feature and optimizing the cutoff as we did on our training data can lead to overfitting.
Given that we know the test data, we can treat it like we did our training data to see if the same feature with a different cutoff will optimize our predictions.
Redo the analysis from Q8, this time using the test set.
Which feature best optimizes our overall accuracy?
(a)Sepal.Length; (b)Sepal.Width; (c)Petal.Length; (d)Petal.Width
Answer:(d)
Code:
foo <- function(x){
  rangedValues <- seq(range(x)[1],range(x)[2],by=0.1)
  sapply(rangedValues,function(i){
    y_hat <- ifelse(x>i,'virginica','versicolor')
    mean(y_hat==test$Species)
  })
}
predictions <- apply(test[,-5],2,foo)
sapply(predictions,max)

Q11:Now we will perform some exploratory data analysis on the data.
plot(iris,pch=21,bg=iris$Species)
Notice that Petal.Length and Petal.Width in combination could potentially be more information than either feature alone.
Optimize the the cutoffs for Petal.Length and Petal.Width separately in the train dataset by using the seq function with increments of 0.1.
Then, report the overall accuracy when applied to the test dataset by creating a rule that predicts virginica if Petal.Length is greater than the
length cutoff OR Petal.Width is greater than the width cutoff, and versicolor otherwise.
What is the overall accuracy for the test data now?
Answer:0.90
Code:
library(caret)
data(iris)
iris <- iris[-which(iris$Species=='setosa'),]
y <- iris$Species

plot(iris,pch=21,bg=iris$Species)

set.seed(2)
test_index <- createDataPartition(y,times=1,p=0.5,list=FALSE)
test <- iris[test_index,]
train <- iris[-test_index,]

petalLengthRange <- seq(range(train$Petal.Length)[1],range(train$Petal.Length)[2],by=0.1)
petalWidthRange <- seq(range(train$Petal.Width)[1],range(train$Petal.Width)[2],by=0.1)

length_predictions <- sapply(petalLengthRange,function(i){
  y_hat <- ifelse(train$Petal.Length>i,'virginica','versicolor')
  mean(y_hat==train$Species)
})
length_cutoff <- petalLengthRange[which.max(length_predictions)] # 4.7

width_predictions <- sapply(petalWidthRange,function(i){
  y_hat <- ifelse(train$Petal.Width>i,'virginica','versicolor')
  mean(y_hat==train$Species)
})
width_cutoff <- petalWidthRange[which.max(width_predictions)] # 1.5

y_hat <- ifelse(test$Petal.Length>length_cutoff | test$Petal.Width>width_cutoff,'virginica','versicolor')
mean(y_hat==test$Species)


###Assessments on edX
###Section 2.2: Conditional Probabilities

Q1:In a previous module, we covered Bayes' theorem and the Bayesian paradigm.
Conditional probabilities are a fundamental part of this previous covered rule.
P(A|B)=P(B|A) x P(A)/P(B) 
We first review a simple example to go over conditional probabilities.

Assume a patient comes into the doctor’s office to test whether they have a particular disease.
The test is positive 85% of the time when tested on a patient with the disease (high sensitivity):  P(test+|disease)=0.85 
The test is negative 90% of the time when tested on a healthy patient (high specificity):  P(test−|heathy)=0.90 
The disease is prevalent in about 2% of the community:  P(disease)=0.02 
Using Bayes' theorem, calculate the probability that you have the disease if the test is positive.
Enter your answer as a percentage or decimal (eg "50%" or "0.50").
Answer:0.1478261
Explanation: 0.85x0.02 / (0.85x0.02)+(0.1x0.98) = 0.1478261

The following 4 questions (Q2-Q5) all relate to implementing this calculation using R.

We have a hypothetical population of 1 million individuals with the following conditional probabilities as described below:
  
The test is positive 85% of the time when tested on a patient with the disease (high sensitivity):  P(test+|disease)=0.85 
The test is negative 90% of the time when tested on a healthy patient (high specificity):  P(test−|heathy)=0.90 
The disease is prevalent in about 2% of the community:  P(disease)=0.02 
Here is some sample code to get you started:
  
set.seed(1) # set.seed(1, sample.kind="Rounding") if using R 3.6 or later
disease <- sample(c(0,1), size=1e6, replace=TRUE, prob=c(0.98,0.02))
test <- rep(NA, 1e6)
test[disease==0] <- sample(c(0,1), size=sum(disease==0), replace=TRUE, prob=c(0.90,0.10))
test[disease==1] <- sample(c(0,1), size=sum(disease==1), replace=TRUE, prob=c(0.15, 0.85))

Q2:What is the probability that a test is positive?
Answer:0.114509
Code:mean(test)

Q3:What is the probability that an individual has the disease if the test is negative?
Answer:0.003461356
Code:mean(disease[test==0])

Q4:What is the probability that you have the disease if the test is positive?
Remember: calculate the conditional probability the disease is positive assuming a positive test.
Answer:0.1471762
Code:mean(disease[test==1]==1)

Q5:Compare the prevalence of disease in people who test positive to the overall prevalence of disease.
If a patient's test is positive, how much does that increase their risk of having the disease?
First calculate the probability of having the disease given a positive test, then divide by the probability of having the disease.
Answer:7.389106
Code:mean(disease[test==1]==1)/mean(disease==1)

Q6:We are now going to write code to compute conditional probabilities for being male in the heights dataset.
Round the heights to the closest inch. Plot the estimated conditional probability  P(x)=Pr(Male|height=x)  for each  x .
Part of the code is provided here:
library(dslabs)
data("heights")
# MISSING CODE
qplot(height, p, data =.)
Which of the following blocks of code can be used to replace # MISSING CODE to make the correct plot?
(a)heights %>% 
	group_by(height) %>%
	summarize(p = mean(sex == "Male")) %>%
(b)heights %>% 
	mutate(height = round(height)) %>%
	group_by(height) %>%
	summarize(p = mean(sex == "Female")) %>%
(c)heights %>% 
	mutate(height = round(height)) %>%
	summarize(p = mean(sex == "Male")) %>%
(d)heights %>% 
	mutate(height = round(height)) %>%
	group_by(height) %>%
	summarize(p = mean(sex == "Male")) %>%
Answer:(d)

Q7:In the plot we just made in Q6 we see high variability for low values of height.
This is because we have few data points. This time use the quantile  0.1,0.2,…,0.9  and the cut() function
to assure each group has the same number of points. Note that for any numeric vector x, you can create groups 
based on quantiles like this: cut(x, quantile(x, seq(0, 1, 0.1)), include.lowest = TRUE).
Part of the code is provided here:
ps <- seq(0, 1, 0.1)
heights %>% 
	# MISSING CODE
	group_by(g) %>%
	summarize(p = mean(sex == "Male"), height = mean(height)) %>%
	qplot(height, p, data =.)
Which of the following lines of code can be used to replace # MISSING CODE to make the correct plot?
(a)mutate(g = cut(male, quantile(height, ps), include.lowest = TRUE)) %>%
(b)mutate(g = cut(height, quantile(height, ps), include.lowest = TRUE)) %>%
(c)mutate(g = cut(female, quantile(height, ps), include.lowest = TRUE)) %>%
(d)mutate(g = cut(height, quantile(height, ps))) %>%
Answer:(b)

Q8:You can generate data from a bivariate normal distrubution using the MASS package using the following code:
Sigma <- 9*matrix(c(1,0.5,0.5,1), 2, 2)
dat <- MASS::mvrnorm(n = 10000, c(69, 69), Sigma) %>%
	data.frame() %>% setNames(c("x", "y"))
And you can make a quick plot using plot(dat).

Using an approach similar to that used in the previous exercise, let's estimate the conditional expectations and make a plot.
Part of the code has again been provided for you:
  
ps <- seq(0, 1, 0.1)
dat %>% 
# MISSING CODE
qplot(x, y, data =.)
Which of the following blocks of code can be used to replace # MISSING CODE to make the correct plot?
(a)mutate(g = cut(x, quantile(x, ps), include.lowest = TRUE)) %>%
  group_by(g) %>%
  summarize(y = mean(y), x = mean(x)) %>%
(b)mutate(g = cut(x, quantile(x, ps))) %>%
  group_by(g) %>%
  summarize(y = mean(y), x = mean(x)) %>%
(c)mutate(g = cut(x, quantile(x, ps), include.lowest = TRUE)) %>%
  summarize(y = mean(y), x = mean(x)) %>%
(d)mutate(g = cut(x, quantile(x, ps), include.lowest = TRUE)) %>%
  group_by(g) %>%
  summarize(y =(y), x =(x)) %>%
Answer:(a)




###Assessments on edX
###Section 3.1:

Q1
Answer
Code

Q2
Answer
Code

Q3
Answer
Code

Q4
Answer
Code

Q5
Answer
Code

Q6
Answer
Code

Q7
Answer
Code

Q8
Answer
Code