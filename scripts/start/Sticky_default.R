######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ####
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")

clima<-"cc"
resolutions<-c("1000")
realization<-c("sticky_feb18","mixed_feb17")
trade<-c("exo")


for (i in 1:length(resolutions)){
for(j in 1:length(realization)){
for(k in 1:length(trade)){
#Change the results folder name

cfg$title<-paste0("Develop_merge_",realization[j],"_c",resolutions[i],"_trade_",trade[k])

cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev44_c1000_690d3718e151be1b450b394c1064b1c5.tgz",
               "rev4.44_h12_magpie.tgz",
               "rev4.44_h12_validation.tgz",
               "additional_data_rev3.79.tgz")

#data from the c200 resolution
gdx <- paste0("/p/projects/landuse/users/mbacca/magpie_downloads/Develop_sticky_merge/magpie/output/Develop_merge_sticky_feb18_c200_trade_selfsuff_reduced_2020-05-17_23.44.14/fulldata.gdx")
 ov_prod_reg <- readGDX(gdx,"ov_prod_reg",select=list(type="level"))
 ov_supply <- readGDX(gdx,"ov_supply",select=list(type="level"))
 f21_trade_balance <- ov_prod_reg - ov_supply
 #f21_trade_balance.cs3 will be deleted when downloading the high res data. Therefore renamed.
 write.magpie(round(f21_trade_balance,6),paste0("modules/21_trade/input/f21_trade_balance2.cs3"))
 manipulateFile("modules/21_trade/exo/input.gms",c("f21_trade_balance.cs3","f21_trade_balance2.cs3"))

 #use exo trade and parallel optimization
  cfg$gms$trade <- trade[k]
  cfg$gms$optimization <- "nlp_par"
  cfg$gms$s15_elastic_demand <- 0

#recalibrate
#cfg$recalibrate <- "ifneeded"


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

start_run(cfg=cfg)}
}}
