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
###Section 2.1: Basics of Evaluating Machine Learning Algorithms (Part A)

##Q1:For each of the following, indicate whether the outcome is continuous or categorical.
Answer: Digit reader=categorical; Height=continuous; Spam filter=categorical;
Stock prices=continuous; Sex=categorical
  
##Q2:How many features are available to us for prediction in the mnist digits dataset?
You can download the mnist dataset using the read_mnist() function from the dslabs package.
Answer:784
Explanation: One way to figure out the number of features available for prediction is to download mnist and then use the ncol function, like this:
mnist <- read_mnist()
ncol(mnist$train$images)


###Assessments on edX
###Section 2.1: Basics of Evaluating Machine Learning Algorithms (Part B)

The following questions all ask you to work with the dataset described below.
The reported_heights and heights datasets were collected from three classes taught in the Departments of Computer Science and Biostatistics,
as well as remotely through the Extension School. The Biostatistics class was taught in 2016 along with an online version offered by the Extension School.
On 2016-01-25 at 8:15 AM, during one of the lectures, the instructors asked student to fill in
the sex and height questionnaire that populated the reported_heights dataset.
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

##Q1:The type column of dat indicates whether students took classes in person ("inclass") or online ("online").
What proportion of the inclass group is female? What proportion of the online group is female?
Enter your answer as a percentage or decimal (eg "50%" or "0.50") to at least the hundredths place.
Answer: In class=0.667 ; Online=0.378
Code: dat %>% group_by(type) %>% summarize(prop_female = mean(sex == "Female"))

##Q2:In the course videos, height cutoffs were used to predict sex. Instead of using height, use the type variable to predict sex.
Use what you learned in Q1 to make an informed guess about sex based on the most prevalent sex for each type.
Report the accuracy of your prediction of sex. You do not need to split the data into training and test sets.
Enter your accuracy as a percentage or decimal (eg "50%" or "0.50") to at least the hundredths place.
Answer: 0.63
Code:
y_hat <- ifelse(x == "online", "Male", "Female") %>% 
  factor(levels = levels(y))
mean(y_hat==y)

##Q3:Write a line of code using the table() function to show the confusion matrix between y_hat and y.
Use the exact format function(a, b) (note the spacing!) for your answer and do not name the columns and rows.
Type the line of code below:
Answer:table(y_hat, y)

##Q4:What is the sensitivity of this prediction? You can use the sensitivity() function from the caret package.
Enter your answer as a percentage or decimal (eg "50%" or "0.50") to at least the hundredths place.
Answer:0.382
Code: library(caret)
sensitivity(y_hat, y)

##Q5:What is the specificity of this prediction? You can use the specificity() function from the caret package.
Enter your answer as a percentage or decimal (eg "50%" or "0.50") to at least the hundredths place.
Answer:0.841
Code:library(caret)
specificity(y_hat, y)

##Q6:What is the prevalence (% of females) in the dat dataset defined above?
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

##Q7:First let us create an even split of the data into train and test partitions using createDataPartition() from the caret package.
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
Note: for this question, you may ignore any warning message generated by the code. If you have R 3.6 or later,
you should always use the sample.kind argument in set.seed for this course.

##Q8:Next we will figure out the singular feature in the dataset that yields the greatest overall accuracy when predicting species.
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

##My Code: I created a separated code for every feature and got the max accuracy (example below)
accuracy_1 <- map_dbl(cutoff, function(x){
+ y_hat <- ifelse(train$Sepal.Length > x,"virginica","versicolor")
+  mean(y_hat==train$Species)
+ })
max(accuracy_1)

##Q9:For the feature selected in Q8, use the smart cutoff value from the training data to calculate overall accuracy in the test data.
What is the overall accuracy?
Answer:0.90
Code:
predictions <- foo(train[,3])
rangedValues <- seq(range(train[,3])[1],range(train[,3])[2],by=0.1)
cutoffs <-rangedValues[which(predictions==max(predictions))]

y_hat <- ifelse(test[,3]>cutoffs[1],'virginica','versicolor')
mean(y_hat==test$Species)

##Q10:Notice that we had an overall accuracy greater than 96% in the training data, but the overall accuracy was lower in the test data.
This can happen often if we overtrain.
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

##Q11:Now we will perform some exploratory data analysis on the data.
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

##Q1:In a previous module, we covered Bayes' theorem and the Bayesian paradigm.
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
  
set.seed(1, sample.kind="Rounding")
disease <- sample(c(0,1), size=1e6, replace=TRUE, prob=c(0.98,0.02))
test <- rep(NA, 1e6)
test[disease==0] <- sample(c(0,1), size=sum(disease==0), replace=TRUE, prob=c(0.90,0.10))
test[disease==1] <- sample(c(0,1), size=sum(disease==1), replace=TRUE, prob=c(0.15, 0.85))

##Q2:What is the probability that a test is positive?
Answer:0.114509
Code:mean(test)

##Q3:What is the probability that an individual has the disease if the test is negative?
Answer:0.003461356
Code:mean(disease[test==0])

##Q4:What is the probability that you have the disease if the test is positive?
Remember: calculate the conditional probability the disease is positive assuming a positive test.
Answer:0.1471762
Code:mean(disease[test==1]==1) OR mean(disease[test==1])

##Q5:Compare the prevalence of disease in people who test positive to the overall prevalence of disease.
If a patient's test is positive, how much does that increase their risk of having the disease?
First calculate the probability of having the disease given a positive test, then divide by the probability of having the disease.
Answer:7.389106
Code:mean(disease[test==1]==1)/mean(disease==1)

##Q6:We are now going to write code to compute conditional probabilities for being male in the heights dataset.
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

##Q7:In the plot we just made in Q6 we see high variability for low values of height.
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

##Q8:You can generate data from a bivariate normal distrubution using the MASS package using the following code:
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
###Section 3.1: Linear Regression for Prediction (Part 1)

##Q1:Create a data set using the following code:
set.seed(1, sample.kind="Rounding")
n <- 100
Sigma <- 9*matrix(c(1.0, 0.5, 0.5, 1.0), 2, 2)
dat <- MASS::mvrnorm(n = 100, c(69, 69), Sigma) %>%
      data.frame() %>% setNames(c("x", "y"))
We will build 100 linear models using the data above and calculate the mean and standard deviation of the combined models.
First, set the seed to 1 again (make sure to use sample.kind="Rounding" if your R is version 3.6 or later).
Then, within a replicate() loop, (1) partition the dataset into test and training sets with p=0.5 and
using dat$y to generate your indices, (2) train a linear model predicting y from x,
(3) generate predictions on the test set, and (4) calculate the RMSE of that model.
Then, report the mean and standard deviation (SD) of the RMSEs from all 100 models.
Report all answers to at least 3 decimal places.
Answer: Mean=2.49 ; SD=0.124
Code:
set.seed(1, sample.kind="Rounding")
rmse <- replicate(100, {
	test_index <- createDataPartition(dat$y, times = 1, p = 0.5, list = FALSE)
	train_set <- dat %>% slice(-test_index)
	test_set <- dat %>% slice(test_index)
	fit <- lm(y ~ x, data = train_set)
 	y_hat <- predict(fit, newdata = test_set)
	sqrt(mean((y_hat-test_set$y)^2))
})

mean(rmse)
sd(rmse)

##Q2:Now we will repeat the exercise above but using larger datasets.
Write a function that takes a size n, then (1) builds a dataset using the code provided at the top of Q1
but with n observations instead of 100 and without the set.seed(1,sample.kind="Rounding"),
(2) runs the replicate() loop that you wrote to answer Q1, which builds 100 linear models and returns a vector of RMSEs,
and (3) calculates the mean and standard deviation of the 100 RMSEs.
Set the seed to 1 (if using R 3.6 or later, use the argument sample.kind="Rounding") and then use sapply() or map()
to apply your new function to n <- c(100, 500, 1000, 5000, 10000).
You only need to set the seed once before running your function; do not set a seed within your function.
Also be sure to use sapply() or map() as you will get different answers running the simulations individually due to setting the seed.
Answer: Mean,100=2.498 ; SD,100=0.118 ; Mean,500=2.72 ; SD,500=0.08 ; 
Mean,1000=2.5555 : SD,1000=0.0456 ; Mean,5000=2.6248 ; SD,5000=0.0231 ;
Mean,10000=2.6184 ; SD,10000=0.0169
Code:
set.seed(1, sample.kind="Rounding")
n <- c(100, 500, 1000, 5000, 10000)
res <- sapply(n, function(n){
	Sigma <- 9*matrix(c(1.0, 0.5, 0.5, 1.0), 2, 2)
	dat <- MASS::mvrnorm(n, c(69, 69), Sigma) %>%
		data.frame() %>% setNames(c("x", "y"))
	rmse <- replicate(100, {
		test_index <- createDataPartition(dat$y, times = 1, p = 0.5, list = FALSE)
		train_set <- dat %>% slice(-test_index)
		test_set <- dat %>% slice(test_index)
		fit <- lm(y ~ x, data = train_set)
		y_hat <- predict(fit, newdata = test_set)
		sqrt(mean((y_hat-test_set$y)^2))
	})
	c(avg = mean(rmse), sd = sd(rmse))
})

res

##Q3:What happens to the RMSE as the size of the dataset becomes larger?
(a)On average, the RMSE does not change much as n gets larger, but the variability of the RMSE decreases.
(b)Because of the law of large numbers the RMSE decreases; more data means more precise estimates.
(c)n = 10000 is not sufficiently large. To see a decrease in the RMSE we would need to make it larger.
(d)The RMSE is not a random variable.
Answer:(a)

##Q4:Now repeat the exercise from Q1, this time making the correlation between x and y larger, as in the following code:
set.seed(1, sample.kind="Rounding")
n <- 100
Sigma <- 9*matrix(c(1.0, 0.95, 0.95, 1.0), 2, 2)
dat <- MASS::mvrnorm(n = 100, c(69, 69), Sigma) %>%
	data.frame() %>% setNames(c("x", "y"))
Note what happens to RMSE - set the seed to 1 as before.
Answer: Mean=0.91 ; SD=0.0624
Code:
set.seed(1, sample.kind="Rounding")
rmse <- replicate(100, {
	test_index <- createDataPartition(dat$y, times = 1, p = 0.5, list = FALSE)
	train_set <- dat %>% slice(-test_index)
	test_set <- dat %>% slice(test_index)
	fit <- lm(y ~ x, data = train_set)
 	y_hat <- predict(fit, newdata = test_set)
	sqrt(mean((y_hat-test_set$y)^2))
})

mean(rmse)
sd(rmse)

##Q5:Which of the following best explains why the RMSE in question 4 is so much lower than the RMSE in question 1?
(a)It is just luck. If we do it again, it will be larger.
(b)The central limit theorem tells us that the RMSE is normal.
(c)When we increase the correlation between x and y, x has more predictive power and thus provides a better estimate of y.
(d)These are both examples of regression so the RMSE has to be the same.
Answer:(c)
Explanation: The correlation between x and y has a much bigger effect on RMSE than n.
Large n simply provides us with more precise estimates of the linear model coefficients.

##Q6:Create a data set using the following code.
set.seed(1, sample.kind="Rounding")
Sigma <- matrix(c(1.0, 0.75, 0.75, 0.75, 1.0, 0.25, 0.75, 0.25, 1.0), 3, 3)
dat <- MASS::mvrnorm(n = 100, c(0, 0, 0), Sigma) %>%
	data.frame() %>% setNames(c("y", "x_1", "x_2"))
Note that y is correlated with both x_1 and x_2 but the two predictors are independent of each other, as seen by cor(dat).
Set the seed to 1, then use the caret package to partition into a test and training set of equal size.
Compare the RMSE when using just x_1, just x_2 and both x_1 and x_2. Train a single linear model for each (not 100 like in the previous questions).

