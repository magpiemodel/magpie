# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: AgMIP GlobEcon simulations 2020
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE runs
source("config/default.cfg")

cfg$force_download <- FALSE

#cfg$results_folder <- "output/:title:"
cfg$results_folder <- "output/:title::date:"

cfg$output <- c("rds_report","projects/agmip_report","validation","extra/disaggregation")



#################################################################
# 1 Baseline SSP1-3 simulations "_NoMt_NoCC"                    #
#################################################################


### SSPs w/o mitigation ################
cfg$title <- "SSP1_NoMt_NoCC"
cfg <- gms::setScenario(cfg,c("SSP1","NPI"))
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_NoMt_NoCC"
cfg <- gms::setScenario(cfg,c("SSP2","NPI"))
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP3_NoMt_NoCC"
cfg <- gms::setScenario(cfg,c("SSP3","NPI"))
start_run(cfg,codeCheck=FALSE)



#reset:
cfg <- gms::setScenario(cfg,c("SSP2","NPI"))




#################################################################
# 2 AgMIP diet scenarios based on SSP2 "SSP2_NoMt_NoCC_"        #
#################################################################


#################################################################
# 2A EAT Lancet scenarios "FlexA_":

### settings:
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "healthy_BMI"
cfg$gms$c15_EAT_scen <- "FLX"



cfg$title <- "SSP2_NoMt_NoCC_FlexA_WLD"
cfg$gms$scen_countries15  <- all_iso_countries
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SSP2_NoMt_NoCC_FlexA_USA"
#region: USA
cfg$gms$scen_countries15  <- "USA"
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SSP2_NoMt_NoCC_FlexA_LAM"
#region: LAM
cfg$gms$scen_countries15  <- "ABW,AIA,ARG,ATA,ATG,BES,BHS,BLM,BLZ,BMU,
       BOL,BRA,BRB,BVT,CHL,COL,CRI,CUB,CUW,CYM,
       DMA,DOM,ECU,FLK,GLP,GRD,GTM,GUF,GUY,HND,
       HTI,JAM,KNA,LCA,MAF,MEX,MSR,MTQ,NIC,PAN,
       PER,PRI,PRY,SGS,SLV,SUR,SXM,TCA,TTO,URY,
       VCT,VEN,VGB,VIR"
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SSP2_NoMt_NoCC_FlexA_EUR"
#region: EUR
cfg$gms$scen_countries15  <- "ALA,AUT,BEL,BGR,CYP,CZE,DEU,DNK,ESP,EST,
       FIN,FRA,FRO,GBR,GGY,GIB,GRC,HRV,HUN,IMN,
       IRL,ITA,JEY,LTU,LUX,LVA,MLT,NLD,POL,PRT,
       ROU,SVK,SVN,SWE"
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SSP2_NoMt_NoCC_FlexA_CHN"
#region: CHA
cfg$gms$scen_countries15  <- "CHN,HKG,MAC,TWN"
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SSP2_NoMt_NoCC_FlexA_DEV"
#region: CAZ, EUR, NEU, USA
cfg$gms$scen_countries15  <- "AUS,CAN,HMD,NZL,SPM,
  ALA,AUT,BEL,BGR,CYP,CZE,DEU,DNK,ESP,EST,
        FIN,FRA,FRO,GBR,GGY,GIB,GRC,HRV,HUN,IMN,
        IRL,ITA,JEY,LTU,LUX,LVA,MLT,NLD,POL,PRT,
        ROU,SVK,SVN,SWE,
  ALB,AND,BIH,CHE,GRL,ISL,LIE,MCO,MKD,MNE,
        NOR,SJM,SMR,SRB,TUR,VAT,
  USA"
start_run(cfg,codeCheck=FALSE)



#reset:
cfg$gms$s15_elastic_demand <- 1
cfg$gms$s15_exo_diet <- 0
cfg$gms$scen_countries15  <- all_iso_countries
cfg <- setScenario(cfg,c("SSP2","NPI"))




#################################################################
# 2B Livestock diet scenarios "HalfRDoM_DEV" and "HalfRD_DEV":

### settings:


cfg$title <- "SSP2_NoMt_NoCC_HalfRDoM_DEV"
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$s15_livestock_substitution <- 0.5
cfg$gms$s15_food_substitution_start <- 2020
cfg$gms$s15_food_substitution_target <- 2050
cfg$gms$s15_food_subst_functional_form <- 1

#region: CAZ, EUR, NEU, USA
cfg$gms$scen_countries15  <- "AUS,CAN,HMD,NZL,SPM,
  ALA,AUT,BEL,BGR,CYP,CZE,DEU,DNK,ESP,EST,
        FIN,FRA,FRO,GBR,GGY,GIB,GRC,HRV,HUN,IMN,
        IRL,ITA,JEY,LTU,LUX,LVA,MLT,NLD,POL,PRT,
        ROU,SVK,SVN,SWE,
  ALB,AND,BIH,CHE,GRL,ISL,LIE,MCO,MKD,MNE,
        NOR,SJM,SMR,SRB,TUR,VAT,
  USA"
start_run(cfg,codeCheck=FALSE)
#reset:
cfg$gms$s15_livestock_substitution <- 0


cfg$title <- "SSP2_NoMt_NoCC_HalfRD_DEV"
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$s15_rumdairy_substitution <- 0.5
cfg$gms$s15_food_substitution_start <- 2020
cfg$gms$s15_food_substitution_target <- 2050
cfg$gms$s15_food_subst_functional_form <- 1
#region: CAZ, EUR, NEU, USA
cfg$gms$scen_countries15  <- "AUS,CAN,HMD,NZL,SPM,
  ALA,AUT,BEL,BGR,CYP,CZE,DEU,DNK,ESP,EST,
        FIN,FRA,FRO,GBR,GGY,GIB,GRC,HRV,HUN,IMN,
        IRL,ITA,JEY,LTU,LUX,LVA,MLT,NLD,POL,PRT,
        ROU,SVK,SVN,SWE,
  ALB,AND,BIH,CHE,GRL,ISL,LIE,MCO,MKD,MNE,
        NOR,SJM,SMR,SRB,TUR,VAT,
  USA"
start_run(cfg,codeCheck=FALSE)
#reset:
cfg$gms$s15_livestock_substitution <- 0



#reset:
cfg$gms$scen_countries15  <- all_iso_countries
cfg <- setScenario(cfg,c("SSP2","NPI"))
