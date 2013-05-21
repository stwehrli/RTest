# Test R and GitHub

library(igraph)
a <- random.graph.game(20, 0.1)
plot(a, layout=layout.fruchterman.reingold, vertex.label=NA)