Which of the three models performs the best (has the lowest RMSE)?
(a)x_1
(b)x_2
(c)x_1 and x_2
Answer:(c)
Explanation:The linear model with both predictors performs the best, as seen using the following code:
set.seed(1, sample.kind="Rounding")
test_index <- createDataPartition(dat$y, times = 1, p = 0.5, list = FALSE)
train_set <- dat %>% slice(-test_index)
test_set <- dat %>% slice(test_index)

fit <- lm(y ~ x_1, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))

fit <- lm(y ~ x_2, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))

fit <- lm(y ~ x_1 + x_2, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))

##Q7:Report the lowest RMSE of the three models tested in Q6.
Answer: 0.307
Explanation:The lowest RMSE is for the model that includes x_1 and x_2 as predictors.

##Q8:Repeat the exercise from Q6 but now create an example in which x_1 and x_2 are highly correlated.
set.seed(1, sample.kind="Rounding")
Sigma <- matrix(c(1.0, 0.75, 0.75, 0.75, 1.0, 0.95, 0.75, 0.95, 1.0), 3, 3)
dat <- MASS::mvrnorm(n = 100, c(0, 0, 0), Sigma) %>%
	data.frame() %>% setNames(c("y", "x_1", "x_2"))
Set the seed to 1, then use the caret package to partition into a test and training set of equal size.
Compare the RMSE when using just x_1, just x_2, and both x_1 and x_2.
Compare the results from Q6 and Q8. What can you conclude?
(a)Unless we include all predictors we have no predictive power.
(b)Adding extra predictors improves RMSE regardless of whether the added predictors are correlated with other predictors or not.
(c)Adding extra predictors results in over fitting.
(d)Adding extra predictors can improve RMSE substantially, but not when the added predictors are highly correlated with other predictors.
Answer:(d)
Explanation:
The following code will allow you to repeat the exercise in Q6 with predictors that are highly correlated:
set.seed(1, sample.kind="Rounding")
test_index <- createDataPartition(dat$y, times = 1, p = 0.5, list = FALSE)
train_set <- dat %>% slice(-test_index)
test_set <- dat %>% slice(test_index)

fit <- lm(y ~ x_1, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))

fit <- lm(y ~ x_2, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))

fit <- lm(y ~ x_1 + x_2, data = train_set)
y_hat <- predict(fit, newdata = test_set)
sqrt(mean((y_hat-test_set$y)^2))
When the predictors are highly correlated with each other,
adding addtional predictors does not improve the model substantially, thus RMSE stays roughly the same.


###Assessments on edX
###Section 3.1: Linear Regression for Prediction (Part 2)

##Q1:Define a dataset using the following code:

set.seed(2, sample.kind="Rounding")
make_data <- function(n = 1000, p = 0.5, 
				mu_0 = 0, mu_1 = 2, 
				sigma_0 = 1,  sigma_1 = 1){

y <- rbinom(n, 1, p)
f_0 <- rnorm(n, mu_0, sigma_0)
f_1 <- rnorm(n, mu_1, sigma_1)
x <- ifelse(y == 1, f_1, f_0)
  
test_index <- createDataPartition(y, times = 1, p = 0.5, list = FALSE)

list(train = data.frame(x = x, y = as.factor(y)) %>% slice(-test_index),
	test = data.frame(x = x, y = as.factor(y)) %>% slice(test_index))
}
dat <- make_data()
Note that we have defined a variable x that is predictive of a binary outcome y: dat$train %>% ggplot(aes(x, color = y)) + geom_density().

Set the seed to 1, then use the make_data() function defined above to generate 25 different datasets with mu_1 <- seq(0, 3, len=25).
Perform logistic regression on each of the 25 different datasets (predict 1 if p>0.5) and plot accuracy (res in the figures) vs mu_1 (delta in the figures).”

Which is the correct plot?
Answer:(a)
Explanation:
The correct plot can be generated using the following code:
set.seed(1, sample.kind="Rounding") #if you are using R 3.6 or later
delta <- seq(0, 3, len = 25)
res <- sapply(delta, function(d){
	dat <- make_data(mu_1 = d)
	fit_glm <- dat$train %>% glm(y ~ x, family = "binomial", data = .)
	y_hat_glm <- ifelse(predict(fit_glm, dat$test) > 0.5, 1, 0) %>% factor(levels = c(0, 1))
	mean(y_hat_glm == dat$test$y)
})
qplot(delta, res)


###Assessments on edX
###Section 3.2: Smoothing

##Q1:In the Wrangling course of this series, PH125.6x, we used the following code to obtain mortality counts for Puerto Rico for 2015-2018:
library(tidyverse)
library(lubridate)
library(purrr)
library(pdftools)
    
fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package="dslabs")
dat <- map_df(str_split(pdf_text(fn), "\n"), function(s){
	s <- str_trim(s)
	header_index <- str_which(s, "2015")[1]
	tmp <- str_split(s[header_index], "\\s+", simplify = TRUE)
	month <- tmp[1]
	header <- tmp[-1]
	tail_index  <- str_which(s, "Total")
	n <- str_count(s, "\\d+")
	out <- c(1:header_index, which(n==1), which(n>=28), tail_index:length(s))
	s[-out] %>%
		str_remove_all("[^\\d\\s]") %>%
		str_trim() %>%
		str_split_fixed("\\s+", n = 6) %>%
		.[,1:5] %>%
		as_data_frame() %>% 
		setNames(c("day", header)) %>%
		mutate(month = month,
			day = as.numeric(day)) %>%
		gather(year, deaths, -c(day, month)) %>%
		mutate(deaths = as.numeric(deaths))
}) %>%
	mutate(month = recode(month, "JAN" = 1, "FEB" = 2, "MAR" = 3, "APR" = 4, "MAY" = 5, "JUN" = 6, 
                          "JUL" = 7, "AGO" = 8, "SEP" = 9, "OCT" = 10, "NOV" = 11, "DEC" = 12)) %>%
	mutate(date = make_date(year, month, day)) %>%
        filter(date <= "2018-05-01")
Use the loess() function to obtain a smooth estimate of the expected number of deaths as a function of date.
Plot this resulting smooth function. Make the span about two months long.

Which of the following plots is correct?
Answer:(a)
Explanation:The following code makes the correct plot:
span <- 60 / as.numeric(diff(range(dat$date)))
fit <- dat %>% mutate(x = as.numeric(date)) %>% loess(deaths ~ x, data = ., span = span, degree = 1)
dat %>% mutate(smooth = predict(fit, as.numeric(date))) %>%
	ggplot() +
	geom_point(aes(date, deaths)) +
	geom_line(aes(date, smooth), lwd = 2, col = "red")
The second plot uses a shorter span, the third plot uses the entire timespan, and the fourth plot uses a longer span.

##Q2:Work with the same data as in Q1 to plot smooth estimates against day of the year, all on the same plot, but with different colors for each year.
Which code produces the desired plot?
(a)dat %>% 
    mutate(smooth = predict(fit), day = yday(date), year = as.character(year(date))) %>%
    ggplot(aes(day, smooth, col = year)) +
    geom_line(lwd = 2)
(b)dat %>% 
    mutate(smooth = predict(fit, as.numeric(date)), day = mday(date), year = as.character(year(date))) %>%
    ggplot(aes(day, smooth, col = year)) +
    geom_line(lwd = 2)
(c)dat %>% 
    mutate(smooth = predict(fit, as.numeric(date)), day = yday(date), year = as.character(year(date))) %>%
    ggplot(aes(day, smooth)) +
    geom_line(lwd = 2)
(d)dat %>% 
    mutate(smooth = predict(fit, as.numeric(date)), day = yday(date), year = as.character(year(date))) %>%
    ggplot(aes(day, smooth, col = year)) +
    geom_line(lwd = 2)
Answer:(d)

##Q3:Suppose we want to predict 2s and 7s in the mnist_27 dataset with just the second covariate.
Can we do this? On first inspection it appears the data does not have much predictive power.
In fact, if we fit a regular logistic regression the coefficient for x_2 is not significant!
This can be seen using this code:
library(broom)
library(dslabs)
data(mnist_27)
mnist_27$train %>% glm(y ~ x_2, family = "binomial", data = .) %>% tidy()
Plotting a scatterplot here is not useful since y is binary:
qplot(x_2, y, data = mnist_27$train)
Fit a loess line to the data above and plot the results. What do you observe?
(a)There is no predictive power and the conditional probability is linear.
(b)There is no predictive power and the conditional probability is non-linear.
(c)There is predictive power and the conditional probability is linear.
(d)There is predictive power and the conditional probability is non-linear.
Answer:(d)
Explanation:Note that there is indeed predictive power, but that the conditional probability is non-linear.
The loess line can be plotted using the following code:
mnist_27$train %>% 
	mutate(y = ifelse(y=="7", 1, 0)) %>%
	ggplot(aes(x_2, y)) + 
	geom_smooth(method = "loess")


###Assessments on edX
###Section 3.3: Working with Matrices

##Q1:Which line of code correctly creates a 100 by 10 matrix of randomly generated normal numbers and assigns it to x?
(a)x <- matrix(rnorm(1000), 100, 100)
(b)x <- matrix(rnorm(100*10), 100, 10)
(c)x <- matrix(rnorm(100*10), 10, 10)
(d)x <- matrix(rnorm(100*10), 10, 100)
Answer:(b)

##Q2:Write the line of code that would give you the specified information about the matrix x that you generated in q1. Do not include any spaces in your line of code.
Answer:Dimension of x=dim(x) ; 
Number of rows of x=nrow(x) or dim(x)[1] or length(x[,1]) ; 
Number of columns of x=ncol(x) or dim(x)[2] or length(x[1,])

##Q3:Which of the following lines of code would add the scalar 1 to row 1, the scalar 2 to row 2, and so on, for the matrix x?
Select ALL that apply.
(a)x <- x + seq(nrow(x))
(b)x <- 1:nrow(x)
(c)x <- sweep(x, 2, 1:nrow(x),"+")
(d)x <- sweep(x, 1, 1:nrow(x),"+")
Answer:(a) and (d)

##Q4:Which of the following lines of code would add the scalar 1 to column 1, the scalar 2 to column 2, and so on, for the matrix x?
Select ALL that apply.
(a)x <- 1:ncol(x)
(b)x <- 1:col(x)
(c)x <- sweep(x, 2, 1:ncol(x), FUN = "+")
(d)x <- -x
Answer:(c)

##Q5:Which code correctly computes the average of each row of x?
(a)mean(x); (b)rowMedians(x); (c)sapply(x,mean); (d)rowSums(x); (e)rowMeans(x)
Answer:(e)
Which code correctly computes the average of each column of x?
(a)mean(x); (b)sapply(x,mean); (c)colMeans(x); (d)colMedians(x); (e)colSums
Answer:(c)

##Q6:For each observation in the mnist training data,
compute the proportion of pixels that are in the grey area, defined as values between 50 and 205 (but not including 50 and 205).
(To visualize this, you can make a boxplot by digit class.)
What proportion of the 60000*784 pixels in the mnist training data are in the grey area overall, defined as values between 50 and 205?
Answer:0.0618
Explanation:The matrix and plot can be calculated using the following code:
mnist <- read_mnist()
y <- rowMeans(mnist$train$images>50 & mnist$train$images<205)
qplot(as.factor(mnist$train$labels), y, geom = "boxplot")
The proportion of pixels can be calculated using mean(y).




###Assessments on edX
###Section 4.1: Nearest Neighbors (Part 1) 

##Q1:Load the following dataset:
library(dslabs)
data(tissue_gene_expression)
This dataset includes a matrix x:
dim(tissue_gene_expression$x)
This matrix has the gene expression levels of 500 genes from 189 biological samples representing seven different tissues.
The tissue type is stored in y:
table(tissue_gene_expression$y)
Which of the following lines of code computes the Euclidean distance between each observation and stores it in the object d?
(a)d <- dist(tissue_gene_expression$x, distance='maximum')
(b)d <- dist(tissue_gene_expression)
(c)d <- dist(tissue_gene_expression$x)
(d)d <- cor(tissue_gene_expression$x)
Answer:(c)

