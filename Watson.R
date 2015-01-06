######################################################################################################Tom
# Testing Revolution R Enterprise 7 on Watson
# Watson: 24 x Intel Xeon X5650 / 2.6 GHZ
# wehrlist@ethz.ch

# Run R-Benchmark of Urbanok
source("R-Benchmark.R")

# Test Parallel Infrastructure
# See RevoForeachIterators_Users_Guide
library(doParallel)

# Automatic creation of cluster
detectCores()
registerDoParallel(cores=2)
registerDoParallel(cores=detectCores(all.tests=TRUE))

# Tell me about parallel backend
getDoParWorkers()
getDoParName()
getDoParRegistered()
getDoParVersion()

# Bootstrapping on the iris data set
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 10000
ptime <- system.time({
  r <- foreach(icount(trials), .combine = cbind) %dopar% {
    ind <- sample(100, 100, replace = TRUE)
    result1 <- glm(x[ind, 2] ~ x[ind, 1], family=binomial(logit))
    coefficients(result1)
  }
})[3]
ptime

#######################################################################################################
# RRE Matrix Benchmark
# http://www.revolutionanalytics.com/revolution-revor-enterprise-benchmark-details

# Matrix Multiplication
set.seed (1)
m <- 10000
n <-  5000
A <- matrix (runif (m*n),m,n)
system.time (B <- crossprod(A))

# Cholesky Factorization
system.time (C <- chol(B))

# Singular Value Deomposition
m <- 10000
n <- 2000
A <- matrix (runif (m*n),m,n)
system.time (S <- svd (A,nu=0,nv=0))

# Linear Discriminant Analysis
require(MASS)
g <- 5
k <- round(m/2)
A <- data.frame(A, fac=sample(LETTERS[1:g],m,replace=TRUE))
train <- sample(1:m, k)
system.time (L <- lda(fac ~., data=A, prior=rep(1,g)/g, subset=train))

#######################################################################################################
# Resources
# Compiling R with MKL Support
# http://www.r-bloggers.com/compiling-r-3-0-1-with-mkl-support/

#######################################################################################################


