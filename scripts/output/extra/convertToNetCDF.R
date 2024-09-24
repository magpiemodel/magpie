# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Convert all .mz files to NetCDF (.nc) for a magpie directory
# comparison script: FALSE
# ---------------------------------------------------------------

# Version 1.00 - Michael Crawford
# 1.00: first working version

library(gms)
library(magclass)

############################# BASIC CONFIGURATION #######################################
if (!exists("source_include")) {

    title       <- NULL
    outputdir   <- NULL

    # Define arguments that can be read from command line
    readArgs("outputdir", "title")

}
#########################################################################################

message("Converting all .mz outputs to .nc for output directory: ", outputdir)

mzFiles <- list.files(path = outputdir, pattern = "0\\.5(_share)?\\.mz$", full.names = TRUE)

lapply(X = mzFiles, FUN = function(x) {
    tryCatch({
        magObj <- magclass::read.magpie(x)
        newName <- sub("\\.[^.]+$", "", x)
        write.magpie(x = magObj, file_name = paste0(newName, ".nc"), file_folder = outputdir, append = FALSE)
    }, error = function(e) {
        message("Error processing file: ", x, " - ", e$message)
    })
})