##Q2:Using the dataset from Q1, compare the distances between observations 1 and 2 (both cerebellum),
observations 39 and 40 (both colon), and observations 73 and 74 (both endometrium).
Distance-wise, are samples from tissues of the same type closer to each other?
(a)No, the samples from the same tissue type are not necessarily closer.
(b)The two colon samples are closest to each other, but the samples from the other two tissues are not.
(c)The two cerebellum samples are closest to each other, but the samples from the other two tissues are not.
(d)Yes, the samples from the same tissue type are closest to each other.
Answer:(d)
Explanation:You can calculate the distances using the following code:
ind <- c(1, 2, 39, 40, 73, 74)
as.matrix(d)[ind,ind]

##Q3:Make a plot of all the distances using the image() function to see if the pattern you observed in Q2 is general.
Which code would correctly make the desired plot?
(s)image(d) ; (b)image(as.matrix(d)) ; (c)d ; (d)image()
Answer:(b)


###Assessments on edX
###Section 4.1: Nearest Neighbors (Part 2)

##Q1:Previously, we used logistic regression to predict sex based on height.
Now we are going to use knn to do the same. Set the seed to 1, then use the caret package to partition the
dslabs heights data into a training and test set of equal size.
Use the sapply() or map function to perform knn with k values of seq(1, 101, 3) and
calculate F1 scores with the F_meas() function using the default value of the relevant argument.
What is the max value of F_1?
Answer: 0.60194
At what value of k does the max occur?
If there are multiple values of k with the maximum value, report the smallest such k.
Answer: 46
Code:
library(dslabs)
library(tidyverse)
library(caret)
data("heights")

set.seed(1, sample.kind="Rounding")
test_index <- createDataPartition(heights$sex, times = 1, p = 0.5, list = FALSE)
test_set <- heights[test_index, ]
train_set <- heights[-test_index, ]     
                
ks <- seq(1, 101, 3)
F_1 <- sapply(ks, function(k){
	fit <- knn3(sex ~ height, data = train_set, k = k)
	y_hat <- predict(fit, test_set, type = "class") %>% 
		factor(levels = levels(train_set$sex))
	F_meas(data = y_hat, reference = test_set$sex)
})
plot(ks, F_1)
max(F_1)
ks[which.max(F_1)]

##Q2:Next we will use the same gene expression example used in the Comprehension Check: Distance exercises. You can load it like this:
library(dslabs)
data("tissue_gene_expression")
First, set the seed to 1 and split the data into training and test sets. Then, report the accuracy you obtain from predicting tissue type
using KNN with k = 1, 3, 5, 7, 9, 11 using sapply() or map_df(). Note: use the createDataPartition() function outside of sapply() or map_df().
Answer: k1=0.989 ; k3=0.968 ; k5=0.947 ; k7=0.916 ; k9=0.916 ; k11=0.906
Code:
set.seed(1, sample.kind="Rounding")
library(caret)
y <- tissue_gene_expression$y
x <- tissue_gene_expression$x
test_index <- createDataPartition(y, list = FALSE)
sapply(seq(1, 11, 2), function(k){
	fit <- knn3(x[-test_index,], y[-test_index], k = k)
	y_hat <- predict(fit, newdata = data.frame(x=x[test_index,]),
				type = "class")
mean(y_hat == y[test_index])
})


###Assessments on edX
###Section 4.2: Cross-validation (Part 1) 

##Q1:Generate a set of random predictors and outcomes using the following code:
set.seed(1996) #if you are using R 3.5 or earlier
set.seed(1996, sample.kind="Rounding") #if you are using R 3.6 or later
n <- 1000
p <- 10000
x <- matrix(rnorm(n*p), n, p)
colnames(x) <- paste("x", 1:ncol(x), sep = "_")
y <- rbinom(n, 1, 0.5) %>% factor()

x_subset <- x[ ,sample(p, 100)]
Because x and y are completely independent, you should not be able to predict y using x with accuracy greater than 0.5.
Confirm this by running cross-validation using logistic regression to fit the model.
Because we have so many predictors, we selected a random sample x_subset. Use the subset when training the model.
Which code correctly performs this cross-validation?
(a)fit <- train(x_subset, y)
fit$results
(b)fit <- train(x_subset, y, method = "glm")
fit$results
(c)fit <- train(y, x_subset, method = "glm")
fit$results
(d)fit <- test(x_subset, y, method = "glm")
fit$results
Answer:(b)

##Q2:Now, instead of using a random selection of predictors, we are going to search for those that are most predictive of the outcome.
We can do this by comparing the values for the  y=1  group to those in the  y=0  group, for each predictor, using a t-test.
You can do perform this step like this:
install.packages("BiocManager")
BiocManager::install("genefilter")
library(genefilter)
tt <- colttests(x, y)
Which of the following lines of code correctly creates a vector of the p-values called pvals?
(a)pvals <- tt$dm
(b)pvals <- tt$statistic
(c)pvals <- tt
(d)pvals <- tt$p.value
Answer:(d)

##Q3:Create an index ind with the column numbers of the predictors that were "statistically significantly"
associated with y. Use a p-value cutoff of 0.01 to define "statistically significantly."
How many predictors survive this cutoff?
Answer:108
Code:
ind <- which(pvals <= 0.01)
length(ind)

##Q4:Now re-run the cross-validation after redefinining x_subset to be the subset of x defined by the columns
showing "statistically significant" association with y.
What is the accuracy now?
Answer:0.754
Code:
x_subset <- x[,ind]
fit <- train(x_subset, y, method = "glm")
fit$results

##Q5:Re-run the cross-validation again, but this time using kNN.
Try out the following grid k = seq(101, 301, 25) of tuning parameters. Make a plot of the resulting accuracies.
Which code is correct?
(a)fit <- train(x_subset, y, method = "knn", tuneGrid = data.frame(k = seq(101, 301, 25)))
ggplot(fit)
(b)fit <- train(x_subset, y, method = "knn")
ggplot(fit)
(c)fit <- train(x_subset, y, method = "knn", tuneGrid = data.frame(k = seq(103, 301, 25)))
ggplot(fit)
(d)fit <- train(x_subset, y, method = "knn", tuneGrid = data.frame(k = seq(101, 301, 5)))
ggplot(fit)
Answer:(a)

##Q6:In the previous exercises, we see that despite the fact that x and y are completely independent,
we were able to predict y with accuracy higher than 70%. We must be doing something wrong then.
What is it?
(a)The function train() estimates accuracy on the same data it uses to train the algorithm.
(b)We are overfitting the model by including 100 predictors.
(c)We used the entire dataset to select the columns used in the model.
(d)The high accuracy is just due to random variability.
Answer:(c)
Explanation:Because we used the entire dataset to select the columns in the model, the accuracy is too high.
The selection step needs to be included as part of the cross-validation algorithm,
and then the cross-validation itself is performed after the column selection step.
As a follow-up exercise, try to re-do the cross-validation, this time including the selection step in the cross-validation algorithm.
The accuracy should now be close to 50%.

##Q7:Use the train() function with kNN to select the best k for predicting tissue from gene expression on the tissue_gene_expression dataset from dslabs.
Try k = seq(1,7,2) for tuning parameters. For this question, do not split the data into test and train sets 
(understand this can lead to overfitting, but ignore this for now).
What value of k results in the highest accuracy?
Answer:1
Code:
data("tissue_gene_expression")
fit <- with(tissue_gene_expression, train(x, y, method = "knn", tuneGrid = data.frame( k = seq(1, 7, 2))))
ggplot(fit)
fit$results


###Assessments on edX
###Section 4.2: Cross-validation (Part 2)

##Q1:The createResample() function can be used to create bootstrap samples.
For example, we can create the indexes for 10 bootstrap samples for the mnist_27 dataset like this:
library(dslabs)
library(caret)
data(mnist_27)
set.seed(1995) # if R 3.6 or later, set.seed(1995, sample.kind="Rounding")
indexes <- createResample(mnist_27$train$y, 10)
How many times do 3, 4, and 7 appear in the first resampled index?
Answer: Enter the number of times 3 appears=1 ;
Enter the number of times 4 appears=4 ;
Enter the number of times 7 appears=0
Code:
sum(indexes[[1]] == 3)
sum(indexes[[1]] == 4)
sum(indexes[[1]] == 7)

##Q2:We see that some numbers appear more than once and others appear no times.
This has to be this way for each dataset to be independent. Repeat the exercise for all the resampled indexes.
What is the total number of times that 3 appears in all of the resampled indexes?
Answer:11
Code:
x=sapply(indexes, function(ind){
	sum(ind == 3)
})
sum(x)

##Q3:A random dataset can be generated using the following code:

y <- rnorm(100, 0, 1)
Estimate the 75th quantile, which we know is qnorm(0.75), with the sample quantile: quantile(y, 0.75).
Set the seed to 1 and perform a Monte Carlo simulation with 10,000 repetitions,
generating the random dataset and estimating the 75th quantile each time.
What is the expected value and standard error of the 75th quantile?
Answer: E=0.666 ;SE=0.135
Code:
set.seed(1, sample.kind="Rounding")
B <- 10000
q_75 <- replicate(B, {
	y <- rnorm(100, 0, 1)
	quantile(y, 0.75)
})

mean(q_75)
sd(q_75)

##Q4:In practice, we can't run a Monte Carlo simulation. Use the sample:
set.seed(1, sample.kind="Rounding")
y <- rnorm(100, 0, 1)
Set the seed to 1 again after generating y and use 10 bootstrap samples
to estimate the expected value and standard error of the 75th quantile.
Answer: E=0.731 ; SE=0.0742
Code:
set.seed(1, sample.kind="Rounding")
indexes <- createResample(y, 10)
q_75_star <- sapply(indexes, function(ind){
  y_star <- y[ind]
  quantile(y_star, 0.75)
})
mean(q_75_star)
sd(q_75_star)

##Q5:Repeat the exercise from Q4 but with 10,000 bootstrap samples instead of 10. Set the seed to 1.
Answer: E=0.674 ; SE=0.0931
Code:
set.seed(1, sample.kind="Rounding")
indexes <- createResample(y, 10000)
q_75_star <- sapply(indexes, function(ind){
  y_star <- y[ind]
  quantile(y_star, 0.75)
})
mean(q_75_star)
sd(q_75_star)
  
##Q6:When doing bootstrap sampling, the simulated samples are drawn from the empirical distribution of the original data.
True or False: The bootstrap is particularly useful in situations in which a tractable variance formula exists.
Answer: True
Explanation: True
True. The bootstrap is particularly useful in situations when we do not have access to the distribution or it is unknown.




###Assessments on edX
###Section 4.3: Generative Models

##Q1:Create a dataset of samples from just cerebellum and hippocampus, two parts of the brain, and a predictor matrix with 10 randomly selected columns using the following code:
library(dslabs)
library(caret)
library(tidyverse)
data("tissue_gene_expression")

set.seed(1993) #if using R 3.6 or later set.seed(1993, sample.kind="Rounding")
ind <- which(tissue_gene_expression$y %in% c("cerebellum", "hippocampus"))
y <- droplevels(tissue_gene_expression$y[ind])
x <- tissue_gene_expression$x[ind, ]
x <- x[, sample(ncol(x), 10)]
Use the train() function to estimate the accuracy of LDA. For this question, use the version of x and y created with the code above:
do not split them or tissue_gene_expression into training and test sets (understand this can lead to overfitting).
Report the accuracy from the train() results (do not make predictions).
What is the accuracy?
Answer:0.871
Code:
fit_lda <- train(x, y, method = "lda")
fit_lda$results["Accuracy"]

