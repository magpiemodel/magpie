# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

###########################################################################

### INPUT FILES
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev44_c200_690d3718e151be1b450b394c1064b1c5.tgz",
			   "calibration_H12_c200_26Feb20.tgz",
         "rev4.44forestry_h12_magpie.tgz",
         "rev4.44forestry_h12_validation.tgz",
         "forestry_20200513.tgz",
         "coupling_co2_prices_apr20.tgz",
         "additional_data_rev3.80.tgz")

### REPOSITORIES
cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,"/p/projects/landuse/users/mishra/additional_data_private_forestry"=NULL,"/p/projects/magpie/users/mishra/projects/coupling"=NULL), getOption("magpie_repos"))

### TIME
cfg$gms$c_timesteps <- "5year"

### LAND
cfg$gms$land <- "landmatrix_dec18"

### YIELDS
# * IPCC BEF
# * plantation yield switch
cfg$gms$s14_timber_plantation_yield <- 1     # def = 1

### FORESTRY
cfg$gms$forestry  <- "dynamic_may20"
# * switch for using natveg (0) or plantation (1) growth curves for plantations
cfg$gms$s32_timber_plantation <- 1		# def = 0
# * switch for using interest-rate based (0) or Faustmann (1) rotations for plantations
cfg$gms$s32_faustmann_rotation <- 0   # def = 0
# * switch for turning off (0) or on (1) the timber plantation land distribution
cfg$gms$s32_initial_distribution <- 1   # def = 1

### NATVEG
cfg$gms$natveg  <- "dynamic_may20"
# Age class distribution in secondary forests
# * (0): All secondary forest is considered to be in the highest age-class
# * (1): Equal distribution of LUH2 secondary forest in all age-classes
# * (2): Distribution of LUH2 secondary forest into age-class distribution from Poulter et al. 2019 GFAD v1.1
cfg$gms$s35_secdf_distribution <- 0

### CARBON
# * Carbon switch
cfg$gms$c52_carbon_switch <- "default_lpjml"          # def = "default_lpjml"

### TIMBER
# * (biomass_mar20): WIP
cfg$gms$timber <- "biomass_mar20"                  # def = biomass_mar20
# Switch for timber demand
cfg$gms$s73_timber_demand <- 1
# Setting if demand adjuster should be price based or manuall adjusted
cfg$gms$s73_price_adjuster <- 0       # def = 0
# Counter for iterations of demand adjustment
cfg$gms$s73_counter <- 0
# Maximum iterations for demand adjustments
cfg$gms$s73_maxiter <- 5
# price elasticity from lauri et al
cfg$gms$s73_price_elasticity <- -0.5
# Counter for iterations of demand adjustment
cfg$gms$s73_counter2 <- 0
# Maximum iterations for demand adjustments
cfg$gms$s73_maxiter2 <- 5

### OPTIMIZATION
# * 1: using optfile for specified solver settings
# * 0: default settings (optfile will be ignored)
cfg$gms$s80_optfile <- 1

###########################################################################

cfg$results_folder <- "output/:title:"

cfg$recalc_npi_ndc <- "ifneeded"

log_folder <- "run_details"
dir.create(log_folder,showWarnings = FALSE)

identifier_flag <- "BF36"

cat(paste0("Flag for secondary forest distributions. Poulter distribution by raster calculations. Ageclasses collapsed by half."), file=paste0(log_folder,"/",identifier_flag,".txt"),append=F)

for(s73_price_adjuster in c(0)){

  cfg$gms$s73_price_adjuster <- s73_price_adjuster

  for(secdf_distribution in c(0)){ 					## (0) for all in highest acx (1) for equal dist (2) for poulter dist

    cfg$gms$s35_secdf_distribution <- secdf_distribution

    for(ssp in c("SSP2")){

      for(timber_demand in c("biomass_mar20")){ ## Add "off" here to turn off timber demand

        cfg$gms$timber <- timber_demand

        if(timber_demand == "biomass_mar20") cfg$gms$s32_initial_distribution = 1
        if(timber_demand == "off") cfg$gms$s32_initial_distribution = 0

        for(faustmann_switch in c(0)){

          cfg$gms$s32_faustmann_rotation <- faustmann_switch

          for (co2_price_path in c("NPI","2deg")) { ## Add "2deg" here for CO2 price runs

            if (co2_price_path == "NPI") {
              cfg <- setScenario(cfg,c(ssp,"NPI"))
              co2_price_path_flag = "Baseline"
            } else if (co2_price_path == "2deg"){
              cfg <- setScenario(cfg,c(ssp,"NDC"))
              co2_price_path_flag = "Policy"
							cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
							cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
            } else if (co2_price_path == "Hotelling"){
              cfg <- setScenario(cfg,c(ssp,"NDC"))
              co2_price_path_flag = "PolicyH"
            }

            for(emis_policy in c("redd+_nosoil")){ ## Add "ssp_nosoil" for policy penalizing only natveg emissions

              cfg$gms$c56_emis_policy <- emis_policy

              for(plantation_switch in c(1)){ ## Add 0 here to treat plantations as natural vegetation

                cfg$gms$s14_timber_plantation_yield <- plantation_switch
                cfg$gms$s32_timber_plantation <- cfg$gms$s14_timber_plantation_yield

#                cfg$gms$c56_pollutant_prices <- "coupling"
#                cfg$gms$c60_2ndgen_biodem <- "coupling"

#                file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
#                file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)

                ### Create flags

                if(timber_demand == "biomass_mar20") demand_flag = ""
                if(timber_demand == "off") demand_flag = "NoTimber"

                if(emis_policy == "ssp_nosoil") pol_flag = "SSPnosoil"
                if(emis_policy == "redd+_nosoil") pol_flag = ""

                if(plantation_switch == 1) plantation_flag = ""
                if(plantation_switch == 0) plantation_flag = "NatVeg"

                if(faustmann_switch == 1) faustmann_flag = "Faustmann"
                if(faustmann_switch == 0) faustmann_flag = ""

                if(s73_price_adjuster == 1) adjustment_flag = "PriceAdj"
                if(s73_price_adjuster == 0) adjustment_flag = ""

                if(secdf_distribution == 0) distribution_flag = "xDist"
                if(secdf_distribution == 1) distribution_flag = "kDist"
                if(secdf_distribution == 2) distribution_flag = "pDist"

                cfg$title <- paste0(identifier_flag,"_",ssp,"_",adjustment_flag,"_",demand_flag,"_",plantation_flag,"_",faustmann_flag,"_",pol_flag,"_",distribution_flag,"_",co2_price_path_flag)

                cfg$output <- c("rds_report")

#                cat(cfg$title,"\n")

                start_run(cfg,codeCheck=FALSE)
              }
            }
          }
        }
      }
    }
  }
}
