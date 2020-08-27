setwd("C:\\Users\\DELL PC\\Desktop\\Practice Projects R\\Predicting Emp Attrition R Project Kindle Book\\All about Visualization in R")
data("diamonds")
str(diamonds)

#Simple Graph g1----
ggplot(diamonds,aes(x=carat,y=price))+geom_point()
#Result: Here we get black and white graph

#Character Changed to factor g2----
ggplot(diamonds,aes(x=factor(clarity),y=price))+geom_point()
#Result: Here we get an overplotted black and white graph, oppertunity of using jittering here. The x axis 
#written as factor(clarity) is annoying

#Simple Graph with color g3----
ggplot(diamonds,aes(x=carat,y=price,color=color))+geom_point()
#Result: Here we get colored graph with the points being colored(aesthetic) as per their color(variable)


#g3 Graph with color aesthetic written in geom_point g4----
ggplot(diamonds,aes(x=carat,y=price))+geom_point(aes(color=color))
#this is same as ggplot(diamonds,aes(x=carat,y=price,color=color))+geom_point()


# Graph with size element g5----
ggplot(diamonds,aes(x=carat,y=price,size=x))+geom_point()
# this produces graph with size of the point depending on the x


#Alpha included g6----
ggplot(diamonds,aes(x=carat,y=price,color=clarity))+geom_point(alpha=0.4)
#this produces graph with providing some transperency to the points


#With smoothing line along with point g7----
ggplot(diamonds,aes(x=carat,y=price))+geom_point(alpha=0.6)+
  geom_smooth(method='lm',col='red',se=F)
#this produces graph scatter plot with a smoothing line 


#With coord_fixed: A fixed scale coordinate system forces a specified ratio between the physical 
#representation of a data unit on the axes. The default ratio=1, ensure that one unit on the x-axis 
#is same length as one unit on the y axis.

#coord_fixed (ratio=1) (x/y) ie. x unit in x axis to y unit in y axis to g8

ggplot(diamonds,aes(x=carat,y=price))+geom_point(alpha=0.4)+coord_fixed()
#As the x axis is very smaller than y axis scale, thus our graph is very weird



#1000 unit in y axis is 1 unit in x axis=> ratio=x/y (1/1000)= 0.001  g9
ggplot(diamonds,aes(x=table,y=price))+geom_point(alpha=0.4)+coord_fixed(ratio=.001)
#Over plotting is a problem here as seen


#we are log transforming the y axis scale_y_log10  g10
ggplot(diamonds,aes(x=table,y=price))+geom_point(alpha=0.4)+scale_y_log10()


# To change the range of a continuous axis, the functions xlim() and ylim() can be used we 
#limit the graph to 80 in x axis and 10000 in y axis g11
ggplot(diamonds,aes(x=table,y=price))+geom_point(alpha=0.4)+scale_y_log10()+xlim(0,80)+ylim(0,10000)

# this is same as g11 as g12 (ax ylim is overwriting on the scale_y_log10)
ggplot(diamonds,aes(x=table,y=price))+geom_point(alpha=0.4)+xlim(0,80)+ylim(0,10000)




# the function expand_limits() can be used to :quickly set the intercept of x and y axes at (0,0)
# change the limits of x and y axes g13
ggplot(diamonds,aes(x=table,y=price))+geom_point(alpha=0.4)+expand_limits(x=c(0,80),y=c(0,10000))
#This is same as g11



# It is also possible to use the functions scale_x_continuous() and scale_y_continuous() to change x and y axis limits, respectively.
# 
# The simplified formats of the functions are :
#   
#   scale_x_continuous(name, breaks, labels, limits, trans)
# scale_y_continuous(name, breaks, labels, limits, trans)  g14

ggplot(diamonds,aes(x=table,y=price))+geom_point(alpha=0.4)+
  scale_x_continuous(name="Axis for Table",breaks=c(5,10,30,80),limits=c(0,80))
#Here we did 3 things in 1 go, we named the Axis, pointed out where we want the breaks in the axis to show up
#and set the limit 0 min and 80 max





#scale_x_sqrt(), scale_y_sqrt() : for sqrt transformation g15
ggplot(diamonds,aes(x=table,y=price))+geom_point(alpha=0.4)+scale_y_sqrt()
#like like scale_y_log10() we did sqrt transformation of y axis


