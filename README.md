# openwashdata Course Quizzes

This directory contains interactive learnr quizzes for the openwashdata course and a landing page to access them.

**Live Demo**: https://hjj91u-nicolo-massari.shinyapps.io/openwashdata-quiz-hub/

## Structure

- `app.R` - Quiz landing page that links to all deployed quizzes
- `modules/` - Directory containing all quiz files
  - `md-01-quiz.Rmd` - Module 1 quiz on Quarto basics (learnr tutorial)
  - `_github_username.Rmd` - Reusable component for GitHub username input
  - `_submission.Rmd` - Reusable component for quiz submission
  - Additional quiz files can be added as `md-XX-quiz.Rmd`

## Required Packages

Make sure these packages are installed:

```r
install.packages(c("learnr", "tidyverse", "gapminder", "knitr", "rsconnect", "httr", "digest"))

# Install packages from GitHub
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
remotes::install_github("rstudio/gradethis")
remotes::install_github("rundel/learnrhash")
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

## Google Form Integration

The quizzes now include automatic submission to Google Forms for tracking student progress:

### Features
- **GitHub username collection**: Students enter their GitHub username at the start
- **Learnrhash generation**: Quiz responses are encoded using learnrhash
- **Automatic submission**: Results are submitted to Google Form via POST request
- **Error handling**: Provides fallback hash if submission fails
- **Modular components**: Reusable username and submission components

### Google Form Setup
- **Form URL**: https://docs.google.com/forms/d/e/1FAIpQLScnw9R8wMU5SfFqNVXGeEkiIygLTB_Dc6jWBmbwEeHuekBDzg/formResponse
- **Entry IDs** (tidy format): 
  - `entry.1315905314` - Raw learnrhash
  - `entry.61564704` - GitHub username
  - `entry.1169139257` - Module name
- **Data structure**: Each submission creates a row with:
  - Hash column: Complete learnrhash for decoding
  - Username column: GitHub username for filtering
  - Module column: Module identifier (fetched from tutorial ID metadata)
- **Authentication**: None required - form accepts responses from anyone with the link

### Advantages of Google Forms
- **No authentication needed**: Forms can accept anonymous submissions
- **Tidy data format**: Each field in its own column for easy analysis
- **Reliable**: Google handles all the backend infrastructure
- **Easy to view**: Responses automatically appear in Google Sheets
- **Error-resistant**: Works even with network issues
- **Easy filtering**: Separate columns for username and module

## Deployment Process

### Automated Deployment (CI/CD)

Quizzes are automatically deployed to shinyapps.io via GitHub Actions when changes are pushed to the `main` or `dev` branches.

#### Setting Up Automated Deployment

1. **Get shinyapps.io credentials**:
   - Go to [shinyapps.io](https://www.shinyapps.io/) → Account → Tokens
   - Click "Add Token" to generate new credentials
   - Copy the `name`, `token`, and `secret` values

2. **Configure GitHub Secrets**:
   - Go to your GitHub repository → Settings → Secrets and variables → Actions
   - Add these repository secrets:
     - `SHINYAPPS_ACCOUNT`: Your shinyapps.io account name
     - `SHINYAPPS_TOKEN`: The token from shinyapps.io  
     - `SHINYAPPS_SECRET`: The secret from shinyapps.io

3. **Add new quizzes to automated deployment**:
   - Edit `build.R` and add your new quiz:
   ```r
   # Deploy new quiz module
   rsconnect::deployDoc(
     doc = "modules/md-02-quiz.Rmd",
     appName = "openwashdata-module2-quiz", 
     forceUpdate = TRUE
   )
   ```

#### How the CI/CD Workflow Works

The GitHub Action (`.github/workflows/deploy-quiz.yml`):
- **Triggers**: On pushes to `main`/`dev` branches or manual workflow dispatch
- **Environment**: Sets up R 4.3.2 with required packages from DESCRIPTION
- **Authentication**: Uses repository secrets to authenticate with shinyapps.io
- **Deployment**: Executes `build.R` to deploy all applications defined there
- **Logging**: Uploads deployment logs if any failures occur

### Manual Deployment

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

1. **Create the quiz file** (e.g., `modules/md-02-quiz.Rmd`) using this template:

```r
---
title: "Module 2: Your Title"
output: learnr::tutorial
runtime: shiny_prerendered
description: "Your quiz description"
tutorial:
  id: "module2-your-id"
---

`​``{r setup, include=FALSE}
library(learnr)
library(tidyverse)
library(gradethis)
library(learnrhash)
library(httr)

tutorial_options(
  exercise.eval = FALSE,
  exercise.checker = gradethis::grade_learnr
)

knitr::opts_chunk$set(echo = FALSE)

# Google Form setup
form_url <- "https://docs.google.com/forms/d/e/1FAIpQLScnw9R8wMU5SfFqNVXGeEkiIygLTB_Dc6jWBmbwEeHuekBDzg/formResponse"
`​``

## Introduction

Your introduction text here.

`​``{r github-username, child='_github_username.Rmd'}
`​``

## Your Quiz Content

Add your questions and exercises here...

`​``{r submission-section, child='_submission.Rmd'}
`​``

## Summary

Your summary here.
```
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