rsconnect::deployApp(
  appName = "openwashdata-quiz-hub",
  forceUpdate = TRUE
)

rsconnect::deployDoc(
  doc = "modules/md-01-quiz.Rmd",
  appName = "openwashdata-module1-quiz",
  forceUpdate = TRUE
)

# Example of what to add when creating new quiz:

#rsconnect::deployDoc(
#  doc = "modules/md-02-quiz.Rmd",
#  appName = "openwashdata-module2-quiz",
#  forceUpdate = TRUE
#)
