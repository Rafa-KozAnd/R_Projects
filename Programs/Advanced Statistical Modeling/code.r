library(brms)
library(tidyverse)

set.seed(123)  # Para garantir reprodutibilidade

# Número de observações por grupo
n <- 50

# Criar dados simulados
dados <- tibble(
  grupo = rep(c("A", "B", "C"), each = n),
  x = rnorm(3 * n),
  y = 2 + 0.5 * as.numeric(grupo == "B") - 0.3 * as.numeric(grupo == "C") + 0.8 * x + rnorm(3 * n)
)

# Exibir os primeiros registros dos dados
print(head(dados))

# Ajustar o modelo com brms
modelo <- brm(
  formula = y ~ 1 + x + (1 | grupo),
  data = dados,
  cores = 2,  # Número de núcleos de CPU para usar (ajuste conforme sua máquina)
  chains = 4  # Número de cadeias de MCMC
)

# Sumário do modelo
summary(modelo)

# Sumário dos coeficientes
coeficientes <- tidy(modelo)
print(coeficientes)

# Visualização dos efeitos fixos (coeficientes)
plot(coeficientes, type = "estimates")

# Visualização das distribuições posteriores dos parâmetros
plot(modelo)
