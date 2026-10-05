## Plotting and Style Lecture code - 2026 Programming in Psychological Science
#
# Record of Revisions
#
# Date            Programmer              Descriptions of Change
# ====         ================           ======================
# 20-Jan-2022     Michael Nunez                Original code
# 23-Jan-2023     Michael Nunez             Changes for 2023
# 22-Jan-2024     Michael Nunez             Changes for 2024
# 11-Sep-2026     Michael Nunez             Changed for 2026-2027

my_sample <- rnorm(1000)
hist(my_sample)

plot(my_sample)

my_other_sample <- 10 - 2 * my_sample + rnorm(1000)
plot(my_sample, my_other_sample)

?plot

plot(my_sample, my_other_sample, type = "l")

x <- seq(0, 2 * pi, by = .1)
plot(x, sin(x), type = "l")

# NOT line(x, cos(x))  # This is different function
lines(x, cos(x), col = "red")
lines(x + (pi/4), sin(x), type = "l", col = "green")

test <- matrix(nrow=63, ncol=2)
test[,1] <- x
test[,2] <- sin(x)
plot(test, type="l")

# Boxplots - don't do this, try instead violin plots in ggplot2
my_data = rpois(1000, lambda = 1)
max(my_data)
boxplot(my_data)
?boxplot

# Plot density
plot(density(my_data))

# Is it better than just a histogram?
hist(my_data)

#Another way to save plots
#A script per plot is very useful for research and conducting reproducible science
setwd("C:/Users/mnunez/Dropbox/work/Teaching/Programming_in_Psychological_Science/pips2026_2027/Week3")
getwd()
dir()
png('Some_sine_waves.png')
x = seq(0, 2*pi, by=.1)
plot(x, cos(x), type="l", col="blue")
lines(x, sin(x), col='red')
dir() # Is it there?
# Close device
dev.off() # Notice it did not make a nice plot in my graphics window

#See also:
?png
?jpeg
?pdf
?svg

x11() # Opens a new window
x = seq(0, 2*pi, by=.1)
plot(
  x, 
  cos(x), 
  type = "l", 
  col = "blue",
  xlab = "Time", 
  ylab = "Position") 
lines(x, sin(x), col='red')
title("Pendulum")

# More help on function arguments to plot, lines, histogram, etc.
?par

x11()
x = seq(0, 2*pi, by=.1)
plot(
  x, 
  cos(x), 
  type = "l",
  lwd = 3,
  lty = "dotdash",
  col = "blue",
  xlab = "Time", 
  ylab = "Position",
  cex.lab = 2)
lines(x, sin(x), col='red', lwd = 2, lty = "dashed")
title("Pendulum", cex.main=0.5)
dev.off()

# Subplots in base R
?par # par() does a lot, it will standardize pltos
x11()
par(mfrow = c(2,2)) # 2-by-2 grid of plots
#par(col = "blue")

# Now make some plots after par
plot( exp( seq(-2,2,by=0.1) ), type = 'b', col = 'red' )
hist( rexp(1000, rate = .5) )
boxplot( rpois(1000, lambda=1) )
plot( sin(seq(0, 2*pi, by=.1)) , col='red', lwd = 2, lty = "dashed")

# Remove default x-labels and y-labels
par(mfrow = c(2,2)) # 2-by-2 grid of plots
plot( exp( seq(-2,2,by=0.1) ), type = 'b', col = 'red' , ylab = "")
hist( rexp(1000, rate = .5), ylab = "")
boxplot( rpois(1000, lambda=1), ylab = "")
plot( sin(seq(0, 2*pi, by=.1)), col='red', lwd = 2, lty = "dashed", ylab = "")

# How to make room? See ?par
# I see that mar is the numerical vector for the margins
# Then I used google or chatgpt
par(mfrow = c(2, 2)) # 2-by-2 grid of plots
par(mar = c(2, 2, 1, 1)) # decreases margins around each subplot
plot( exp( seq(-2,2,by=0.1) ), type = 'b', col = 'red' , ylab = "")
hist( rexp(1000, rate = .5), ylab = "")
boxplot( rpois(1000, lambda=1), ylab = "")
plot( sin(seq(0, 2*pi, by=.1)), col='red', lwd = 2, lty = "dashed", ylab = "")

# how do I remove the title of a histogram in R?
# Googling... "R remove histogram title"
# Ask Claude: "How do I remove the title in my histogram? [code]"
# Ah here it is: https://stackoverflow.com/questions/736541/plots-without-titles-labels-in-r
# Stack Overflow is your friend