##Q2:In this case, LDA fits two 10-dimensional normal distributions.
Look at the fitted model by looking at the finalModel component of the result of train().
Notice there is a component called means that includes the estimated means of both distributions.
Plot the mean vectors against each other and determine which predictors (genes) appear to be driving the algorithm.
Which TWO genes appear to be driving the algorithm (i.e. the two genes with the highest means)?
PLCB1; RAB1B; MSH4; OAZ2; SPI1; SAPCD1; HEMK1
Answer:RAB1B and OAZ2
Code:
t(fit_lda$finalModel$means) %>% data.frame() %>%
  mutate(predictor_name = rownames(.)) %>%
  ggplot(aes(cerebellum, hippocampus, label = predictor_name)) +
  geom_point() +
  geom_text() +
  geom_abline()

##Q3:Repeat the exercise in Q1 with QDA.
Create a dataset of samples from just cerebellum and hippocampus, two parts of the brain,
and a predictor matrix with 10 randomly selected columns using the following code:
library(dslabs)      
library(caret)
data("tissue_gene_expression")

set.seed(1993) #set.seed(1993, sample.kind="Rounding") if using R 3.6 or later
ind <- which(tissue_gene_expression$y %in% c("cerebellum", "hippocampus"))
y <- droplevels(tissue_gene_expression$y[ind])
x <- tissue_gene_expression$x[ind, ]
x <- x[, sample(ncol(x), 10)]
Use the train() function to estimate the accuracy of QDA. For this question,
use the entire tissue_gene_expression dataset: do not split it into training and test sets (understand this can lead to overfitting).
What is the accuracy?
Answer:0.815
Code:
fit_qda <- train(x, y, method = "qda")
fit_qda$results["Accuracy"]
  
##Q4:Which TWO genes drive the algorithm when using QDA instead of LDA (i.e. the two genes with the highest means)?
PLCB1; RAB1B; MSH4; OAZ2; SPI1; SAPCD1; HEMK1
Answer:RAB1B and OAZ2
Code:
t(fit_qda$finalModel$means) %>% data.frame() %>%
 mutate(predictor_name = rownames(.)) %>%
 ggplot(aes(cerebellum, hippocampus, label = predictor_name)) +
 geom_point() +
 geom_text() +
 geom_abline()

##Q5:One thing we saw in the previous plots is that the values of the predictors correlate in both groups:
some predictors are low in both groups and others high in both groups.
The mean value of each predictor found in colMeans(x) is not informative or useful for prediction and often for purposes of interpretation,
it is useful to center or scale each column. This can be achieved with the preProcess argument in train().
Re-run LDA with preProcess = "center". Note that accuracy does not change, but it is now easier to identify
the predictors that differ more between groups than based on the plot made in Q2.
Which TWO genes drive the algorithm after performing the scaling?
C21orf62; PLCB1; RAB1B; MSH4; OAZ2; SPI1; SAPCD1; IL18R1
Answer:OAZ2 and SPI1
Code:
fit_lda <- train(x, y, method = "lda", preProcess = "center")
fit_lda$results["Accuracy"]
t(fit_lda$finalModel$means) %>% data.frame() %>%
 mutate(predictor_name = rownames(.)) %>%
 ggplot(aes(predictor_name, hippocampus)) +
 geom_point() +
 coord_flip()

You can see that it is different genes driving the algorithm now. This is because the predictor means change.
In the previous exercises we saw that both LDA and QDA approaches worked well.
For further exploration of the data, you can plot the predictor values for the two genes with the largest differences between the two groups
in a scatter plot to see how they appear to follow a bivariate distribution as assumed by the LDA and QDA approaches,
coloring the points by the outcome, using the following code:
d <- apply(fit_lda$finalModel$means, 2, diff)
ind <- order(abs(d), decreasing = TRUE)[1:2]
plot(x[, ind], col = y)

##Q6:Now we are going to increase the complexity of the challenge slightly.
Repeat the LDA analysis from Q5 but using all tissue types. Use the following code to create your dataset:
library(dslabs)      
library(caret)
data("tissue_gene_expression")

set.seed(1993) #set.seed(1993, sample.kind="Rounding") if using R 3.6 or later
y <- tissue_gene_expression$y
x <- tissue_gene_expression$x
x <- x[, sample(ncol(x), 10)]
What is the accuracy using LDA?
Answer:0.819
Code:
fit_lda <- train(x, y, method = "lda", preProcess = c("center"))
fit_lda$results["Accuracy"]
We see that the results are slightly worse when looking at all of the tissue types instead of only selected ones.
You can use the confusionMatrix function to learn more about what type of errors we are making, like this: confusionMatrix(fit_lda)




###Assessments on edX
###Section 5.1: Classification with More than Two Classes

##Q1:Create a simple dataset where the outcome grows 0.75 units on average for every increase in a predictor, using this code:
library(rpart)
n <- 1000
sigma <- 0.25
set.seed(1) #set.seed(1, sample.kind = "Rounding") if using R 3.6 or later
x <- rnorm(n, 0, 1)
y <- 0.75 * x + rnorm(n, 0, sigma)
dat <- data.frame(x = x, y = y)

Which code correctly uses rpart() to fit a regression tree and saves the result to fit?
(a)fit <- rpart(y ~ .) 
(b)fit <- rpart(y, ., data = dat) 
(c)fit <- rpart(x ~ ., data = dat) 
(d)fit <- rpart(y ~ ., data = dat)
Answer:(d)

##Q2:Which of the following plots has the same tree shape obtained in Q1?
Answer:(d)
Code: The plot can be made using the following code:
plot(fit)
text(fit)

##Q3:Below is most of the code to make a scatter plot of y versus x along with the predicted values based on the fit.
dat %>% 
  mutate(y_hat = predict(fit)) %>% 
  ggplot() +
  geom_point(aes(x, y)) +
  #BLANK
  
Which line of code should be used to replace #BLANK in the code above?
(a)geom_step(aes(x, y_hat), col=2)
(b)geom_smooth(aes(y_hat, x), col=2)
(c)geom_quantile(aes(x, y_hat), col=2)
(d)geom_step(aes(y_hat, x), col=2)
Answer:(a)

##Q4:Now run Random Forests instead of a regression tree using randomForest() from the randomForest package,
and remake the scatterplot with the prediction line. Part of the code is provided for you below.
library(randomForest)
fit <- #BLANK 
  dat %>% 
  mutate(y_hat = predict(fit)) %>% 
  ggplot() +
  geom_point(aes(x, y)) +
  geom_step(aes(x, y_hat), col = "red")
    
What code should replace #BLANK in the provided code?
(a)randomForest(y ~ x, data = dat)
(b)randomForest(x ~ y, data = dat)
(c)randomForest(y ~ x, data = data)
(d)randomForest(x ~ y)
Answer:(a)

##Q5:Use the plot() function to see if the Random Forest from Q4 has converged or if we need more trees.
Which of these graphs is produced by plotting the random forest?
Answer:(c)
Code: plot(fit)

##Q6:It seems that the default values for the Random Forest result in an estimate that is too flexible (unsmooth).
Re-run the Random Forest but this time with a node size of 50 and a maximum of 25 nodes. Remake the plot.
Part of the code is provided for you below.
library(randomForest)
fit <- #BLANK
  dat %>% 
  mutate(y_hat = predict(fit)) %>% 
  ggplot() +
  geom_point(aes(x, y)) +
  geom_step(aes(x, y_hat), col = "red")

What code should replace #BLANK in the provided code?
(a)randomForest(y ~ x, data = dat, nodesize = 25, maxnodes = 25)
(b)randomForest(y ~ x, data = dat, nodes = 50, max = 25)
(c)randomForest(x ~ y, data = dat, nodes = 50, max = 25)
(d)randomForest(y ~ x, data = dat, nodesize = 50, maxnodes = 25)
(e)randomForest(x ~ y, data = dat, nodesize = 50, maxnodes = 25)
Answer:(d)
Explanation:We see that using randomForest(y ~ x, data = dat, nodesize = 50, maxnodes = 25) yields smoother results.
We'll pick up with this exercise after we learn more about the caret package.


###Assessments on edX
###Section 5.2: Caret Package

##Q1:Load the rpart package and then use the caret::train() function with method = "rpart" to fit a classification tree to the tissue_gene_expression dataset.
Try out cp values of seq(0, 0.1, 0.01). Plot the accuracies to report the results of the best model. Set the seed to 1991.
Which value of cp gives the highest accuracy?
Answer:0
Code:
library(caret)
library(rpart)          
library(dslabs)
set.seed(1991)
data("tissue_gene_expression")
fit <- with(tissue_gene_expression, 
                train(x, y, method = "rpart",
                      tuneGrid = data.frame(cp = seq(0, 0.1, 0.01))))
ggplot(fit)

##Q2:Note that there are only 6 placentas in the dataset. By default, rpart() requires 20 observations before splitting a node.
That means that it is difficult to have a node in which placentas are the majority.
Rerun the analysis you did in the exercise in Q1, but this time, also allow rpart() to split any node by using the argument control = rpart.control(minsplit = 0).
Look at the confusion matrix again to determine whether the accuracy increases. Again, set the seed to 1991.
What is the accuracy now?
Answer:0.9141
Code:
library(rpart)
set.seed(1991)
data("tissue_gene_expression")
fit_rpart <- with(tissue_gene_expression, 
                      train(x, y, method = "rpart",
                            tuneGrid = data.frame(cp = seq(0, 0.10, 0.01)),
                            control = rpart.control(minsplit = 0)))
ggplot(fit_rpart)
confusionMatrix(fit_rpart)

##Q3:Plot the tree from the best fitting model of the analysis you ran in Q2.
Which gene is at the first split?
B3GNT4; CAPN3; CES2; CFHR4; CLIP3; GPA33; HRH1
Answer: GPA33
Code:The first split is at GPA33 >= 8.794. The following code will give the tree:
plot(fit_rpart$finalModel)
text(fit_rpart$finalModel)

##Q4:We can see that with just seven genes, we are able to predict the tissue type.
Now let's see if we can predict the tissue type with even fewer genes using a Random Forest.
Use the train() function and the rf method to train a Random Forest model and save it to an object called fit.
Try out values of mtry ranging from seq(50, 200, 25) (you can also explore other values on your own). What mtry value maximizes accuracy?
To permit small nodesize to grow as we did with the classification trees, use the following argument: nodesize = 1.
Note: This exercise will take some time to run. If you want to test out your code first, try using smaller values with ntree.
Set the seed to 1991 again.
What value of mtry maximizes accuracy?
Answer:100
Code:
set.seed(1991, sample.kind="Rounding")
library(randomForest)
fit <- with(tissue_gene_expression, 
            train(x, y, method = "rf", 
                  nodesize = 1,
                  tuneGrid = data.frame(mtry = seq(50, 200, 25))))
ggplot(fit)

##Q5:Use the function varImp() on the output of train() and save it to an object called imp:
imp <- #BLANK
What should replace #BLANK in the code above?
Do not include spaces in your answer.
Answer:varImp(fit)

##Q6:he rpart() model we ran above produced a tree that used just seven predictors.
Extracting the predictor names is not straightforward, but can be done. If the output of the call to train was fit_rpart, we can extract the names like this:
tree_terms <- as.character(unique(fit_rpart$finalModel$frame$var[!(fit_rpart$finalModel$frame$var == "<leaf>")]))
tree_terms

Calculate the variable importance in the Random Forest call from Q4 for these seven predictors and examine where they rank.
What is the importance of the CFHR4 gene in the Random Forest call?
Answer:35.0
What is the rank of the CFHR4 gene in the Random Forest call?
Answer:7
Code:The following code can be used to calculate the rank and importance in the Random Forest call for the predictors from the rpart() model:
data_frame(term = rownames(imp$importance), importance = imp$importance$Overall) %>%
 mutate(rank = rank(-importance)) %>% arrange(desc(importance)) %>%
 filter(term %in% tree_terms)


###Assessments on edX
###Section 5.3: Titanic Exercises

Titanic Exercises
These exercises cover everything you have learned in this course so far.
You will use the background information to provided to train a number of different types of models on this dataset.

