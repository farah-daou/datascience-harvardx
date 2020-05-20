####Program: Data Science by HarvardX
####Course 7: Linear Regression


###Assessments on edX
###Section 1: Baseball as a Motivating Example

##Q1:What is the application of statistics and data science to baseball called?
(a)Moneyball;(b)Sabermetrics;(c)The “Oakland A’s Approach”;
(d)There is no specific name for this; it’s just data science.
Answer:(b)
Explanation:The term “sabermetrics” was coined by Bill James, and is derived from
the acronym SABR: the society for American baseball research.
  
##Q2:Which of the following outcomes is not included in the batting average?
(a)A home run;(b)A base on balls;(c)An out;(d)A single
Answer:(b)
Explanation:A base on balls is not considered a hit and is excluded from the at-bat total.
Batting average is calculated as hits divided by total at-bats.
Bases on balls are not considered hits and are excluded from the total number of at-bats.

##Q3:Why do we consider team statistics as well as individual player statistics?
(a)The success of any individual player also depends on the strength of their team.
(b)Team statistics can be easier to calculate.
(c)The ultimate goal of sabermetrics is to rank teams, not players.
Answer:(a)
Explanation:Team statistics are important because the success of individual players
depends also on the strength of their team.

##Q4:You want to know whether teams with more at-bats per game have more runs per game.
What R code below correctly makes a scatter plot for this relationship?
(a)Teams %>% filter(yearID %in% 1961:2001 ) %>%
  ggplot(aes(AB, R)) + 
  geom_point(alpha = 0.5)
(b)Teams %>% filter(yearID %in% 1961:2001 ) %>%
  mutate(AB_per_game = AB/G, R_per_game = R/G) %>%
  ggplot(aes(AB_per_game, R_per_game)) + 
  geom_point(alpha = 0.5)

(c)Teams %>% filter(yearID %in% 1961:2001 ) %>%
  mutate(AB_per_game = AB/G, R_per_game = R/G) %>%
  ggplot(aes(AB_per_game, R_per_game)) + 
  geom_line()

(d)Teams %>% filter(yearID %in% 1961:2001 ) %>%
  mutate(AB_per_game = AB/G, R_per_game = R/G) %>%
  ggplot(aes(R_per_game, AB_per_game)) + 
  geom_point()
Answer:(b)
Explanation:This is the only block of code that makes a scatter plot of
runs per game (y-axis) vs. at-bats per game (x-axis).
  
##Q5:What does the variable “SOA” stand for in the Teams table?
Hint: make sure to use the help file (?Teams).
(a)sacrifice out;(b)slides or attempts;
(c)strikeouts by pitchers;(d)accumulated singles
Answer:(c)
Explanation:Using the help file (?Teams) shows that the variable "SOA" stands for
"strikeouts by pitchers."
  
##Q6:Load the Lahman library.
Filter the Teams data frame to include years from 1961 to 2001.
Make a scatterplot of runs per game versus at bats (AB) per game.
Which of the following is true?
(a)There is no clear relationship between runs and at bats per game.
(b)As the number of at bats per game increases, the number of runs per game tends to increase.
(c)As the number of at bats per game increases, the number of runs per game tends to decrease.
Answer:(b)
Explanation:When you examine the scatterplot, you can see a clear trend towards increasing runs
per game with increasing number of at-bats per game.
The following code can be used to make the scatterplot:
  
library(Lahman)
library(tidyverse)
library(dslabs)
Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(AB_per_game = AB / G, R_per_game = R / G) %>%
  ggplot(aes(AB_per_game, R_per_game)) + 
  geom_point(alpha = 0.5)
  
##Q7:Use the filtered Teams data frame from Question 6.
Make a scatterplot of win rate (number of wins per game) versus number of fielding errors (E) per game.
Which of the following is true?
(a)There is no relationship between win rate and errors per game.
(b)As the number of errors per game increases, the win rate tends to increase.
(c)As the number of errors per game increases, the win rate tends to decrease.
Answer:(c)
Explanation:When you examine the scatterplot, you can see a clear trend towards decreased
win rate with increasing number of errors per game.
The following code can be used to make the scatterplot:
  
Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(win_rate = W / G, E_per_game = E / G) %>%
  ggplot(aes(win_rate, E_per_game)) + 
  geom_point(alpha = 0.5)
  
##Q8:Use the filtered Teams data frame from Question 6.
Make a scatterplot of triples (X3B) per game versus doubles (X2B) per game.
Which of the following is true?
(a)There is no clear relationship between doubles per game and triples per game.
(b)As the number of doubles per game increases, the number of triples per game tends to increase.
(c)As the number of doubles per game increases, the number of triples per game tends to decrease.
Answer:(a)
Explanation:When you examine the scatterplot, you can see no clear relationship
between doubles and triples per game.
The following code can be used to make the scatterplot:
  
Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(doubles_per_game = X2B / G, triples_per_game = X3B / G) %>%
  ggplot(aes(doubles_per_game, triples_per_game)) + 
  geom_point(alpha = 0.5)
  



###Assessments on edX
###Section 1: Correlation
  
##Q1:While studying heredity, Francis Galton developed what important statistical concept?
(a)Standard deviation;(b)Normal distribution;(c)Correlation;(d)Probability
Answer:(c)
Explanation:Francis Galton developed the concept of correlation while study heredity.

##Q2:The correlation coefficient is a summary of what?
(a)The trend between two variables
(b)The dispersion of a variable
(c)The central tendency of a variable
(d)The distribution of a variable
Answer:(a)
Explanation:The correlation coefficient is a summary of the trend between two variables.
The standard deviation describes the dispersion of a variable;
the mean is a description of a variable’s central tendency;
the distribution of a variable (e.g., normal, log-normal) describes the possible values of your
data and the probability of them occurring.
  
##Q3:Below is a scatter plot showing the relationship between two variables, x and y.
From this figure, the correlation between x and y appears to be about:
(a)-0.9;(b)-0.2;(c)0.9;(d)2
Answer:(a)
Explanation:The correlation appears to be about -0.9.
The variables x and y have a strong negative relationship with each other;
as x increases, y decreases.
  
##Q4:Instead of running a Monte Carlo simulation with a sample size of 25 from the 179
father-son pairs described in the videos,
we now run our simulation with a sample size of 50.
Would you expect the mean of our sample correlation to increase, decrease, or stay approximately the same?
(a)Increase;(b)Decrease;(c)Stay approximately the same
Answer:(c)
Explanation:Because the expected value of the sample correlation is the population correlation,
it should stay approximately the same even if the sample size is increased.

##Q5:Instead of running a Monte Carlo simulation with a sample size of 25 from the 179
father-son pairs described in the videos,
we now run our simulation with a sample size of 50.
Would you expect the standard deviation of our sample correlation to
increase, decrease, or stay approximately the same?
(a)Increase;(b)Decrease;(c)Stay approximately the same
Answer:(b)
Explanation:As the sample size N increases,
the standard deviation of the sample correlation should decrease.
  
##Q6:If X and Y are completely independent,
what do you expect the value of the correlation coefficient to be?
(a)-1;(b)-0.5;(c)0;(d)0.5;(e)1
(f)Not enough information to answer the question
Answer:(c)
Explanation:Variables that are independent of each other have a correlation coefficient of 0.
  
##Q7:Load the Lahman library. Filter the Teams data frame to include years from 1961 to 2001.
What is the correlation coefficient between number of runs per game and number of at bats per game?
Answer:0.6580976
Code:The correlation coefficient can be calculated using the following code:
library(Lahman)
Teams_small <- Teams %>% filter(yearID %in% 1961:2001)
cor(Teams_small$R/Teams_small$G, Teams_small$AB/Teams_small$G)
  