#The transforming the scale dont have physical effect on the data point like scale_y_sqrt dont 
#square root the y axis elements, it simply transform the axis scaling showing data only in the
#specific ranges as specified in the scaling and exclude other



#Axis tick marks can be set to show exponents. The scales package is required to
#access break formatting functions g16
library(scales)
ggplot(diamonds,aes(x=table,y=price))+geom_point(alpha=0.4)+
  scale_y_continuous(trans=log2_trans(),breaks=trans_breaks("log2",function(x)2^x),labels= trans_format("log2",math_format(2^.x)))
#for running trans_breaks and trans_format we use scales packages
#any exponential thing comes under logvalue_trans() and the function to write the trans_breaks is like above




#Note that many transformation functions are available using the scales package : log10_trans(), 
#sqrt_trans(), etc. Use help(trans_new) for a full list.





#Smoothing line by geom smooth
#methods: auto- smoothing method choosen based on the size of largest group
#loess- used for less than 1000 obs
#gam- >1000 obs
#lm- linear model     g17
ggplot(diamonds,aes(x=x,y=y))+geom_point(alpha=0.2)+
  geom_smooth(aes(color=clarity),se=FALSE)
#Interesting thing to node that except x and y aesthetic other aesthetics can also go in inside geoms
#We can also see even if we dont specify the method R automatically took smoothing method to be 
# gam as the number of observations >1000




#Multiple smoothing lines all serving different purpose  g18
ggplot(mtcars,aes(x=wt,y=mpg,col=factor(cyl)))+geom_point()+geom_smooth(method="lm",se=FALSE)+
  geom_smooth(aes(group=1),method="lm",se=F,linetype=2)


#Overplotting where jittering is required g19
ggplot(diamonds,aes(y=carat,x=clarity,color=cut))+geom_point(position="jitter")

#this is same as g20
ggplot(diamonds,aes(y=carat,x=clarity,color=cut))+geom_jitter()

str(diamonds)

#the following are the elements of the aesthetics
#x,y,color,size,alpha,linewidth,fill,labels,shape,linetype

#Shape 21 goes in the geom_point (donot mention it in aesthetics) and not in ggplot
#When shape 21 is used the size goes in geom_point too g21
ggplot(diamonds,aes(x=x,y=y,color=color,alpha=0.3))+geom_point(shape=21,size=4)

str(mtcars)
#use of text in graphs, we use geom_text() g22
ggplot(mtcars,aes(x=wt,y=mpg,label=cyl,color=vs))+geom_text(size=3)

#The labeled variable is shown g23
ggplot(mtcars,aes(x=wt,y=mpg,label=cyl,color=factor(vs)))+geom_text(size=3)


#Jittering with jitter width g24
ggplot(mtcars,aes(x=factor(cyl),y=mpg,col=factor(gear),alpha=0.5))+
  geom_point(position=position_jitter(0.1))

#or 
ggplot(mtcars,aes(x=factor(cyl),y=mpg,col=factor(gear),alpha=0.5))+
  geom_jitter(width=0.1)

#Faceting facet_grid y | ~ x -  g25
ggplot(mtcars,aes(x=mpg,y=cyl,col=as.factor(vs)))+
  geom_point()+facet_grid(am~gear)
#Problem here is by just looking at the figure we cant say which one is am and which one is gear

#g26
ggplot(mtcars,aes(x=mpg,y=cyl,col=as.factor(vs)))+geom_point()+facet_grid(am~.)

#g27
ggplot(mtcars,aes(x=mpg,y=cyl,col=as.factor(vs)))+geom_point()+facet_grid(.~gear)

#Problem with g25,g26,g27 is it is difficult to identify what does the facet parameters refer to



# the concept of ggplot divides a plot into three different fundamental
# parts: plot = data + Aesthetics + geometry.

#geom_histogram, the fill should be place in geom g28
ggplot(mtcars,aes(x=wt))+geom_histogram(alpha=0.4,fill="blue")


#density plot g29
ggplot(mtcars,aes(x=wt))+geom_density(fill="blue",alpha=0.4)


#A subset of mtcars data is used by the layer geom_line(). The line is colored
#according to the values of the continuous variable cyl. g30
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() + # to draw points
  geom_line(data = head(mtcars), color = "red")