Background
The Titanic was a British ocean liner that struck an iceberg and sunk on its maiden voyage in 1912 from the United Kingdom to New York.
More than 1,500 of the estimated 2,224 passengers and crew died in the accident, making this one of the largest maritime disasters ever outside of war.
The ship carried a wide range of passengers of all ages and both genders, from luxury travelers in first-class to immigrants in the lower classes.
However, not all passengers were equally likely to survive the accident. You will use real data about a selection of 891 passengers to predict which passengers survived.

Libraries and data
Use the titanic_train data frame from the titanic library as the starting point for this project.

library(titanic)    # loads titanic_train data frame
library(caret)
library(tidyverse)
library(rpart)

# 3 significant digits
options(digits = 3)

# clean the data - `titanic_train` is loaded with the titanic package
titanic_clean <- titanic_train %>%
  mutate(Survived = factor(Survived),
         Embarked = factor(Embarked),
         Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age), # NA age to median age
         FamilySize = SibSp + Parch + 1) %>%    # count family members
  select(Survived,  Sex, Pclass, Age, Fare, SibSp, Parch, FamilySize, Embarked)

##Q1:Split titanic_clean into test and training sets - after running the setup code, it should have 891 rows and 9 variables.
Set the seed to 42, then use the caret package to create a 20% data partition based on the Survived column. Assign the 20% partition to test_set and the remaining 80% partition to train_set.
How many observations are in the training set?
Answer: 712
How many observations are in the test set?
Answer: 179
What proportion of individuals in the training set survived? 
Answer: 0.383
Code:
set.seed(42, sample.kind = "Rounding")
test_index <- createDataPartition(titanic_clean$Survived, times = 1, p = 0.2, list = FALSE) # create a 20% test set
test_set <- titanic_clean[test_index,]
train_set <- titanic_clean[-test_index,]
nrow(train_set)
nrow(test_set)
mean(train_set$Survived == 1)

##Q2:The simplest prediction method is randomly guessing the outcome without using additional predictors.
These methods will help us determine whether our machine learning algorithm performs better than chance. How accurate are two methods of guessing Titanic passenger survival?
Set the seed to 3. For each individual in the test set, randomly guess whether that person survived or not by sampling from the vector c(0,1)
(Note: use the default argument setting of prob from the sample function). Assume that each person has an equal chance of surviving or not surviving.
What is the accuracy of this guessing method?
Answer: 0.542 or 0.475
Code:
set.seed(3, sample.kind = "Rounding")
# guess with equal probability of survival
guess <- sample(c(0,1), nrow(test_set), replace = TRUE)
mean(guess == test_set$Survived)

##Q3a:Use the training set to determine whether members of a given sex were more likely to survive or die.
Apply this insight to generate survival predictions on the test set.
What proportion of training set females survived?
Answer: 0.733 or 0.731
What proportion of training set males survived?
Answer: 0.193 or 0.197
Code:
train_set %>%
  group_by(Sex) %>%
  summarize(Survived = mean(Survived == 1)) %>%
  filter(Sex == "female") %>%
  pull(Survived)
train_set %>%
  group_by(Sex) %>%
  summarize(Survived = mean(Survived == 1)) %>%
  filter(Sex == "male") %>%
  pull(Survived)

##Q3b:Predict survival using sex on the test set: if the survival rate for a sex is over 0.5, predict survival for all individuals of that sex,
and predict death if the survival rate for a sex is under 0.5.
What is the accuracy of this sex-based prediction method on the test set?
Answer: 0.81 or 0.821
Code:
sex_model <- ifelse(test_set$Sex == "female", 1, 0)    # predict Survived=1 if female, 0 if male
mean(sex_model == test_set$Survived)    # calculate accuracy