##Q8:Use the filtered Teams data frame from Question 7.
What is the correlation coefficient between win rate (number of wins per game)
and number of errors per game?
Answer:-0.3396947
Code:The correlation coefficient can be calculated using the following code:
cor(Teams_small$W/Teams_small$G, Teams_small$E/Teams_small$G)
  
##Q9:Use the filtered Teams data frame from Question 7.
What is the correlation coefficient between doubles (X2B) per game and triples (X3B) per game?
Answer:-0.01157404
Code:The correlation coefficient can be calculated using the following code:
cor(Teams_small$X2B/Teams_small$G, Teams_small$X3B/Teams_small$G)




####Assessments on edX
####Section 1: Stratification and Variance Explained

##Q1:Look at the figure below.
The slope of the regression line in this figure is equal to what, in words?
(a)Slope = (correlation coefficient of son and father heights) *
  (standard deviation of sons’ heights / standard deviation of fathers’ heights)
(b)Slope = (correlation coefficient of son and father heights) *
  (standard deviation of fathers’ heights / standard deviation of sons’ heights)
(c)Slope = (correlation coefficient of son and father heights) /
  (standard deviation of sons’ heights * standard deviation of fathers’ heights)
(d)Slope = (mean height of fathers) - (correlation coefficient of son and father heights
  * mean height of sons).
Answer:(a)
Explanation:From the notes, we know that the slope is  m=ρσyσx .
Expressed in words, the slope is the correlation coefficient of the son and father heights
times the standard deviation of the sons' heights divided by the standard deviation of the fathers' heights.


##Q2:Why does the regression line simplify to a line with intercept zero and slope ρ
when we standardize our x and y variables?
Try the simplification on your own first!
(a)When we standardize variables, both x and y will have a mean of one and a standard deviation of zero.
When you substitute this into the formula for the regression line,
the terms cancel out until we have the following equation:  yi=ρxi .
(b)When we standardize variables, both x and y will have a mean of zero and a standard deviation of one.
When you substitute this into the formula for the regression line,
the terms cancel out until we have the following equation:  yi=ρxi .
(c)When we standardize variables, both x and y will have a mean of zero and a standard deviation of one.
When you substitute this into the formula for the regression line,
the terms cancel out until we have the following equation:  yi=ρ+xi .
Answer:(b)
Explanation:When we standardize variables, they have a mean of 0 and a standard deviation of 1,
giving the equation  yi=ρxi .
The equation  yi=ρ+xi  is for a line with an intercept equal to the correlation coefficient,
but the regression line simplifies
to have an intercept of 0 when we standardize variables.
  
##Q3:What is a limitation of calculating conditional means?
Select ALL that apply.
(a)Each stratum we condition on (e.g., a specific father’s height) may not have many data points.
(b)Because there are limited data points for each stratum, our average values have large standard errors.
(c)Conditional means are less stable than a regression line.
(d)Conditional means are a useful theoretical tool but cannot be calculated.
Answer:(a),(b),and(c)
Explanation:Some limitations of calculating conditional means include:
each specific stratum used for conditioning may not have data points,
because there are limited data points for each stratum there may be large standard errors on the means,
and conditional means are less stable than a regression line.
Conditional means can be calculated, so it is not correct that they are only useful as a theoretical tool.
  
##Q4:A regression line is the best prediction of Y given we know the value of X when:
(a)X and Y follow a bivariate normal distribution.
(b)Both X and Y are normally distributed.
(c)Both X and Y have been standardized.
(d)There are at least 25 X-Y pairs.
Answer:(a)
Explanation:In order for the regression line to be the best predictor of Y given a known value of X,
X and Y must follow a bivariate normal distribution.
It is insufficient for X and Y to each be normally distributed on their own;
they must also have a joint bivariate normal distribution.
  
##Q5:Which one of the following scatterplots depicts an x and y distribution that is
NOT well-approximated by the bivariate normal distribution?
Answer:(a)
Explanation:The v-shaped distribution of points from the first plot means that the x and y variables
do not follow a bivariate normal distribution.
When a pair of random variables is approximated by a bivariate normal, the scatter plot looks like an oval
(as in the 2nd, 3rd, and 4th plots)
It is okay if the oval is very round (as in the 3rd plot) or long and thin (as in the 4th plot).
  
##Q6:We previously calculated that the correlation coefficient  ρ  between fathers’ and sons’ heights is 0.5.
Given this, what percent of the variation in sons’ heights is explained by fathers’ heights?
(a)0%;(b)25%;(c)50%;(d)75%
Answer:(b)
Explanation:When two variables follow a bivariate normal distribution,
the variation explained can be calculated as  ρ2×100 .
In this case, with a correlation coefficient of 0.5,
then the the variance explained is  0.52×100=25% .

##Q7:Suppose the correlation between father and son’s height is 0.5,
the standard deviation of fathers’ heights is 2 inches,
and the standard deviation of sons’ heights is 3 inches.
Given a one inch increase in a father’s height,
what is the predicted change in the son’s height?
(a)0.333;(b)0.5;(c)0.667;(d)0.75;(e)1;(f)1.5
Answer:(d)
Explanation:The slope of the regression line is calculated by multiplying the correlation coefficient
by the ratio of the standard deviation of son heights and standard deviation of father heights: 
σson/σfather. In this case, that is  0.5×3/2.


In the second part of this assessment, you'll analyze a set of mother and daughter heights,
also from GaltonFamilies. Define female_heights, a set of mother and daughter heights
sampled from GaltonFamilies, as follows:

set.seed(1989) #if you are using R 3.5 or earlier
set.seed(1989, sample.kind="Rounding") #if you are using R 3.6 or later
library(HistData)
data("GaltonFamilies")

female_heights <- GaltonFamilies%>%     
  filter(gender == "female") %>%     
  group_by(family) %>%     
  sample_n(1) %>%     
  ungroup() %>%     
  select(mother, childHeight) %>%     
  rename(daughter = childHeight)


##Q8:Calculate the mean and standard deviation of mothers' heights, the mean and standard deviation
of daughters' heights, and the correlaton coefficient between mother and daughter heights.
(a)Mean of mothers' heights=64.1
Code:mean(female_heights$mother)
(b)Standard deviation of mothers' heights=2.29
Code:sd(female_heights$mother)
(c)Mean of daughters' heights=64.3
Code:mean(female_heights$daughter)
(d)Standard deviation of daughters' heights=2.39
Code:sd(female_heights$daughter)
(e)Correlation coefficient=0.325
Code:cor(female_heights$mother, female_heights$daughter)
  
##Q9:Calculate the slope and intercept of the regression line
predicting daughters' heights given mothers' heights.
Given an increase in mother's height by 1 inch, how many inches is the daughter's height expected to change?
(a)Slope of regression line predicting daughters' height from mothers' heights=0.339
Code:r <- cor(female_heights$mother, female_heights$daughter)
s_y <- sd(female_heights$daughter)
s_x <- sd(female_heights$mother)
r * s_y/s_x
(b)Intercept of regression line predicting daughters' height from mothers' heights=42.5
Code:mu_y <- mean(female_heights$daughter)
mu_x <- mean(female_heights$mother)
mu_y - (r * s_y/s_x)*mu_x
(c)Change in daughter's height in inches given a 1 inch increase in the mother's height=0.339
Code:r * s_y/s_x
  
##Q10:What percent of the variability in daughter heights is explained by the mother's height?
Report your answer as a value between 0 and 100.
Answer:10.5
Code:r^2*100
  
