install.packages("shiny")
install.packages("shinyWidgets")

library(shiny)
library(shinyWidgets)

# Definir a interface do usuário (UI)
ui <- fluidPage(
  
  # Título do aplicativo
  titlePanel("Jogo de Matemática Educativo"),
  
  # Sidebar layout com perguntas e respostas
  sidebarLayout(
    sidebarPanel(
      # Pergunta de matemática
      uiOutput("pergunta"),
      
      # Entrada para a resposta
      numericInput("resposta", "Resposta:", value = NULL, min = 0, step = 1),
      
      # Botão para enviar a resposta
      actionButton("enviar", "Enviar Resposta"),
      
      # Feedback sobre a resposta
      verbatimTextOutput("feedback")
    ),
    
    # Painel principal (neste exemplo, vazio)
    mainPanel()
  )
)

# Definir o código do servidor (server)
server <- function(input, output, session) {
  
  # Função para gerar uma nova pergunta
  gerar_pergunta <- function() {
    numero1 <- sample(1:10, 1)
    numero2 <- sample(1:10, 1)
    operador <- sample(c("+", "-"), 1)
    
    pergunta <- paste(numero1, operador, numero2, "?", sep = " ")
    resposta_correta <- ifelse(operador == "+", numero1 + numero2, numero1 - numero2)
    
    return(list(pergunta = pergunta, resposta_correta = resposta_correta))
  }
  
  # Inicializar o jogo com a primeira pergunta
  pergunta_atual <- gerar_pergunta()
  output$pergunta <- renderUI({
    pergunta_atual$pergunta
  })
  
  # Reagir ao botão de enviar resposta
  observeEvent(input$enviar, {
    resposta <- input$resposta
    
    if (!is.null(resposta)) {
      if (resposta == pergunta_atual$resposta_correta) {
        output$feedback <- renderText({
          paste("Resposta correta! Parabéns!")
        })
      } else {
        output$feedback <- renderText({
          paste("Resposta incorreta. Tente novamente!")
        })
      }
      
      # Gerar uma nova pergunta após 2 segundos
      invalidateLater(2000, session)
      pergunta_atual <- gerar_pergunta()
      updateNumericInput(session, "resposta", value = NULL)
      updateUI(session, "pergunta", uiOutput("pergunta"))
    }
  })
}

# Rodar o aplicativo Shiny
shinyApp(ui = ui, server = server)
