# Single-cell Analysis

This pipeline implements an unsupervised learning for discovering groups of similar examples within the data. 

Single-cell data are used with genes' expression profiles in each cell.

First of all, dimensionality reduction is applied in the dataset with 5 diffent ways:

1. Factor Analysis
2. PCA
3. SVD
4. t-distributed stochastic neighbor embedding (tsne)
5. UMAP

Then clustering of the dimensionality reduced data are implemented with 2 different ways:

1. Gaussian Mixture Model
2. K-means
