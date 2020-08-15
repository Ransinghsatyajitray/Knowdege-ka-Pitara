# Process: trainControl > algorithm list > set.seed > caretList to check accuracy of different models > modelCor > caretStack for different methods


setwd("C:\\Users\\DELL PC\\Desktop\\Practice Projects R\\Predicting Emp Attrition R Project Kindle Book")

library(readr)
library(dplyr)
library(caret)
library(caretEnsemble)


mydata <- read_csv("Raw_data_Emp_Att.csv")

mydata <- mydata %>% select(-EmployeeNumber,-EmployeeCount,-Over18, -StandardHours)

# In stacking we build multiple models with various ML Algorithms. Each algorithm possesses a unique
# way of learning the characteristics of data and final stacked model indirectly incorporates all the 
# unique ways of learning. Stacking gets the combined power of several ML Algorithms through getting
# the final prediction by means of voting or averaging as we do in other types of ensembles.


control<-trainControl(method="repeatedcv",number=10, repeats = 10,savePredictions = TRUE,classProbs = TRUE)

#Declaring the ML Algorithm to use in stacking:
algorithmList<- c("C5.0","knn","svmRadial")

#Setting the seed to ensure reproducibility of results,
set.seed(1000)

#Creating Stacking Model,
models <- caretList(Attrition~., data=mydata, trControl=control, methodList=algorithmList)


# Obtaining the stacking model result and printing them
results <- resamples(models)
summary(results)

# Identifying the correlation between the results
modelCor(results)


# We can see from the correlation table results that none of the individual ML algorithms
# predictions are highly correlated. Very high correlated result means that the algorithms
# have produced very similar predictions. Combining the very similar prediction may not 
# really yield significant benefit compared with what one would avail from accepting the 
# individual prediction.


# Setting up the cross validation control parameters for stacking the predictions from individual ML algorithms

stackControl <- trainControl(method="cv", number=10, savePredictions = TRUE, classProbs=TRUE)

# Stacking the predictions of individual ML algorithms using generalized linear model
stack.glm <- caretStack(models,method="glm",trControl=stackControl)

# printing the stacked final results
print(stack.glm)

# Stacking the predictions of individual ML algorithms using random Forest
stack.rf <- caretStack(models,method="rf",trControl=stackControl)

# Printing the summary of rf based on stacking 
print(stack.rf)

# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxx OUTPUT xxxxxxxxxxxxxxxxxxxxxxxxx

# > setwd("C:\\Users\\DELL PC\\Desktop\\Practice Projects R\Predicting Emp Attrition R Project Kindle Book")
# Error: '\P' is an unrecognized escape in character string starting ""C:\\Users\\DELL PC\\Desktop\\Practice Projects R\P"
# > setwd("C:\\Users\\DELL PC\\Desktop\\Practice Projects R\\Predicting Emp Attrition R Project Kindle Book")
# > mydata <- mydata %>% select(-EmployeeNumber,-EmployeeCount,-Over18, -StandardHours)
# Error in mydata %>% select(-EmployeeNumber, -EmployeeCount, -Over18, -StandardHours) : 
#   could not find function "%>%"
# > library(readr)
# Warning message:
# package 'readr' was built under R version 3.5.3 
# > library(dplyr)
# 
# Attaching package: 'dplyr'
# 
# The following objects are masked from 'package:stats':
# 
#     filter, lag
# 
# The following objects are masked from 'package:base':
# 
#     intersect, setdiff, setequal, union
# 
# > library(caret)
# Loading required package: lattice
# Loading required package: ggplot2
# Warning messages:
# 1: package 'caret' was built under R version 3.5.3 
# 2: package 'ggplot2' was built under R version 3.5.3 
# > mydata <- read_csv("Raw_data_Emp_Att.csv")
# Parsed with column specification:
# cols(
#   .default = col_double(),
#   Attrition = col_character(),
#   BusinessTravel = col_character(),
#   Department = col_character(),
#   EducationField = col_character(),
#   Gender = col_character(),
#   JobRole = col_character(),
#   MaritalStatus = col_character(),
#   Over18 = col_character(),
#   OverTime = col_character()
# )
# See spec(...) for full column specifications.
# > mydata <- mydata %>% select(-EmployeeNumber,-EmployeeCount,-Over18, -StandardHours)
# > install.packages("caretEnsemble")
# Installing package into 'C:/Users/DELL PC/Documents/R/win-library/3.5'
# (as 'lib' is unspecified)
# also installing the dependency 'pbapply'
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/3.5/pbapply_1.4-2.zip'
# Content type 'application/zip' length 69488 bytes (67 KB)
# downloaded 67 KB
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/3.5/caretEnsemble_2.0.1.zip'
# Content type 'application/zip' length 1738358 bytes (1.7 MB)
# downloaded 1.7 MB
# 
# package 'pbapply' successfully unpacked and MD5 sums checked
# package 'caretEnsemble' successfully unpacked and MD5 sums checked
# 
# The downloaded binary packages are in
# 	C:\Users\DELL PC\AppData\Local\Temp\RtmpgxNBNl\downloaded_packages
# > control<-trainControl(method="repeatedcv",number=10, repeats = 10)
# > #Declaring the ML Algorithm to use in stacking:
# > algorithmList <- c("C5.0","nb","glm","knn","svmRadial")
# > #Setting the seed to ensure reproducibility of results,
# > set.seed(1000)
# > mydata <- read_csv("Raw_data_Emp_Att.csv")
# Parsed with column specification:
# cols(
#   .default = col_double(),
#   Attrition = col_character(),
#   BusinessTravel = col_character(),
#   Department = col_character(),
#   EducationField = col_character(),
#   Gender = col_character(),
#   JobRole = col_character(),
#   MaritalStatus = col_character(),
#   Over18 = col_character(),
#   OverTime = col_character()
# )
# See spec(...) for full column specifications.
# > #Setting the seed to ensure reproducibility of results,
# > set.seed(1000)
# > #Creating Stacking Model,
# > models <- caretList(Attrition~.,data=mydata,trControl=control, methodList=algorithmList)
# Error in caretList(Attrition ~ ., data = mydata, trControl = control,  : 
#   could not find function "caretList"
# > library(caretEnsemble)
# 
# Attaching package: 'caretEnsemble'
# 
# The following object is masked from 'package:ggplot2':
# 
#     autoplot
# 
# Warning message:
# package 'caretEnsemble' was built under R version 3.5.3 
# > #Creating Stacking Model,
# > models <- caretList(Attrition~.,data=mydata,trControl=control, methodList=algorithmList)
# Error in `contrasts<-`(`*tmp*`, value = contr.funs[1 + isOF[nn]]) : 
#   contrasts can be applied only to factors with 2 or more levels
# In addition: Warning messages:
# 1: In trControlCheck(x = trControl, y = target) :
#   trControl$savePredictions not 'all' or 'final'.  Setting to 'final' so we can ensemble the models.
# 2: In trControlCheck(x = trControl, y = target) :
#   indexes not defined in trControl.  Attempting to set them ourselves, so each model in the ensemble will have the same resampling indexes.
# > # Obtaining the stacking model result and printing them
# > results <- resamples(models)
# Error in resamples(models) : object 'models' not found
# > View(mydata)
# > #Creating Stacking Model,
# > models <- caretList(Attrition~.,data=mydata,trControl=control, methodList=algorithmList)
# Error in `contrasts<-`(`*tmp*`, value = contr.funs[1 + isOF[nn]]) : 
#   contrasts can be applied only to factors with 2 or more levels
# In addition: Warning messages:
# 1: In trControlCheck(x = trControl, y = target) :
#   trControl$savePredictions not 'all' or 'final'.  Setting to 'final' so we can ensemble the models.
# 2: In trControlCheck(x = trControl, y = target) :
#   indexes not defined in trControl.  Attempting to set them ourselves, so each model in the ensemble will have the same resampling indexes.
# > #Creating Stacking Model,
# > models <- caretList(Attrition~., data=mydata, trControl=control, methodList=algorithmList)
# Error in `contrasts<-`(`*tmp*`, value = contr.funs[1 + isOF[nn]]) : 
#   contrasts can be applied only to factors with 2 or more levels
# In addition: Warning messages:
# 1: In trControlCheck(x = trControl, y = target) :
#   trControl$savePredictions not 'all' or 'final'.  Setting to 'final' so we can ensemble the models.
# 2: In trControlCheck(x = trControl, y = target) :
#   indexes not defined in trControl.  Attempting to set them ourselves, so each model in the ensemble will have the same resampling indexes.
# > control<-trainControl(method="repeatedcv",number=10, repeats = 10,savePredictions = TRUE,classProbs = TRUE)
# > #Creating Stacking Model,
# > models <- caretList(Attrition~., data=mydata, trControl=control, methodList=algorithmList)
# Error in `contrasts<-`(`*tmp*`, value = contr.funs[1 + isOF[nn]]) : 
#   contrasts can be applied only to factors with 2 or more levels
# In addition: Warning messages:
# 1: In trControlCheck(x = trControl, y = target) :
#   x$savePredictions == TRUE is depreciated. Setting to 'final' instead.
# 2: In trControlCheck(x = trControl, y = target) :
#   indexes not defined in trControl.  Attempting to set them ourselves, so each model in the ensemble will have the same resampling indexes.
# > #Declaring the ML Algorithm to use in stacking:
# > algorithmList<- c("C5.0","nb","glm","knn","svmRadial")
# > #Creating Stacking Model,
# > models <- caretList(Attrition~., data=mydata, trControl=control, methodList=algorithmList)
# Error in `contrasts<-`(`*tmp*`, value = contr.funs[1 + isOF[nn]]) : 
#   contrasts can be applied only to factors with 2 or more levels
# In addition: Warning messages:
# 1: In trControlCheck(x = trControl, y = target) :
#   x$savePredictions == TRUE is depreciated. Setting to 'final' instead.
# 2: In trControlCheck(x = trControl, y = target) :
#   indexes not defined in trControl.  Attempting to set them ourselves, so each model in the ensemble will have the same resampling indexes.
# > mydata <- mydata %>% select(-EmployeeNumber,-EmployeeCount,-Over18, -StandardHours)
# > #Creating Stacking Model,
# > models <- caretList(Attrition~., data=mydata, trControl=control, methodList=algorithmList)
# Error in { : 
#   task 1 failed - "Not all variable names used in object found in newdata"
# In addition: There were 50 or more warnings (use warnings() to see the first 50)
# > View(mydata)
# > names(mydata)
#  [1] "Age"                      "Attrition"                "BusinessTravel"          
#  [4] "DailyRate"                "Department"               "DistanceFromHome"        
#  [7] "Education"                "EducationField"           "EnvironmentSatisfaction" 
# [10] "Gender"                   "HourlyRate"               "JobInvolvement"          
# [13] "JobLevel"                 "JobRole"                  "JobSatisfaction"         
# [16] "MaritalStatus"            "MonthlyIncome"            "MonthlyRate"             
# [19] "NumCompaniesWorked"       "OverTime"                 "PercentSalaryHike"       
# [22] "PerformanceRating"        "RelationshipSatisfaction" "StockOptionLevel"        
# [25] "TotalWorkingYears"        "TrainingTimesLastYear"    "WorkLifeBalance"         
# [28] "YearsAtCompany"           "YearsInCurrentRole"       "YearsSinceLastPromotion" 
# [31] "YearsWithCurrManager"    
# > #Creating Stacking Model,
# > models <- caretList(Attrition~., data=mydata, trControl=control, methodList=algorithmList)
# 
# Warning messages:
# 1: In trControlCheck(x = trControl, y = target) :
#   x$savePredictions == TRUE is depreciated. Setting to 'final' instead.
# 2: In trControlCheck(x = trControl, y = target) :
#   indexes not defined in trControl.  Attempting to set them ourselves, so each model in the ensemble will have the same resampling indexes.
# > #Declaring the ML Algorithm to use in stacking:
# > algorithmList<- c("C5.0","knn","svmRadial")
# > #Creating Stacking Model,
# > models <- caretList(Attrition~., data=mydata, trControl=control, methodList=algorithmList)
# There were 30 warnings (use warnings() to see them)
# > # Obtaining the stacking model result and printing them
# > results <- resamples(models)
# > summary(results)
# 
# Call:
# summary.resamples(object = results)
# 
# Models: C5.0, knn, svmRadial 
# Number of resamples: 100 
# 
# Accuracy 
#                Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
# C5.0      0.8013699 0.8549611 0.8639456 0.8651628 0.8835616 0.9256757    0
# knn       0.7972973 0.8299320 0.8367347 0.8370902 0.8435374 0.8698630    0
# svmRadial 0.8424658 0.8581081 0.8775510 0.8773423 0.8911565 0.9251701    0
# 
# Kappa 
#                  Min.    1st Qu.     Median      Mean   3rd Qu.      Max. NA's
# C5.0       0.07278020 0.31008554 0.37402609 0.3801010 0.4566182 0.6900228    0
# knn       -0.04892966 0.03939894 0.05637734 0.0764370 0.1160784 0.2618414    0
# svmRadial  0.19900498 0.36394481 0.43939394 0.4413922 0.5213675 0.6896949    0
# 
# > # Identifying the correlation between the results
# > modelCor(results)
#                  C5.0         knn  svmRadial
# C5.0       1.00000000 -0.05749405  0.4288936
# knn       -0.05749405  1.00000000 -0.0805878
# svmRadial  0.42889357 -0.08058780  1.0000000
# > stackControl <- trainControl(method="repeatedCV",number=10,repeats=10,savePredictions = TRUE, classProbs=TRUE)
# Warning message:
# `repeats` has no meaning for this resampling method. 
# > stackControl <- trainControl(method="repeatedCV", number=10, repeats=10,savePredictions = TRUE, classProbs=TRUE)
# Warning message:
# `repeats` has no meaning for this resampling method. 
# > stackControl <- trainControl(method="cv", number=10, savePredictions = TRUE, classProbs=TRUE)
# > # Stacking the predictions of individual ML algorithms using generalized linear model
# > stack.glm <- caretStack(models,method="glm",trControl=stackControl)
# > # printing the stacked final results
# > print(stack.glm)
# A glm ensemble of 3 base models: C5.0, knn, svmRadial
# 
# Ensemble results:
# Generalized Linear Model 
# 
# 14700 samples
#     3 predictor
#     2 classes: 'No', 'Yes' 
# 
# No pre-processing
# Resampling: Cross-Validated (10 fold) 
# Summary of sample sizes: 13230, 13230, 13230, 13230, 13230, 13230, ... 
# Resampling results:
# 
#   Accuracy   Kappa    
#   0.8784354  0.4493652
# 
# > # Stacking the predictions of individual ML algorithms using random Forest
# > stack.rf <- caretStack(models,method="rf",trControl=stackControl)
# note: only 2 unique complexity parameters in default grid. Truncating the grid to 2 .
# 
# > # Printing the summary of rf based on stacking 
# > print(stack.rf)
# A rf ensemble of 3 base models: C5.0, knn, svmRadial
# 
# Ensemble results:
# Random Forest 
# 
# 14700 samples
#     3 predictor
#     2 classes: 'No', 'Yes' 
# 
# No pre-processing
# Resampling: Cross-Validated (10 fold) 
# Summary of sample sizes: 13230, 13230, 13230, 13230, 13230, 13230, ... 
# Resampling results across tuning parameters:
# 
#   mtry  Accuracy   Kappa    
#   2     0.8748980  0.4646706
#   3     0.8712245  0.4505075
# 
# Accuracy was used to select the optimal model using the largest value.
# The final value used for the model was mtry = 2.
# > 