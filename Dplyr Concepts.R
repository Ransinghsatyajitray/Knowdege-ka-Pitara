###########################################################################

###########################################################################

###   Companion code for book:  DPLYR                                   ###

###   Author: Bill Yarberry                                             ###

###   Open source                                                       ###

###                                                                     ###

###########################################################################

###########################################################################

getwd()
setwd("C:/Users/DELL PC/Desktop/Practice Projects R/Predicting Emp Attrition R Project Kindle Book") #this will vary; change to fit your hard drive/subdirectory of choice

# rm(list = ls())   # clear the workspace


# BOOK REFERENCE: 001 -----------------------------------------------------



#install.packages("tidyverse")  #uncomment the "install" code if

#you have never installed the tidyverse package. Then recomment.

# install.packages("tidyverse") #run installs one time only

# install.packages("lubridate")

# install.packages("stringr")

# install.packages("formattable") #this is optional. Merely improves

#the appearance of output


library(tidyverse) #load all of them into memory prior to running code

library(lubridate)

library(stringr)

library(formattable)  # again, optional  head function can be used here


# ----------------------------------------------------------------------------


library(tidyverse)




data("iris")

data("USArrests")

options(warn=0)





# BOOK REFERENCE: 002 -----------------------------------------------------



# Filter

# note to self -- use snagit to format the tables, with shadow

data("mtcars")

#select only cars with six cylinders

six.cyl.only <- filter(mtcars, cyl == 6)

# show first few records of the new dataframe

head(six.cyl.only)

#--------------------------------------------------------------------------------




# BOOK REFERENCE: 003 -----------------------------------------------------



six.cylinders.and.110.horse.power <- filter(mtcars, cyl == 6, hp == 110)

# show first few records of the new dataframe

formattable(six.cylinders.and.110.horse.power)



#-----------------------------------------------------------------------




# BOOK REFERENCE: 004 -----------------------------------------------------


data("ChickWeight")

#formattable(ChickWeight) #before

chick.subset <- filter(ChickWeight, Time < 6, weight > 50)

#formattable(chick.subset) #after

# ---------------------------------------------------------------------



# BOOK REFERENCE: 005 -----------------------------------------------------



gear.eq.4.or.more.than.8 <- filter(mtcars, gear == 4|cyl > 6)   #OR  

# formattable(gear.eq.4.or.more.than.8)


#filter based on smallest engine displacement

smallest.engine.displacement <- filter(mtcars, disp == min(disp))

#formattable(smallest.engine.displacement)


# ----------------------------------------------------------------------




# BOOK REFERENCE: 006 -----------------------------------------------------



data("airquality")

formattable(airquality)

no.missing.ozone = filter(airquality, !is.na(Ozone))

formattable(no.missing.ozone)


airquality.no.na = filter(airquality, complete.cases(airquality)) #we can use na.omit too

formattable(airquality.no.na)


# ------------------------------------------------------------------------




# BOOK REFERENCE: 007 -----------------------------------------------------



data("iris")

#before

table(iris$Species) #counts of species in the dataset


iris.two.species <- filter(iris, Species %in% c("setosa", "virginica"))

#after

table(iris.two.species$Species)

# another way to demonstrate that the filter worked

nrow(iris); nrow(iris.two.species)




# BOOK REFERENCE: 007B -----------------------------------------------------



data("airquality")

formattable(airquality)

airqual.3.columns = filter(airquality, Ozone > 29)[,1:3] #only rows with Ozone more than 29; include only first three columns

formattable(airqual.3.columns)

# --------------------------------------------------------------------------




# BOOK REFERENCE: 008 -----------------------------------------------------


nrow(mtcars)

mtcars.more.than.200 <- filter_all(mtcars, any_vars(. > 200)) #anyting, anywhere, more than 200

nrow(mtcars.more.than.200)

formattable(mtcars.more.than.200)

mtcars.even.starts.with.h <- filter_at(mtcars, vars(starts_with("h")), any_vars((. %% 2) == 0))

formattable(mtcars.even.starts.with.h)

nrow(mtcars.even.starts.with.h)


# ------------------------------------------------------------------------



# BOOK REFERENCE: 009 -----------------------------------------------------



table(mtcars$gear)

more.frequent.no.of.gears <- mtcars %>%
  
  group_by(gear) %>%
  
  filter(n() > 10)

