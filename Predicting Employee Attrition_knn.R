# Averaging, majority vote, weighted average, 
# consolidated learning
# multiple model + multiple subset of data
# snergy


setwd("C:\\Users\\DELL PC\\Desktop\\Practice Projects R\\Predicting Emp Attrition R Project Kindle Book")

library(rsample)
data("attrition")
library(dplyr)
library(ggplot2)



str(attrition)

mydata <- attrition

table(mydata$Attrition)

# Out of 1470 observations in the dataset, we have 1233 samples that are non attrition and 237 attrition cases.
# Clearly we are dealing with class imbalance dataset.

# considering only the numeric variables in dataset.
numeric_mydata <- select_if(mydata,is.numeric)

# converting the target variable "yes" or "no" values into numeric
# it defaults to 1 and 2 however converting it into 0 and 1 to be consistent

numeric_attrition <- as.numeric(mydata$Attrition)-1 

# Creating a new dataframe with numeric columns and numeric target
numeric_mydata <- cbind(numeric_mydata,numeric_attrition)


# loading the corrplot library for conducting the correlation analysis
library(corrplot)
# Creating the correlation plot
M <- cor(numeric_mydata)
corrplot(M,method = "circle")


# High correlation between the independent variables indicates the existance of redundant features
# This is called multicolliearlity
# If we were to fit a regression model, then 
# 1. removing the redundant features
# 2. apply PCA or 
# 3. partial least square regression 

# A. Overtime Vs Attrition:
l <- ggplot(mydata, aes(OverTime,fill=Attrition))
l <- l + geom_histogram(stat="count")

# Finding out what proportion of people working overtime get attrited, mean is applied on as.numeric(mydata$Attrition)-1
tapply(as.numeric(mydata$Attrition)-1, mydata$OverTime, mean)

print(l)

# B. MaritalStatus Vs Attrition:
l1 <- ggplot(mydata, aes(MaritalStatus,fill=Attrition))
l1 <- l1 + geom_histogram(stat="count")

# Finding out what proportion of MaritalStatus get attrited, mean is applied on as.numeric(mydata$Attrition)-1
tapply(as.numeric(mydata$Attrition)-1, mydata$MaritalStatus, mean)

print(l1)


# JobRole Vs Attrition:
l2 <- ggplot(mydata, aes(JobRole,fill=Attrition))
l2 <- l2 + geom_histogram(stat="count")

# Finding out what proportion of MaritalStatus get attrited, mean is applied on as.numeric(mydata$Attrition)-1
tapply(as.numeric(mydata$Attrition)-1, mydata$JobRole, mean)

print(l2)


# Gender Vs Attrition:
l3 <- ggplot(mydata, aes(Gender,fill=Attrition))
l3 <- l3 + geom_histogram(stat="count")

# Finding out what proportion of MaritalStatus get attrited, mean is applied on as.numeric(mydata$Attrition)-1
tapply(as.numeric(mydata$Attrition)-1, mydata$Gender, mean)

print(l3)


# EducationField Vs Attrition:
l4 <- ggplot(mydata, aes(EducationField,fill=Attrition))
l4 <- l4 + geom_histogram(stat="count")

# Finding out what proportion of MaritalStatus get attrited, mean is applied on as.numeric(mydata$Attrition)-1
tapply(as.numeric(mydata$Attrition)-1, mydata$EducationField, mean)

print(l4)


# Department Vs Attrition:
l5 <- ggplot(mydata, aes(Department,fill=Attrition))
l5 <- l5 + geom_histogram(stat="count")

# Finding out what proportion of MaritalStatus get attrited, mean is applied on as.numeric(mydata$Attrition)-1
tapply(as.numeric(mydata$Attrition)-1, mydata$Department, mean)

print(l5)


# BusinessTravel Vs Attrition:
l6 <- ggplot(mydata, aes(BusinessTravel,fill=Attrition))
l6 <- l6 + geom_histogram(stat="count")


library(patchwork)
(l1+l2+l3)/(l4+l5+l6)


# Finding out what proportion of MaritalStatus get attrited, mean is applied on as.numeric(mydata$Attrition)-1
tapply(as.numeric(mydata$Attrition)-1, mydata$BusinessTravel, mean)

print(l6)


# jitter plot:
ggplot(mydata, aes(OverTime, Age))+
  facet_grid(.~MaritalStatus)+geom_jitter(aes(color=Attrition),alpha=0.5)+
  ggtitle("x=OverTime, y=Age, z=MaritalStatus")+
  theme_light()



# For imbalance datasets, Kappa or precision & recall or AUC of ROC are the appropriate metrics to use

library(caret)

# Removing the non-discriminatory features (as identified during EDA) from the dataset
library(readr)
mydata <- read_csv("Raw_data_Emp_Att.csv")

mydata <- mydata %>% select(-EmployeeNumber,-Over18,-EmployeeCount,-StandardHours)


# Setting the seed prior to model building to ensures reproducibility of the results obtained
set.seed(1000)

# Setting the train control parameters specifying gold standard 10 fold cross validation repeated 10 times
fitControl <- trainControl(method = "repeatedcv",number = 10,repeats = 10)

#knn model
# We pass the train control parameters and specify that knn algorithm need to be used to build the model
# we specify 20 as parameter which means the train command will search through 20 different random k values
# and finally retain the model that produces  the best performance measurement.

knn_model <- train(Attrition~., data=mydata, trControl=fitControl, method="knn", tuneLength=20)

predicted_values <- predict(knn_model,mydata)

confusionMatrix(as.factor(mydata$Attrition),predicted_values)

# save the model to the disk
saveRDS(knn_model,"knn_model.rds")


# load the model
loaded_knn <- readRDS("knn_model.rds")

final_prediction <- predict(loaded_knn,mydata)

confusionMatrix(as.factor(mydata$Attrition),final_prediction)
