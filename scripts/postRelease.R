postRelease <- function() {
  gert::git_fetch("upstream")
  gert::git_merge("upstream/master")

  pattern <- "and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html)."
  textToAdd <- paste("",
                     "",
                     "",
                     "## [Unreleased]",
                     "",
                     "### changed",
                     "-",
                     "",
                     "### added",
                     "-",
                     "",
                     "### removed",
                     "-",
                     "",
                     "### fixed",
                     "-",
                     sep = "\n")

  readLines("CHANGELOG.md") |>
    sub(pattern = pattern, replacement = paste0(pattern, textToAdd), fixed = TRUE) |>
    writeLines("CHANGELOG.md")

  readLines("CITATION.cff") |>
    sub(pattern = "^(version:.*)$", replacement = "\\1dev") |>
    writeLines("CITATION.cff")

  citation::cff2zenodo("CITATION.cff")

  message("TODO: git add -p")
  gms::getLine()

  gert::git_commit("merge master into develop")
  gert::git_push()
  system(paste0("gh pr create --base develop --title 'merge master into develop' --body '' --reviewer tscheypidi"))
}

postRelease()