##Q11:A mother has a height of 60 inches.
What is the conditional expected value of her daughter's height given the mother's height?
Answer:62.9
Code:The expected height can be calculated using the following code:
m = r * s_y/s_x
b = mu_y - (r * s_y/s_x)*mu_x
x = 60
m*x+b




####Assessments on edX
####Section 2: Introduction to Linear Models

##Q1:As described in the videos, when we stratified our regression lines for
runs per game vs. bases on balls by the number of home runs, what happened?
(a)The slope of runs per game vs. bases on balls within each stratum
was reduced because we removed confounding by home runs.
(b)The slope of runs per game vs. bases on balls within each stratum
was reduced because there were fewer data points.
(c)The slope of runs per game vs. bases on balls within each stratum
increased after we removed confounding by home runs.
(d)The slope of runs per game vs. bases on balls within each stratum
stayed about the same as the original slope.
Answer:(a)
Explanation:Home runs are a confounder in the runs per game vs. bases on balls regression analysis.
When we removed confounding by home runs, the slope of runs per game vs. bases on balls
within each stratum decreased.

##Q2:We run a linear model for sons’ heights vs. fathers’ heights
using the Galton height data, and get the following results:
> lm(son ~ father, data = galton_heights)
Call:
lm(formula = son ~ father, data = galton_heights)
Coefficients:
(Intercept)    father  
35.71       0.50  
Interpret the numeric coefficient for "father."
(a)For every inch we increase the son’s height,
the predicted father’s height increases by 0.5 inches.
(b)For every inch we increase the father’s height,
the predicted son’s height grows by 0.5 inches.
(c)For every inch we increase the father’s height,
the predicted son’s height is 0.5 times greater.
Answer:(b)
Explanation:The coefficient for “father” gives the predicted increase in son’s height for
each increase of 1 unit in the father’s height. In this case, it means that for every inch
we increase the father’s height, the son’s predicted height increases by 0.5 inches.

##Q3:We want the intercept term for our model to be more interpretable,
so we run the same model as before but now we subtract the mean of fathers’ heights
from each individual father’s height to create a new variable centered at zero.
galton_heights <- galton_heights %>%
  mutate(father_centered=father - mean(father))
We run a linear model using this centered fathers’ height variable.
> lm(son ~ father_centered, data = galton_heights)
Call:
  lm(formula = son ~ father_centered, data = galton_heights)
Coefficients:
  (Intercept)    father_centered  
70.45          0.50  
Interpret the numeric coefficient for the intercept.
(a)The height of a son of a father of average height is 70.45 inches.
(b)The height of a son when a father’s height is zero is 70.45 inches.
(c)The height of an average father is 70.45 inches.
Answer:(a)
Explanation:Because the fathers’ heights (the independent variable) have been centered on their mean,
the intercept represents the height of the son of a father of average height.
In this case, that means that the height of a son of a father of average height is 70.45 inches.
If we had not centered fathers’ heights to its mean, then the intercept would represent
the height of a son when a father’s height is zero.

##Q4:Suppose we fit a multivariate regression model for expected runs based on BB and HR:
E[R|BB=x1,HR=x2]=β0+β1x1+β2x2 
Suppose we fix  BB=x1 . Then we observe a linear relationship between runs and HR with intercept of:
(a)β0 ;(b)β0+β2x2 ;(c)β0+β1x1 ;(d)β0+β2x1
Answer:(c)
Explanation:If x1 is fixed, then  β1x1  is fixed and acts as the intercept for this regression model.
This is the basis of stratificaton.

##Q5:Which of the following are assumptions for the errors  ϵi  in a linear regression model?
Check ALL correct answers.
(a)The  ϵi  are independent of each other
(b)The  ϵi  have expected value 0
(c)The variance of  ϵi  is a constant
Answer:(a),(b),and(c)




####Assessments of edX
####Section 2: Least Squares Estimates

##Q1:The following code was used in the video to plot RSS with β0=25 .
beta1 = seq(0, 1, len=nrow(galton_heights))
results <- data.frame(beta1 = beta1,
                      rss = sapply(beta1, rss, beta0 = 25))
results %>% ggplot(aes(beta1, rss)) + geom_line() + 
  geom_line(aes(beta1, rss), col=2)
In a model for sons’ heights vs fathers’ heights,
what is the least squares estimate (LSE) for  β1  if we assume  β^0  is 36?
Hint: modify the code above to do your analysis.
(a)0.65; (b)0.5; (c)0.2; (d)12
Answer:(b)
Explanation:Using the code from the video, you can plot RSS vs β1 to find the value for β1
that minimizes the RSS. In this case, that value is 0.5 when we assume that  β^0  is 36.
When we assumed that β^0 was 25, as in the sample code, the LSE for β1 was 0.65.

##Q2:The least squares estimates for the parameters β0,β1,…,βn ________ the residual sum of squares.
(a)maximize; (b)minimize; (c)equal
Answer:(b)
Explanation:The least squares estimates minimize, not maximize, the residual sum of squares.
  
##Q3:Load the Lahman library and filter the Teams data frame to the years 1961-2001.
Run a linear model in R predicting the number of runs per game based on both the number of
bases on balls per game and the number of home runs per game.
What is the coefficient for bases on balls?
(a)0.39; (b)1.56; (c)1.74; (d)0.027
Answer:(a)
Explanation:The coefficient for bases on balls is 0.39; the coefficient for home runs is 1.56;
the intercept is 1.74; the standard error for the BB coefficient is 0.027.

##Q4:We run a Monte Carlo simulation where we repeatedly take samples of N = 100 from the
Galton heights data and compute the regression slope coefficients for each sample:
  B <- 1000
N <- 100
lse <- replicate(B, {
  sample_n(galton_heights, N, replace = TRUE) %>% 
    lm(son ~ father, data = .) %>% .$coef 
})

lse <- data.frame(beta_0 = lse[1,], beta_1 = lse[2,]) 
What does the central limit theorem tell us about the variables beta_0 and beta_1?
Select ALL that apply.
(a)They are approximately normally distributed.
(b)The expected value of each is the true value of  β0  and  β1
(assuming the Galton heights data is a complete population).
(c)The central limit theorem does not apply in this situation.
(d)It allows us to test the hypothesis that  β0=0  and  β1=0 .
Answer:(a) and (b)
Explanation:With a large enough N, the central limit theorem applies and tells us that the
distributions of both beta_0 and beta_1 are approximately normal.
The expected values of beta_0 and beta_1 are the true values of β0 and β1,
assuming that the Galton heights data are a complete population.
For hypothesis testing, we assume that the errors in the model are normally distributed.
  
##Q5:In an earlier video, we ran the following linear model and looked at a summary of the results.
mod <- lm(son ~ father, data = galton_heights)
summary(mod)
Call:
  lm(formula = son ~ father, data = galton_heights)

Residuals:
  Min     1Q  Median     3Q    Max 
-5.902  -1.405  0.092    1.342  8.092 

Coefficients:
  Estimate  Std. Error  t value     Pr(>|t|)  
(Intercept)     35.7125     4.5174       7.91    2.8e-13 ***
  father           0.5028     0.0653       7.70    9.5e-13 ***
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
What null hypothesis is the second p-value (the one in the father row) testing?
(a)β1=1, where β1 is the coefficient for the variable "father."
(b)β1=0.503, where β1 is the coefficient for the variable "father."
(c)β1=0, where β1 is the coefficient for the variable "father."
Answer:(c)
Explanation:The p-value for "father" tests the null hypothesis that  β1=0 , i.e., the fathers' heights
are not associated with the sons' heights, where  β1  is the coefficient for the variable father.
  
