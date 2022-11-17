local({
  argv <- commandArgs(trailingOnly = TRUE)
  lockfile <- if (length(argv) >= 1) argv else Sys.glob(c("output/*/renv.lock", "renv/archive/*renv.lock"))
  piamenv::restoreRenv(lockfile)
})
