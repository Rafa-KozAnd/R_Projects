# Criar um vetor de datas
datas <- as.Date("2023-06-01") + 0:29

# Criar um vetor de preços de fechamento da AAPL (exemplo fictício)
precos <- c(150.32, 151.25, 152.18, 153.10, 152.76, 153.55, 153.42, 154.21, 153.90, 153.45,
            152.89, 153.67, 153.82, 154.10, 153.88, 153.45, 153.12, 152.85, 152.60, 153.05,
            153.28, 152.95, 152.62, 153.00, 153.20, 153.45, 154.05, 153.78, 154.20, 154.35)

# Criar um objeto xts (série temporal)
serie_temporal <- xts(precos, order.by = datas)

# Exibir a série temporal
print(serie_temporal)

# Subconjugar dados para o mês de junho de 2023
dados_junho <- serie_temporal["2023-06"]
print(dados_junho)

# Calcular uma média móvel simples de 5 períodos
media_movel <- rollmean(serie_temporal, k = 5, align = "right", fill = NA)
print(media_movel)

# Carregar o pacote ggplot2
library(ggplot2)

# Converter a série temporal em um data frame
dados_plot <- data.frame(Data = index(serie_temporal), Preco = coredata(serie_temporal))

# Plotar o gráfico de séries temporais
ggplot(dados_plot, aes(x = Data, y = Preco)) +
  geom_line() +
  labs(title = "Preços de Fechamento da AAPL",
       x = "Data",
       y = "Preço")
