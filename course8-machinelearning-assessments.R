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
###Section : 

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

###Assessments on edX
###Section : 

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


