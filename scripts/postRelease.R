postRelease <- function() {
  gert::git_pull("upstream", "master") # TODO

  readLines("CITATION.cff") |>
    sub(pattern = "^(version:.*)$", replacement = "\\1dev") |>
    writeLines("CITATION.cff")

  citation::cff2zenodo("CITATION.cff")

  # system("gh pr create") # TODO onto magpiemodel/magpie develop, then open in browser to add reviewer
}

postRelease()
