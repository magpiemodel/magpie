# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Scenarios for FSEC
# ----------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("scripts/projects/fsec.R")
source("config/default.cfg")

codeCheck <- FALSE

# -----------------------------------------------------------------------------------------------------------------
# Single transformation runs
# -----------------------------------------------------------------------------------------------------------------
# Population
cfg <- fsecScenario(scenario = "population")
start_run(cfg = cfg, codeCheck = codeCheck)

# Improved institutions
cfg <- fsecScenario(scenario = "institutions")
start_run(cfg = cfg, codeCheck = codeCheck)

# Energy and transport
cfg <- fsecScenario(scenario = "energy")
start_run(cfg = cfg, codeCheck = codeCheck)

# Diet and health
cfg <- fsecScenario(scenario = "diet")
start_run(cfg = cfg, codeCheck = codeCheck)

# Meat
cfg <- fsecScenario(scenario = "meat")
start_run(cfg = cfg, codeCheck = codeCheck)

# Waste
cfg <- fsecScenario(scenario = "waste")
start_run(cfg = cfg, codeCheck = codeCheck)

# Animal waste management
cfg <- fsecScenario(scenario = "awms")
start_run(cfg = cfg, codeCheck = codeCheck)

# Livestock management
cfg <- fsecScenario(scenario = "livestock")
start_run(cfg = cfg, codeCheck = codeCheck)

# Cropefficiency
cfg <- fsecScenario(scenario = "cropefficiency")
start_run(cfg = cfg, codeCheck = codeCheck)

# Biodiversity
cfg <- fsecScenario(scenario = "biodiversity")
start_run(cfg = cfg, codeCheck = codeCheck)

# Fair trade
cfg <- fsecScenario(scenario = "fairTrade")
start_run(cfg = cfg, codeCheck = codeCheck)

# Timber cities
cfg <- fsecScenario(scenario = "timberCities")
start_run(cfg = cfg, codeCheck = codeCheck)

# Afforestation
cfg <- fsecScenario(scenario = "REDDaff")
start_run(cfg = cfg, codeCheck = codeCheck)

# REDD
cfg <- fsecScenario(scenario = "REDD")
start_run(cfg = cfg, codeCheck = codeCheck)

# Land sparing
cfg <- fsecScenario(scenario = "landSparing")
start_run(cfg = cfg, codeCheck = codeCheck)

# Water sparing
cfg <- fsecScenario(scenario = "waterSparing")
start_run(cfg = cfg, codeCheck = codeCheck)

# Peatland
cfg <- fsecScenario(scenario = "peatland")
start_run(cfg = cfg, codeCheck = codeCheck)

# Air pollution
#cfg <- fsecScenario(scenario = "airPollution")
#start_run(cfg = cfg, codeCheck = codeCheck)

# Soil
cfg <- fsecScenario(scenario = "soil")
start_run(cfg = cfg, codeCheck = codeCheck)

# -----------------------------------------------------------------------------------------------------------------
# Scenario runs
# -----------------------------------------------------------------------------------------------------------------
### Business-as-usual
cfg <- fsecScenario(scenario = "bau")
start_run(cfg = cfg, codeCheck = codeCheck)

### SSP1 + mitigation (RCP 1.9)
cfg <- fsecScenario(scenario = "ssp1")
cfg$input['cellular'] <- "rev4.73FSECmodeling_e2bdb6cd_0bd54110_cellularmagpie_c200_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1.tgz"
start_run(cfg = cfg, codeCheck = codeCheck)

### SSP3 + mitigation (RCP 7.0)
cfg <- fsecScenario(scenario = "ssp3")
cfg$input['cellular'] <- "rev4.73FSECmodeling_e2bdb6cd_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz"
start_run(cfg = cfg, codeCheck = codeCheck)

### SSP4 + mitigation (RCP 6.0)
cfg <- fsecScenario(scenario = "ssp4")
cfg$input['cellular'] <- "rev4.73FSECmodeling_e2bdb6cd_3c888fa5_cellularmagpie_c200_MRI-ESM2-0-ssp460_lpjml-8e6c5eb1.tgz"
start_run(cfg = cfg, codeCheck = codeCheck)

### SSP5 without mitigation (RCP 8.5)
cfg <- fsecScenario(scenario = "ssp5")
cfg$input['cellular'] <- "rev4.73FSECmodeling_e2bdb6cd_09a63995_cellularmagpie_c200_MRI-ESM2-0-ssp585_lpjml-8e6c5eb1.tgz"
start_run(cfg = cfg, codeCheck = codeCheck)

### FSDP Scenario
cfg <- fsecScenario(scenario = "fsdp")
cfg$input['cellular'] <- "rev4.73FSECmodeling_e2bdb6cd_6819938d_cellularmagpie_c200_MRI-ESM2-0-ssp126_lpjml-8e6c5eb1.tgz"
### Emission policy must be set separately in full FSDP scenario
# (because it would be overwritten in the different transformations)
cfg$gms$c56_emis_policy <- "sdp_all"
start_run(cfg = cfg, codeCheck = codeCheck)
