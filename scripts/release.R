release <- function(newVersion) {
  if (Sys.which("sbatch") == "") {
    stop("release must be created on cluster")
  }

  releaseDate <- format(Sys.time(), "%Y-%m-%d")
  oldVersion <- readLines("CITATION.cff") |>
    grep(pattern = "^version: (.*)$", value = TRUE) |>
    sub(pattern = "^version: (.*)$", replacement = "\\1") |>
    sub(pattern = "dev", replacement = "")

  githubUrl <- "https://github.com/magpiemodel/magpie/compare/"
  readLines("CHANGELOG.md") |>
    sub(pattern = "## [Unreleased]", replacement = paste0("## [", newVersion, "] - ", releaseDate), fixed = TRUE) |>
    sub(pattern = paste0("\\[Unreleased\\]: ", githubUrl, "v(.+)\\.\\.\\.develop"),
        replacement = paste0("[Unreleased]: ", githubUrl, "v", newVersion, "...develop\n",
                             "[", newVersion, "]: ", githubUrl, "v\\1...v", newVersion)) |>
    writeLines("CHANGELOG.md")

  readLines("CITATION.cff") |>
    sub(pattern = "^version:.*$", replacement = paste("version:", newVersion)) |>
    sub(pattern = "^date-released:.*$", replacement = paste("date-released:", releaseDate)) |>
    writeLines("CITATION.cff")

  readLines("README.md") |>
    gsub(pattern = oldVersion, replacement = newVersion) |>
    writeLines("README.md")

  citation::cff2zenodo("CITATION.cff")

  message("creating documentation using goxygen...")
  goxygen::goxygen()
  message("uploading documentation to RSE server")
  system(paste0("rsync -e ssh -avz doc/html rse:/webservice/doc/magpie/", newVersion))

  message("uploading input data to RSE server")
  sys.source("scripts/start/extra/publish_data.R", envir = new.env()) # only works on cluster

  message("TODO:\n",
          "- CHANGELOG.md: sort lines in each category: changed, added, removed, fixed; remove empty categories\n",
          "- git add -p\n",
          "Press enter when done to commit, push and create PR")
  gms::getLine()

  gert::git_commit(paste("magpie release", newVersion))
  gert::git_push()
  system(paste0("gh pr create --base master --title 'magpie release ", newVersion, "' --body '' --reviewer tscheypidi"))
}

arguments <- commandArgs(TRUE)
if (length(arguments) != 1) {
  stop("Please pass the new version number, e.g. `Rscript scripts/release.R 4.6.2`")
}
release(arguments)
