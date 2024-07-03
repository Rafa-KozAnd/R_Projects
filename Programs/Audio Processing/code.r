install.packages("tuneR")

install.packages("ggplot2")

library(tuneR)
library(ggplot2)

# Carregar um arquivo de áudio (substitua "caminho/para/audio.wav" pelo seu caminho de arquivo)
audio <- readWave("caminho/para/audio.wav")

# Exibir informações básicas sobre o arquivo de áudio
print(audio)

# Obter os dados do áudio
dados_audio <- audio@left

# Criar um vetor de tempo correspondente
tempo <- seq(0, duration(audio), length.out = length(dados_audio))

# Criar um gráfico de linha dos dados de áudio
dados_plot <- data.frame(Temporal = tempo, Amplitude = dados_audio)
ggplot(dados_plot, aes(x = Temporal, y = Amplitude)) +
  geom_line() +
  labs(title = "Dados de Áudio",
       x = "Tempo (segundos)",
       y = "Amplitude") +
  theme_minimal()

# Aumentar o volume do áudio
audio_aumentado <- audio * 1.5  # Multiplica os dados de áudio por 1.5 (aumenta o volume)

# Reproduzir o áudio aumentado (opcional)
play(audio_aumentado)

# Salvar o áudio aumentado (substitua "caminho/para/audio_aumentado.wav" pelo seu caminho de destino)
writeWave(audio_aumentado, "caminho/para/audio_aumentado.wav")
