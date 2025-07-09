# app.R - Quiz Landing Page for openwashdata Course

library(shiny)
library(bslib)

# Define available quizzes with their deployed URLs
quizzes <- list(
  list(
    id = "module1",
    title = "Module 1: Quarto Basics",
    description = "Test your understanding of Quarto basics for openwashdata package documentation",
    url = "https://hjj91u-nicolo-massari.shinyapps.io/openwashdata-module1-quiz/",
    available = TRUE
  )
  # Add more quizzes here as you deploy them
  # list(
  #   id = "module2",
  #   title = "Module 2: Data Visualization",
  #   description = "Learn about creating effective visualizations",
  #   url = "https://hjj91u-nicolo-massari.shinyapps.io/openwashdata-module2-quiz/",
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
                  tags$a(
                    href = quiz$url,
                    target = "_blank",
                    class = "btn btn-primary btn-lg",
                    "Start Quiz"
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
            tags$li("Progress tracking within each quiz"),
            tags$li("Automatic grading with gradethis")
          ),
          
          h3("How to Use"),
          tags$ol(
            tags$li("Select a quiz module from the home page"),
            tags$li("Click 'Start Quiz' to open the interactive tutorial"),
            tags$li("Work through the questions at your own pace"),
            tags$li("Run code in the interactive exercises"),
            tags$li("Use hints if you get stuck"),
            tags$li("Check your solutions for immediate feedback")
          ),
          
          h3("Technical Requirements"),
          p("These quizzes run entirely in your web browser. No R installation is required on your computer - everything runs on our servers."),
          
          h3("Progress Tracking"),
          p("Your progress is automatically saved within each quiz session. However, progress may be lost if you close the browser or if the session times out.")
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  # Simple server - no reactive elements needed for this landing page
}

# Create Shiny app
shinyApp(ui = ui, server = server)