table(more.frequent.no.of.gears$gear)



#additional criteria can be added to the filter

more.frequent.no.of.gears.and.low.horsepower <- mtcars %>%
  
  group_by(gear) %>%
  
  filter(n() > 10, hp < 105)

table(more.frequent.no.of.gears.and.low.horsepower$gear)


# -----------------------------------------------------------------


# BOOK REFERENCE: 010 & 011 -----------------------------------------------------



msleep <- ggplot2::msleep #loads the msleep dataframe from the package ggplot2

formattable(msleep)

msleep.over.5 <-  msleep %>%
  
  select(name, sleep_total:sleep_rem, brainwt:bodywt) %>%
  
  filter_at(vars(contains("sleep")), all_vars(.>5))

formattable(msleep.over.5)



msleep <- ggplot2::msleep #loads the msleep dataframe from the package ggplot2

formattable(msleep[,1:4])


animal.name.sequence <- arrange(msleep, vore, order)

formattable(animal.name.sequence[,1:4])


animal.name.sequence.desc <- arrange(msleep, vore, desc(order))

formattable(animal.name.sequence.desc[,1:4])


# ---------------------------------------------------------------------------------





# BOOK REFERENCE: 012 -----------------------------------------------------



#rename - rename one or more columns in a dataset

names(iris) #iris is a built-in dataset

renamed.iris <- rename(iris, width.of.petals = Petal.Width, various.plants.and.animals = Species)

names(renamed.iris)


#----------------------------------------------------------------------------




# BOOK REFERENCE: 013 -----------------------------------------------------



#Mutate


data("ChickWeight")

formattable(ChickWeight[1:2,] ) #first two rows

Chickweight.with.log <- mutate(ChickWeight, log.of.weight = log10(weight))

formattable(Chickweight.with.log[1:2,]) #first two rows, with new field added


# ----------------------------------------------------------------------------




#put a 99 in front of the Diet number

ChickWeight[1:3,]

Chickweight.w.99 <- mutate(ChickWeight, new.diet.no = paste("99", Diet, sep = ""))

Chickweight.w.99[1:3,]


#Ifelse logic for mutate

data("airquality")

airquality[1:3,]

airquality.w.text <- mutate(airquality, very.high.wind = ifelse(Wind > 17,"Yes","No")) %>%
  
  arrange(desc(very.high.wind))

airquality.w.text[1:4,]





# BOOK REFERENCE: 014 -----------------------------------------------------



msleep <- ggplot2::msleep #loads the msleep dataframe from the package ggplot2

names(msleep)

msleep.with.square.roots <- mutate_all(msleep[,6:11], funs("square root" = sqrt( .  )))

names(msleep.with.square.roots)

formattable(msleep.with.square.roots)


msleep.with.square.roots[1:2,]  #show first two rows of new dataframe


names(msleep.with.square.roots)

msleep.with.square.roots[1:2,]


# -----------------------------------------------------------------------------

# funs used when more than 1 columns. vars and funs go hand in hand


# # install.packages("stargazer")

# library(stargazer)

# # stargazer(mtcars, type = 'text', out = 'out.txt')

#

# stargazer(msleep.with.square.roots, type = "text", out = "out.txt")


mydata4 = mutate_at(mydata2, vars(Sepal.Length,Sepal.Width), funs(Rank=min_rank(desc(.))))



ls("package:datasets")




# BOOK REFERENCE: 015 -----------------------------------------------------



data("Titanic")

Titanic <- as.data.frame(Titanic)

formattable(Titanic)


titanic.with.ranks <- mutate_at(Titanic, vars(Class,Age,Survived),
                                
                                funs(Rank = min_rank(desc(.))))

formattable(titanic.with.ranks)



msleep <- ggplot2::msleep #loads the msleep dataframe from the package ggplot2

#the package stringr is used below;  it is automatically loaded with the library(tidyverse) command

# str_detect looks for the occurence of a designated string, anywhere in the field listed

class(msleep$sleep_total)   # class function shows that the sleep_total variable is numeric

sleep.changed.variables <- msleep %>% mutate_if( (str_detect(colnames(.), "sleep")), as.character)

class(sleep.changed.variables$sleep_total)  #class function now shows sleep_total variable is character

