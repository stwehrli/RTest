# Test R and GitHub

library(igraph)
a <- random.graph.game(20, 0.1)
plot(a, layout=layout.fruchterman.reingold, vertex.label=NA)
plot(a, layout=layout.fruchterman.reingold, vertex.label=NA, vertex.color="red")

# Let's add some more comments...
