release <- function(newVersion) {
  readLines("CHANGELOG.md") |>
    sub(pattern = "## [Unreleased]", replacement = paste0("## [", newVersion, "]"), fixed = TRUE) |>
    sub(pattern = "\\[Unreleased\\]: https://github.com/magpiemodel/magpie/compare/v([0-9]+\\.[0-9]+\\.[0-9]+)...develop",
        replacement = paste0("[Unreleased]: https://github.com/magpiemodel/magpie/compare/v", newVersion, "...develop\n",
                             "[", newVersion, "]: https://github.com/magpiemodel/magpie/compare/v\\1...v", newVersion)) |>
    writeLines("CHANGELOG.md")
}

release("4.6.2")
