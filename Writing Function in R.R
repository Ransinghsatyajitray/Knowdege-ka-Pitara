setwd("C:\\Users\\DELL PC\\Desktop\\Practice Projects R\\Predicting Emp Attrition R Project Kindle Book\\Writing Function and Functional Programming with purrr")

data(iris)

# Arguments----
args(median)
# function (x, na.rm = FALSE, ...) 
#   NULL

median(iris$Sepal.Length,na.rm=TRUE)

args(rank)
# function (x, na.last = TRUE, ties.method = c("average", "first", 
#                                              "last", "random", "max", "min")) 
#   NULL


# 1st place: the largest positive value in iris$Sepal.Length is the smallest ("most negative") value in -iris$Sepal.Length.
rank(-iris$Sepal.Length, na.last = "keep", ties.method = "min")



# Converting Scripts to function:----
library(readr)
library(lubridate)
library(dplyr)

data_1990 <- read_csv("data_from_1990.csv") %>% filter(a<0) %>% mutate(c=a+b)
data_1991 <- read_csv("data_from_1991.csv") %>% filter(a<0) %>% mutate(c=a+b)
data_1992 <- read_csv("data_from_1992.csv") %>% filter(a<0) %>% mutate(c=a+b)



# Step1: Donot Run
data_year <- function(file_csv){ # argument is anything that changes between multiple rewrites
  data_1990 <- read_csv("data_from_1990.csv") %>% filter(a<0) %>% mutate(c=a+b)
}

# Step2: Donot Run
data_year <- function(file_csv){
  data_1990 <- read_csv(file_csv) %>% filter(a<0) %>% mutate(c=a+b)
}

# Step3: 
data_year <- function(file_csv){
  read_csv(file_csv) %>% filter(a<0) %>% mutate(c=a+b) # no need to assign the last value so assignment is removed
}

# example:
data_1993 <- data_year("data_from_1993.csv")
data_1994 <- data_year("data_from_1994.csv")


# The Process:
# 1. Make a template
# 2. Paste in the script
# 3. Choose the arguments
# 4. Replace specific values with argument names
# 5. Make specific varaible name more general
# 6. Remove a final assignment


# Update the function to return n_flips coin tosses
toss_coin <- function(n_flips) {
  coin_sides <- c("head", "tail")
  sample(coin_sides, n_flips, replace = TRUE) # sample argument takes what to chose from randomly, how many times to choose, with or without replace
}

# Generate 10 coin tosses
toss_coin(10)





# Update the function so heads have probability p_head
toss_coin <- function(n_flips, p_head) {
  coin_sides <- c("head", "tail")
  # Define a vector of weights
  weights <- c(p_head, 1 - p_head)
  # Modify the sampling to be weighted 
  sample(coin_sides, n_flips, replace = TRUE, prob = weights) #prob is also an argument in sample
}

# Generate 10 coin tosses
toss_coin(10, p_head = 0.8)




# function are like verbs (eg. select, arrange, mutate)----

# Error (VIMP)
mtcars %>% lm(mpg~.)  #this will throw an error as pipe operator demands first argument of preceding function to be data

# No error as we corrected the error, now %>% can respond
run_regression <- function(data,formula){
  lm(formula,data) #follow the function code of lm
}

run_regression(mtcars,mpg~.)
# or
mtcars %>% run_regression(mpg~.)




# Regression predicted values column adding----
run_reg_poisson <- function(data,formula){
  glm(formula,data,family = poisson ) #checkout what family mean and how they are given what they are given
}


model_reg <- mtcars %>% run_reg_poisson(mpg~.) 


mtcars %>% mutate(predicted_value=predict(model_reg,type = "response"))
#or
mtcars %>% mutate(predicted_value=predict(mtcars %>% 
                                            run_reg_poisson(mpg~.),type = "response"))





# Default Argument mention it in function argument----
# Cutting a vector by quantile: (Converting a numerical variable to categorical variable is called cutting)

?cut
# cut(x, breaks, labels = NULL,   #NULL -> (]
#     include.lowest = FALSE, right = TRUE, dig.lab = 3,
#     ordered_result = FALSE, ...)

# (a,b) = a<x<b
# [a,b) = a<=x<b

cut_by_quantile <- function(x, n, na.rm, labels, interval_type) {
  probs <- seq(0, 1, length.out = n + 1) # partitioning the probability
  qtiles <- quantile(x, probs, na.rm = na.rm, names = FALSE)
  right <- switch(interval_type, "(lo, hi]" = TRUE, "[lo, hi)" = FALSE)
  cut(x, qtiles, labels = labels, right = right, include.lowest = TRUE)
}

cut_by_quantile(mtcars$mpg,n=4,na.rm=TRUE,labels=c("a1","a2","a3","a4"),interval_type = TRUE)
# [1] a3 a3 a3 a3 a2 a2 a1 a4 a3 a2 a2 a2 a2 a1 a1 a1 a1 a4 a4 a4 a3 a2 a1 a1 a2 a4 a4 a4 a2
# [30] a3 a1 a3
# Levels: a1 a2 a3 a4


