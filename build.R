# Load configuration
source("config.R")

# HELPER

deploy_quiz <- function(module_name) {
  module_path <- paste0(file.path("modules", module_name), ".Rmd")
  rsconnect::deployApp(
    appFiles = c(
      "modules/_github_username.Rmd",
      "modules/_submission.Rmd",
      module_path,
      "modules/github_usernames.csv"
    ),
    appPrimaryDoc = module_path,
    appName = module_name,
    appMode = "rmd-shiny",
    forceUpdate = TRUE
  )
}


# QUIZ DEPLOYMENT

rsconnect::deployApp(
  appName = main_app_name,
  forceUpdate = TRUE
)

for (quiz in quiz_names) {
  deploy_quiz(quiz)
}

# To add new quizzes, edit config.R
