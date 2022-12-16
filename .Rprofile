source("renv/activate.R")

if (!"https://rse.pik-potsdam.de/r/packages" %in% getOption("repos")) {
  options(repos = c(getOption("repos"), pik = "https://rse.pik-potsdam.de/r/packages"))
}

# bootstrapping, will only run once after this repo is freshly cloned
if (isTRUE(rownames(installed.packages(priority = "NA")) == "renv")) {
  if (file.exists("DESCRIPTION") && !identical(readLines("DESCRIPTION"), readLines("DEPENDENCIES"))) {
    warning("Unexpected DESCRIPTION file found, try removing it. Will not install dependencies.")
  } else {
    message("R package dependencies are not installed in this renv, installing now...")
    renv::install("yaml", prompt = FALSE) # yaml is required to find dependencies in Rmd files
    # renv will only consider a file called DESCRIPTION, so rename DEPENDENCIES
    file.copy("DEPENDENCIES", "DESCRIPTION")
    renv::hydrate() # auto-detect and install all dependencies
    file.remove("DESCRIPTION")
    message("Finished installing R package dependencies.")
  }
}

# source global .Rprofile (very important to load user specific settings)
if (file.exists("~/.Rprofile")) {
  source("~/.Rprofile")
}
