release <- function(newVersion) {
  githubUrl <- "https://github.com/magpiemodel/magpie/compare/"
  readLines("CHANGELOG.md") |>
    sub(pattern = "## [Unreleased]", replacement = paste0("## [", newVersion, "]"), fixed = TRUE) |>
    sub(pattern = "\\[Unreleased\\]: ", githubUrl, "v([0-9]+\\.[0-9]+\\.[0-9]+)...develop",
        replacement = paste0("[Unreleased]: ", githubUrl, "v", newVersion, "...develop\n",
                             "[", newVersion, "]: ", githubUrl, "v\\1...v", newVersion)) |>
    writeLines("CHANGELOG.md")
}

release("4.6.2")
