setwd("C:/Users/DELL PC/Desktop/Practice Projects R/Predicting Emp Attrition R Project Kindle Book")

library(readr)
library(dplyr)
library(caret)

mydata <- read_csv("Raw_data_Emp_Att.csv")

names(getModelInfo())
set.seed(1202)

mydata <- mydata %>% select(-EmployeeNumber,-EmployeeCount,-Over18, -StandardHours)

# setting up crossvalidation
crossvalidation <- trainControl(method="cv",number=10)

# If the parameters values are not known then its values should be taken as multiple of 10.
# setting the hyper parameters.

# 1. eta is the learning rate (taking care of gradient feature in it) it value should be low like 0.01, 0.1, 0.2, 0.3
# 2. colsample_bytree it has a range of (0,1],it is the subsample ratio of column when constructing each tree
# 3. max_depth is the maximum depth of trees, 
# 4. nrounds=100. it control the maximum number of iterations. it is linked with learning rate
# 5. gamma is the complexity parameter. Gamma values around 20 are extremely high and should be used only when you are using high depth
#      gamma is dependent on the data and the other hyperparameters
# 6. min_child_weight is If the tree partition step results in a leaf node with the sum of 
#       instance weight less than min_child_weight, then the building process will give up 
#       further partitioning. In linear regression task, this simply corresponds to minimum 
#       number of instances needed to be in each node. The larger min_child_weight is, the more 
#       conservative the algorithm will be.



parameters_grid <- expand.grid(eta=0.1, colsample_bytree=c(0.5,0.7), max_depth=c(3,6,8), nrounds=100,
                               gamma=1, min_child_weight=2, subsample=0.5)

model_xgboost <- train(Attrition~., data=mydata, trControl=crossvalidation, method="xgbTree",tuneGrid=parameters_grid)

model_xgboost

prediction <- predict(model_xgboost,mydata)

confusionMatrix(as.factor(mydata$Attrition),prediction)

saveRDS(model_xgboost,"xgboost_model.rds")