# To minimise the line of code while execute the function we can use default values and values to choose from
# Set the categories for interval_type to "(lo, hi]" and "[lo, hi)"
cut_by_quantile_1 <- function(data_input, n = 5, na.rm = FALSE, labels = NULL, 
                            interval_type = c("(lo, hi]", "[lo, hi)")) {
  # Match the interval_type argument
  interval_type <- match.arg(interval_type)  # interesting
  probs <- seq(0, 1, length.out = n + 1)
  qtiles <- quantile(data_input, probs, na.rm = na.rm, names = FALSE)
  right <- switch(interval_type, "(lo, hi]" = TRUE, "[lo, hi)" = FALSE)
  cut(data_input, qtiles, labels = labels, right = right, include.lowest = TRUE)
}

cut_by_quantile_1(mtcars$mpg)


# Passing arguments between function:----
# can use pipe operator

# Challenge:
# 1. handling missing value

# use of elipses ... argument (this mean accept any other argument in to the function and
# pass it into the function that require it)

get_reciprocal <- function(x,na.rm=TRUE){
  1/x
}


# Custom function inside another function
calc_harmonic_mean <- function(x, na.rm = FALSE) {
  x %>%
    get_reciprocal() %>%
    mean(na.rm = na.rm)
}


mtcars %>% group_by(gear) %>% 
  summarise(Reciprocal_of_mean_mpg=calc_harmonic_mean(mpg,na.rm = TRUE))

mtcars$mpg


# elipses ...
# Swap na.rm arg for ... in signature and body
calc_harmonic_mean1 <- function(x, ...) {
  x %>%
    get_reciprocal() %>%
    mean(...) %>%
    get_reciprocal()
}


mtcars %>% group_by(gear) %>% summarise(Calc_hm=calc_harmonic_mean1(mpg,na.rm=TRUE))



# Checking Argument (providing error message) ----
# if the creater made mistake it is called bug

calc_with_error_msg <- function(data,na.rm=FALSE){
  if(!is.numeric(data)){
    stop("data is not of numeric class, it is of",class(data)," type.") # or warning
  }else{data %>% log() %>% mean(na.rm=na.rm)
    }
}


iris %>% group_by(Cutting_Var=cut(Sepal.Length,breaks = seq(min(Sepal.Length,na.rm=TRUE),max(Sepal.Length,na.rm=TRUE),by=1))) %>%
  summarise(Mean_value=calc_with_error_msg(Species))


# This is assertion:

# Error: Problem with `summarise()` input `Mean_value`.
# x data is not of numeric class, it is offactor type.
# i Input `Mean_value` is `calc_with_error_msg(Species)`.
# i The error occured in group 1: Cutting_Var = "(4.3,5.3]".
# Run `rlang::last_error()` to see where the error occurred.


iris %>% group_by(Cutting_Var=cut(Sepal.Length,breaks = seq(min(Sepal.Length,na.rm=TRUE),max(Sepal.Length,na.rm=TRUE),by=1))) %>%
  summarise(Mean_value=calc_with_error_msg(Sepal.Width))

library(assertive)



# Return Value and Scope:----

# Return value from a function----
# It is the last value when the body come to end
# But some times it is required to return early (this done using if and return statement inside it)

A <- c(1,2,3,4,5,6,7,NA)
B <- c(1,2,3,4,5,6,7)


simple_sum <- function(x){
  if(anyNA(x)){
    return(NA)
  }else{
    total <- 0
    for(any_value in x){
    total <- total+any_value}
    total # or return(total)
  }
}

simple_sum(B)

# With respect to scoping one good thing to remember is father cant know whats inside child but child can see whats inside father

# Returning invisibly (nothing gets printed in the console, good for graphs in which we need to make plots in Plots section)----

# When the main purpose of a function is to generate output, like drawing a plot or 
# printing something in the console, you may not want a return value to be printed as 
# well. In that case, the value should be invisibly returned.

pipeable_plot <- function(data, formula) {
  # Call plot() with the formula interface
  plot(formula, data)
  # Invisibly return the input dataset
  invisible(data)  
}


# Nothing in console, everything in Plots
mtcars %>% pipeable_plot(mpg ~ gear)


# Returning multiple values from functions (we can do this by keeping variables in list ----
R.version.string

session <- function(){
  list(
    r_version=R.version.string,
    operating_sys=Sys.info()[c("sysname","release")],
    loaded_pkgs=loadedNamespaces()
  )
}

session()


# Multiassignment operator with zeallot package (Similar to Python unpacking variables)
library(zeallot)
# we assign the variables inside c() the list outputs
c(Ransingh, Satyajit, Ray) %<-% session()  # At a time we created 3 variable

attributes(iris$Species)
attributes(iris)



# dplyr has dataframe has input and dataframe as output----

# broom package : 1. glance -> degree of freedom, AIC, BIC etc
#                 2. tidy -> p value
#                 3. augment -> residuals



# broom package----

library(broom)
# We have created run_reg_poisson earlier
model_reg <- mtcars %>% run_reg_poisson(mpg~.) 

groom_model <- function(model) {
  list(
    dof = glance(model),  
    coefficients_pvalue = tidy(model),
    observations_residuals = augment(model)
  )
}

# Call groom_model on model, assigning to 3 variables
c(mdl, cff, obs) %<-% groom_model(model_reg)

mdl
cff
obs

# Check if glance, tidy and augment also work on other models too?----



# Environment----
# childs are also called environment

