# openwashdata Interactive Quizzes

Interactive quizzes for learning openwashdata package development using Quarto Live.

## Quick Start

```bash
# Clone repository
git clone https://github.com/ds4owd-dev/quiz.git
cd quiz
```

```r
# Install dependencies in R
renv::restore()
```

```bash
# Build site
quarto render

# Preview locally (choose one)
quarto preview
# OR use the Python server
python3 serve.py
```

## Development

### Create a new quiz

1. Create a new `.qmd` file:

```markdown
---
title: "Your Quiz Title"
format:
  live-html:
    resources:
      - _extensions/r-wasm/live/resources
engine: knitr
---

{{< include ./_extensions/r-wasm/live/_knitr.qmd >}}

## Your quiz content

```{webr}
# Interactive R code
```
```

2. Add link in `index.qmd`
3. Run `quarto render`

## Deployment

Push to `main` branch - GitHub Actions handles deployment to GitHub Pages.

## License

Part of the openwashdata initiative.