##Q6:Which R code(s) below would properly plot the predictions and
confidence intervals for our linear model of sons’ heights?
Select ALL that apply.
(a)galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth()
(b)galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth(method = "lm")
(c)model <- lm(son ~ father, data = galton_heights)
predictions <- predict(model, interval = c("confidence"), level = 0.95)
data <- as_tibble(predictions) %>% bind_cols(father = galton_heights$father)
ggplot(data, aes(x = father, y = fit)) +
  geom_line(color = "blue", size = 1) + 
  geom_ribbon(aes(ymin=lwr, ymax=upr), alpha=0.2) + 
  geom_point(data = galton_heights, aes(x = father, y = son))
(d)model <- lm(son ~ father, data = galton_heights)
predictions <- predict(model)
data <- as_tibble(predictions) %>% bind_cols(father = galton_heights$father)

ggplot(data, aes(x = father, y = fit)) +
  geom_line(color = "blue", size = 1) + 
  geom_point(data = galton_heights, aes(x = father, y = son))
Answer:(b) and (c)
Explanation:If using the geom_smooth command, you need to specify that method = “lm” in
your geom_smooth command, otherwise the smooth line is a loess smooth and not a linear model.
If using the predict command, you need to include the confidence intervals on your figure by
first specifying that you want confidence intervals in the predict command,
and then adding them to your figure as a geom_ribbon.
  

Define female_heights, a set of mother and daughter heights sampled from GaltonFamilies, as follows:
  
set.seed(1989) #if you are using R 3.5 or earlier
set.seed(1989, sample.kind="Rounding") #if you are using R 3.6 or later
library(HistData)
data("GaltonFamilies")
options(digits = 3)    # report 3 significant digits

female_heights <- GaltonFamilies %>%     
  filter(gender == "female") %>%     
  group_by(family) %>%     
  sample_n(1) %>%     
  ungroup() %>%     
  select(mother, childHeight) %>%     
  rename(daughter = childHeight)

##Q7:Fit a linear regression model predicting the mothers' heights using daughters' heights.
(a)What is the slope of the model?
Answer=0.31
Code:fit <- lm(mother ~ daughter, data = female_heights)
fit$coef[2]

(b)What the intercept of the model?
Answer=44.12
Code:fit$coef[1]
  
##Q8:Predict mothers' heights using the model.
(a)What is the predicted height of the first mother in the dataset?
Answer=65.6
Code:predict(fit)[1]

(b)What is the actual height of the first mother in the dataset?
Answer=67
Code:female_heights$mother[1]
  

We have shown how BB and singles have similar predictive power for scoring runs.
Another way to compare the usefulness of these baseball metrics is by assessing
how stable they are across the years. Because we have to pick players based on their
previous performances, we will prefer metrics that are more stable.
In these exercises, we will compare the stability of singles and BBs.

Before we get started, we want to generate two tables:
one for 2002 and another for the average of 1999-2001 seasons.
We want to define per plate appearance statistics,
keeping only players with more than 100 plate appearances.
Here is how we create the 2002 table:

library(Lahman)
bat_02 <- Batting %>% filter(yearID == 2002) %>%
    mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
    filter(pa >= 100) %>%
    select(playerID, singles, bb)

##Q9:Now compute a similar table but with rates computed over 1999-2001.
Keep only rows from 1999-2001 where players have 100 or more plate appearances,
calculate each player's single rate and BB rate per season,
then calculate the average single rate (mean_singles) and
average BB rate (mean_bb) per player over those three seasons.
(a)How many players had a single rate mean_singles of greater than 0.2 per plate appearance over 1999-2001?
Answer=46
Code:bat_99_01 <- Batting %>% filter(yearID %in% 1999:2001) %>%
  mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
  filter(pa >= 100) %>%
  group_by(playerID) %>%
  summarize(mean_singles = mean(singles), mean_bb = mean(bb))
sum(bat_99_01$mean_singles > 0.2)

(b)How many players had a BB rate mean_bb of greater than 0.2 per plate appearance over 1999-2001?
Answer=3
Code:sum(bat_99_01$mean_bb > 0.2)
  
##Q10:Use inner_join() to combine the bat_02 table with the table of 1999-2001
rate averages you created in the previous question.
(a)What is the correlation between 2002 singles rates and 1999-2001 average singles rates?
Answer=0.551
Code:dat <- inner_join(bat_02, bat_99_01)
cor(dat$singles, dat$mean_singles)

(b)What is the correlation between 2002 BB rates and 1999-2001 average BB rates?
Answer=0.717
Code:cor(dat$bb, dat$mean_bb)
  
##Q11:Make scatterplots of mean_singles versus singles and mean_bb versus bb.
Are either of these distributions bivariate normal?
(a)Neither distribution is bivariate normal.
(b)singles and mean_singles are bivariate normal, but bb and mean_bb are not.
(c)bb and mean_bb are bivariate normal, but singles and mean_singles are not.
(d)Both distributions are bivariate normal.
Answer:(d)
Code:Both distributions are bivariate normal, as can be seen in the scatter plots
made using the following code:
dat %>%
  ggplot(aes(singles, mean_singles)) +
  geom_point()
dat %>%
  ggplot(aes(bb, mean_bb)) +
  geom_point()
  
##Q12:
(a)Fit a linear model to predict 2002 singles given 1999-2001 mean_singles.
What is the coefficient of mean_singles, the slope of the fit?
Answer=0.5881
Code:fit_singles <- lm(singles ~ mean_singles, data = dat)
fit_singles$coef[2]

(b)Fit a linear model to predict 2002 bb given 1999-2001 mean_bb.
What is the coefficient of mean_bb, the slope of the fit?
Answer=0.8290
Code:fit_bb <- lm(bb ~ mean_bb, data = dat)
fit_bb$coef[2]
  
  
  
  
####Assessments on edX
####Section 2: Tibbles, do, and broom


##Q1:As seen in the videos, what problem do we encounter when we try to run a
linear model on our baseball data, grouping by home runs?
(a)There is not enough data in some levels to run the model.
(b)The lm() function does not know how to handle grouped tibbles.
(c)The results of the lm() function cannot be put into a tidy format.
Answer:(b)
Explanation:The lm() function does not know how to handle grouped tibbles, so we can't simply
run a linear model on the baseball data grouped by home runs.
We need something to bridge between the grouped tibble and the lm() function.
  
##Q2:Tibbles are similar to what other class in R?
(a)Vectors; (b)Matrices; (c)Data frames; (d)Lists
Answer:(c)
Explanation:Tibbles are essentially modern versions of data frames.
  
##Q3:What are some advantages of tibbles compared to data frames?
Select ALL that apply.
(a)Tibbles display better.
(b)If you subset a tibble, you always get back a tibble.
(c)Tibbles can have complex entries.
(d)Tibbles can be grouped.
Answer:(a), (b), (c), and (d)
Explanation:All of the listed answers are advantages of tibbles when compared to data frames:
tibbles display better, they always return tibbles when subsetted,
they can have complex entries, and they can be grouped.
  
##Q4:What are two advantages of the do() command, when applied to the tidyverse?
Select TWO.
(a)It is faster than normal functions.
(b)It returns useful error messages.
(c)It understands grouped tibbles.
(d)It always returns a data.frame.
Answer: (c) and (d)
Explanation:The do function serves as a useful bridge between base R functions and the tidyverse.
It understands grouped tibbles and always returns a data.frame.