# ---------------------------------------------------------------------------



# BOOK REFERENCE: 016 -----------------------------------------------------



#create toy dataframe

fruit <- c("apple","pear","orange","grape", "orange","orange")

x <- c(1,2,4,9,4,6)

y <- c(22,3,4,55,15,9)

z <- c(3,1,4,10,12,8)

df <- data.frame(fruit,x,y,z)

formattable(df)

df.show.single.dup <- mutate(df, duplicate.indicator = duplicated(x))

formattable(df.show.single.dup) #note that although there are three instances of orange, only the second and third instances are flagged as TRUE duplicates

# ------------------------------------------------------------------------------------------------------------------------





# BOOK REFERENCE: 017 -----------------------------------------------------


#drop variables

#create toy dataframe

fruit <- c("apple","pear","orange","grape", "orange","orange")

x <- c(1,2,4,9,4,6)

y <- c(22,3,4,55,15,9)

z <- c(3,1,4,10,12,8)

df <- data.frame(fruit,x,y,z)

df <- mutate(df, z = NULL)

formattable(df)

# -----------------------------------------------------




# BOOK REFERENCE: 018 -----------------------------------------------------

# mutate guidelines


library(nycflights13) #not recommended but works

mutate(flights,
       
       gain = arr_delay - dep_delay,
       
       hours = air_time / 60,
       
       gain_per_hour = gain / hours,
       
       gain_per_minute = 60 * gain_per_hour)



library(nycflights13)    #recommended

newfield.flights <- flights %>%
  
  mutate(gain = arr_delay - dep_delay,
         
         hours = air_time / 60) %>%
  
  mutate(gain_per_hour = gain / hours) %>%
  
  mutate(gain_per_minute = 60 * gain_per_hour)


newfield.flights[1:6,c(1:2,20:23)] #show selected columns for first six rows, including the newly created ones

# ---------------------------------------------------------------------------------------------




# BOOK REFERENCE: 019 -----------------------------------------------------

#transmute

#keep only variables created

#create toy dataframe

fruit <- c("apple","pear","orange","grape", "orange","orange")

x <- c(1,2,4,9,4,6)

y <- c(22,3,4,55,15,9)

z <- c(3,1,4,10,12,8)

df <- data.frame(fruit,x,y,z)

df

df <- transmute(df, new.variable = x + y + z)

#row "apple" =1 + 22 + 3 = 26

#row "pear" = 2 + 3 + 1 = 6 and so on

df

# -------------------------------------------------------




# BOOK REFERENCE: 020 -----------------------------------------------------



#create toy dataframe

fruit <- c("apple","pear","orange","grape", "orange","orange")

x <- c(1,2,4,9,4,6)

y <- c(22,3,4,55,15,9)

z <- c(3,1,4,10,12,8)

df <- data.frame(fruit,x,y,z) #before select

df

new.df.no.fruit <- select(df, -fruit)  #put a minus sign in front of any #variable(s) to be dropped

new.df.no.fruit #after select



#------------------------------------------------------------



# BOOK REFERENCE: 021 -----------------------------------------------------


data("mtcars")

names(mtcars)  #the names command lists column names in the dataframe

mtcars.no.col.names.start.with.d <- select(mtcars, -starts_with("d"))

names(mtcars.no.col.names.start.with.d) #show starting column names

mtcars.no.col.names.ends.with <- select(mtcars, - ends_with("t")) #drop drat and wt

names(mtcars.no.col.names.ends.with) #show column names after the select


# --------------------------------------------------------------------------



# BOOK REFERENCE: 022 -----------------------------------------------------


fruit <- c("apple","pear","orange","grape", "orange","orange")

x <- c(1,2,4,9,4,6)

y <- c(22,3,4,55,15,9)

z <- c(3,1,4,10,12,8)

df <- data.frame(fruit,x,y,z)

df

#to move column "z" to the extreme left (first column);  

#     sometimes it is more convenient to have frequently used columns on the left

df.new <- select(df,z, everything()) #the keyword "everything()" means that all remaining columns should be retained

df.new





# BOOK REFERENCE: 023 -----------------------------------------------------




#data on top 3 states by household income and other measures

#   sources:  US Census, New York Times and Wikipedia

state <- c("Maryland", "Alaska", "New Jersey")

income <- c(76067,74444,73702)

