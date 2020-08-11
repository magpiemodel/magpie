# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


require(magclass)
source("scripts/start_functions.R")
source("config/default.cfg")

# Download data
input_old <- .get_info("input/info.txt", "^Used data set:", ": ")
if(!setequal(cfg$input, input_old) | cfg$force_download) {
  # download data and update code
  download_and_update(cfg)
}

cfg$force_download <- FALSE
cfg$title <- "fable_india_exo_trade"

# Update exogenous trade balances for India
cfg$gms$trade <- "exo"
cfg$gms$c60_bioenergy_subsidy <- 0 # to prevent infeasibilities in other regions

tb_file       <- "modules/21_trade/input/f21_trade_balance.cs3"
tb_india_file <- "trade_balance_india.cs3"
out           <- read.magpie(tb_file)
replacement   <- read.magpie(tb_india_file)
out["IND",,]  <- replacement
write.magpie(out,tb_file)
cat("Exogenous trade information for India has been updated!\n\n")

# copy trade balance india to output folder (for documentation)
cfg$files2export$start <- c(cfg$files2export$start,tb_india_file)

# start model
start_run(cfg)
