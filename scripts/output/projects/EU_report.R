readArgs("outputdir")
rmarkdown::render("./scripts/output/projects/EU_report.Rmd",
                  output_dir = outputdir)