dev.off() # Run to get rid of current par, or x11() etc.
hist( rexp(1000, rate = .5), main = "")

## Break ##

install.packages('ggplot2')
library(ggplot2)

# Or install the entire tidyverse, which we will also use next week
install.packages('tidyverse')
library(tidyverse)

# The next few examples follow alone Chapter 3: Data visualisation of
# https://r4ds.had.co.nz/data-visualisation.html

# ggplot and tidyverse coding sometimes has a different function structure
?mpg # Classic ggplot2 example
mpg
head(mpg)
glimpse(mpg) ##need dyplr
colnames(mpg)
# More next week

ggplot(data = mpg) #Noting happens!

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))
# ggplot() creates a coordinate system to which you add layers

# In general this is the format
# ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# Color all dots
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# Color some dots by class
unique(mpg$class) 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "class")) # Wrong!

# Don't use quotes so that ggplot() functions know you want to reference mpg
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))

# This + won't work here:
ggplot(data = mpg)
+ geom_point(mapping = aes(x = displ, y = hwy, color = class))
# You have to put the plus on the first line

# Let's plot a best fit smoothed line to the data
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
# Many warnings

# Hmmm, maybe just one smoothed line:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# One more concise way is to put the "aesTHETIC mappings" in ggplot()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

# now I could color only the dots by class:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

#Look it recognizes British English as well:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(colour = class)) + 
  geom_smooth()


# Other packages:
install.packages('patchwork')
library(patchwork)
# Google patchwork
# https://statisticsglobe.com/patchwork-r-package

# Introduction to coding style ---------------------------

# Who thinks that have some examples of bad R style already?

# Variable names  ---------------------------

# Possible the most important thing you can do to make your code readable:
# Informative variable names and file names (and function names, next week!)

# Bad
x <- c(19.99, 45.00, 12.50, 8.75)
y <- x * 1.21
z <- sum(y)
w <- z > 75

# Good
item_prices <- c(19.99, 45.00, 12.50, 8.75)
prices_with_tax <- item_prices * 1.21
total_cost <- sum(prices_with_tax)
free_shipping <- total_cost > 75

# camelCase versus snake_case  ---------------------------

# Good file name: fit_models.R
# Bad file name: fitModels.R
# Bad file name fit models.R

# Tidyverse style now recommends snake_case.
# I believe Google used to recommend camelCase.
# But more people follow Tidyverse recommendations now.

# Good
norm_samples <- rnorm(1000, mean = 10, sd = 100)

# Bad
normSamples <- rnorm(1000, mean = 10, sd = 100)

# Comments   ---------------------------

# Comments are interesting because they are helpful
# However too long of comments about code make the code difficult to read
# Be concise
# The Tidyverse style recommends explaining the "why" not the "what" or "how"

# Good comment

# An action is chosen for each fish
what_do <- switch(caught_fish,
                  large_trout = "eat",
                  small_trout = "return",
                  carp = ,
                  perch = "sell")

# Bad comment

# This is the switch function with takes the variable "caught_fish" and then 
# assigns a value to variable what_do. These values assigned to what_do are
# "eat" for large_trout & "return" for small_trout and carp and 
# "sell" to perch.
what_do <- switch(caught_fish,
                  large_trout = "eat",
                  small_trout = "return",
                  carp = ,
                  perch = "return",
                  shoe = )

# Spacing  ---------------------------
# Refer to https://style.tidyverse.org/index.html
# Especially about spacing!

# Good
mean(c(1, 1, 2, 3))

# Bad 
mean (c(1,1,2,3))

# Functions within functions  ---------------------------

# In general it is easier to read variable assignments 
# then functions within functions.

# Good
mood_state <- 4
beta_sims <- rbeta(mood_state^2, shape1 = 1, shape2 = .5)
interactions <- matrix(beta_sims, mood_state, mood_state)

# Bad
n_brain_funcs <- 4
interactions <- matrix(rbeta(mood_state^2, shape1 = 1, shape2 = .5),
                       mood_state, mood_state)


# https://style.tidyverse.org

# Two quick ways to check SOME style:

# styler addin to RStudio:
# https://styler.r-lib.org/
# install.packages("styler")

# lintr
# https://github.com/r-lib/lintr
# install.packages("lintr")
library(lintr)
lint( 'PIPS_2026_lecture_plotting_style.R' )

# Line 31 Put spaces around all infix operators.
# Line 33 Commas should always have a space after.
# Line 37 Use <-, not =, for assignment.