# openwashdata Interactive Quizzes

This repository contains interactive quizzes for learning openwashdata package development using Quarto Live.

## Features

- **Interactive Code Execution**: Run R code directly in your browser using WebAssembly
- **No Installation Required**: Works entirely in the browser - no R installation needed
- **Self-Paced Learning**: Hints and solutions available for all exercises
- **Modern Web Interface**: Built with Quarto and pkgdown for a clean, responsive design

## Setup

### Prerequisites

- R (4.0 or higher)
- Quarto CLI
- Git

### Installation

1. Clone this repository:
```bash
git clone https://github.com/ds4owd-dev/quiz.git
cd quiz
```

2. Install R dependencies using renv:
```r
renv::restore()
```

3. The quarto-live extension is already included in the repository.

## Building the Site

### Local Development

To render the site locally:

```bash
quarto render
```

The site will be built in the `docs/` directory. You can preview it by opening `docs/index.html` in your browser.

### Building with pkgdown

To build the full pkgdown site:

```r
pkgdown::build_site()
```

## Deployment

The site is automatically deployed to GitHub Pages using GitHub Actions. Simply push to the `main` branch, and the site will be updated.

## Creating New Quizzes

To create a new quiz:

1. Create a new `.qmd` file (e.g., `md-02-quiz.qmd`)
2. Use the following template:

```markdown
---
title: "Your Quiz Title"
format: live-html
engine: knitr
---

{{< include ./_extensions/r-wasm/live/_knitr.qmd >}}

## Your quiz content here

```{webr}
# Interactive R code block
```
```

3. Add a link to your quiz in `index.qmd`
4. Update `_pkgdown.yml` to include the new quiz in the navigation

## Repository Structure

```
quiz/
├── _extensions/          # Quarto extensions (quarto-live)
├── .github/             # GitHub Actions workflows
├── renv/                # R package management
├── _pkgdown.yml         # pkgdown configuration
├── _quarto.yml          # Quarto website configuration
├── index.qmd            # Home page
├── md-01-quiz.qmd       # Module 1 quiz
├── styles.css           # Custom CSS styles
└── README.md            # This file
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is part of the openwashdata initiative. See LICENSE for details.