#Use of pipe inside geom g31
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() + # to draw points
  geom_line(data = mtcars%>%filter(vs==1), color = "red")

#Use of pipe inside geom g32
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() + # to draw points
  geom_line(data = mtcars%>%filter(vs==1), color = "red")+
  geom_line(data = mtcars%>%filter(vs==0), color = "green")


# For one continuous variable:
#   - geom_area() for area plot
# - geom_density() for density plot
# - geom_dotplot() for dot plot
# - geom_freqpoly() for frequency polygon
# - geom_histogram() for histogram plot
# - stat_ecdf() for empirical cumulative density function
# - stat_qq() for quantile - quantile plot

#geom_area require both x and y aesthetics g33
ggplot(mtcars,aes(x=drat,y=hp))+geom_area()


#frequency polygon, the thing we plot using the geom_histogram we could plot the same
#using frequency ploygon g34
ggplot(mtcars,aes(x=drat))+geom_freqpoly()
#fill and color dont work in geom_freqpoly



#We can color the area under the frequency ploygon by using below g35
ggplot(mtcars,aes(x=drat))+geom_area(stat="bin",color= "black", fill="#00AFBB")
#stat="bin is must otherwise r will throw an error


#through the ..internal_parameter.. we get the density plot by controlling the
#y axis g36
ggplot(mtcars,aes(x=drat))+geom_histogram(aes(y=..density..))


#Bar plot vs area plot 
ggplot(mtcars,aes(x=drat))+geom_bar(stat="bin") #bar plot g37

ggplot(mtcars,aes(x=drat))+geom_area(stat="bin") #area plot g38


#Density plot g39
ggplot(mtcars,aes(x=drat))+geom_density(color="black",fill="gray")+
  geom_vline(aes(xintercept=mean(drat),color="#FC4E07", linetype="dashed"))


#What should be in aesthetics: basically all x , y of any form which are accessed directly from the data (be it directly or be it indirectly like mean sd operation on them)


#Change colors by groups g40
ggplot(mtcars,aes(x=drat))+geom_density(aes(color=factor(cyl)))


#g41
ggplot(mtcars,aes(x=drat))+geom_density(aes(fill=factor(cyl)),alpha=0.4)

#An example where different dataframe used for plotting graph (Vimp) g42
ggplot(mtcars,aes(x=drat))+geom_density(aes(color=factor(cyl),alpha=0.4))+
  geom_vline(data=diamonds,aes(xintercept=mean(x),color=cut),linetype="dashed")
#Although the above graph is confusing but it serve our pupose to show multiple dataframe could be used




#How to know the formula of colors used in R

#Basic Histo, increasing no of bins, change line color and fill color, overlaod histo, dodge (interleaved),
#histo with density,
#qqplot
# geom_point() for scatter plot
# . geom_smooth() for adding smoothed line such as regression line
# . geom_quantile() for adding quantile lines
# . geom_rug() for adding a marginal rug
# . geom_jitter() for avoiding overplotting
# . geom_text() for adding textual annotations



#Histogram with density plot g43
ggplot(mtcars,aes(x=drat))+geom_histogram(aes(y=..density..), colour="black", fill="white") +
  geom_density(alpha=0.2, fill = "#FF6666")
#frequency ploygon (normal data count) & density plot (normal data %cummulative)

#g44
ggplot(mtcars,aes(x=drat))+geom_histogram(aes(y=..density.., color = factor(am), fill = factor(am)),
                                          alpha=0.5)+
  geom_density(aes(color = factor(am)), size = 1)

#ECDF (Empirical Cumulative Density Function) reports for any given number the
#percent of individuals
ggplot(mtcars,aes(x=drat))+stat_ecdf(geom="point") #g45
ggplot(mtcars,aes(x=drat))+stat_ecdf(geom="step") #g46


#bar: fill, dodge, stack
ggplot(mtcars,aes(x=cyl,fill=am))+geom_bar() #g47


ggplot(mtcars,aes(x=cyl,fill=factor(am)))+geom_bar(position="stack") #g48


ggplot(mtcars,aes(x=cyl,fill=factor(am)))+geom_bar(position="fill") #g49


ggplot(mtcars,aes(x=cyl,fill=factor(am)))+geom_bar(position="dodge") #g50


ggplot(mtcars,aes(x=cyl,fill=factor(am)))+geom_bar(position=position_dodge(width=0.2)) #g51