##Q4a:In the training set, which class(es) (Pclass) were passengers more likely to survive than die?
Select ALL that apply.
(a)1; (b)2; (c)3
Answer:(a)
Code:
train_set %>%
  group_by(Pclass) %>%
  summarize(Survived = mean(Survived == 1)
  
##Q4b:Predict survival using passenger class on the test set: predict survival if the survival rate for a class is over 0.5, otherwise predict death.
What is the accuracy of this class-based prediction method on the test set?
Answer: 0.682 or 0.704
Code:
class_model <- ifelse(test_set$Pclass == 1, 1, 0)    # predict survival only if first class
mean(class_model == test_set$Survived)    # calculate accuracy

##Q4c:Use the training set to group passengers by both sex and passenger class.
Which sex and class combinations were more likely to survive than die?
Select ALL that apply.
(a)female 1st class
(b)female 2nd class
(c)female 3rd class
(d)male 1st class
(e)male 2nd class
(f)male 3rd class
Answer: (a) and (b)
Code:
train_set %>%
  group_by(Sex, Pclass) %>%
  summarize(Survived = mean(Survived == 1)) %>%
  filter(Survived > 0.5)

##Q4d:Predict survival using both sex and passenger class on the test set.
Predict survival if the survival rate for a sex/class combination is over 0.5, otherwise predict death.
What is the accuracy of this sex- and class-based prediction method on the test set?
Answer: 0.793 or 0.821
Code:
sex_class_model <- ifelse(test_set$Sex == "female" & test_set$Pclass != 3, 1, 0)
mean(sex_class_model == test_set$Survived)

OR

sex_class_model <- ifelse(test_set$Pclass == 1 & test_set$Sex == "female" | test_set$Pclass ==2 & test_set$Sex == "female", 1, 0)
mean(sex_class_model == test_set$Survived)

##Q5a:Use the confusionMatrix() function to create confusion matrices for the sex model, class model, and combined sex and class model.
You will need to convert predictions and survival status to factors to use this function.
What is the "positive" class used to calculate confusion matrix metrics?
0; 1
Answer: 0
Which model has the highest sensitivity?
(a)sex only
(b)class only
(c)sex and class combined
Answer: (c)
Which model has the highest specificity?
(a)sex only
(b)class only
(c)sex and class combined
Answer: (a)
Which model has the highest balanced accuracy?
(a)sex only
(b)class only
(c)sex and class combined
Answer: (a)

##Q5b:What is the maximum value of balanced accuracy?
Answer: 0.806 or 0.791
Code:
confusionMatrix(data = factor(sex_model), reference = factor(test_set$Survived))
confusionMatrix(data = factor(class_model), reference = factor(test_set$Survived))
confusionMatrix(data = factor(sex_class_model), reference = factor(test_set$Survived))

##Q6:Use the F_meas() function to calculate  F1  scores for the sex model, class model, and combined sex and class model.
You will need to convert predictions to factors to use this function.
Which model has the highest  F1  score?
(a)sex only
(b)class only
(c)sex and class combined
Answer: (c)
What is the maximum value of the  F1  score?
Answer: 0.872
Code:
F_meas(data = factor(sex_model), reference = test_set$Survived)
F_meas(data = factor(class_model), reference = test_set$Survived)
F_meas(data = factor(sex_class_model), reference = test_set$Survived)

##Q7:Set the seed to 1. Train a model using linear discriminant analysis (LDA) with the caret lda method using fare as the only predictor.
What is the accuracy on the test set for the LDA model?
Answer: 0.659 or 0.693
Code:
set.seed(1, sample.kind = "Rounding")
train_lda <- train(Survived ~ Fare, method = "lda", data = train_set)
lda_preds <- predict(train_lda, test_set)
mean(lda_preds == test_set$Survived)
OR
confusionMatrix(lda_preds, test_set$Survived)$overall["Accuracy"]

Set the seed to 1. Train a model using quadratic discriminant analysis (QDA) with the caret qda method using fare as the only predictor.
What is the accuracy on the test set for the QDA model?
Answer: 0.659 or 0.693
Code:
set.seed(1, sample.kind = "Rounding")
train_qda <- train(Survived ~ Fare, method = "qda", data = train_set)
qda_preds <- predict(train_qda, test_set)
mean(qda_preds == test_set$Survived)
OR
confusionMatrix(qda_preds, test_set$Survived)$overall["Accuracy"]
  
##Q8:
Set the seed to 1. Train a logistic regression model with the caret glm method using age as the only predictor.
What is the accuracy on the test set using age as the only predictor?
Answer: 0.615
Code:
set.seed(1, sample.kind = "Rounding")
train_glm_age <- train(Survived ~ Age, method = "glm", data = train_set)
glm_preds_age <- predict(train_glm_age, test_set)
mean(glm_preds_age == test_set$Survived)

Set the seed to 1. Train a logistic regression model with the caret glm method using four predictors: sex, class, fare, and age.
What is the accuracy on the test set using these four predictors?
Answer: 0.821 or 0.849
Code:
set.seed(1, sample.kind = "Rounding")
train_glm <- train(Survived ~ Sex + Pclass + Fare + Age, method = "glm", data = train_set)
glm_preds <- predict(train_glm, test_set)
mean(glm_preds == test_set$Survived)

Set the seed to 1. Train a logistic regression model with the caret glm method using all predictors. Ignore warnings about rank-deficient fit.
What is the accuracy on the test set using all predictors?
Answer: 0.827 or 0.849
Code:
set.seed(1, sample.kind = "Rounding")
train_glm_all <- train(Survived ~ ., method = "glm", data = train_set)
glm_all_preds <- predict(train_glm_all, test_set)
mean(glm_all_preds == test_set$Survived)
    
##Q9a:Set the seed to 6. Train a kNN model on the training set using the caret train function.
Try tuning with k = seq(3, 51, 2).
What is the optimal value of the number of neighbors k?
Answer: 11
Code:
set.seed(6, sample.kind = "Rounding")
train_knn <- train(Survived ~ .,
                   method = "knn",
                   data = train_set,
                   tuneGrid = data.frame(k = seq(3, 51, 2)))
train_knn$bestTune

##Q9b:Plot the kNN model to investigate the relationship between the number of neighbors and accuracy on the training set.
Of these values of  k , which yields the highest accuracy?
(a)7 ; (b)11 ; (c)17 ; (d)21
Answer: 11
Code:
ggplot(train_knn)
 
##Q9c:What is the accuracy of the kNN model on the test set?
Answer: 0.709
Code:
knn_preds <- predict(train_knn, test_set)
mean(knn_preds == test_set$Survived)
    
##Q10:Set the seed to 8 and train a new kNN model. Instead of the default training control, use 10-fold cross-validation where each partition consists of 10% of the total.
What is the optimal value of k using cross-validation?
Answer: 5
Code:
set.seed(8, sample.kind = "Rounding") 
train_knn_cv <- train(Survived ~ .,
                      method = "knn",
                      data = train_set,
                      tuneGrid = data.frame(k = seq(3, 51, 2)),
                      trControl = trainControl(method = "cv", number = 10, p = 0.9))
train_knn_cv$bestTune

What is the accuracy on the test set using the cross-validated kNN model?
Answer: 0.648
Code:
knn_cv_preds <- predict(train_knn_cv, test_set)
mean(knn_cv_preds == test_set$Survived)
  
##Q11a:Set the seed to 10. Use caret to train a decision tree with the rpart method.
Tune the complexity parameter with cp = seq(0, 0.05, 0.002).
What is the optimal value of the complexity parameter (cp)?
Answer: 0.02 or 0.016
Code:
set.seed(10, sample.kind = "Rounding")
train_rpart <- train(Survived ~ ., 
                     method = "rpart",
                     tuneGrid = data.frame(cp = seq(0, 0.05, 0.002)),
                     data = train_set)

train_rpart$bestTune
What is the accuracy of the decision tree model on the test set?
Answer: 0.849 or 0.838
Code:
rpart_preds <- predict(train_rpart, test_set)
mean(rpart_preds == test_set$Survived)
 
##Q11b:Inspect the final model and plot the decision tree.
Which variables are used in the decision tree?
Select ALL that apply.
Survived; Sex; Pclass; Age; Fare; Parch; Embarked
Answer: Sex, Pclass, Age, and Fare
Code:
train_rpart$finalModel # inspect final model
# make plot of decision tree
plot(train_rpart$finalModel, margin = 0.1)
text(train_rpart$finalModel)
  
##Q11c:Using the decision rules generated by the final model, predict whether the following individuals would survive.
A 28-year-old male
Answer: would NOT survive
A female in the second passenger class
Answer: would survive
A third-class female who paid a fare of $8
Answer: would survive
A 5-year-old male with 4 siblings
Answer: would NOT survive
A third-class female who paid a fare of $25
Answer: would NOT survive
A first-class 17-year-old female with 2 siblings
Answer: would survive
A first-class 17-year-old male with 2 siblings
Answer: would NOT survive
Explanation: For each case, follow the decision tree to determine whether it results in survived=0 (didn't survive) or survived=1 (did survive).
   
##Q12:Set the seed to 14. Use the caret train() function with the rf method to train a random forest. Test values of mtry ranging from 1 to 7. Set ntree to 100.
What mtry value maximizes accuracy?
Answer: 3 or 2
Code:
set.seed(14, sample.kind = "Rounding")
train_rf <- train(Survived ~ .,
                  data = train_set,
                  method = "rf",
                  ntree = 100,
                  tuneGrid = data.frame(mtry = seq(1:7)))
train_rf$bestTune

What is the accuracy of the random forest model on the test set?
Answer: 0.877 or 0.844
Code: 
rf_preds <- predict(train_rf, test_set)
mean(rf_preds == test_set$Survived)

Use varImp() on the random forest model object to determine the importance of various predictors to the random forest model.
What is the most important variable?
Be sure to report the variable name exactly as it appears in the code.
Answer: Sexmale
Code: varImp(train_rf)    # first row
    
  
  

###Assessments on edX
###Section 6.1: Case Study: MNIST 

For these exercises we are going to build several machine learning models for the mnist_27 dataset and then build an ensemble.
Each of the exercises in this comprehension check builds on the last.

##Q1:Use the training set to build a model with several of the models available from the caret package.
We will test out 10 of the most common machine learning models in this exercise:
models <- c("glm", "lda", "naive_bayes", "svmLinear", "knn", "gamLoess", "multinom", "qda", "rf", "adaboost")
    
Apply all of these models using train() with all the default parameters.
You may need to install some packages. Keep in mind that you will probably get some warnings. Also, it will probably take a while to train all of the models - be patient!
Run the following code to train the various models:
library(caret)
library(dslabs)
set.seed(1, sample.kind = "Rounding")
data("mnist_27")

fits <- lapply(models, function(model){ 
	print(model)
	train(y ~ ., method = model, data = mnist_27$train)
}) 
    
names(fits) <- models
    
Did you train all of the models?
Answer:Yes

##Q2:Now that you have all the trained models in a list, use sapply() or map() to create a matrix of predictions for the test set.
You should end up with a matrix with length(mnist_27$test$y) rows and length(models) columns.
What are the dimensions of the matrix of predictions?
Number of rows:200
Number of columns:10
Code:
pred <- sapply(fits, function(object) 
	predict(object, newdata = mnist_27$test))
dim(pred)

##Q3:Now compute accuracy for each model on the test set.
Report the mean accuracy across all models.
Answer:0.789
Code:
acc <- colMeans(pred == mnist_27$test$y)
acc
mean(acc)

##Q4:Next, build an ensemble prediction by majority vote and compute the accuracy of the ensemble.
Vote 7 if more than 50% of the models are predicting a 7, and 2 otherwise.
What is the accuracy of the ensemble?
Answer:0.815
Code:
votes <- rowMeans(pred == "7")
y_hat <- ifelse(votes > 0.5, "7", "2")
mean(y_hat == mnist_27$test$y)

##Q5:In Q3, we computed the accuracy of each method on the test set and noticed that the individual accuracies varied.
How many of the individual methods do better than the ensemble?
Answer:3

Which individual methods perform better than the ensemble?
Select ALL that apply.
glm; lda; naive_bayes; svmLinear; knn; gamLoess; multinom; qda; rf; adaboost
Answer:knn, gamLoess, and qda
Code:
ind <- acc > mean(y_hat == mnist_27$test$y)
sum(ind)
models[ind]

##Q6:It is tempting to remove the methods that do not perform well and re-do the ensemble.
The problem with this approach is that we are using the test data to make a decision.
However, we could use the minimum accuracy estimates obtained from cross validation with the training data for each model.
Obtain these estimates and save them in an object.
Report the mean of these training set accuracy estimates.
What is the mean of these training set accuracy estimates?
Answer:0.809
Code:
acc_hat <- sapply(fits, function(fit) min(fit$results$Accuracy))
mean(acc_hat)

##Q7:Now let's only consider the methods with an estimated accuracy of greater than or equal to 0.8 when constructing the ensemble. Vote 7 if 50% or more of the models are predicting a 7, and 2 otherwise.
What is the accuracy of the ensemble now?
Answer:0.825
Code:
ind <- acc_hat >= 0.8
votes <- rowMeans(pred[,ind] == "7")
y_hat <- ifelse(votes>=0.5, 7, 2)
mean(y_hat == mnist_27$test$y)


###Assessments on edX
###Section 6.2: Recommendation Systems

The following exercises all work with the movielens data, which can be loaded using the following code:
library(tidyverse)
library(lubridate)
library(dslabs)
data("movielens")

##Q1:Compute the number of ratings for each movie and then plot it against the year the movie came out.
Use the square root transformation on the counts.
What year has the highest median number of ratings?
Answer:1995
Code:
movielens %>% group_by(movieId) %>%
  summarize(n = n(), year = as.character(first(year))) %>%
  qplot(year, n, data = ., geom = "boxplot") +
  coord_trans(y = "sqrt") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
  
##Q2:We see that, on average, movies that came out after 1993 get more ratings.
We also see that with newer movies, starting in 1993, the number of ratings decreases with year: the more recent a movie is, the less time users have had to rate it.
Among movies that came out in 1993 or later, select the top 25 movies with the highest average number of ratings per year (n/year), and caculate the average rating of each of them.
To calculate number of ratings per year, use 2018 as the end year.
What is the average rating for the movie The Shawshank Redemption?
Answer:4.49
What is the average number of ratings per year for the movie Forrest Gump?
Answer:14.2
Code:
movielens %>% 
  filter(year >= 1993) %>%
  group_by(movieId) %>%
  summarize(n = n(), years = 2018 - first(year),
            title = title[1],
            rating = mean(rating)) %>%
  mutate(rate = n/years) %>%
  top_n(25, rate) %>%
  arrange(desc(rate))

##Q3:From the table constructed in Q2, we can see that the most frequently rated movies tend to have above average ratings.
This is not surprising: more people watch popular movies.
To confirm this, stratify the post-1993 movies by ratings per year and compute their average ratings.
To calculate number of ratings per year, use 2018 as the end year. Make a plot of average rating versus ratings per year and show an estimate of the trend.
What type of trend do you observe?
(a)There is no relationship between how often a movie is rated and its average rating.
(b)Movies with very few and very many ratings have the highest average ratings.
(c)The more often a movie is rated, the higher its average rating.
(d)The more often a movie is rated, the lower its average rating
Answer:(c)
Code:
movielens %>% 
  filter(year >= 1993) %>%
  group_by(movieId) %>%
  summarize(n = n(), years = 2018 - first(year),
            title = title[1],
            rating = mean(rating)) %>%
  mutate(rate = n/years) %>%
  ggplot(aes(rate, rating)) +
  geom_point() +
  geom_smooth()

##Q4:Suppose you are doing a predictive analysis in which you need to fill in the missing ratings with some value.
Given your observations in the exercise in Q3, which of the following strategies would be most appropriate?
(a)Fill in the missing values with the average rating across all movies.
(b)Fill in the missing values with 0.
(c)Fill in the missing values with a lower value than the average rating across all movies.
(d)Fill in the value with a higher value than the average rating across all movies.
(e)None of the above
Answer:(c)
Explanation:
Because a lack of ratings is associated with lower ratings, it would be most appropriate to fill in the missing value with a lower value than the average.
You should try out different values to fill in the missing value and evaluate prediction in a test set.

##Q5:The movielens dataset also includes a time stamp.
This variable represents the time and data in which the rating was provided.
The units are seconds since January 1, 1970. Create a new column date with the date.
Which code correctly creates this new column?
(a)movielens <- mutate(movielens, date = as.date(timestamp))
(b)movielens <- mutate(movielens, date = as_datetime(timestamp))
(c)movielens <- mutate(movielens, date = as.data(timestamp))
(d)movielens <- mutate(movielens, date = timestamp)
Answer:(b)
Explanation:
The as_datetime function in the lubridate package is particularly useful here.
  
##Q6:Compute the average rating for each week and plot this average against date.
Hint: use the round_date() function before you group_by().
What type of trend do you observe?
(a)There is very strong evidence of a time effect on average rating.
(b)There is some evidence of a time effect on average rating.
(c)There is no evidence of a time effect on average rating (straight horizontal line).
Answer:(b)
Code:
movielens %>% mutate(date = round_date(date, unit = "week")) %>%
  group_by(date) %>%
  summarize(rating = mean(rating)) %>%
  ggplot(aes(date, rating)) +
  geom_point() +
  geom_smooth() 

##Q7:Consider again the plot you generated in Q6.
If we define  du,i  as the day for user's  u  rating of movie  i , which of the following models is most appropriate?
(a)Yu,i=μ+bi+bu+du,i+εu,i 
(b)Yu,i=μ+bi+bu+du,iβ+εu,i 
(c)Yu,i=μ+bi+bu+du,iβi+εu,i 
(d)Yu,i=μ+bi+bu+f(du,i)+εu,i , with  f  a smooth function of  du,i
Answer:(d)
  
##Q8:The movielens data also has a genres column.
This column includes every genre that applies to the movie.
Some movies fall under several genres. Define a category as whatever combination appears in this column. Keep only categories with more than 1,000 ratings.
Then compute the average and standard error for each category.
Plot these as error bar plots.
Which genre has the lowest average rating?
Enter the name of the genre exactly as reported in the plot, including capitalization and punctuation.
Answer:Comedy
Code:
movielens %>% group_by(genres) %>%
	summarize(n = n(), avg = mean(rating), se = sd(rating)/sqrt(n())) %>%
	filter(n >= 1000) %>% 
	mutate(genres = reorder(genres, avg)) %>%
	ggplot(aes(x = genres, y = avg, ymin = avg - 2*se, ymax = avg + 2*se)) + 
	geom_point() +
	geom_errorbar() + 
	theme(axis.text.x = element_text(angle = 90, hjust = 1))

##Q9:The plot you generated in Q8 shows strong evidence of a genre effect. Consider this plot as you answer the following question.
If we define  gu,i  as the genre for user  u 's rating of movie  i , which of the following models is most appropriate?
(a)Yu,i=μ+bi+bu+gu,i+εu,i 
(b)Yu,i=μ+bi+bu+gu,iβ+εu,i 
(c)Yu,i=μ+bi+bu+∑Kk=1xku,iβk+εu,i , with  xku,i=1  if  gu,i  is genre  k 
(d)Yu,i=μ+bi+bu+f(gu,i)+εu,i , with  f  a smooth function of  gu,i
Answer:(c)
  
  
###Assessments on edX
###Section 6.3: Regularization (Part 1)

The exercises in Q1-Q8 work with a simulated dataset for 1000 schools.
This pre-exercise setup walks you through the code needed to simulate the dataset.
If you have not done so already since the Titanic Exercises, please restart R or reset the number of digits that are printed with options(digits=7).
An education expert is advocating for smaller schools.
The expert bases this recommendation on the fact that among the best performing schools, many are small schools. Let's simulate a dataset for 1000 schools.
First, let's simulate the number of students in each school, using the following code:
  
set.seed(1986, sample.kind="Rounding")
n <- round(2^rnorm(1000, 8, 1))
Now let's assign a true quality for each school that is completely independent from size.
This is the parameter we want to estimate in our analysis. The true quality can be assigned using the following code:

set.seed(1, sample.kind="Rounding")
mu <- round(80 + 2*rt(1000, 5))
range(mu)
schools <- data.frame(id = paste("PS",1:1000),
                      size = n,
                      quality = mu,
                      rank = rank(-mu))
                      
We can see the top 10 schools using this code: 
schools %>% top_n(10, quality) %>% arrange(desc(quality))
Now let's have the students in the school take a test.
There is random variability in test taking, so we will simulate the test scores as normally distributed with the average
determined by the school quality with a standard deviation of 30 percentage points.
This code will simulate the test scores:
  
set.seed(1, sample.kind="Rounding")
mu <- round(80 + 2*rt(1000, 5))

scores <- sapply(1:nrow(schools), function(i){
  scores <- rnorm(schools$size[i], schools$quality[i], 30)
  scores
})
schools <- schools %>% mutate(score = sapply(scores, mean))

##Q1:What are the top schools based on the average score?
Show just the ID, size, and the average score.
Report the ID of the top school and average score of the 10th school.
What is the ID of the top school?
Note that the school IDs are given in the form "PS x" - where x is a number.
Report the number only.
Answer:567

What is the average score of the 10th school?
Answer:87.95
Code:
schools %>% top_n(10, score) %>% arrange(desc(score)) %>% select(id, size, score)
  
##Q2:Compare the median school size to the median school size of the top 10 schools based on the score.
What is the median school size overall?
Answer:261

What is the median school size of the of the top 10 schools based on the score?
Answer:185.5
Code:
median(schools$size)
schools %>% top_n(10, score) %>% .$size %>% median()
  
##Q3:According to this analysis, it appears that small schools produce better test scores than large schools.
Four out of the top 10 schools have 100 or fewer students.
But how can this be? We constructed the simulation so that quality and size were independent.
Repeat the exercise for the worst 10 schools.
What is the median school size of the bottom 10 schools based on the score?
Answer:219
Code:
schools %>% top_n(-10, score) %>% .$size %>% median() 
  
##Q4:From this analysis, we see that the worst schools are also small. Plot the average score versus school size to see what's going on. Highlight the top 10 schools based on the true quality.
What do you observe?
(a)There is no difference in the standard error of the score based on school size; there must be an error in how we generated our data.
(b)The standard error of the score has larger variability when the school is smaller, which is why both the best and the worst schools are more likely to be small.
(c)The standard error of the score has smaller variability when the school is smaller, which is why both the best and the worst schools are more likely to be small.
(d)The standard error of the score has larger variability when the school is very small or very large, which is why both the best and the worst schools are more likely to be small.
(e)The standard error of the score has smaller variability when the school is very small or very large, which is why both the best and the worst schools are more likely to be small.
Answer:(b)
Code:
schools %>% ggplot(aes(size, score)) +
  geom_point(alpha = 0.5) +
  geom_point(data = filter(schools, rank<=10), col = 2)

We can see that the standard error of the score has larger variability when the school is smaller.
This is a basic statistical reality we learned in PH125.3x: Data Science: Probability and PH125.4x: Data Science: Inference and Modeling courses!
Note also that several of the top 10 schools based on true quality are also in the top 10 schools based on the exam score: schools %>% top_n(10, score) %>% arrange(desc(score)).
  
##Q5:Let's use regularization to pick the best schools. Remember regularization shrinks deviations from the average towards 0.
To apply regularization here, we first need to define the overall average for all schools, using the following code:
overall <- mean(sapply(scores, mean))
Then, we need to define, for each school, how it deviates from that average.
Write code that estimates the score above the average for each school but dividing by n+α instead of n, with n the school size and α a regularization parameter. Try α=25.
What is the ID of the top school with regularization?
Note that the school IDs are given in the form "PS x" - where x is a number. Report the number only.
Answer:191
 
What is the regularized score of the 10th school?
Answer:87.15
Code:
alpha <- 25
score_reg <- sapply(scores, function(x)  overall + sum(x-overall)/(length(x)+alpha))
schools %>% mutate(score_reg = score_reg) %>%
  top_n(10, score_reg) %>% arrange(desc(score_reg))
  
##Q6:Notice that this improves things a bit. The number of small schools that are not highly ranked is now lower. Is there a better  α ?
Using values of  α  from 10 to 250, find the  α  that minimizes the RMSE.
RMSE=sqrt(11000∑i=11000(quality−estimate)^2)
What value of  α  gives the minimum RMSE?
Answer:135
Code:
alphas <- seq(10,250)
rmse <- sapply(alphas, function(alpha){
  score_reg <- sapply(scores, function(x) overall+sum(x-overall)/(length(x)+alpha))
  sqrt(mean((score_reg - schools$quality)^2))
})
plot(alphas, rmse)
alphas[which.min(rmse)]
  
##Q7:Rank the schools based on the average obtained with the best  α .
Note that no small school is incorrectly included.
What is the ID of the top school now?
Note that the school IDs are given in the form "PS x" - where x is a number.
Report the number only.
Answer:191

What is the regularized average score of the 10th school now?
Answer:85.4
Code:
alpha <- alphas[which.min(rmse)]  
score_reg <- sapply(scores, function(x)
  overall+sum(x-overall)/(length(x)+alpha))
schools %>% mutate(score_reg = score_reg) %>%
  top_n(10, score_reg) %>% arrange(desc(score_reg))
  
##Q8:A common mistake made when using regularization is shrinking values towards 0 that are not centered around 0.
For example, if we don't subtract the overall average before shrinking, we actually obtain a very similar result.
Confirm this by re-running the code from the exercise in Q6 but without removing the overall mean.
What value of  α  gives the minimum RMSE here?
Answer:10
Code:The code here is nearly the same as in Q6, but we don't subtract the overall mean.
The value of \( \alpha \) that minimizes the RMSE can be calculated using the following code:
alphas <- seq(10,250)
rmse <- sapply(alphas, function(alpha){
  score_reg <- sapply(scores, function(x) sum(x)/(length(x)+alpha))
  sqrt(mean((score_reg - schools$quality)^2))
})
plot(alphas, rmse)
alphas[which.min(rmse)]
  

###Assessments on edX
###Section 6.3: Regularization (Part 2)

In this exercise set, we will be covering a topic useful for understanding matrix factorization: the singular value decomposition (SVD).
SVD is a mathematical result that is widely used in machine learning, both in practice and to understand the mathematical properties of some algorithms.
This is a rather advanced topic and to complete this exercise set you will have to be familiar with linear algebra concepts such as matrix multiplication, orthogonal matrices, and diagonal matrices.

The SVD tells us that we can decompose an  N×p  matrix  Y  with  p<N  as 
Y=UDV⊤ 
with  U  and  V  orthogonal of dimensions  N×p  and  p×p  respectively and  D  a  p×p  diagonal matrix with the values of the diagonal decreasing: 

d1,1≥d2,2≥…dp,p 
In this exercise, we will see one of the ways that this decomposition can be useful.
To do this, we will construct a dataset that represents grade scores for 100 students in 24 different subjects.
The overall average has been removed so this data represents the percentage point each student received above or below the average test score.
So a 0 represents an average grade (C), a 25 is a high grade (A+), and a -25 represents a low grade (F). You can simulate the data like this:

set.seed(1987, sample.kind="Rounding")
n <- 100
k <- 8
Sigma <- 64  * matrix(c(1, .75, .5, .75, 1, .5, .5, .5, 1), 3, 3) 
m <- MASS::mvrnorm(n, rep(0, 3), Sigma)
m <- m[order(rowMeans(m), decreasing = TRUE),]
y <- m %x% matrix(rep(1, k), nrow = 1) + matrix(rnorm(matrix(n*k*3)), n, k*3)
colnames(y) <- c(paste(rep("Math",k), 1:k, sep="_"),
                 paste(rep("Science",k), 1:k, sep="_"),
                 paste(rep("Arts",k), 1:k, sep="_"))

Our goal is to describe the student performances as succinctly as possible.
For example, we want to know if these test results are all just a random independent numbers. Are all students just about as good?
Does being good in one subject  imply you will be good in another? How does the SVD help with all this?
We will go step by step to show that with just three relatively small pairs of vectors we can explain much of the variability in this  100×24  dataset.  
  
##Q1:You can visualize the 24 test scores for the 100 students by plotting an image:
my_image <- function(x, zlim = range(x), ...){
	colors = rev(RColorBrewer::brewer.pal(9, "RdBu"))
	cols <- 1:ncol(x)
	rows <- 1:nrow(x)
	image(cols, rows, t(x[rev(rows),,drop=FALSE]), xaxt = "n", yaxt = "n",
			xlab="", ylab="",  col = colors, zlim = zlim, ...)
	abline(h=rows + 0.5, v = cols + 0.5)
	axis(side = 1, cols, colnames(x), las = 2)
}
my_image(y)
    
How would you describe the data based on this figure?
(a)The test scores are all independent of each other.
(b)The students that are good at math are not good at science.
(c)The students that are good at math are not good at arts.
(d)The students that test well are at the top of the image and there seem to be three groupings by subject.
(e)The students that test well are at the bottom of the image and there seem to be three groupings by subject.
Answer:
Code:
  
##Q2:You can examine the correlation between the test scores directly like this:
my_image(cor(y), zlim = c(-1,1))
range(cor(y))
axis(side = 2, 1:ncol(y), rev(colnames(y)), las = 2)
    
Which of the following best describes what you see?
(a)The test scores are independent.
(b)Test scores in math and science are highly correlated but scores in arts are not.
(c)There is high correlation between tests in the same subject but no correlation across subjects.
(d)There is correlation among all tests, but higher if the tests are in science and math and even higher within each subject.
Answer:
Code:
  
Q3:Remember that orthogonality means that  U⊤U  and  V⊤V  are equal to the identity matrix.
This implies that we can also rewrite the decomposition as
YV=UD or U⊤Y=DV⊤ 
We can think of  YV  and  U⊤V  as two transformations of  Y  that preserve the total variability of  Y  since  U  and  V  are orthogonal.

Use the function svd() to compute the SVD of y. This function will return  U ,  V , and the diagonal entries of  D .
s <- svd(y)
names(s)
    
You can check that the SVD works by typing:
y_svd <- s$u %*% diag(s$d) %*% t(s$v)
max(abs(y - y_svd))
    
Compute the sum of squares of the columns of  Y  and store them in ss_y.
Then compute the sum of squares of columns of the transformed  YV  and store them in ss_yv.
Confirm that sum(ss_y) is equal to sum(ss_yv).

What is the value of sum(ss_y) (and also the value of sum(ss_yv))?
Answer:
Code:
  
##Q4:We see that the total sum of squares is preserved. This is because  V  is orthogonal.
Now to start understanding how  YV  is useful, plot ss_y against the column number and then do the same for ss_yv.
What do you observe?
(a)ss_y and ss_yv are decreasing and close to 0 for the 4th column and beyond.
(b)ss_yv is decreasing and close to 0 for the 4th column and beyond.
(c)ss_y is decreasing and close to 0 for the 4th column and beyond.
(d)There is no discernible pattern to either ss_y or ss_yv.
Answer:
Code:
  
##Q5:Now notice that we didn't have to compute ss_yv because we already have the answer.
How? Remember that  YV=UD  and because  U  is orthogonal, we know that the sum of squares of the columns of  UD  are the diagonal entries of  D  squared.
Confirm this by plotting the square root of ss_yv versus the diagonal entries of  D .
Which of these plots is correct?
Answer:
Code:
  
##Q6:So from the above we know that the sum of squares of the columns of  Y  (the total sum of squares) adds up to the sum of s$d^2
and that the transformation  YV  gives us columns with sums of squares equal to s$d^2.
Now compute the percent of the total variability that is explained by just the first three columns of  YV .
What proportion of the total variability is explained by the first three columns of  YV ?
Enter a decimal, not the percentage.
Answer:
Code:
  
##Q7:Before we continue, let's show a useful computational trick to avoid creating the matrix diag(s$d).
To motivate this, we note that if we write  U  out in its columns  [U1,U2,…,Up]  then  UD  is equal to
UD=[U1d1,1,U2d2,2,…,Updp,p] 

Use the sweep function to compute  UD  without constructing diag(s$d) or using matrix multiplication.
Which code is correct?
(a)identical(t(s$u %*% diag(s$d)), sweep(s$u, 2, s$d, FUN = "*"))
(b)identical(s$u %*% diag(s$d), sweep(s$u, 2, s$d, FUN = "*"))
(c)identical(s$u %*% t(diag(s$d)), sweep(s$u, 2, s$d, FUN = "*"))
(d)identical(s$u %*% diag(s$d), sweep(s$u, 2, s, FUN = "*"))
Answer:
Code:
  
##Q8:We know that  U1d1,1 , the first column of  UD , has the most variability of all the columns of  UD .
Earlier we looked at an image of  Y  using my_image(y), in which we saw that the student to student variability is quite large
and that students that are good in one subject tend to be good in all.
This implies that the average (across all subjects) for each student should explain a lot of the variability.
Compute the average score for each student, plot it against  U1d1,1 , and describe what you find.

What do you observe?
(a)There is no relationship between the average score for each student and  U1d1,1 .
(b)There is a linearly decreasing relationship between the average score for each student and  U1d1,1 .
(c)There is a linearly increasing relationship between the average score for each student and  U1d1,1 .
(d)There is an exponentially increasing relationship between the average score for each student and  U1d1,1 .
(e)There is an exponentially decreasing relationship between the average score for each student and  U1d1,1 .
Answer:
Code:

##Q9:We note that the signs in SVD are arbitrary because:
UDV⊤=(−U)D(−V)⊤ 
With this in mind we see that the first column of  UD  is almost identical to the average score for each student except for the sign.

This implies that multiplying  Y  by the first column of  V  must be performing a similar operation to taking the average.
Make an image plot of  V  and describe the first column relative to others and how this relates to taking an average.

How does the first column relate to the others, and how does this relate to taking an average?
(a)The first column is very variable, which implies that the first column of YV is the sum of the rows of Y
multiplied by some non-constant function, and is thus not proportional to an average.
(b)The first column is very variable, which implies that the first column of YV is the sum of the rows of Y
multiplied by some non-constant function, and is thus proportional to an average.
(c)The first column is very close to being a constant, which implies that the first column of YV
is the sum of the rows of Y multiplied by some constant, and is thus proportional to an average.
(d)The first three columns are all very close to being a constant,
which implies that these columns are the sum of the rows of Y multiplied by some constant, and are thus proportional to an average.
Answer:
Code:


The following four exercises are all ungraded and are provided to give you an additional opportunity to
practice working with matrices in a continuation of the exercises with this dataset.
We recommend that you attempt to write the code on your own before hitting "submit" and viewing the answers.   
    
##Q10:We already saw that we can rewrite  UD  as
U1d1,1+U2d2,2+⋯+Updp,p 
with  Uj  the j-th column of  U . This implies that we can rewrite the entire SVD as:
Y=U1d1,1V⊤1+U2d2,2V⊤2+⋯+Updp,pV⊤p 
with  Vj  the jth column of  V .

Plot  U1 , then plot  V⊤1  using the same range for the y-axis limits, then make an image of  U1d1,1V⊤1  and compare it to the image of  Y .
Hint: use the my_image() function defined above.
Use the drop=FALSE argument to assure the subsets of matrices are matrices.
Answer:
Code:
  
##Q11:We see that with just a vector of length 100, a scalar, and a vector of length 24, we can actually come close to reconstructing the a  100×24  matrix. This is our first matrix factorization:
Y≈d1,1U1V⊤1 
In the exercise in Q6, we saw how to calculate the percent of total variability explained. However, our approximation only explains the observation that good students tend to be good in all subjects.
Another aspect of the original data that our approximation does not explain was the higher similarity we observed within subjects.
We can see this by computing the difference between our approximation and original data and then computing the correlations. You can see this by running this code:
resid <- y - with(s,(u[, 1, drop=FALSE]*d[1]) %*% t(v[, 1, drop=FALSE]))
my_image(cor(resid), zlim = c(-1,1))
axis(side = 2, 1:ncol(y), rev(colnames(y)), las = 2)

Now that we have removed the overall student effect, the correlation plot reveals that we have not yet explained the within subject correlation
nor the fact that math and science are closer to each other than to the arts.
So let's explore the second column of the SVD.
Repeat the previous exercise (Q10) but for the second column: Plot  U2 , then plot  V⊤2  using the same range for the y-axis limits,
then make an image of  U2d2,2V⊤2  and compare it to the image of resid.
Answer:
Code:
  
##Q12:The second column clearly relates to a student's difference in ability in math/science versus the arts.
We can see this most clearly from the plot of s$v[,2]. Adding the matrix we obtain with these two columns will help with our approximation:
Y≈d1,1U1V⊤1+d2,2U2V⊤2 
We know it will explain sum(s$d[1:2]^2)/sum(s$d^2) * 100 percent of the total variability. We can compute new residuals like this:
resid <- y - with(s,sweep(u[, 1:2], 2, d[1:2], FUN="*") %*% t(v[, 1:2]))
my_image(cor(resid), zlim = c(-1,1))
axis(side = 2, 1:ncol(y), rev(colnames(y)), las = 2)
and see that the structure that is left is driven by the differences between math and science. Confirm this by first plotting  U3 ,
then plotting  V⊤3  using the same range for the y-axis limits, then making an image of  U3d3,3V⊤3  and comparing it to the image of resid
Answer:
Code:

##Q13:The third column clearly relates to a student's difference in ability in math and science. We can see this most clearly from the plot of s$v[,3].
Adding the matrix we obtain with these two columns will help with our approximation:
Y≈d1,1U1V⊤1+d2,2U2V⊤2+d3,3U3V⊤3 
We know it will explain: sum(s$d[1:3]^2)/sum(s$d^2) * 100 percent of the total variability. We can compute new residuals like this:
resid <- y - with(s,sweep(u[, 1:3], 2, d[1:3], FUN="*") %*% t(v[, 1:3]))
my_image(cor(resid), zlim = c(-1,1))
axis(side = 2, 1:ncol(y), rev(colnames(y)), las = 2)

We no longer see structure in the residuals: they seem to be independent of each other.
This implies that we can describe the data with the following model:

Y=d1,1U1V⊤1+d2,2U2V⊤2+d3,3U3V⊤3+ε 
with  ε  a matrix of independent identically distributed errors.
This model is useful because we summarize of  100×24  observations with  3×(100+24+1)=375  numbers.

Furthermore, the three components of the model have useful interpretations:
1 - the overall ability of a student
2 - the difference in ability between the math/sciences and arts
3 - the remaining differences between the three subjects.
The sizes  d1,1,d2,2  and  d3,3  tell us the variability explained by each component. Finally, note that the components  dj,jUjV⊤j  are equivalent to the jth principal component.
Finish the exercise by plotting an image of  Y , an image of  d1,1U1V⊤1+d2,2U2V⊤2+d3,3U3V⊤3  and an image of the residuals, all with the same zlim.
Answer:
Code:


###Assessments on edX
###Section 6.3: Regularization (Part 3)
  
##Q1:We want to explore the tissue_gene_expression predictors by plotting them.
data("tissue_gene_expression")
dim(tissue_gene_expression$x)
We want to get an idea of which observations are close to each other, but, as you can see from the dimensions, the predictors are 500-dimensional, making plotting difficult.
Plot the first two principal components with color representing tissue type.
Which tissue is in a cluster by itself?
cerebellum; colon; endometrium; hippocampus; kidney; liver; placenta
Answer:
Code:
  
##Q2:The predictors for each observation are measured using the same device and experimental procedure.
This introduces biases that can affect all the predictors from one observation.
For each observation, compute the average across all predictors, and then plot this against the first PC with color representing tissue.
Report the correlation.
What is the correlation?
Answer:
Code:
  
##Q3:We see an association with the first PC and the observation averages. Redo the PCA but only after removing the center.
Part of the code is provided for you.

#BLANK
pc <- prcomp(x)
data.frame(pc_1 = pc$x[,1], pc_2 = pc$x[,2], 
           tissue = tissue_gene_expression$y) %>%
  ggplot(aes(pc_1, pc_2, color = tissue)) +
  geom_point()

Which line of code should be used to replace #BLANK in the code block above?
(a)x <- with(tissue_gene_expression, sweep(x, 1, mean(x)))
(b)x <- sweep(x, 1, rowMeans(tissue_gene_expression$x))
(c)x <- tissue_gene_expression$x - mean(tissue_gene_expression$x)
(d)x <- with(tissue_gene_expression, sweep(x, 1, rowMeans(x)))
Answer:
Code:
  
##Q4:For the first 10 PCs, make a boxplot showing the values for each tissue.
For the 7th PC, which two tissues have the greatest median difference?
Select the TWO tissues that have the greatest median difference.
cerebellum; colon; endometrium; hippocampus; kidney; liver; placenta
Answer:
Code:
  
##Q5:Plot the percent variance explained by PC number. Hint: use the summary function.
How many PCs are required to reach a cumulative percent variance explained greater than 50%?
Answer:
Code:


###Assessments on edX
###Section 6.3: Regularization (Part 4)
      
##Q1:Load the tissue_gene_expression dataset. Remove the row means and compute the distance between each observation. Store the result in d.
Which of the following lines of code correctly does this computation?
(a)d <- dist(tissue_gene_expression$x)
(b)d <- dist(rowMeans(tissue_gene_expression$x))
(c)d <- dist(rowMeans(tissue_gene_expression$y))
(d)d <- dist(tissue_gene_expression$x - rowMeans(tissue_gene_expression$x))
Answer:
Code:
  
##Q2:Make a hierarchical clustering plot and add the tissue types as labels.
You will observe multiple branches.
Which tissue type is in the branch farthest to the left?
cerebellum; colon; endometrium; hippocampus; kidney; liver; placenta
Answer:
Code:
  
##Q3:Select the 50 most variable genes. Make sure the observations show up in the columns, that the predictor are centered, and add a color bar to show the different tissue types.
Hint: use the ColSideColors argument to assign colors. Also, use col = RColorBrewer::brewer.pal(11, "RdBu") for a better use of colors.
Part of the code is provided for you here:
library(RColorBrewer)
sds <- matrixStats::colSds(tissue_gene_expression$x)
ind <- order(sds, decreasing = TRUE)[1:50]
colors <- brewer.pal(7, "Dark2")[as.numeric(tissue_gene_expression$y)]
#BLANK

Which line of code should replace #BLANK in the code above?
(a)heatmap(t(tissue_gene_expression$x[,ind]), col = brewer.pal(11, "RdBu"), scale = "row", ColSideColors = colors)
(b)heatmap(t(tissue_gene_expression$x[,ind]), col = brewer.pal(11, "RdBu"), scale = "row", ColSideColors = rev(colors))
(c)heatmap(t(tissue_gene_expression$x[,ind]), col = brewer.pal(11, "RdBu"), scale = "row", ColSideColors = sample(colors))
(d)heatmap(t(tissue_gene_expression$x[,ind]), col = brewer.pal(11, "RdBu"), scale = "row", ColSideColors = sample(colors))
Answer:
Code:



 
###Assessments on edX
###Section 


Q1:
Answer:
Code:
  
Q2:
Answer:
Code:
  
Q3:
Answer:
Code:
  
Q4:
Answer:
Code:
  
Q5:
Answer:
Code:
  
Q6:
Answer:
Code:
  
Q7:
Answer:
Code:
  
Q8:
Answer:
Code: