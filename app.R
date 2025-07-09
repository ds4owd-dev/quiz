# app.R - Quiz Landing Page for openwashdata Course

library(shiny)
library(bslib)
library(rmarkdown)

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
  
  nav_panel(
    "Home",
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
          p("These quizzes run entirely in your web browser using WebR technology. No R installation is required on your computer.")
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  
  # Handle quiz launches
  lapply(quizzes, function(quiz) {
    if (quiz$available) {
      observeEvent(input[[paste0("start_", quiz$id)]], {
        # Run the quiz in a new browser window/tab
        # This maintains the landing page while opening the quiz
        browseURL(paste0("http://127.0.0.1:", session$clientData$url_port, "/", quiz$file))
      })
    }
  })
  
}

# Create Shiny app
shinyApp(ui = ui, server = server)