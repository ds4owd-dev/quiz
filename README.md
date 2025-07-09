# openwashdata Course Quizzes

This directory contains interactive learnr quizzes for the openwashdata course.

## Structure

- `app.R` - Quiz landing page that lists all available quizzes
- `md-01-quiz.Rmd` - Module 1 quiz on Quarto basics
- Additional quiz files can be added as `md-XX-quiz.Rmd`

## Running the Quiz System

To run the quiz landing page locally:

```r
shiny::runApp()
```

Or to run a specific quiz directly:

```r
rmarkdown::run("md-01-quiz.Rmd")
```

## Adding New Quizzes

1. Create a new learnr quiz file (e.g., `md-02-quiz.Rmd`)
2. Add the quiz to the `quizzes` list in `app.R`:

```r
list(
  id = "module2",
  title = "Module 2: Your Title",
  description = "Quiz description",
  file = "md-02-quiz.Rmd",
  available = TRUE
)
```

## Required Packages

- shiny
- bslib
- learnr
- tidyverse
- gapminder
- knitr
- gradethis
- rmarkdown