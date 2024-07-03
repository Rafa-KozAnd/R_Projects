# Criar uma matriz de adjacência para representar a rede
matriz_adj <- matrix(0, nrow = 5, ncol = 5)
rownames(matriz_adj) <- colnames(matriz_adj) <- c("Alice", "Bob", "Carol", "David", "Eve")

# Definir as conexões (arestas)
matriz_adj["Alice", c("Bob", "Carol")] <- 1
matriz_adj["Bob", c("Alice", "Carol", "David")] <- 1
matriz_adj["Carol", c("Alice", "Bob", "David")] <- 1
matriz_adj["David", c("Bob", "Carol", "Eve")] <- 1
matriz_adj["Eve", "David"] <- 1

# Converter a matriz de adjacência em um objeto de grafo
rede <- graph_from_adjacency_matrix(matriz_adj, mode = "undirected", weighted = NULL)

# Visualizar a rede
plot(rede, vertex.label.dist = 1, vertex.label.color = "black", vertex.size = 30, edge.arrow.size = 0.5)

# Calcular grau de centralidade dos vértices
cent_grau <- degree(rede)

# Exibir o grau de centralidade dos vértices
print(cent_grau)

# Identificar comunidades na rede usando o algoritmo de Louvain
comunidades <- cluster_louvain(rede)

# Exibir as comunidades identificadas
print(comunidades)

# Colorir os vértices de acordo com as comunidades identificadas
cores <- rainbow(max(membership(comunidades)))
plot(rede, vertex.label.dist = 1, vertex.label.color = "black", vertex.size = 30, edge.arrow.size = 0.5, vertex.color = cores[membership(comunidades)])