median.us <- c(61372,61372,61372)

life.expectancy <- c(78.8,78.3,80.3)

m.some.number <- c(33,11,44)

top.3.states <- data.frame(state, income, median.us, life.expectancy, m.some.number)

top.3.states #before

m.variables <- c(var1 = "median.us", var2 = "m.some.number")

only.m <- select(top.3.states, !!m.variables)

only.m #after

# --------------------------------------------------------------------




# BOOK REFERENCE: 024 -----------------------------------------------------



#select all

#applies a function to columns

top.3.states #before - column names are not capitalized

#capitalize column names, using the "toupper" function

new.top.3.states <- select_all(top.3.states, toupper)

new.top.3.states #after function "toupper" applied


# --------------------------------------------------------




# BOOK REFERENCE: 025 -----------------------------------------------------



state <- c("Maryland", "Alaska", "New Jersey")

income <- c(76067,74444,73702)

median.us <- c(61372,61372,61372)

life.expectancy <- c(78.8,78.3,80.3)

m.some.number <- c(33,11,44)

top.3.states <- data.frame(state, income, median.us, life.expectancy, m.some.number)

top.3.states #display dataframe values

pull.first.column <- pull(top.3.states,1)  #get only first column, the state

pull.first.column #show contents of first column (in this case, the state)


# use a negative to pull a column from the right.  -1 = rightmost column

pull.last.column <- pull(top.3.states,-1)  #get only last column, m.some.number

pull.last.column  #show contents of last column


# ------------------------------------------------------------



# BOOK REFERENCE: 026 -----------------------------------------------------


nrow(mtcars) #number of rows in original data frame


mtcars.more.than.200 <- filter_all(mtcars, any_vars(. > 200))

#anyting, anywhere, more than 200

nrow(mtcars.more.than.200)

#shows that only 16 rows met the criteria

#---------------------------------------------------




# BOOK REFERENCE: 027 -----------------------------------------------------


#select specified columns plus any column without a "p"

names(mtcars)  #column names of mtcars dataframe

cars.with.no.p <- select(mtcars, mpg, everything(), -contains("p"))

names(cars.with.no.p) #names of dataframe columns after select statement

#No column name with a "p" anywhere is included in the new dataframe


# ---------------------------------------------------------------------------



# BOOK REFERENCE: 028 -----------------------------------------------------



#select using wildcard type matching

names(mtcars)  #column names of built-in mtcars dataframe

#column name(s) selected contain the characters "pg" or "gea"

subset.mtcars <- select(mtcars,
                        
                        matches("pg|gea"))

names(subset.mtcars)


# --------------------------------------------------------------------




# BOOK REFERENCE: 029 -----------------------------------------------------

# column -> pull, row -> slice


#slice

msleep <- ggplot2::msleep #loads the msleep dataframe from the package ggplot2

nrow(msleep) #initially 83 rows

msleep.only.first.6 <-  slice(msleep, 1:6) #you do not have to know how many columns exist in the data frame. n() = total # of rows






nrow(msleep.only.first.6) #now only six rows - the first six rows of the dataframe


msleep.20.rows <- msleep  %>%
  
  slice(20:39)

nrow(msleep.20.rows)

#you can show the difference between the original and sliced data frame (or tibble) as follows:

nrow(msleep) - nrow(msleep.20.rows)


# ---------------------------------------------------------------------------------




# BOOK REFERENCE: 030 -----------------------------------------------------



#Left join:  match both files using key (by = "key"); keep all records on left dataframe

#     for any matching records on the right dataframe, add data to a new column to create

#     the output dataframe


us.state.areas <- as.data.frame(cbind(state.abb, state.area))

us.state.areas[1:3,]

us.state.abbreviation.and.name <- as.data.frame(cbind(state.abb, state.name))

us.state.abbreviation.and.name[1:3,]

#match by state abbreviation using left join

#for illustration purposes, alter the abbreviation for Alabama; you will see a warning message

us.state.abbreviation.and.name[1,1] <- "Intentional Mismatch"

us.state.with.abbreviation.and.name.and.area <- left_join(us.state.areas, us.state.abbreviation.and.name,
                                                          
                                                          by = "state.abb")

us.state.with.abbreviation.and.name.and.area[1:3,]





# BOOK REFERENCE: 031 -----------------------------------------------------



