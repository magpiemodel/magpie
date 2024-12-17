.PHONY: help docs update-renv update-renv-all archive-renv restore-renv check check-fix start output
.DEFAULT_GOAL := help

# extracts the help text and formats it nicely
HELP_PARSING = 'm <- readLines("Makefile");\
				m <- grep("\#\#", m, value=TRUE);\
				command <- sub("^([^ ]*) *\#\#(.*)", "\\1", m);\
				help <- sub("^([^ ]*) *\#\#(.*)", "\\2", m);\
				cat(sprintf("%-18s%s", command, help), sep="\n")'

help: ## Show this help.
	@Rscript -e $(HELP_PARSING)

docs: ## Generate/update model HTML documentation in the doc/ folder.
	Rscript -e 'goxygen::goxygen(); warnings()'
	@echo -e '\nOpen\ndoc/html/index.htm\nin your browser to view the generated documentation.'

update-renv: ## Upgrade all pik-piam packages in your renv to the respective
             ## latest release and write renv.lock to archive.
	Rscript -e 'piamenv::updateRenv()'

update-renv-all: ## Upgrade all packages (including CRAN packages) in your renv
                 ## to the respective latest release and write renv.lock to archive.
	Rscript -e 'renv::update(); piamenv::archiveRenv()'

archive-renv: ## Write renv.lock to archive.
	Rscript -e 'piamenv::archiveRenv()'

restore-renv: ## Restore renv to the state described in interactively
              ## selected renv.lock from the archive or a run folder.
	Rscript -e 'piamenv::restoreRenv()'

check: ## Check if the GAMS code follows the coding etiquette
       ## using gms::codeCheck.
	Rscript -e 'invisible(gms::codeCheck(strict = TRUE))'

check-fix: ## Check if the GAMS code follows the coding etiquette
           ## and offer fixing any problems directly if possible
           ## using gms::codeCheck.
	Rscript -e 'invisible(gms::codeCheck(strict = TRUE, interactive = TRUE))'

start: ## Start a MAgPIE run.
	Rscript start.R

output: ## Run an output script.
	Rscript output.R
