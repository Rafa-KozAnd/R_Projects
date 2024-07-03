library(leaflet)
library(ggplot2)

# Dados de exemplo: coordenadas de algumas cidades
dados <- data.frame(
  Cidade = c("São Paulo", "Rio de Janeiro", "Belo Horizonte", "Brasília", "Salvador"),
  Lat = c(-23.5505, -22.9068, -19.9167, -15.7801, -12.9716),
  Long = c(-46.6333, -43.1729, -43.9333, -47.9292, -38.5014)
)


# Criar o mapa interativo com leaflet
mapa_interativo <- leaflet(dados) %>%
  addTiles() %>%  # Adicionar camada de azulejos padrão
  addMarkers(~Long, ~Lat, popup = ~Cidade)  # Adicionar marcadores com popups

# Exibir o mapa interativo
mapa_interativo

# Carregar um mapa de fundo do Brasil usando ggplot2
mapa_estatico <- ggplot() +
  borders("world", regions = "Brazil", fill = "gray90", color = "gray30") +
  geom_point(data = dados, aes(x = Long, y = Lat), color = "blue", size = 3) +
  geom_text(data = dados, aes(x = Long, y = Lat, label = Cidade), vjust = -0.5, hjust = 0.5, size = 4) +
  labs(title = "Mapa Estático das Cidades",
       subtitle = "Coordenadas das Cidades no Brasil",
       x = "Longitude",
       y = "Latitude") +
  theme_minimal()

# Exibir o mapa estático
print(mapa_estatico)