##Q5:You want to take the tibble dat, which we used in the video on the do() function,
and run the linear model R ~ BB for each strata of HR.
Then you want to add three new columns to your grouped tibble:
the coefficient, standard error, and p-value for the BB term in the model.
You’ve already written the function get_slope(), shown below.

get_slope <- function(data) {
  fit <- lm(R ~ BB, data = data)
  sum.fit <- summary(fit)

  data.frame(slope = sum.fit$coefficients[2, "Estimate"], 
             se = sum.fit$coefficients[2, "Std. Error"],
             pvalue = sum.fit$coefficients[2, "Pr(>|t|)"])
}

What additional code could you write to accomplish your goal?
(a)dat %>% 
  group_by(HR) %>% 
  do(get_slope)
(b)dat %>% 
  group_by(HR) %>% 
  do(get_slope(.))
(c)dat %>% 
  group_by(HR) %>% 
  do(slope = get_slope(.))
(d)dat %>% 
  do(get_slope(.))
Answer:(b)
Code:dat %>% 
  group_by(HR) %>% 
  do(get_slope(.))

This is the only command that correctly creates a tibble with four columns:
HR, slope, se, and pvalue for each level of HR. The data frame must be passed to get_slope() using .
If you name the results of the do() command such as in the code do(slope = get_slope(.)),
that will save all results in a single column called slope.
If you forget group_by(), then the results will be a model on the data as a whole,
rather than on the data stratified by home runs.

##Q6:The output of a broom function is always what?
(a)A data.frame; (b)A list; (c)A vector
Answer:(a)
Explanation:The broom functions always output data.frame.
  
##Q7:You want to know whether the relationship between home runs and runs per game varies by baseball league. 
You create the following dataset:

dat <- Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(HR = HR/G,
         R = R/G) %>%
  select(lgID, HR, BB, R) 
What code would help you quickly answer this question?
(a)dat %>% 
  group_by(lgID) %>% 
  do(tidy(lm(R ~ HR, data = .), conf.int = T)) %>% 
  filter(term == "HR") 
(b)dat %>% 
  group_by(lgID) %>% 
  do(glance(lm(R ~ HR, data = .)))
(c)dat %>% 
  do(tidy(lm(R ~ HR, data = .), conf.int = T)) %>% 
  filter(term == "HR")
(d)dat %>% 
  group_by(lgID) %>% 
  do(mod = lm(R ~ HR, data = .))
Answer:(a)
Code:
dat %>% 
  group_by(lgID) %>% 
  do(tidy(lm(R ~ HR, data = .), conf.int = T)) %>% 
  filter(term == "HR")
This code is a good application of the command tidy(), from the broom package.
The glance() function provides data on model fit rather than on effect estimates and confidence intervals.
If you forget the line group_by(lgID), your code will give you a single estimate for the entire dataset
because you have not grouped the data by league ID.

dat %>% 
  group_by(lgID) %>% 
  do(mod = lm(R ~ HR, data = .))
This code gives get a data.frame with the column mod, which contains the linear model results.
While it is possible to then extract effect estimates and confidence intervals from this model,
it is not nearly as easy as using the tidy function.




We have investigated the relationship between fathers' heights and sons' heights.
But what about other parent-child relationships? Does one parent's height have a
stronger association with child height?
How does the child's gender affect this relationship in heights?
Are any differences that we observe statistically significant?

The galton dataset is a sample of one male and one female child from each family in the GaltonFamilies dataset.
The pair column denotes whether the pair is father and daughter, father and son,
mother and daughter, or mother and son.

Create the galton dataset using the code below:

library(tidyverse)
library(HistData)
data("GaltonFamilies")
set.seed(1) # if you are using R 3.5 or earlier
set.seed(1, sample.kind = "Rounding") # if you are using R 3.6 or later
galton <- GaltonFamilies %>%
    group_by(family, gender) %>%
    sample_n(1) %>%
    ungroup() %>% 
    gather(parent, parentHeight, father:mother) %>%
    mutate(child = ifelse(gender == "female", "daughter", "son")) %>%
    unite(pair, c("parent", "child"))

galton
  
##Q8:Group by pair and summarize the number of observations in each group.
(a)How many father-daughter pairs are in the dataset?
Answer = 176
(b)How many mother-son pairs are in the dataset?
Answer = 179

Code:galton %>%
    group_by(pair) %>%
    summarize(n = n())
  
##Q9:Calculate the correlation coefficients for fathers and daughters, fathers and sons,
mothers and daughters and mothers and sons.

Which pair has the strongest correlation in heights?
(a)fathers and daughters; (b)fathers and sons
(c)mothers and daughters; (d)mothers and sons
Answer:(b)
Code:galton %>%
    group_by(pair) %>%
    summarize(cor = cor(parentHeight, childHeight)) %>%
    filter(cor == max(cor))

Which pair has the weakest correlation in heights?
(a)fathers and daughters; (b)fathers and sons
(c)mothers and daughters; (d)mothers and sons
Code:galton %>%
    group_by(pair) %>%
    summarize(cor = cor(parentHeight, childHeight)) %>%
    filter(cor == min(cor))
  
##Q10:Use lm() and the broom package to fit regression lines for each parent-child pair type.
Compute the least squares estimates, standard errors, confidence intervals and p-values
for the parentHeight coefficient for each pair.

(a)What is the estimate of the father-daughter coefficient?
Answer = 0.34
Code:library(broom)
galton %>%
    group_by(pair) %>%
    do(tidy(lm(childHeight ~ parentHeight, data = .), conf.int = TRUE)) %>%
    filter(term == "parentHeight", pair == "father_daughter") %>%
    pull(estimate)

(b)For every 1-inch increase in mother's height, how many inches does the typical son's height increase?
Give your answer as a number with no units.
Answer = 0.381
Code:galton %>%
    group_by(pair) %>%
    do(tidy(lm(childHeight ~ parentHeight, data = .), conf.int = TRUE)) %>%
    filter(term == "parentHeight", pair == "mother_son") %>%
    pull(estimate)
  
##Q11:
Which sets of parent-child heights are significantly correlated at a p-value cut off of .05?
Select ALL that apply.
(a)father-daughter; (b)father-son
(c)mother-daughter; (d)mother-son
Answer:(a), (b), (c), and (d)
Explanation:All of the parent-child heights are correlated with a p-value of <0.05

Which of the following statements are true?
Select ALL that apply.
(a)All of the confidence intervals overlap each other.
(b)At least one confidence interval covers zero.
(c)The confidence intervals involving mothers' heights are larger than the confidence intervals
involving fathers' heights.
(d)The confidence intervals involving daughters' heights are larger than the confidence intervals
involving sons' heights.
(e)The data are consistent with inheritance of height being independent of the child's gender.
(f)The data are consistent with inheritance of height being independent of the parent's gender.
Answer:(a), (c), (e), and (f) 
Code:galton %>%
    group_by(pair) %>%
    do(tidy(lm(childHeight ~ parentHeight, data = .), conf.int = TRUE)) %>%
    filter(term == "parentHeight" & p.value < .05)
All four of the confidence intervals overlap. The confidence intervals for mothers' heights
are larger than those for fathers' heights, as observed from the standard errors.
Because the confidence intervals overlap, the data are consistent with inheritance of height being
independent of the child's or the parent's gender.

  
  
