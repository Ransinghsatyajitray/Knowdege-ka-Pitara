# Visualization Centric Packages
library(ggplot2)
library(dplyr)
library(DataExplorer)
library(patchwork)
library(gganimate)
library(gapminder)
library(gifski)


setwd("C:\\Users\\DELL PC\\Desktop\\All about Visualization in R")


data("gapminder")


# Basic histogram with ggplot2----

# dataset:
data <- data.frame(value=rnorm(100))

# basic histogram
p <- ggplot(data, aes(x=value)) + 
  geom_histogram()


p


# Load dataset from github
data1 <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/1_OneNum.csv", header=TRUE)

# plot
p1 <- data1 %>%
  filter( price<300 ) %>%
  ggplot( aes(x=price)) +
  geom_histogram( binwidth=3, fill="#69b3a2", color="#e9ecef", alpha=0.9) +
  ggtitle("Bin size = 3") +
  theme_ipsum() +
  theme(
    plot.title = element_text(size=15)
  )

p1


# Mirror density chart with ggplot2----
# Dummy data
data3 <- data.frame(
  var1 = rnorm(1000),
  var2 = rnorm(1000, mean=2)
)

# Chart
p3 <- ggplot(data3, aes(x=x) ) +
  # Top
  geom_density( aes(x = var1, y = ..density..), fill="#69b3a2" ) +
  geom_label( aes(x=4.5, y=0.25, label="variable1"), color="#69b3a2") +
  # Bottom
  geom_density( aes(x = var2, y = -..density..), fill= "#404080") +
  geom_label( aes(x=4.5, y=-0.25, label="variable2"), color="#404080") +
  theme_ipsum() +
  xlab("value of x")


p3



# Histogram with several groups - ggplot2----
# Build dataset with different distributions
data4 <- data.frame(
  type = c( rep("variable 1", 1000), rep("variable 2", 1000) ),
  value = c( rnorm(1000), rnorm(1000, mean=4) )
)


# Represent it
p4 <- data4 %>%
  ggplot( aes(x=value, fill=type)) +
  geom_histogram( color="#e9ecef", alpha=0.6, position = 'identity') +
  scale_fill_manual(values=c("#69b3a2", "#404080")) +
  theme_ipsum() +
  labs(fill="")



p4



# Using small multiple
library(viridis)
library(forcats)





# Animation:----
# Get data:


# Charge libraries:
# library(ggplot2)
# library(gganimate)
# library(gifski)


# Make a ggplot, but add frame=year: one image per year
animate_1 <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, color = continent)) +
  geom_point() +
  scale_x_log10() +
  theme_bw() +
  # gganimate specific bits:
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) + # time variables used for transition
  ease_aes('linear')

# Save at gif:
animate(animate_1, duration = 5, fps = 20, width =500, height =500, renderer = gifski_renderer())
anim_save("output.gif")


# Make a ggplot, but add frame=year: one image per year
animate_2 <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')


# Save at gif:
animate(animate_2, duration = 5, fps = 20, width =500, height =500, renderer = gifski_renderer())
anim_save("output2.gif")


# Progressive line chart rendering

library(babynames)
library(hrbrthemes)

# Keep only 3 names
don <- babynames %>% 
  filter(name %in% c("Ashley", "Patricia", "Helen")) %>%
  filter(sex=="F")

# Plot
annimate_3 <- don %>%
  ggplot( aes(x=year, y=n, group=name, color=name)) +
  geom_line() +
  geom_point() +
  scale_color_discrete() +
  ggtitle("Popularity of American names in the previous 30 years") +
  theme_ipsum() +
  ylab("Number of babies born") +
  transition_reveal(year)


animate(annimate_3, duration = 5, fps = 20, width =500, height =500, renderer = gifski_renderer())
anim_save("output1.gif")


