#
#
#  Assignment 2 - Dimitra Paranou
#
# 
library(ggplot2)
# set current working directory
setwd("/home/dparanou/Master/Machine Learning in Computational Biology/Assignment2")
print(getwd())

# read csv files
data = read.csv("Assignment2_Datasets/dataset1.csv")
print(data)

# create dataframe from our data
df = data.frame(names=data[,1], data[,-1])
rownames(df) = df[,1]
df[,1] = NULL
df = t(df)

# normilize the data
df_normalized = scale(df)

#
# Dimensionality reduction
#

# Principal Component Analysis (PCA)

# Adding additional components makes your estimate of the total dataset more accurate, but also more unwieldy

pca = prcomp(df, center = TRUE, scale = TRUE)

summary(pca)

library(ggfortify)

autoplot(pca)
autoplot(pca, data=df)

var_explained = pca$sdev^2/sum(pca$sdev^2)

qplot(c(1:50), var_explained[1:50]) + 
  geom_line() + 
  xlab("Principal Component") + 
  ylab("Variance Explained") +
  ggtitle("Scree Plot") +
  ylim(0, 0.5)

# We notice is that the first 59 components has an Eigenvalue > 1 and explains almost 80% of variance. 
# PCA is a linear algorithm. It will not be able to interpret complex polynomial relationship between features.

plot(pca$x[,1],pca$x[,2], xlab="PC1 (44.3%)", ylab = "PC2 (19%)", main = "PC1 / PC2 - plot")


# t-distributed stochastic neighbor embedding
# non-linear algorithm
# t-SNE is based on probability distributions with random walk on neighborhood graphs to find the structure within the data
library(tsne)

colors = rainbow(ncol(df_normalized))
names(colors) = unique(colnames(df_normalized))
ecb = function(x,y){ plot(x,t='n'); text(x, labels=colnames(df_normalized), col=colors[colnames(df_normalized)]) }
tsne = tsne(df_normalized, epoch_callback = ecb, perplexity=100)

plot(tsne)
text(tsne, labels=colnames(df), col=colors[colnames(df)])


# Uniform Manifold Approximation and Projection (UMAP)
# non-linear algorithm
library(umap)

umap = umap(df)

plot(umap$layout)

# Factor Analysis
# Factor Analysis is a method which works in an Unsupervised Learning setup and forms groups of features by computing the relationship between the features

corrm<- cor(df)

eigen(corrm)$values

require(psych)

FA<-fa(r=corrm, 4, rotate="varimax", fm="ml")  
FA_SORT<-fa.sort(FA)
FA_SORT$loadings