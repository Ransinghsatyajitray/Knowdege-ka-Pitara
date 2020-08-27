setwd("C:\\Users\\DELL PC\\Desktop\\Practice Projects R\\Predicting Emp Attrition R Project Kindle Book\\Writing Function and Functional Programming with purrr")

#__________________________________PURRR_______________________________________________
#Lists can be difficult to both understand and manipulate, but they can pack a ton of information and are very powerful. 

library(purrr)


# Using for loop----
#empty list that takes inputs from content within for loop
list_to_fill <- list()

for(i in seq_along(mtcars)){
  list_to_fill[[i]] <- mean(mtcars[[i]])
}

list_to_fill


# using map
map(mtcars,mean) # This gives the same result



# _______________________________Index subsetting if list___________________________________
mtcars[1]
mtcars[[1]] #this gives list
mtcars[[1]][1]



library(dplyr)
map_df(mtcars,mean) %>% pivot_longer(cols=1:11,names_to = "Variables",values_to = "Mean")


df_rows <- data.frame(names=names(mtcars),rows=NA)


for(i in seq_along(mtcars)){
  df_rows[i,'rows'] <- mean(mtcars[[i]]) 
}

df_rows




# map outputs a list
map_df(mtcars,~mean(.x)/sd(.x))

library(repurrrsive)
data("sw_films")


# sw_films is a list of dataframes
sw_films %>% set_names(map_chr(sw_films,"title"))

map_chr(sw_films,"title")

sw_films[[1]]$episode_id


# pipes with map.----
map_df(mtcars,~.x %>% sum() %>% log())
map_df(mtcars,~.x %>% sum(.) %>% log(.))  #always keep . within the function and always start with ~.x


map_df(mtcars,~mean(.)/sd(.))
map_df(mtcars,~.x %>% mean(.)/sd(.))

# creating list df----
sites <- list("north","east","west")
list_of_df <-  map(sites,  
                   ~data.frame(sites = .x,
                               a = rnorm(mean = 5,   n = 200, sd = (5/2)),
                               b = rnorm(mean = 200, n = 200, sd = 15)))



# Multiple linear equation on go----
list_of_df %>% 
  map(~.x %>% lm(a~b,data=.)) %>%
  map(summary)


# getting specific output from regression model
library(broom)

list_of_df %>% 
  map(~.x %>% lm(a~b,data=.)) %>%
  map(~.x %>% glance(.))

list_of_df %>% 
  map(~.x %>% lm(a~b,data=.)) %>%
  map(~.x %>% tidy(.))

list_of_df %>% 
  map(~.x %>% lm(a~b,data=.)) %>%
  map(~.x %>% augment(.))




# map2 when different input data are stored in 2 different list----
# List of 1, 2 and 3
means <- list(1,2,3)

# Create sites list
sites <- list("north","west","east")

# Map over two arguments: sites and means
list_of_files_map2 <- map2(sites, means, ~data.frame(sites = .x,
                                                     a = rnorm(mean = .y, n = 200, sd = (5/2))))


# # pmap when different input data are stored in more than 2 different list----
sites <- list("a","b","c","d")
means <- list(1,2,3,4)
sigma <- list(.1,.2,.3,.4)
means2 <- list(10,20,30,40)
sigma2 <- list(1,2,3,4)

# Create a master list, a list of lists
pmapinputs <- list(sites = sites, means = means, sigma = sigma, 
                   means2 = means2, sigma2 = sigma2)

# Map over the master list
list_of_files_pmap <- pmap(pmapinputs, 
                           function(sites, means, sigma, means2, sigma2) 
                             data.frame(sites = sites,
                                        a = rnorm(mean = means,  n = 200, sd = sigma),
                                        b = rnorm(mean = means2, n = 200, sd = sigma2)))

list_of_files_pmap



# safely----
list_of_df %>% 
  map(safely(function(x)lm(a~b,data=x)))