ggplot(mtcars,aes(x=cyl,fill=factor(am)))+geom_bar(position="dodge",width=.2)

#Scatter plots: Continuous X and Y
b <- ggplot(mtcars, aes(x = wt, y = mpg))

b+geom_point() #g52
b+geom_smooth() #g53
b+geom_quantile() #g54


#Smoothing line g55
b+geom_smooth(method="auto", se=TRUE, fullrange=FALSE, level=0.95)



#Add quantile lines from a quantile regression g56
ggplot(mpg, aes(cty, hwy)) +
  geom_point() + geom_quantile() +
  theme_minimal()


#Add marginal rugs using faithful data  g57
data(faithful)
ggplot(faithful, aes(x = eruptions, y = waiting)) +
  geom_point() + geom_rug()

#g58
b + geom_point(aes(color = factor(cyl))) +
  geom_rug(aes(color = factor(cyl)))   
#Rug are lines attached to the axis, they provide more(additional) insight in to data of how data is distributed


#Textual annotations (use of row names) g59
b + geom_text(aes(label = rownames(mtcars)),
              size = 3)


#2d density plot g60
c <- ggplot(diamonds, aes(carat, price))
c + geom_density_2d()



#Scatter plots with 2d density estimation g61
sp <- ggplot(faithful, aes(x = eruptions, y = waiting))

sp + geom_point(color = "#00AFBB") +
  geom_density_2d(color = "#E7B800")




data("ToothGrowth")
e <- ggplot(ToothGrowth, aes(x = factor(dose), y = len))


#Check where fun.data and fun.args are used

#when we are using summary of certain aesthetic in stat_summary we use fun.y(or fun.x) depending on which axis factor 
#we are doing the analysis g62
e + geom_jitter(position = position_jitter(0.2)) +
  stat_summary(fun.y = mean, geom = "point",
               shape = 18, size = 3, color = "red")

#stat_summary fun.data and fun.args g63
#The function stat_summary() can be used to add mean/median points
e + geom_jitter(position = position_jitter(0.2))+
  stat_summary(fun.data="mean_sdl", fun.args = list(mult=1),
               geom="pointrange", color = "red")
#here in stat summary since we are not only using y data mean alone we are using std with 1 standard deviation
#mult=1

#g64
e + geom_jitter(position = position_jitter(0.2))+
  stat_summary(fun.data="mean_sdl", fun.args = list(mult=3),
               geom="pointrange", color = "red")


# Change manually point colors using the functions :
#   . scale_color_manual(): to use custom colors
# . scale_color_brewer(): to use color palettes from RColorBrewer package
# . scale_color_grey(): to use grey color palettes
e3 <- e + geom_jitter(aes(color = factor(dose)), position = position_jitter(0.2)) +
  theme_minimal()

e3 + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9")) #g65

e3 + scale_color_brewer(palette="Dark2") #g66

#Bar Chart

f <- ggplot(mtcars, aes(x = factor(cyl), y = wt))

# Change fill color manually: custom color
f + geom_bar(aes(fill = factor(am)), stat="identity") +
  scale_fill_manual(values = c("#999999", "#E69F00"))  #g67

# Add labels to a dodged bar plot :
#   ggplot(data=df2, aes(x=dose, y=len, fill=supp)) +
#   geom_bar(stat="identity", position = position_dodge())+
#   geom_text(aes(label = len), vjust = 1.6, color = "white",
#             position = position_dodge(0.9), size = 3.5)

# Possible layers include:
#   . geom_crossbar() for hollow bar with middle indicated by horizontal line
# . geom_errorbar() for error bars
# . geom_errorbarh() for horizontal error bars
# . geom_linerange() for drawing an interval represented by a vertical line
# . geom_pointrange() for creating an interval represented by a vertical line,
# with a point in the middle.


# Horizontal error bar
#The arguments xmin and xmax are used for horizontal error bars.
# ggplot(mtcars, aes(x = factor(cyl), y = wt ,
#                      xmin = wt-sd, xmax = wt+sd))


#Pie Charts
#The function coord_polar() is used to produce a pie chart, which is just a stacked
#bar chart in polar coordinates.

df <- data.frame(
  group = c("Male", "Female", "Child"),
  value = c(25, 25, 50))


#default plot
ggplot(df, aes(x="", y = value, fill=group)) +
  geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0) #g68

