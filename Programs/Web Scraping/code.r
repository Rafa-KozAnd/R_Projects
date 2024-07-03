# URL da página que queremos fazer scraping (exemplo hipotético)
url <- "https://www.amazon.com.br/best-sellers-books"

# Fazendo o scraping
page <- read_html(url)

# Extrair os títulos dos livros
titulos <- page %>%
  html_nodes("ol") %>%
  html_nodes("li") %>%
  html_text()

# Exibir os títulos
print(titulos)
