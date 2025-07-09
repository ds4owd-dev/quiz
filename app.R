# app.R - Quiz Landing Page for openwashdata Course

library(shiny)
library(bslib)

# Define available quizzes
quizzes <- list(
  list(
    id = "module1",
    title = "Module 1: Quarto Basics",
    description = "Test your understanding of Quarto basics for openwashdata package documentation",
    file = "md-01-quiz.Rmd",
    available = TRUE
  )
  # Add more quizzes here as you create them
  # list(
  #   id = "module2",
  #   title = "Module 2: Data Visualization",
  #   description = "Learn about creating effective visualizations",
  #   file = "md-02-quiz.Rmd",
  #   available = FALSE
  # )
)

# UI
ui <- page_navbar(
  title = "openwashdata Quizzes",
  theme = bs_theme(bootswatch = "cosmo"),
  id = "navbar",
  
  nav_panel(
    "Home",
    value = "home",
    div(
      class = "container mt-5",
      div(
        class = "text-center mb-5",
        h1("openwashdata Course Quizzes"),
        p(class = "lead", "Interactive tutorials to test your knowledge")
      ),
      
      div(
        class = "row justify-content-center",
        div(
          class = "col-md-8",
          lapply(seq_along(quizzes), function(i) {
            quiz <- quizzes[[i]]
            div(
              class = "card mb-4",
              div(
                class = "card-header d-flex justify-content-between align-items-center",
                h4(class = "mb-0", quiz$title),
                if (!quiz$available) {
                  span(class = "badge bg-secondary", "Coming Soon")
                }
              ),
              div(
                class = "card-body",
                p(quiz$description),
                if (quiz$available) {
                  actionButton(
                    inputId = paste0("start_", quiz$id),
                    label = "Start Quiz",
                    class = "btn btn-primary"
                  )
                } else {
                  span(class = "text-muted", "This quiz is not yet available")
                }
              )
            )
          })
        )
      )
    )
  ),
  
  nav_panel(
    "Quiz",
    value = "quiz",
    div(
      id = "quiz-container",
      class = "container mt-3",
      uiOutput("quiz_content")
    )
  ),
  
  nav_panel(
    "About",
    div(
      class = "container mt-5",
      div(
        class = "row justify-content-center",
        div(
          class = "col-md-8",
          h2("About These Quizzes"),
          p("These interactive quizzes are designed to help you learn and practice concepts from the openwashdata course."),
          
          h3("Features"),
          tags$ul(
            tags$li("Interactive R code exercises"),
            tags$li("Immediate feedback on your answers"),
            tags$li("Hints and solutions available"),
            tags$li("Progress tracking within each quiz")
          ),
          
          h3("How to Use"),
          tags$ol(
            tags$li("Select a quiz module from the home page"),
            tags$li("Work through the questions at your own pace"),
            tags$li("Run code and check your answers"),
            tags$li("Use hints if you get stuck"),
            tags$li("Review solutions after attempting each question")
          ),
          
          h3("Technical Requirements"),
          p("These quizzes require an R installation and the necessary packages installed on the server.")
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  
  # Reactive value to store current quiz
  current_quiz <- reactiveVal(NULL)
  
  # Handle quiz launches
  lapply(quizzes, function(quiz) {
    if (quiz$available) {
      observeEvent(input[[paste0("start_", quiz$id)]], {
        # Store the current quiz
        current_quiz(quiz)
        
        # Switch to quiz panel
        updateNavbarPage(session, "navbar", selected = "quiz")
      })
    }
  })
  
  # Render quiz content
  output$quiz_content <- renderUI({
    quiz <- current_quiz()
    
    if (is.null(quiz)) {
      div(
        class = "text-center mt-5",
        h3("No quiz selected"),
        p("Please return to the home page and select a quiz to begin."),
        actionButton("back_to_home", "Back to Home", class = "btn btn-primary")
      )
    } else {
      div(
        div(
          class = "d-flex justify-content-between align-items-center mb-4",
          h2(quiz$title),
          actionButton("back_to_home2", "Back to Home", class = "btn btn-secondary")
        ),
        div(
          class = "alert alert-info",
          p(strong("Note:"), " This quiz requires launching in a separate window. Click the button below to open the interactive quiz."),
          tags$a(
            href = quiz$file,
            target = "_blank",
            class = "btn btn-primary",
            "Open Quiz in New Tab"
          )
        ),
        hr(),
        p("If the quiz doesn't open automatically, you can access it directly at:"),
        code(quiz$file)
      )
    }
  })
  
  # Handle back to home buttons
  observeEvent(input$back_to_home, {
    updateNavbarPage(session, "navbar", selected = "home")
  })
  
  observeEvent(input$back_to_home2, {
    updateNavbarPage(session, "navbar", selected = "home")
  })
}

# Create Shiny app
shinyApp(ui = ui, server = server)