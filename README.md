# openwashdata Course Quizzes

This directory contains interactive learnr quizzes for the openwashdata course and a landing page to access them.

**Live Demo**: https://hjj91u-nicolo-massari.shinyapps.io/openwashdata-quiz-hub/

## Structure

- `app.R` - Quiz landing page that links to all deployed quizzes
- `modules/` - Directory containing all quiz files
  - `md-01-quiz.Rmd` - Module 1 quiz on Quarto basics (learnr tutorial)
  - Additional quiz files can be added as `md-XX-quiz.Rmd`

## Required Packages

Make sure these packages are installed:

```r
install.packages(c("learnr", "tidyverse", "gapminder", "knitr", "rsconnect"))

# Install gradethis from GitHub
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
remotes::install_github("rstudio/gradethis")
```

## ShinyApps.io Authentication

Before deploying, you need to authenticate with shinyapps.io:

1. **Get your account credentials** from https://www.shinyapps.io/admin/#/tokens
2. **Set up authentication** in R:

```r
rsconnect::setAccountInfo(
  name = 'your-account-name',
  token = 'YOUR-TOKEN-HERE',
  secret = 'YOUR-SECRET-HERE'
)
```

Replace `your-account-name`, `YOUR-TOKEN-HERE`, and `YOUR-SECRET-HERE` with your actual credentials.

## Deployment Process

This quiz system uses a two-part deployment approach:

### 1. Deploy Individual Quizzes

Each quiz is deployed as a separate learnr tutorial using `deployDoc()`:

```r
# Deploy Module 1 quiz
rsconnect::deployDoc(
  doc = "modules/md-01-quiz.Rmd",
  appName = "openwashdata-module1-quiz",
  forceUpdate = TRUE
)
```

For additional quizzes:
```r
# Deploy Module 2 quiz (when created)
rsconnect::deployDoc(
  doc = "modules/md-02-quiz.Rmd",
  appName = "openwashdata-module2-quiz",
  forceUpdate = TRUE
)
```

### 2. Deploy the Landing Page

The landing page is deployed as a regular Shiny app using `deployApp()`:

```r
rsconnect::deployApp(
  appName = "openwashdata-quiz-hub",
  forceUpdate = TRUE
)
```

## Adding New Quizzes

To add a new quiz module:

1. **Create the quiz file** (e.g., `md-02-quiz.Rmd`) following the learnr format
2. **Deploy the quiz**:
   ```r
   rsconnect::deployDoc(
     doc = "md-02-quiz.Rmd",
     appName = "openwashdata-module2-quiz",
     forceUpdate = TRUE
   )
   ```
3. **Update the landing page** by adding the new quiz to the `quizzes` list in `app.R`:
   ```r
   list(
     id = "module2",
     title = "Module 2: Your Title",
     description = "Quiz description",
     url = "https://your-account.shinyapps.io/openwashdata-module2-quiz/",
     available = TRUE
   )
   ```
4. **Redeploy the landing page**:
   ```r
   rsconnect::deployApp(
     appName = "openwashdata-quiz-hub",
     forceUpdate = TRUE
   )
   ```

## Local Testing

### Test Individual Quizzes

```r
# Test a quiz locally
rmarkdown::run("modules/md-01-quiz.Rmd")
```

### Test Landing Page

```r
# Test the landing page locally
shiny::runApp()
```

## Student Access

Students access the system through:
1. **Landing page**: Main hub showing all available quizzes
2. **Individual quizzes**: Full learnr tutorials with interactive exercises, hints, and automatic grading

Each quiz runs independently and provides the complete learnr experience including progress tracking within that session.