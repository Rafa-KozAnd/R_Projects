install.packages("ggplot2")
install.packages("readr")

library(shiny)
library(ggplot2)
library(readr)

# Definir a interface do usuário (UI)
ui <- fluidPage(
  
  # Título do aplicativo
  titlePanel("Aplicativo Interativo em R"),
  
  # Sidebar layout com controles
  sidebarLayout(
    sidebarPanel(
      
      # Carregar arquivo CSV
      fileInput("file", "Carregar arquivo CSV",
                accept = c(".csv")),
      
      # Selecionar variáveis para plotagem
      selectInput("xvar", "Selecionar variável para o eixo X:",
                  choices = NULL),
      selectInput("yvar", "Selecionar variável para o eixo Y:",
                  choices = NULL)
    ),
    
    # Painel principal com gráfico
    mainPanel(
      plotOutput("plot")
    )
  )
)

### Passo 3: Definir o Código do Servidor

Agora, vamos definir o código do servidor que lida com a lógica do aplicativo, carregamento de dados e plotagem do gráfico.

```r
# Definir o código do servidor
server <- function(input, output, session) {
  
  # Reagir ao carregar arquivo CSV
  dados <- reactive({
    req(input$file)
    read_csv(input$file$datapath)
  })
  
  # Atualizar as opções de seleção de variáveis
  observe({
    req(dados())
    updateSelectInput(session, "xvar", choices = colnames(dados()))
    updateSelectInput(session, "yvar", choices = colnames(dados()))
  })
  
  # Renderizar o gráfico dinamicamente
  output$plot <- renderPlot({
    req(input$xvar, input$yvar)
    ggplot(dados(), aes_string(x = input$xvar, y = input$yvar)) +
      geom_point() +
      labs(x = input$xvar, y = input$yvar) +
      theme_minimal()
  })
}

### Passo 4: Rodar o Aplicativo Shiny

Agora, podemos rodar o aplicativo Shiny usando a função `shinyApp`.

```r
# Rodar o aplicativo Shiny
shinyApp(ui = ui, server = server)
