# Correspondence Analysis is an extension of Principal Component Analysis suited to explore the relationship among 
# qualitative variables (categorical variables) 

library(FactoMineR)
library(factoextra)

data("housetasks")

# The data for the CA should be in a correspondence table

library(gplots)

# Convert the data as a table:
dt <- as.table(as.matrix(housetasks))

# Ballonplot:
balloonplot(t(dt),main="housetasks",xlab="",ylab="",label=FALSE,show.margins = FALSE)


chisq <- chisq.test(housetasks)

res.ca <- CA(housetasks,graph = FALSE)

eig.val <- get_eigenvalue(res.ca)

fviz_screeplot(res.ca,addlabels=TRUE,ylim=c(0,50))


fviz_ca_biplot(res.ca) # rows in blue and columns in red

