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
###Section 1: Introdution to Regression
  
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
####Section 2:Introduction to Linear Models

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
####Section 2: