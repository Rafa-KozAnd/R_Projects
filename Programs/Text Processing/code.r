# Criar documentos fictícios
docs <- c("R é uma linguagem de programação estatística poderosa e versátil.",
          "O processamento de texto em R é útil para análise de dados textuais.",
          "A mineração de texto envolve a extração de informações úteis de grandes conjuntos de documentos.",
          "Tokenização é o processo de dividir um texto em unidades menores, como palavras ou frases.",
          "Nuvens de palavras são uma forma visual interessante de explorar os termos mais frequentes em um texto.")

# Criar um corpus a partir dos documentos
corpus <- Corpus(VectorSource(docs))

# Transformar para minúsculas
corpus <- tm_map(corpus, content_transformer(tolower))

# Remover pontuações
corpus <- tm_map(corpus, removePunctuation)

# Remover stopwords comuns em português
corpus <- tm_map(corpus, removeWords, stopwords("portuguese"))

# Tokenização
corpus <- tm_map(corpus, tokenize)

# Converter o corpus em uma matriz de termo-documento
dtm <- DocumentTermMatrix(corpus)

# Extrair a frequência dos termos
freq_terms <- colSums(as.matrix(dtm))

# Criar a nuvem de palavras
wordcloud(names(freq_terms), freq_terms, min.freq = 2, random.order = FALSE, colors = brewer.pal(8, "Dark2"))
