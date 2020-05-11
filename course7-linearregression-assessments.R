#### Program: Data Science by HarvardX
#### Course 7: Linear Regression


### Assessments on edX
### Section 1: Baseball as a Motivating Example

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
  



### Assessments on edX
### Section 1: Introdution to Regression
  
##Q1:A
(a)
Answer:
Explanation:
Code:

##Q2:A
(a)
Answer:
Explanation:
Code:
  
##Q3:A
(a)
Answer:
Explanation:
Code:
  
##Q4:A
(a)
Answer:
Explanation:
Code: