# For PCA, following packages are used, FactoMineR, ade4, stats, cs, MASS and ExPosition
# FactoMineR > Performs PCA, MCA(Multiple Correspondence Analysis), FAMD(Factor Analysis of Mixed Data), MFA(Multiple Factor Analysis), HCPC (Hierarchical Clustering on Principal Components)
#           > Provides the coordinates, the quality of representation and contribution of individual observation and varibles.
#          > Predicts the result for supplimentary individual and variables.
# factoextra > produces ggplot2 based elegant data
#           > simplifies cluster analysis and  visualization



# Load FactoMineR----
library(FactoMineR)
library(factoextra)


# function of factorextra:----
# 1. Visualize PC method outputs (fviz_*)
# 2. Extracting data from PC method outputs (get_*)



# The amount of Variance retained by each principal components is measured by eigen value.
# PCA Method is useful when the variables within the dataset are highly correlated.
# Correlation represent the redundancy in the data. Due to this redundancy, PCA can be used to reduce 
# the original variables into a smaller number of new variables explaining most of the variance in the 
# original variables.

# The Main Purpose of PCA----
# 1. Identify hidden pattern in the data
# 2. Reduce the dimentionlaity and noise in the data
# 3. Identify the correlated variables.

data("decathlon2")

# Note that only some of these individuals and the variables will be used to perform the principal 
# component analysis. The coordinates of the remaining individuals and the variables and variables on 
# the factor map will be predicted after the PCA.

# Active Individual and Supplimentary Individual

decathlon2.active <- decathlon2[1:23,1:10]


# Data Standardization:----
# In the principal component analysis, variables are often scaled (standardized). This is particularly 
# recommended when variables are measured in different scales otherwise the PCA outputs obtained will be 
# severely affected.

# The PCA function in FactoMineR standardizes the data automatically during the PCA.

res.pca <- PCA(decathlon2.active,graph=TRUE)  #ncp argument in it helps in determining the number of dimentions kept in final results.

print(res.pca)

# **Results for the Principal Component Analysis (PCA)**
#   The analysis was performed on 23 individuals, described by 10 variables
# *The results are available in the following objects:
#   
#   name               description                          
# 1  "$eig"             "eigenvalues"                        
# 2  "$var"             "results for the variables"          
# 3  "$var$coord"       "coord. for the variables"           
# 4  "$var$cor"         "correlations variables - dimensions"
# 5  "$var$cos2"        "cos2 for the variables"             
# 6  "$var$contrib"     "contributions of the variables"     
# 7  "$ind"             "results for the individuals"        
# 8  "$ind$coord"       "coord. for the individuals"         
# 9  "$ind$cos2"        "cos2 for the individuals"           
# 10 "$ind$contrib"     "contributions of the individuals"   
# 11 "$call"            "summary statistics"                 
# 12 "$call$centre"     "mean of the variables"              
# 13 "$call$ecart.type" "standard error of the variables"    
# 14 "$call$row.w"      "weights for the individuals"        
# 15 "$call$col.w"      "weights for the variables"          



res.pca$ind$coord

# Visualization:----
eig.val <- get_eigenvalue(res.pca)
eig.val

# Eigenvalues can be used to determine the number of principal components to retain after PCA.
# eigen value>1 indicates that the PCs account for more variance than accounted by one of the original 
# variable in the standardized  data. This is commonly used as a cutoff point for which PCs are retained.

# Unfortunately there is no well accepted objective way to decide how many principal components are enough.
# This will depend on the specific field of application and the specific data set.


# Scree Plot: to find contribution of each eigen vector to the variance explained in model
fviz_eig(res.pca,addlabels = TRUE,ylim=c(0,50))


# This function provides a list of matrices containing all the results for the active variables 
var <- get_pca_var(res.pca)   # This can also be got using PCA result and $ in it

var$coord # coefficient of the coordinates
var$cor  # same as coord
var$contrib # % contribution of variables to the principal components



# Correlation Circle: correlation between the variables and the PCs----
fviz_pca_var(res.pca,col.var = "black")

# Positively correlated are in same quandrant
# Negatively are in opposite quadrant

# The correlation between the variables and the principal component can be found by the following machanism
# using the Cos2 component of var
library(corrplot)
corrplot(var$cos2,is.corr=FALSE)



# A high cos2(correlation of variable with PCs) indicate a good representation quality of the variable on principal components.
# The closer the vraiable is to the circle of correlations, the better the representation and
# variables that are closes to center of plot are less important for first component
# cos2 is square cosine

# color by cos2 values: quality on the factor map
fviz_pca_var(res.pca,col.var = "cos2",gradient.cols=c("#00AFBB","#E7B800","#FC4E07"),
             repel = TRUE # Avoid text overlapping
             )


# Variables that are correlated with PC1 and PC2 are the msot important in explaining the variablity 
# in the dataset
# Vraibles that donot correlated with any PC might be removed to simplify overall analysis.



# Contribution of variables to PC1:
fviz_contrib(res.pca,choice="var",axes=1,top=10) #PC1
fviz_contrib(res.pca,choice="var",axes=2,top=10) #PC2
fviz_contrib(res.pca,choice="var",axes=1:2,top=10) #Total contribution to PC1 and PC2

# The total contribution for a given variable is calculated by, 
# contrib= [(C1*Eig1)+(C2*Eig2)/(Eig1+Eig2)]
# Eig1, Eig2: eigen values are amount of variation retained by each PC.
# C1,C2: contribution of variables on PC1 and PC2




# It is also possible to change the color of the variables by group defined by variables
# factor grouping

# Process for showing the PC plot by coloring the variable grouping
# for grouping variables we use kmeans clustering

# Create a grouping variables using the kmeans
# Create 3 groups of variables (centers=3)

set.seed(123)
res.km <- kmeans(var$coord,centers=3,nstart=25)
grp <- as.factor(res.km$cluster)

#Color variables by group
fviz_pca_var(res.pca,col.var= grp, palette= c("#0073C2FF","#EFC000FF","#868686FF"),legend.title="Cluster")


# Dimention Description:
res.desc <- dimdesc(res.pca,axes=c(1,2),proba = 0.05)

# Desciption of dimention 1
res.desc$Dim.1

# Desciption of dimention 2
res.desc$Dim.2


# fviz_pca_var(res.pca,col.var= grp, palette= c("#0073C2FF","#EFC000FF","#868686FF"),legend.title="Cluster")
# this represent the variables but we can also see individual observations too


# We are establishing how closely each observation (row) is related to the principal components
fviz_pca_ind(res.pca,col.ind="cos2",gradient.cols=c("#00AFBB","#E7B800","#FC4E07"),repel = TRUE)

# Contribution of individual observation to PC1 and PC2.
fviz_contrib(res.pca,choice="ind",axes=1:2)


data("iris")

iris.pca <- PCA(iris[,-5],graph = FALSE)

fviz_pca_ind(iris.pca,col.ind=iris$Species,palette=c("#00AFBB","#EFB800","#FC4E07"),addEllipses = TRUE,legend.title="Groups")

fviz_pca_ind(iris.pca,geom.ind="point",col.ind=iris$Species,palette=c("#00AFBB","#EFB800","#FC4E07"),addEllipses = TRUE,legend.title="Groups")



# Biplot----
fviz_pca_biplot(res.pca,repel = TRUE,col.var = "#2E9FDF",col.ind = "#696969")



fviz_pca_biplot(iris.pca,
                # Individual
                geom.ind = "point",fill.ind = iris$Species,
                col.ind = "black",pointshape=21,pointsize=2,palette = "jco",addEllipses = TRUE,
                # Variable
                alpha.var="contrib",
                col.var = "contrib",
                gradient.cols = "RdYlBu",
                legend.title=list(fill="Species",color="Contrib",alpha="Contrib"))