ggplot(df, aes(x="", y = value, fill=group)) +
  geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0) +
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))       #g69

#Check out how to plot pei chart in R
count.data <- data.frame(
  class = c("1st", "2nd", "3rd", "Crew"),
  n = c(325, 285, 706, 885),
  prop = c(14.8, 12.9, 32.1, 40.2)
)

mycols <- c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF")


ggplot(count.data, aes(x = "", y = prop, fill = class)) +
  geom_bar(width = 1, stat = "identity", color = "white")+
  coord_polar("y", start = 0)  #Very simple pie chart g70 

#cumsum ie cummulative sum plays a very vital role in pie chart with label
count.data<-count.data %>%
  arrange(desc(class)) %>%
  mutate(cum_sum = cumsum(prop),lab.ypos = cumsum(prop) - 0.5*prop)
#this step lab.ypos = cumsum(prop) - 0.5*prop is very vital in plotting the graph





ggplot(count.data, aes(x = "", y = prop, fill = class)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0)+
  geom_text(aes(y = lab.ypos, label = prop), color = "white") #g71

#Theme is taken as void while considering pie chart
#Add text annotations : The package scales is used to format the labels in percent
ggplot(count.data, aes(x = "", y = prop, fill = class)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0)+
  geom_text(aes(y = lab.ypos, label = prop), color = "white")+
  theme_void()  #g72


#We go with pie chart ony after we have compiled our entire data


#Donut Chart
ggplot(count.data, aes(x = 2, y = prop, fill = class)) +
  geom_bar(stat = "identity", color = "white") +
  coord_polar(theta = "y", start = 0)+
  geom_text(aes(y = lab.ypos, label = prop), color = "white")+
  scale_fill_manual(values = mycols) +
  theme_void()+
  xlim(0.5, 2.5)  #g73


