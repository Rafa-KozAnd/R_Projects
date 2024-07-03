library(imager)

# Carregar uma imagem (substitua "caminho/para/imagem.jpg" pelo seu caminho de arquivo)
imagem <- load.image("caminho/para/imagem.jpg")

# Exibir a imagem
plot(imagem)

# Converter a imagem para escala de cinza
imagem_escala_cinza <- grayscale(imagem)

# Exibir a imagem em escala de cinza
plot(imagem_escala_cinza)

# Ajustar o brilho e contraste da imagem
imagem_ajustada <- adjust(imagem, gamma = 1.2, contrast = 1.5)

# Exibir a imagem ajustada
plot(imagem_ajustada)

# Aplicar detecção de bordas na imagem
imagem_bordas <- laplacian(imagem)

# Exibir a imagem com bordas detectadas
plot(imagem_bordas)

# Salvar a imagem processada (substitua "caminho/para/imagem_processada.jpg" pelo seu caminho de destino)
save.image(imagem_ajustada, "caminho/para/imagem_processada.jpg")