#inner join

#create first dataframe

names <- c("Sally","Tom","Frieda","Alfonzo")

team.scores <- c(3,5,2,7)

team.league <- c("alpha","beta","gamma", "omicron")

team.info <- data.frame(names, team.scores, team.league)

#create second dataframe

names = c("Sally","Tom", "Bill", "Alfonzo")

school.grades <- c("A","B","C","B")

school.info <- data.frame(names, school.grades)

school.and.team <- inner_join(team.info, school.info, by = "names")

school.and.team

#data appears on the school.and.team dataframe only when names match exactly






# BOOK REFERENCE: 032 -----------------------------------------------------


#antijoin - keeps all values from X with no match in y

# useful, for example, in a quality control review

# an individual in a firm's payroll table should have a match on

# a corresponding Human Resources table.  Mismatch is an error

#create first dataframe

names <- c("Sally","Tom","Frieda","Alfonzo")

team.scores <- c(3,5,2,7)

team.league <- c("alpha","beta","gamma", "omicron")

team.info <- data.frame(names, team.scores, team.league)

team.info

#create second dataframe

names <- c("Sally","Tom", "Bill", "Alfonzo")

school.grades <- c("A","B","C","B")

school.info <- data.frame(names, school.grades)

school.info

team.info.but.no.grades <- anti_join(team.info, school.info, by = "names")

team.info.but.no.grades




# BOOK REFERENCE: 033 -----------------------------------------------------


#fulljoin - keeps all values from X and Y; puts NAs

#   where appropriate

#create first dataframe

names = c("Sally","Tom","Frieda","Alfonzo")

team.scores = c(3,5,2,7)

team.league = c("alpha","beta","gamma", "omicron")

team.info = data.frame(names, team.scores, team.league)

#create second dataframe

names = c("Sally","Tom", "Bill", "Alfonzo")

school.grades = c("A","B","C","B")

school.info = data.frame(names, school.grades)

team.info.and.or.grades <- full_join(team.info, school.info, by = "names")

team.info.and.or.grades




# BOOK REFERENCE: 034 -----------------------------------------------------



#mutate_if

#eliminate factors

names = c("Sally","Tom","Frieda","Alfonzo")

team.scores = c(3,5,2,7)

team.league = c("alpha","beta","gamma", "omicron")

team.info = data.frame(names, team.scores, team.league)

str(team.info)  #shows factors

team.info.no.factors <-  mutate_if(team.info, is.factor, as.character)

str(team.info.no.factors)



# any NA in a numeric field is replaced by zero

df <- data.frame(
  
  alpha = c(22, 1, NA),
  
  almond = c(0, 5, 10),
  
  grape = c(0, 2, 2),
  
  apple = c(NA, 5, 10))

df

df.fix.alpha <- df %>% mutate_if(is.numeric, coalesce, ... = 0)

df.fix.alpha





new.df <- df %>% mutate_if((~max(.)==10 & str_detect(names(.), "al")), as.character)

new.df


x <- sample(c(1:5, NA, NA, NA))

coalesce(x, 44L)







# BOOK REFERENCE: 035 -----------------------------------------------------


#Right join:

# return all rows from y, and all columns from x and y. Rows in y with no match in x

# will have NA values in the new columns. If there are multiple matches between x and y,

# all combinations of the matches are returned.

us.state.areas <- as.data.frame(cbind(state.abb, state.area))

us.state.areas[1:3,]

us.state.abbreviation.and.name <- as.data.frame(cbind(state.abb, state.name))

us.state.abbreviation.and.name[1:3,]

#match by state abbreviation using left join

#for illustration purposes, alter the abbreviation for Alabama; you will see a warning message

us.state.abbreviation.and.name[1,1] <- "Intentional Mismatch"

us.state.with.abbreviation.and.name.and.area <- right_join(us.state.areas, us.state.abbreviation.and.name,
                                                           
                                                           by = "state.abb")

us.state.with.abbreviation.and.name.and.area[1:3,]


# --------------------------------------------------------------------------------

# SOMETHING ELSE?????


#filter out any vore name with an "a" or a "c" anywhere in the name

# ! is the not equal symbol in R.  str_detect is part of the stringr package

# which is automatically loaded using library(tidyverse)


