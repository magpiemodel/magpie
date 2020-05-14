######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ####
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")

clima<-"cc"
resolutions<-c("200")
realization<-c("sticky_feb18","mixed_feb17")
trade<-c("selfsuff_reduced")


for (i in 1:length(resolutions)){
for(j in 1:length(realization)){
for(k in 1:length(trade)){
#Change the results folder name
cfg$title<-paste0("Develop_",realization[j],"_c",resolutions[i],"_trade_",trade[k])


cfg$input <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev44_c",resolutions[i],"_690d3718e151be1b450b394c1064b1c5.tgz"),
              "rev4.44_h12_magpie.tgz",
              "rev4.44_h12_validation.tgz",
              "calibration_H12_c200_26Feb20.tgz",
              "additional_data_rev3.79.tgz)


#recalibrate
cfg$recalibrate <- TRUE

#use Feb15 realization for land realization
cfg$gms$land <- "landmatrix_dec18"

#use Feb15 realization for land realization
cfg$gms$trade <-trade[k]

#Output shouldnt include validation
cfg$output <- c("interpolation","rds_report")

cfg$gms$factor_costs <- realization[j]

#Climate impact or not
cfg$gms$c14_yields_scenario  <- clima
cfg$gms$c42_watdem_scenario  <- clima
cfg$gms$c43_watavail_scenario<- clima
cfg$gms$c52_carbon_scenario  <- clima
cfg$gms$c59_som_scenario  <- clima


start_run(cfg=cfg)
}}
}
