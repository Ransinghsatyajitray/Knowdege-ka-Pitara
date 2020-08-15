# Iteration is a powerful way to make the computer do the work for you. It can also be an area of coding 
# where it is easy to make lots of typos and simple mistakes. The purrr package helps simplify iteration 
# so you can focus on the next step, instead of finding typos.

install.packages("repurrrsive")

# The power of iteration
map(object, functions)

# # Initialize list
# all_files <- list()
# 
# # For loop to read files into a list
# for(i in seq_along(files)){
#   all_files[[i]] <- read_csv(file = files[[i]])
# }
# 
# # Output size of list object
# length(all_files)



# # Load purrr library
# library(purrr)
# 
# # Use map to iterate
# all_files_purrr <- map(files,readr::read_csv) 
# 
# # Output size of list object
# length(all_files_purrr)



# Load repurrrsive package, to get access to the wesanderson dataset
library(repurrrsive)

# Load wesanderson dataset
data(wesanderson)

# Get structure of first element in wesanderson
str(wesanderson[[1]])

# Get structure of GrandBudapest element in wesanderson
str(wesanderson$GrandBudapest)


# Third element of the first wesanderson vector
wesanderson[[1]][3]

# Fourth element of the GrandBudapest wesanderson vector
wesanderson$GrandBudapest[4]


# Subset the first element of the sw_films data
sw_films[[1]]

# Subset the first element of the sw_films data, the title column 
sw_films[[1]]$title


# Many flavors of map():
#map_dbl -> vector

# Map over wesanderson, and determine the length of each element
map(wesanderson, ~length(.x))



# Create a dataframe that has the number of colors from each movie, using map_dbl(). The dbl means a double or a number that can have a decimal.
# Create a numcolors column and fill with length of each wesanderson element
data.frame(numcolors = map_dbl(wesanderson, ~length(.x)))


# pipe inside map.----
map(mtcars,~.x %>% sum() %>% log())

# List of sites north, east, and west
sites <- list("north","east","west")

# Create a list of dataframes, each with a years, a, and b column
list_of_df <-  map(sites,  
                   ~data.frame(sites = .x,
                               a = rnorm(mean = 5,   n = 200, sd = (5/2)),
                               b = rnorm(mean = 200, n = 200, sd = 15)))

list_of_df

# Map over the models to look at the relationship of a vs b
list_of_df %>%
  map(~ lm(a ~ b, data = .)) %>%
  map(summary)



# map2 and pmap
# List of 1, 2 and 3
means <- list(1,2,3)

# Create sites list
sites <- list("north","west","east")

# Map over two arguments: sites and means
list_of_files_map2 <- map2(sites, means, ~data.frame(sites = .x,
                                                     a = rnorm(mean = .y, n = 200, sd = (5/2))))

list_of_files_map2


# # Create a master list, a list of lists
# pmapinputs <- list(sites = sites, means = means, sigma = sigma, 
#                    means2 = means2, sigma2 = sigma2)
# 
# # Map over the master list
# list_of_files_pmap <- pmap(pmapinputs, 
#                            function(sites, means, sigma, means2, sigma2) 
#                              data.frame(sites = sites,
#                                         a = rnorm(mean = means,  n = 200, sd = sigma),
#                                         b = rnorm(mean = means2, n = 200, sd = sigma2)))
# 
# list_of_files_pmap

# safely: to check where in the list the error is occuring.
# eg. map(safely(function(x),x*10,otherwise=NA_real_))

# possibly: dont show the error.




# walk:
# Load the gap_split data
data(gap_split)

# Map over the first 10 elements of gap_split
plots <- map2(gap_split[1:10], 
              names(gap_split[1:10]), 
              ~ ggplot(.x, aes(year, lifeExp)) + 
                geom_line() +
                labs(title = .y))

# Object name, then function name
walk(plots, print)




mtcars %>% map_df(~.x %>% log() %>% sin())



# XXXXXXXXXXXXXXXXXXXXXX more practice needed XXXXXXXXXXXXXXXXXXXXXXXXXXx
#  need to revise again