msleep <- ggplot2::msleep #loads the msleep dataframe from the package ggplot2

table(msleep$vore)

msleep.no.c.or.a <- filter(msleep,  !str_detect(vore, paste(c("c","a"), collapse = "|")))

table(msleep.no.c.or.a$vore)

head(msleep.no.c.or.a)



#mutate:  add a field indicating whether a particular value in a column occurs more than once

#  in this case, the column is conservation

msleep.with.dup.indicator <- mutate(msleep, duplicate.indicator = duplicated(conservation))

formattable(msleep.with.dup.indicator[1:6,]) #note new field, duplicate.indicator to the right. Logical True or False


msleep.with.dup.indicator2 <- mutate(msleep, duplicate.indicator = duplicated(conservation, genus)) %>%
  
  arrange(conservation,genus)


formattable(msleep.with.dup.indicator2)  #both conversation and genus have to be duplicated for the duplicate.indicator to be set to TRUE


# book reference: 036 -----------------------------------------------------


test <- c(3,11,6,88)

first(test)

last(test)

nth(test,2)  #get second number

# -----------------------------------------------------------------------




# book reference: 037 -----------------------------------------------------



# RANKING

y <- c(100,4,12,6,8,3)

rank1 <-row_number(y)

rank1  #shows the vector index numbers corresponding to each rank

#  [1] 6 2 5 3 4 1

y[rank1[1]]  #lowest rank; in this case, rank1[1] points to y[6] which is 3 (lowest)

y[rank1[6]] #highest ranking number, in this case the first number, 100


#minimum rank

rank2 <- min_rank(y) #in this specific case (for y), gives same results as row_number

rank2


#dense rank

rank3 <- dense_rank(y)

rank3


#percent rank

rank4 <- percent_rank(y) #1st element of y is in the 100 percentile, 2nd element of y is in the 2 percentile

# the last element of y is in the 0 percentile

rank4


#cumulative distribution function.  It shows the proportion of all values

#  less than or equal to the current rank

rank5 <- cume_dist(y)

rank5


#breaks the input vector into n buckets

rank6 = ntile(y, 3)  #in this case, choose 3 buckets

rank6



#note: the base R quantile function also has an easy to read output

test.vector <- c(2,22,33,44,77,89,99)

quantile(test.vector, prob = seq(0,1,length = 11),type = 5)

# -----------------------------------------------------------------------------------------------------




# book reference: 038 -----------------------------------------------------



#sampling


data("ChickWeight")

my.sample <- sample_n(ChickWeight, 5)  #randomly sample 5 rows out of ChickWeight's 578 entries

my.sample


set.seed(833) #change this number each time you want the random function to produce the same results; otherwise, it will change from time to time


my.sample <- sample_n(ChickWeight, 10, replace = TRUE)  #sampling with replacement = TRUE means that you could get the same row or element more than once

#   whether to use True or False depends on your purpose.  If you are investigating manufacturing defects, you might want to use replace = FALSE

#   since you don't want to waste your time investigating the same defect again

my.sample


# in some cases sampling needs to be biased towards some higher impact data element.  For example, if you are verifying the accuracy of invoices

# you may want to weight large dollar amounts more than smaller amounts.  As a result you are more likely to get a high value invoice than one with a low dollar amount


#in this example, cars with more cylinders are more likely to be selected as part of the sample

my.sample <- sample_n(mtcars, 12, weight = cyl)

my.sample[,1:5]



x <-sample_frac(ChickWeight, 0.02) #sample 2% of the dataframe rows

x


by_hair_color <- starwars %>% group_by(hair_color)

my.sample <- sample_frac(by_hair_color, .07, replace = TRUE) #sample 7% with replacement

my.sample[,1:5]

# ----------------------------------------------------------------------------------




# Book reference: 039 -----------------------------------------------------


# tally & count


row.kount.only <- ChickWeight %>% tally() #provides only a count (578)

row.kount.only


diet.kount <- ChickWeight %>% count(Diet)  #includes both group_by and tally.  Convenient

diet.kount


# starwars example adapted from the DPLYR documentation (https://cran.r-project.org/web/packages/dplyr/dplyr.pdf)

# show only species that have a single member

# add_count is useful for groupwise filtering

single.species.kount <- starwars %>%
  
  add_count(species) %>%
  
  filter(n == 1)

