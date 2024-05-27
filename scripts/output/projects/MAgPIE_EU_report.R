readArgs("outputdir")
rmarkdown::render("./scripts/output/projects/MAgPIE_EU_report_notebook.Rmd",
                  output_dir = paste0(outputdir, "/validation"))
