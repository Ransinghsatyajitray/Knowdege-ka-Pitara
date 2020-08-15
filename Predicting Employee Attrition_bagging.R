# Bagging involves creating multiple different models from a single dataset. It is important to understand 
# an important statistical technique called bootstrapping in order to get an understnading of bagging

# Bootsraping involves multiple random subsets of a dataet being created. It is possible that the same data 
# sample gets picked up in multiple subsets and this is termed as bootstap with replacement

# In bagging the actual training dataset is split into multiple bags through sampling with replacement
# asssuming thate we ended up with n bags when an ML algorithm is applied on each of these bags, we obtain 
# we n different models. Each model is focused on one bag. When it comes to making predictions on new 
# unseen data, each of these n models makes  independent predictions on the data. A final prediction 
# is arrived at by combining the predictions of the observations of all the n models.

#Classification -> voting
#Regression -> average

# Bagging is very effective to handle  the high sensitivity to data changes.

# caret library provides a framework to implement bagging with any stand alone ML algorithm.
# ldaBag, plsBag, nbBag, treeBag, 
setwd("C:/Users/DELL PC/Desktop/Practice Projects R/Predicting Emp Attrition R Project Kindle Book")

library(readr)
library(dplyr)

mydata <- read_csv("Raw_data_Emp_Att.csv")

mydata <- mydata %>% select(-EmployeeNumber,-EmployeeCount,-Over18, -StandardHours)

# setting up crossvalidation
crossvalidation <- trainControl(method="repeatedcv",number=10,repeats = 10)

set.seed(1200)
# bagging model
model.bagg <- train(Attrition~.,data=mydata,method="treebag",B=10,trControl=crossvalidation,importance=TRUE)

# prediction:
prediction <- predict(model.bagg,mydata)

# ConfusionMatrix:
confusionMatrix(as.factor(mydata$Attrition),prediction)


# saving the model
saveRDS(model.bagg,"treebagg.rds")

# loading the model
treebag <- readRDS("treebagg.rds")


# the accuracy got from the printing model directly is that of model developed on training data
# confusionMatrix accuracy is that model predicted value to the test values

# model accuracy is calculated on training data, but overfitting and underfitting is checked using the 
# test data

