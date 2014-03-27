#######################################################################################################
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
