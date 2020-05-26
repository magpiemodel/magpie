# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
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

#start MAgPIE runs
source("config/default.cfg")

cfg$force_download <- FALSE

#cfg$results_folder <- "output/:title:"
cfg$results_folder <- "output/:title::date:"





##############################################
# AgMIP diet scenarios January 2020          #
##############################################



##############################################
# EAT Lancet scenarios:

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




##############################################
# Livestock diet scenarios:

### settings:


cfg$title <- "SSP2_NoMt_NoCC_HalfRDoM_DEV"
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c15_livescen <- "lin_50pc_20_50"
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
cfg$gms$c15_livescen <- "constant"


cfg$title <- "SSP2_NoMt_NoCC_HalfRD_DEV"
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c15_rumdairyscen <- "lin_50pc_20_50"
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
cfg$gms$c15_rumdairyscen <- "constant"



#reset: 
cfg$gms$scen_countries15  <- all_iso_countries
cfg <- setScenario(cfg,c("SSP2","NPI"))




  