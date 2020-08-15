setwd("C:/Users/DELL PC/Desktop/Practice Projects R/Predicting Emp Attrition R Project Kindle Book")

library(readr)
library(dplyr)
library(caret)

mydata <- read_csv("Raw_data_Emp_Att.csv")

names(getModelInfo())

mydata <- mydata %>% select(-EmployeeNumber,-EmployeeCount,-Over18, -StandardHours)

# setting up crossvalidation
crossvalidation <- trainControl(method="cv",number=10)


set.seed(1201)

tuneGrid <- expand.grid(mtry=c(5,7,10))

model_rf <- train(Attrition~.,data=mydata,trControl=crossvalidation,method="rf",tuneGrid=tuneGrid)

saveRDS(model_rf,"rf_model.rds")