####Assessments on edX
####Section 2: Regression and Baseball
  
  
##Q1:What is the final linear model (in the video "Building a Better Offensive Metric for Baseball")
we used to predict runs scored per game?
(a)lm(R ~ BB + HR)
(b)lm(HR ~ BB + singles + doubles + triples)
(c)lm(R ~ BB + singles + doubles + triples + HR)
(d)lm(R ~ singles + doubles + triples + HR)
Answer:(c)
Explanation:lm(R ~ BB + singles + doubles + triples + HR) is the only one of the
models above that predicts runs scored based on all of the following:
  BBs, singles, doubles, triples, and HRs.
  
##Q2:We want to estimate runs per game scored by individual players, not just by teams.
What summary metric do we calculate to help estimate this?
Look at the code from the video "Building a Metter Offensive Metric for Baseball" for a hint:
  
pa_per_game <- Batting %>% 
  filter(yearID == 2002) %>% 
  group_by(teamID) %>%
  summarize(pa_per_game = sum(AB+BB)/max(G)) %>% 
  .$pa_per_game %>% 
  mean
The summary metric used is:
(a)pa_per_game: the mean number of plate appearances per team per game for each team
(b)pa_per_game: the mean number of plate appearances per game for each player
(c)pa_per_game: the number of plate appearances per team per game, averaged across all teams
Answer:(c)
Explanation:pa_per_game is the number of plate appearances per team per game averaged across all teams.
We initially calculated the pa_per_game grouped by teams
but then took the means across all teams to get one summary metric.
  
##Q3:Imagine you have two teams. Team A is comprised of batters who, on average,
get two bases on balls, four singles, one double, no triples, and one home run.
Team B is comprised of batters who, on average,
get one base on balls, six singles, two doubles, one triple, and no home runs.

Which team scores more runs, as predicted by our model?
(a)Team A; (b)Team B; (c)Tie; (d)Impossible to know
Answer:(b)
Explanation:By using the coefficients from the linear model to predict the number of runs scored
by each team,you find that Team B is expected to score more runs on average.
  
##Q4:The on-base-percentage plus slugging percentage (OPS) metric gives the most weight to:
(a)Singles; (b)Doubles; (c)Triples; (d)Home Runs
Answer:(d)
Explanation:By looking at the equation for OPS, you can tell that the
OPS metric weights home runs most heavily.
  
##Q5:What statistical concept properly explains the “sophomore slump”?
(a)Regression to the mean; (b)Law of averages; (c)Normal distribution
Answer:(a)
Explanation:Regression to the mean is what explains the sophomore slump.
The correlation for performance in two separate years is high but not perfect,
so high performers will tend to perform slightly worse in the following year
(and low performers will tend to perform slightly better in the following year).
  
##Q6:In our model of time vs. observed_distance in the video
"Measurement Error Models", the randomness of our data was due to:
(a)sampling; (b)natural variability; (c)measurement error
Answer:(c)
Explanation:Measurement error models look at applications where randomness
is introduced from measurement error instead of sampling or natural variability.
  
##Q7:Which of the following are important assumptions about the measurement errors
in the experiment presented in the video "Measurement Error Models"?
Select ALL that apply.
(a)The measurement error is random
(b)The measurement error is independent
(c)The measurement error has the same distribution for each time  i
Answer:(a), (b), and (c)
Explanation:In this model, we asumed that the measurement errors were random,
independent from each other, and had the same distribution for each time i.
We also assumed that there was no bias, which means that  E[ε]=0 .
  
##Q8:Which of the following scenarios would violate an assumption of our measurement error model?
(a)The experiment was conducted on the moon.
(b)There was one position where it was particularly difficult to see the dropped ball.
(c)The experiment was only repeated 10 times, not 100 times.
Answer: (b)
Explanation:If there were one position where it was particularly difficult to see the dropped ball,
that would violate the assumption of randomness.
If the experiment were conducted on the moon, that would simply predict a different gravitational constant.
Repeating the experiment 10 instead of 100 times would not matter
because we do not need a large sample for our assumptions to be valid in this model.
  
##Q9:Use the Teams data frame from the Lahman package.
Fit a multivariate linear regression model to obtain the effects of BB and HR on Runs (R) in 1971.
Use the tidy() function in the broom package to obtain the results in a data frame.
(a)What is the estimate for the effect of BB on runs?
Answer = 0.412
Code:library(Lahman)
library(broom)
Teams %>%
  filter(yearID == 1971) %>%
  lm(R ~ BB + HR, data = .) %>%
  tidy() %>%
  filter(term == "BB") %>%
  pull(estimate)
  
(b)What is the estimate for the effect of HR on runs?
Answer = 1.29
Code:The estimate can be calculated using the following code:
Teams %>%
  filter(yearID == 1971) %>%
  lm(R ~ BB + HR, data = .) %>%
  tidy() %>%
  filter(term == "HR") %>%
  pull(estimate)
  
(c)Interpret the p-values for the estimates using a cutoff of 0.05.
Which of the following is the correct interpretation?
(a)Both BB and HR have a nonzero effect on runs.
(b)HR has a significant effect on runs, but the evidence is not strong enough to suggest BB also does.
(c)BB has a significant effect on runs, but the evidence is not strong enough to suggest HR also does.
(d)Neither BB nor HR have a statistically significant effect on runs.
Answer:(b)
Explanation: The p-value for HR is less than 0.05, but the p-value of BB is greater than 0.05 (0.06),
so the evidence is not strong enough to suggest that BB
has a significant effect on runs at a p-value cutoff of 0.05.

##Q10:Repeat the above exercise to find the effects of BB and HR on runs (R)
for every year from 1961 to 2018 using do() and the broom package.
Make a scatterplot of the estimate for the effect of BB on runs over time
and add a trend line with confidence intervals.

Fill in the blank to complete the statement:
The effect of BB on runs has ________ over time.
(a)decreased
(b)increased
(c)remained the same
Answer:(b)
Explanation:The scatterplot with trendline can be made using the following code:
res <- Teams %>%
  filter(yearID %in% 1961:2018) %>%
  group_by(yearID) %>%
  do(tidy(lm(R ~ BB + HR, data = .))) %>%
  ungroup() 
res %>%
  filter(term == "BB") %>%
  ggplot(aes(yearID, estimate)) +
  geom_point() +
  geom_smooth(method = "lm")
  
##Q11:Fit a linear model on the results from Question 10 to determine the effect of year on the impact of BB.
(a)For each additional year, by what value does the impact of BB on runs change?
Answer = 0.00355
Code:The value can be calculated using the following code:
res %>%
  filter(term == "BB") %>%
  lm(estimate ~ yearID, data = .) %>%
  tidy() %>%
  filter(term == "yearID") %>%
  pull(estimate)
  
(b)What is the p-value for this effect?
Answer = 0.00807
Code:The p-value can be calculated using the following code:
res %>%
  filter(term == "BB") %>%
  lm(estimate ~ yearID, data = .) %>%
  tidy() %>%
  filter(term == "yearID") %>%
  pull(p.value)
  
  
  
  
####Assessments on edX
####Section 2: Linear Models (Verified Learners only)


Game attendance in baseball varies partly as a function of how well a team is playing.

Load the Lahman library. The Teams data frame contains an attendance column.
This is the total attendance for the season.
To calculate average attendance, divide by the number of games played, as follows:
  
library(tidyverse)
library(broom)
library(Lahman)
Teams_small <- Teams %>% 
  filter(yearID %in% 1961:2001) %>% 
  mutate(avg_attendance = attendance/G)
Use linear models to answer the following 3-part question about Teams_small.


##Q1:Use runs (R) per game to predict average attendance.
(a)For every 1 run scored per game, average attendance increases by how much?
Answer = 4117
Code:The increase in average attendance can be found using the following code:
# find regression line predicting attendance from R and take slope
Teams_small %>% 
  mutate(R_per_game = R/G) %>% 
  lm(avg_attendance ~ R_per_game, data = .) %>% 
  .$coef %>%
  .[2]
  
