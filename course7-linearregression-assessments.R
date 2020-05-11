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
Explanation:As the sample size N increases, the standard deviation of the sample correlation should decrease.
  
##Q6:If X and Y are completely independent, what do you expect the value of the correlation coefficient to be?
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
What is the correlation coefficient between win rate (number of wins per game) and number of errors per game?
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

##Q1:
(a)
Answer:
Explanation:
Code:

##Q2:
(a)
Answer:
Explanation:
Code: