# A weak learner is an algorithm that performs relatively poorly generally, the accuracy obtained with
# weak learners is just above chance. It is often if not always observed that the weak learners are computationally
# simple. Decison stumps or 1R algorithms are some example of weak learners. 

# Boosting converts weak learners into strong learners. 

# A boosting model is a sequence of models learned on subset of data similar to that of the bagging ensemble 
# technique. The difference is in creation of subset of data. 

# Unlike bagging all the subsets of data used for model training are not created prior to the start of the training
# Rather boosting builds a first model with an ML algo that does prediction on the entire dataset. Now there 
# are some missclassified instances that are subsets and used by the second model. The second model 
# only learns from this misclassified set of data curated from the first model's output.

# The second model's misclassified instance become input to the third model. The process of building model 
# is repeated until the stopping criteria is met.

# The final prediction for an observation in the unseen datset is arrived by averaging or voting 
# the prediction from all the models. 


# GBM, AdaBoost, XGBoost, LightGBM

setwd("C:/Users/DELL PC/Desktop/Practice Projects R/Predicting Emp Attrition R Project Kindle Book")

library(readr)
library(dplyr)
library(caret)

mydata <- read_csv("Raw_data_Emp_Att.csv")

names(getModelInfo())

mydata <- mydata %>% select(-EmployeeNumber,-EmployeeCount,-Over18, -StandardHours)

# setting up crossvalidation
crossvalidation <- trainControl(method="repeatedcv",number=10,repeats = 10)

set.seed(1201)

# Converting the target variables and other categorical variable to numeric as the gbm model expect 
# all numeric fields in the dataset

library(recipes)

my_data_updated <- recipe(Attrition~., data=mydata) %>% 
  step_dummy(all_nominal()) %>% 
  prep() %>% bake(new_data=mydata)

fit_control <- trainControl(method="cv",number=10)

tuneGrid <- expand.grid(n.trees=c(5,50,500),shrinkage=c(0.01,0.02),interaction.depth=c(1,2,3),n.minobsinnode=c(1,2,3))

model_gbm <- train(Attrition~., data=mydata, method="gbm",distribution="bernoulli",tuneGrid=tuneGrid,trcontrol=fit_control)