## Simple Pie Chart
slices <- c(10, 12,4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
pie(slices, labels = lbls, main="Pie Chart of Countries")  #g74


pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Countries")  #g75
#pie(numerical data, catagorical data for labels, heading)



ggplot(count.data, aes(x = 2, y = prop, fill = class)) +
  geom_bar(stat = "identity", color = "white") +
  coord_polar(theta = "y", start = 0)+
  geom_text(aes(y = lab.ypos, label = paste(prop,"%")), color = "white")+
  theme_void()  #g76




#All columns except am
group_by_am<-9
my_names_am<-(1:11)[-group_by_am]  #vector of all numbers from 1 to 11 except 


#Dropping levels
#When we have a catagorical variable withy many levels which are not all present in each sub group og another
#,it may be desirable to drop the unused levels.
str(diamonds)
d<-ggplot(diamonds,aes(x=x,y=y,col=factor(cut)))+geom_point()
#faceting as per clarity
d+facet_grid(clarity~.) #g77

#Speifying scale argument to free up rows
d+facet_grid(clarity~.,scale="free_y") #scale="free_y" removes the data which are very low beonging to perticular
#combination of catagory g78

d+facet_grid(clarity~.,space="free_y")# y axis scale are clearly visible g79


d+facet_grid(clarity~.,space="free_y",scale="free_y") #g80


#theme
diamonds%>%ggplot(aes(X=color,y=price))+
  geom_boxplot(outlier.colour = "red",outlier.shape = 2,outlier.size = 1,alpha=0.2)+
  geom_hline(yintercept = c(5000,10000,13500),linetype="dashed",color="steelblue")+
  facet_grid(~clarity,scale="free_x",space="free_y")+
  theme_grey()+ #text in the x axis
  theme(axis.text.x=element_text(angle=45,size=5))+ #the faceting creates grey section which are called strip
  theme(strip.text.x=element_text(angle=90,size=7))+ggtitle("Pricing of diamonds")+
  theme(plot.title=element_text(hjust=0.5))+
  theme(axis.text.y=element_text(angle=90))   #g81



#Accumulating multiple graphs in a single page

d1<-diamonds%>%ggplot(aes(X=color,y=price))+
  geom_boxplot(outlier.colour = "red",outlier.shape = 2,outlier.size = 1,alpha=0.2)+
  geom_hline(yintercept = c(5000,10000,13500),linetype="dashed",color="steelblue")+
  facet_grid(~clarity,scale="free_x",space="free_y")+
  theme_grey()+ #text in the x axis
  theme(axis.text.x=element_text(angle=45,size=5))+ #the faceting creates grey section which are called strip
  theme(strip.text.x=element_text(angle=90,size=7))+ggtitle("Pricing of diamonds")+
  theme(plot.title=element_text(hjust=0.5))+
  theme(axis.text.y=element_text(angle=90)) 

d2<-d+facet_grid(clarity~.,space="free_y")



d3<-ggplot(count.data, aes(x = 2, y = prop, fill = class)) +
  geom_bar(stat = "identity", color = "white") +
  coord_polar(theta = "y", start = 0)+
  geom_text(aes(y = lab.ypos, label = paste(prop,"%")), color = "white")+
  theme_void() 


d4<-f + geom_bar(aes(fill = factor(am)), stat="identity") +
  scale_fill_manual(values = c("#999999", "#E69F00"))


d5<-ggplot(faithful, aes(x = eruptions, y = waiting)) +
  geom_point() + geom_rug()



d6<-ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() + # to draw points
  geom_line(data = mtcars%>%filter(vs==1), color = "red")

library(cowplot)

plot_grid(d1,d2,d3,d4,d5,d6,nrow=2,ncol=3,labels=c("d1","d2","d3","d4","d5","d6"),hjust=1) #g82


#More Practice needed on theme layer and color coding

library(RColorBrewer)
ggplot(diamonds,aes(cut,fill=color))+
  geom_bar(position="dodge")

#It is simpler to use color schemes that have been designed by other people==========
ggplot(diamonds,aes(cut,fill=color))+
  geom_bar(position="dodge")+
  scale_fill_brewer()  #g83
#This color scheme better suits to continuous rather than the categorical data

#check out all brewer present
display.brewer.all()
ggplot(diamonds,aes(cut,fill=color))+
  geom_bar(position="dodge")+
  scale_fill_brewer(palette="Pastel1")  #g84


ggplot(diamonds,aes(cut,fill=color))+
  geom_bar(position="dodge")+
  scale_fill_brewer(palette="Paired")  #g85


ggplot(diamonds,aes(cut,fill=color))+
  geom_bar(position="dodge")+
  scale_fill_brewer(palette="Accent")  #g86


#Control chart in R
# Load the qcc package


library(qcc)

# Step 1
# The first step is loading the qcc package and sample data.It can be seen from the data that there are total 200 observations of diameter 
# of Piston rings- 40 samples with 5 reading/observation each.


data(pistonrings)
head(pistonrings)


# Step 2
# Before creating control charts, we need to create qcc object from the data, which can be done by calling qcc function.

diameter<-qcc.groups(pistonrings$diameter,pistonrings$sample)


# Step 3
# Now, we consider first 40 samples as training data.

# R chart (plotting range of all groups) and X-bar chart
# (plotting averages of all groups) can be created as follows:

obj <- qcc(diameter[1:40,], type="R") #g87

obj <- qcc(diameter[1:40,], type="xbar") #g88

#Let's see what happen if I change the nsigma to 2.
obj <- qcc(diameter[1:30,], type="xbar",nsigmas = 2) #g89


#' The data, from sample published by Donald Wheeler
my.xmr.raw <- c(5045,4350,4350,3975,4290,4430,4485,4285,3980,3925,3645,3760,3300,3685,3463,5200)
#' Create the individuals chart and qcc object
my.xmr.x <- qcc(my.xmr.raw, type = "xbar.one", plot = TRUE,data.name="Water") #g90
my.xmr.x <- qcc(my.xmr.raw, type = "xbar.one", plot = TRUE,title="Individual Chart") #g91
#' Create the moving range chart and qcc object. qcc takes a two-column matrix
#' that is used to calculate the moving range.
my.xmr.raw.r <- matrix(cbind(my.xmr.raw[1:length(my.xmr.raw)-1], my.xmr.raw[2:length(my.xmr.raw)]), ncol=2)
my.xmr.mr <- qcc(my.xmr.raw.r, type="R", plot = TRUE)

mean(my.xmr.raw)
sd(my.xmr.raw)

help(qcc)

#Have an idea on how Individual Chart Sddev is calculated. Checkout the histogram too


#Idea is to use qcc in map +group+ungroup and create objects for i chart and then put them in 
#cow plot for analysis