(b)Use home runs (HR) per game to predict average attendance.
For every 1 home run hit per game, average attendance increases by how much?
Answer = 8113
Code:The increase in average attendance can be found using the following code:
Teams_small %>% 
  mutate(HR_per_game = HR/G) %>% 
  lm(avg_attendance ~ HR_per_game, data = .) %>% 
  .$coef %>%
  .[2]
  
(c)Use number of wins to predict average attendance; do not normalize for number of games.
For every game won in a season, how much does average attendance increase?
Answer = 121
Code:The increase in average attendance can be found using the following code:
Teams_small %>% 
  lm(avg_attendance ~ W, data = .) %>%
  .$coef %>%
  .[2]
  
(d)Suppose a team won zero games in a season.
Predict the average attendance
Answer = 1129
Code:The average attendance can be found using the following code:
Teams_small %>% 
  lm(avg_attendance ~ W, data = .) %>% 
  .$coef %>%
  .[1]

(e)Use year to predict average attendance.
How much does average attendance increase each year?
Answer = 244
Code:The increase in attendance can be found using the following code:
Teams_small %>% 
  lm(avg_attendance ~ yearID, data = .) %>% 
  .$coef %>%
  .[2]
  
##Q2:Game wins, runs per game and home runs per game are positively correlated with attendance.
We saw in the course material that runs per game and home runs per game are correlated with each other.
Are wins and runs per game or wins and home runs per game correlated?
(a)What is the correlation coefficient for wins and runs per game?
Answer = 0.4116491
Code:The following code will give the correlation coefficient:
cor(Teams_small$W, Teams_small$R/Teams_small$G)
  
(b)What is the correlation coefficient for wins and home runs per game?
Answer = 0.2744313
Code:The following code will give the correlation coefficient:
cor(Teams_small$W, Teams_small$HR/Teams_small$G)
  
##Q3:Stratify Teams_small by wins: divide number of wins by 10 and then round to the nearest integer.
Keep only strata 5 through 10, which have 20 or more data points.
Use the stratified dataset to answer this three-part question.

(a)How many observations are in the 8 win strata?
(Note that due to division and rounding, these teams have 75-85 wins.)
Answer = 338
Code:The number of observations can be found using the following code:
dat <- Teams_small %>%
  mutate(W_strata = round(W/10)) %>%
  filter(W_strata >= 5 & W_strata <= 10)

sum(dat$W_strata == 8)

(b)Calculate the slope of the regression line predicting average attendance
given runs per game for each of the win strata.
Which win stratum has the largest regression line slope?
(a)5; (b)6; (c)7; (d)8; (e)9; (f)10
Answer:(a)
Code:The slope can be found using the following code:
# calculate slope of regression line after stratifying by R per game
dat %>%  
  group_by(W_strata) %>%
  summarize(slope = cor(R/G, avg_attendance)*sd(avg_attendance)/sd(R/G))
  
(c)Calculate the slope of the regression line predicting average attendance
given HR per game for each of the win strata.
Which win stratum has the largest regression line slope?
(a)5; (b)6; (c)7; (d)8; (e)9; (f)10
Answer:(a)
Code:The slope can be found using the following code:
# calculate slope of regression line after stratifying by HR per game
dat %>%  
  group_by(W_strata) %>%
  summarize(slope = cor(HR/G, avg_attendance)*sd(avg_attendance)/sd(HR/G))
  
(d)Which of the followng are true about the effect of win strata on average attendance?
Select ALL that apply.
(a)Across all win strata, runs per game are positively correlated with average attendance.
(b)Runs per game have the strongest effect on attendance when a team wins many games.
(c)After controlling for number of wins, home runs per game are not correlated with attendance.
(d)Home runs per game have the strongest effect on attendance when a team does not win many games.
(e)Among teams with similar numbers of wins, teams with more home runs per game have larger average attendance.
Answer:(a), (d), and (e) 
Explanation:Looking at the data, we can see that runs per game are positively correlated with average attendance,
that home runs per game have the strongest effect on attendance when teams don't win many games, and that teams with
fewer wins have a larger average attendance with more home runs per game.
We also see that runs per game have a stronger effect when teams win few, not many, games, and that home runs per game
are in fact positively correlated with attendance in all win strata.


##Q4:Fit a multivariate regression determining the effects of runs per game,
home runs per game, wins, and year on average attendance.
Use the original Teams_small wins column, not the win strata from question 3.
(a)What is the estimate of the effect of runs per game on average attendance?
Answer = 322
Code:The estimate can be found using the following code:
fit <- Teams_small %>% 
    mutate(R_per_game = R/G,
           HR_per_game = HR/G) %>%
    lm(avg_attendance ~ R_per_game + HR_per_game + W + yearID, data = .)
tidy(fit) %>%
    filter(term == "R_per_game") %>%
    pull(estimate)

(b)What is the estimate of the effect of home runs per game on average attendance?
Answer = 1798
Code:The estimate can be found using the following code:
tidy(fit) %>%
    filter(term == "HR_per_game") %>%
    pull(estimate)

(c)What is the estimate of the effect of number of wins in a season on average attendance?
Answer = 117
Code:The estimate can be found using the following code:
tidy(fit) %>%
    filter(term == "W") %>%
    pull(estimate)
  
##Q5:Use the multivariate regression model from Question 4.
Suppose a team averaged 5 runs per game, 1.2 home runs per game, and won 80 games in a season.
(a)What would this team's average attendance be in 2002?
Answer = 16149.39
Code:The average attendance can be found using the following code:
predict(fit, data.frame(R_per_game = 5, HR_per_game = 1.2, W = 80, yearID = 2002))

(b)What would this team's average attendance be in 1960?
Answer = 6504.842
Code:The average attendance can be found using the following code:
predict(fit, data.frame(R_per_game = 5, HR_per_game = 1.2, W = 80, yearID = 1960))
  
##Q6:Use your model from Question 4 to predict average attendance for teams in 2002 in the original Teams data frame.
What is the correlation between the predicted attendance and actual attendance?
Answer = 0.519
Code:The correlation can be found using the following code:
newdata <- Teams %>%
    filter(yearID == 2002) %>%
    mutate(avg_attendance = attendance/G,
           R_per_game = R/G,
           HR_per_game = HR/G)
preds <- predict(fit, newdata)
cor(preds, newdata$avg_attendance)
  

  

####Assessments on edX
####Section 3: Correlation is Not Causation


##Q1:In the videos, we ran one million tests of correlation for two random variables, X and Y.
How many of these correlations would you expect to have a significant p-value ( p≤0.05 ), just by chance?
(a)5,000; (b)50,000; (c)100,000; (d)It’s impossible to know
Answer:(b)
Explanation:The p-value is defined as the probability of finding the observed result when the
null hypothesis (no correlation) is true.
When we have a p-value of 0.05, this means the chance of finding a correlation when none exists is 5%
e.g., 0.05*1,000,000 chances, which is 50,000.

##Q2:Which of the following are examples of p-hacking?
Select ALL that apply.
(a)Looking for associations between an outcome and several exposures
and only reporting the one that is significant.
(b)Trying several different models and selecting the one that yields the smallest p-value.
(c)Repeating an experiment multiple times and only reporting the one with the smallest p-value.
(d)Using a Monte Carlo simulations in an analysis.
Answer:(a), (b), and (c)
Explanation:Repeating an experiment multiple times and only reporting the one with the smallest p-value,
looking for associations between an outcome and several exposures and only reporting the one that is significant,
and trying several different models and selecting the one that yields the smallest p-value
are all examples of p-hacking.
Monte Carlo simulations do not necessarily lead to multiple testing problems
such as p-hacking in and of themselves.

