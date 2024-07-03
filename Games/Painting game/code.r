install.packages("shiny")
install.packages("ggplot2")

library(shiny)
library(ggplot2)

# Definir a interface do usuário (UI)
ui <- fluidPage(
  
  # Título do aplicativo
  titlePanel("Jogo de Pintura em R"),
  
  # Sidebar layout com paleta de cores e botão de limpar
  sidebarLayout(
    sidebarPanel(
      # Paleta de cores
      selectInput("cor", "Selecionar Cor:",
                  choices = c("red", "blue", "green", "yellow", "black")),
      
      # Botão para limpar a tela
      actionButton("limpar", "Limpar Tela")
    ),
    
    # Painel principal para desenho
    mainPanel(
      plotOutput("desenho", click = "click"),
      verbatimTextOutput("info_click")
    )
  )
)

# Definir o código do servidor (server)
server <- function(input, output, session) {
  
  # Inicializar o plot vazio
  output$desenho <- renderPlot({
    ggplot() +
      geom_blank() +
      xlim(0, 10) + ylim(0, 10) +  # Definir limites do plot
      theme_void()
  })
  
  # Reagir ao clique do mouse para desenhar
  observeEvent(input$click, {
    info <- input$click
    x <- info$x
    y <- info$y
    
    cor <- input$cor
    
    if (!is.null(x) & !is.null(y)) {
      # Atualizar o plot com o ponto pintado na cor selecionada
      gg <- ggplot_build(output$desenho())
      gg$data[[1]] <- rbind(gg$data[[1]], data.frame(x = x, y = y, colour = cor, size = 5))
      
      plot(gg)
    }
  })
  
  # Reagir ao botão de limpar
  observeEvent(input$limpar, {
    output$desenho <- renderPlot({
      ggplot() +
        geom_blank() +
        xlim(0, 10) + ylim(0, 10) +  # Definir limites do plot
        theme_void()
    })
  })
  
  # Informações sobre o clique
  output$info_click <- renderText({
    paste("Coordenadas do último clique:",
          "x =", input$click$x,
          "y =", input$click$y)
  })
}

### Passo 4: Rodar o Aplicativo Shiny

Agora, podemos rodar o aplicativo Shiny usando a função `shinyApp`.

```r
# Rodar o aplicativo Shiny
shinyApp(ui = ui, server = server)

