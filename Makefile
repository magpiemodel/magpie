.PHONY: help docs update-renv update-all-renv check check-fix
.DEFAULT_GOAL := help

help: ## Show this help.
	@sed -e '/##/ !d' -e '/sed/ d' -e 's/^\([^ ]*\) *##\(.*\)/\1^\2/' \
		$(MAKEFILE_LIST) | column -ts '^'

docs: ## Generate/update model HTML documentation in the doc/ folder.
	Rscript -e 'goxygen::goxygen()'
	@echo -e '\nOpen\ndoc/html/index.htm\nin your browser to view the generated documentation.'

update-renv: ## Upgrade all pik-piam packages in your renv to the respective
             ## latest release and write renv.lock to archive.
	Rscript -e 'piamenv::updateRenv()'

update-all-renv: ## Upgrade all packages (including CRAN packages) in your renv
                 ## to the respective latest release and write renv.lock to archive.
	Rscript -e 'renv::update(exclude = "renv"); piamenv::archiveRenv()'

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
