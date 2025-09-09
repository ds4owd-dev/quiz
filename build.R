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
    forceUpdate = TRUE
  )
}


# QUIZ DEPLOYMENT

rsconnect::deployApp(
  appName = "openwashdata-quiz-hub",
  forceUpdate = TRUE
)

deploy_quiz("md-01-quiz")

# Example of what to add when creating new quiz:

#deploy_quiz("md-02-quiz")