##Q3:The Spearman correlation coefficient is robust to outliers because:
(a)It drops outliers before calculating correlation.
(b)It is the correlation of standardized values.
(c)It calculates correlation between ranks, not values.
Answer:(c)
Explanation:Because the Spearman correlation coefficient uses ranks instead of values
to calculate correlation, it is more robust to outliers.

##Q4:What can you do to determine if you are misinterpreting results because of a confounder?
(a)Nothing. If the p-value says the result is significant, then it is.
(b)More closely examine the results by stratifying and plotting the data.
(c)Always assume that you are misinterpreting the results.
(d)Use linear models to tease out a confounder.
Answer:(b)
Explanation:Exploratory data analysis (stratifying and plotting data)
can help determine if there is a confounder.
Linear models cannot be used in all situations.

##Q5:Look again at the admissions data presented in the confounders video using ?admissions.
What important characteristic of the table variables do you need to know
to understand the calculations used in this video?
(a)The data are from 1973.
(b)The columns major and gender are of class character,
while admitted and applicants are numeric.
(c)The data are from the dslabs package.
(d)The column admitted is the percent of students admitted,
while the column applicants is the total number of applicants.
Answer:(d)
Explanation:Several of these statements are true but not relevant to understanding the calculations in the video.
The only statement that is critical for the analysis is that "The column admitted is the percent of students admitted,
while the column applicants is the total number of applicants."
In all data science projects, it is important to understand the data that you are working with.

##Q6:In the example in the confounders video, major selectivity confounds the
relationship between UC Berkeley admission rates and gender because:
(a)It was harder for women to be admitted to UC Berkeley.
(b)Major selectivity is associated with both admission rates and with gender,
as women tended to apply to more selective majors.
(c)Some majors are more selective than others.
(d)Major selectivity is not a confounder.
Answer:(b)
Explanation:Major selectivity is a confounder because it is associated with both admission rate and with gender.

##Q7:Admission rates at UC Berkeley are an example of Simpson’s Paradox because:
(a)It appears that men have a higher admission rate than women, however,
after we stratify by major, we see that on average women have a higher admission rate than men.
(b)It was a paradox that women were being admitted at a lower rate than men.
(c)The relationship between admissions and gender is confounded by major selectivity.
Answer:(a)
Explanation:Simpson’s Paradox refers specifically to cases where the sign of the correlation flips
when comparing the entire dataset vs. specific strata, so only the first statement is correct.




####Assessments on edX
####Section 3: Confounding (Verified Learners only)


For this set of exercises, we examine the data from a 2014 PNAS paper that analyzed success rates
from funding agencies in the Netherlands and concluded:
"our results reveal gender bias favoring male applicants over female applicants in the prioritization
of their "quality of researcher" (but not "quality of proposal")
evaluations and success rates, as well as in the language used in instructional and evaluation materials."

A response was published a few months later titled "No evidence that gender contributes to
personal research funding success in The Netherlands: A reaction to Van der Lee and Ellemers", which concluded:
However, the overall gender effect borders on statistical significance, despite the large sample.
Moreover, their conclusion could be a prime example of Simpson’s paradox;
if a higher percentage of women apply for grants in more competitive scientific disciplines
(i.e., with low application success rates for both men and women),
then an analysis across all disciplines could incorrectly show "evidence" of gender inequality. 

Who is right here: the original paper or the response?
Here, you will examine the data and come to your own conclusion.

The main evidence for the conclusion of the original paper comes down to a comparison of the percentages.
The information we need was originally in Table S1 in the paper, which we include in dslabs:

library(dslabs)
data("research_funding_rates")
research_funding_rates


##Q1:Construct a two-by-two table of gender (men/women) by award status (awarded/not)
using the total numbers across all disciplines.
(a)What is the number of men not awarded?
Answer = 1345
(b)What is the number of women not awarded?
Answer = 1011
Code:The two-by-two table can be constructed using the following code:
two_by_two <- research_funding_rates %>% 
  select(-discipline) %>% 
  summarize_all(funs(sum)) %>%
  summarize(yes_men = awards_men, 
            no_men = applications_men - awards_men, 
            yes_women = awards_women, 
            no_women = applications_women - awards_women) %>%
  gather %>%
  separate(key, c("awarded", "gender")) %>%
  spread(gender, value)
two_by_two

##Q2:Use the two-by-two table from Question 1 to compute
the percentages of men awarded versus women awarded.
(a)What is the percentage of men awarded?
Answer = 17.737
(b)What is the percentage of women awarded?
Answer = 14.89899
Code:The percentage awarded can be calculated using the following code:
two_by_two %>% 
    mutate(men = round(men/sum(men)*100, 1), women = round(women/sum(women)*100, 1)) %>%
    filter(awarded == "yes") %>%
    pull(women)

##Q3:Run a chi-squared test on the two-by-two table to determine
whether the difference in the two success rates is significant.
(You can use tidy() to turn the output of chisq.test() into a data frame as well.)
What is the p-value of the difference in funding rate?
Answer = 0.0509
Code:The p-value can be calculated using the following code:
two_by_two %>% select(-awarded) %>% chisq.test() %>% tidy() %>% pull(p.value)


There may be an association between gender and funding.
But can we infer causation here? Is gender bias causing this observed difference?
The response to the original paper claims that what we see here is similar to the UC Berkeley admissions example.
Specifically they state that this "could be a prime example of Simpson’s paradox;
if a higher percentage of women apply for grants in more competitive scientific disciplines,
then an analysis across all disciplines could incorrectly show 'evidence' of gender inequality."

To settle this dispute, use this dataset with number of applications, awards, and success rate for each gender:

dat <- research_funding_rates %>% 
      mutate(discipline = reorder(discipline, success_rates_total)) %>%
      rename(success_total = success_rates_total,
             success_men = success_rates_men,
             success_women = success_rates_women) %>%
      gather(key, value, -discipline) %>%
      separate(key, c("type", "gender")) %>%
      spread(type, value) %>%
      filter(gender != "total")
dat
To check if this is a case of Simpson's paradox, plot the success rates versus disciplines,
which have been ordered by overall success,
with colors to denote the genders and size to denote the number of applications.


##Q4:
(a)In which fields do men have a higher success rate than women?
Select ALL that apply.
(a)Chemical sciences;(b)Earth/life sciences; (c)Humanities
(d)Interdisciplinary; (e)Medical sciences; (f)Physical sciences
(g)Physics;(h)Social sciences; (i)Technical sciences
Answer:(a), (b),(e),(g), and (h)

(b)Which two fields have the most applications from women?
Select TWO.
(a)Chemical sciences;(b)Earth/life sciences; (c)Humanities
(d)Interdisciplinary; (e)Medical sciences; (f)Physical sciences
(g)Physics;(h)Social sciences; (i)Technical sciences
Answer:(e) and (h)

(c)Which two fields have the lowest overall funding rates?
Select TWO.
(a)Chemical sciences;(b)Earth/life sciences; (c)Humanities
(d)Interdisciplinary; (e)Medical sciences; (f)Physical sciences
(g)Physics;(h)Social sciences; (i)Technical sciences
Answer:(e) and (h)

Code Q4(a,b,and c): The plot can be generated using the following code:
dat %>% 
  ggplot(aes(discipline, success, size = applications, color = gender)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_point()