single.species.kount[,1:6]

#-----------------------------------------------------------------------------------------------





# book reference: 040 -----------------------------------------------------


data(mtcars)

names(mtcars)

mtcars <- rename(mtcars, spam_mpg = mpg)

names(mtcars)


#-------------------------------------------------------------------------



# book reference: 041 -----------------------------------------------------

# not used


#-------------------------------------------------------------------------


# book reference: 042 -----------------------------------------------------


#case_when

#source:https://dplyr.tidyverse.org/reference/case_when.html

# case_when is particularly useful inside mutate when you want to

# create a new variable that relies on a complex combination of existing

# variables

new.starwars <- starwars %>%
  
  select(name:mass, gender, species) %>%
  
  mutate(
    
    type = case_when(
      
      height > 200 | mass > 200 ~ "large",
      
      species == "Droid"        ~ "robot",
      
      TRUE                      ~  "other"
      
    )
    
  )

new.starwars


#--------------------------------------------------------------------------




# book reference: 043 -----------------------------------------------------


row1 <- c("a","b","c","d","e","f","column.to.be.changed")

row2 <- c(1,1,1,6,6,1,2)

row3 <- c(3,4,4,6,4,4,4)

row4 <- c(4,6,25,5,5,2,9)

row5 <- c(5,3,6,3,3,6,2)

df <- as.data.frame(rbind(row2,row3,row4,row5))

names(df) <- row1

df #original

new.df <-df %>%
  
  mutate(column.to.be.changed  = case_when(a == 2 | a == 5 | a == 7 | (a == 1 & b == 4) ~  
                                             
                                             2, a == 0 | a == 1 | a == 4 | a == 3 |  c == 4 ~ 3,
                                           
                                           TRUE ~ NA_real_))

#this is a series of "OR" conditions

#if any of them are true, then the last column (column.to.be.changed) will be

#either a 2 or a 3


new.df #modified

#----------------------------------------------------------------------




# book reference 044 ------------------------------------------------------



#Gathering


state <- c("Maryland", "Alaska", "New Jersey")

income <- c(76067,74444,73702)

median.us <- c(61372,61372,61372)

life.expectancy <- c(78.8,78.3,80.3)

teen.birth.rate.2015 <- c(17,29.3,12.1)    #per 1,000 women (www.cdc.gov)

teen.birth.rate.2007 <- c(34.3,42.9,24.9)

teen.birth.rate.1991 <- c(54.1, 66, 41.3)

top.3.states <- data.frame(state, income, median.us, life.expectancy,
                           
                           teen.birth.rate.2015, teen.birth.rate.2007, teen.birth.rate.1991)

names(top.3.states) <- c("state", "income", "median.us", "life.expectancy","2015","2007","1991")

top.3.states #before

# to put all three years in one column, use gather

new.top.3.states <- top.3.states %>%
  
  gather("2015", "2007", "1991", key = "year", value = "cases")

new.top.3.states  



#--------------------------------------------------------------------------




# book reference: 045 -----------------------------------------------------



# spread


df_1 <- data_frame(Type = c("TypeA", "TypeA", "TypeB", "TypeB"),
                   
                   Answer = c("Yes", "No", NA, "No"),
                   
                   n = 1:4)

df_1  #before


df_2 <- df_1 %>%
  
  filter(!is.na(Answer)) %>%
  
  spread(key=Answer, value=n)


df_2 #after


#-------------------------------------------------------------------




# Book reference: 046 -----------------------------------------------------



# separate


state <- c("Maryland", "Alaska", "New Jersey")

income <- c(76067,74444,73702)

median.us <- c(61372,61372,61372)

life.expectancy <- c(78.8,78.3,80.3)

teen.birth <- c("17//34.3//54.1", "29.0//42.9//66.0", "12.1//24.9//41.3")

#teen.birth as a column has three data elements per row, separated by a special

# character ("//")

top.3.states <- data.frame(state, income, median.us, life.expectancy,
                           
                           teen.birth)

top.3.states #before: years 2015, 2007, and 1991 are combined in one column, "teen.birth"


top.3.states.separated.years <- top.3.states %>%
  
  separate(teen.birth, into = c("2015", "2007","1991"), sep = "//")


top.3.states.separated.years #after


# --------------------------------------------------------------------------------













