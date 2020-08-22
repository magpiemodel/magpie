library(magpie4)
library(luscale)

gdx <- list()
# gdx$C_SDP_NPI <- "/p/projects/piam/runs/coupled-magpie/output/C_SDP-NPi-mag-4/fulldata.gdx"
# gdx$SDP_NPI_old <- "/p/projects/landuse/users/florianh/affbug/f_coupling/output/val_SDP-NPI/fulldata.gdx"
# gdx$SSP1_NPI_old <- "/p/projects/landuse/users/florianh/affbug/f_coupling/output/val_SSP1-NPI/fulldata.gdx"
# gdx$SDP_NPI_exoDietWasteOff <- "/p/projects/landuse/users/florianh/affbug/f_coupling/output/val_SDP-NPI_exoDietWasteOff/fulldata.gdx"
#gdx$SDP_NPI_2020 <- "/p/projects/landuse/users/florianh/affbug/release_candidate2/output/val19_SDP_NPI/fulldata.gdx"
# gdx$SSP1_NPI_2020 <- "/p/projects/landuse/users/florianh/affbug/release_candidate2/output/val19_SSP1-NPI/fulldata.gdx"
#gdx$SSP2_NPI_2020 <- "/p/projects/landuse/users/florianh/affbug/release_candidate2/output/val19_SSP2_NPI/fulldata.gdx"
#gdx$C_SSP2_PkBudg900 <- "/p/projects/piam/runs/coupled-magpie/output/C_SSP2-PkBudg900-mag-4/fulldata.gdx"
#gdx$C_SSP5_PkBudg900 <- "/p/projects/piam/runs/coupled-magpie/output/C_SSP5-PkBudg900-mag-4/fulldata.gdx"
#gdx$val20_SSP5_PkBudg900 <- "/p/projects/landuse/users/florianh/affbug/release_candidate2/output/val20_SSP5_PkBudg900/fulldata.gdx"
#gdx$val21_SSP5_PkBudg900 <- "/p/projects/landuse/users/florianh/affbug/release_candidate2/output/val21_SSP5_PkBudg900/fulldata.gdx"
#gdx$val21_SSP2_PkBudg900 <- "/p/projects/landuse/users/florianh/affbug/release_candidate2/output/val21_SSP2_PkBudg900/fulldata.gdx"
# gdx$C_SDP_BASE <- "/p/projects/piam/runs/coupled-magpie/output/C_SDP-Base-mag-4/fulldata.gdx"
# gdx$C_SSP1_BASE <- "/p/projects/piam/runs/coupled-magpie/output/C_SSP1-Base-mag-4/fulldata.gdx"
# gdx$C_SSP2_BASE <- "/p/projects/piam/runs/coupled-magpie/output/C_SSP2-Base-mag-4/fulldata.gdx"
# gdx$C_SSP5_BASE <- "/p/projects/piam/runs/coupled-magpie/output/C_SSP5-Base-mag-4/fulldata.gdx"
#gdx$val20_SSP5_PkBudg900 <- "/p/projects/landuse/users/florianh/affbug/release_candidate2/output/val20_SSP5_PkBudg900/fulldata.gdx"
#gdx$val21_SSP1_PkBudg900 <- "/p/projects/landuse/users/florianh/affbug/release_candidate2/output/val21_SSP1_PkBudg900/fulldata.gdx"
gdx$RCP2p6 <- "/p/projects/landuse/users/florianh/projects/paper/peatland/f_peatland4/output/T115_SSP2_RCP2p6_default/fulldata.gdx"
gdx$RCP2p6Prot <- "/p/projects/landuse/users/florianh/projects/paper/peatland/f_peatland4/output/T115_SSP2_RCP2p6+PeatProt_default/fulldata.gdx"
gdx$RCP2p6Restor <- "/p/projects/landuse/users/florianh/projects/paper/peatland/f_peatland4/output/T115_SSP2_RCP2p6+PeatRestor_default/fulldata.gdx"


#costs
lapply(gdx,function(x) {
  costs(x,level="glo",sum=F)[,,]/1000000
})

#2nd gen bio
lapply(gdx,function(x) {
  readGDX(x,"f60_bioenergy_dem_coupling")[,,]
})

#GHG prices
lapply(gdx,function(x) {
  readGDX(x,"f56_pollutant_prices_coupling")[,seq(1995,2020,by=5),]
})


#emis glo differ
lapply(gdx,function(x) {
  round(emisCO2(x,level="glo",unit = "gas",lowpass=3)[,c(2060,2080,2090,2100),])
})

#Total aff area is very similar 
lapply(gdx,function(x) {
  land(x,level="glo")[,c(2060,2080,2090,2100),"forestry"]
})

#emis glo differ cum
lapply(gdx,function(x) {
  round(emisCO2(x,level="glo",unit = "gas",lowpass=3,cumulative = TRUE)[,c(2060,2080,2090,2100),])/1000
})

#emis for tropical regions -> problem in LAM
lapply(gdx,function(x) {
  round(emisCO2(x,level="reg",unit = "gas",lowpass=3)[c("LAM","OAS","SSA"),c(2060,2080,2090,2100),])
})

### some more basic checks
#land
lapply(gdx,function(x) {
  land(x,level="glo")[,c(2060,2080,2090,2100),]
})

#TAU
lapply(gdx,function(x) {
  tau(x,level="glo")[,c(2060,2080,2090,2100),]
})


### Example for LAM

#emis cell LAM
lapply(gdx,function(x) {
  round(emisCO2(x,level="cell",unit = "gas",lowpass=3)[c("LAM.82"),c(2060,2080,2090,2100),])
})

#Total aff area remains constant
lapply(gdx,function(x) {
  round(dimSums(readGDX(x,"p32_land")["LAM.82",c(2060,2080,2090,2100),"aff"],dim=3),2)
})

#but ac0 > 0
lapply(gdx,function(x) {
  round(readGDX(x,"p32_land")["LAM.82",c(2060,2080,2090,2100),"aff.ac0"],2)
})

#which implies that ac50 or greater is moved to ac0
lapply(gdx,function(x) {
  round(dimSums(readGDX(x,"p32_land")["LAM.82",c(2060,2080,2090,2100),"aff"][,,"ac0",invert=TRUE],dim=3),2)
})

#ghg Price
lapply(gdx,function(x) {
  round(PriceGHG(x,level="glo")[,seq(2000,2100,by=5),"co2_c"])
})

# 
# 
# #total v32_land over time glo
# lapply(gdx,function(x) {
#   dimSums(readGDX(x,"ov_dem_bioen", select=list(type="level")),dim=c(1,3))[,c(2010,2015,2020),]
# })
# 
# #total v32_land over time glo
# lapply(gdx,function(x) {
#   dimSums(readGDX(x,"i60_bioenergy_dem", select=list(type="level")),dim=c(1,3))[,c(2010,2015,2020),]
# })
# 
# #total v32_land over time glo
# lapply(gdx,function(x) {
#   dimSums(readGDX(x,"ov_dem_feed", select=list(type="level"))[,c(2010,2015,2020),][,,"pasture",invert=TRUE],dim=c(1,3))
# })
# 
# lapply(gdx,function(x) {
#   dimSums(readGDX(x,"p12_interest")[,c(2010,2015,2020,2050,2060,2070,2080,2090,2100),],dim=c(3))
# })
# 
# lapply(gdx,function(x) {
#   dimSums(readGDX(x,"ov15_income_pc_real_ppp_iso")[,c(2010,2015),"level"],dim=c(1,3))
# })
# 
# lapply(gdx,function(x) {
#   round(readGDX(x,"p12_interest")[,c(1995,2030,2050,2100),],2)#,dim=c(1))[,c(2010,2015,2020),]#*1000000000
# })
# 
# lapply(gdx,function(x) {
#   dimSumreadGDX(x,"ov55_feed_intake", select=list(type="level")),dim=c(1,3))[,c(2010,2015,2020),]
# })
# 
# lapply(gdx,function(x) {
#   dimSums(readGDX(x,"i42_wat_req_k"),dim=c(1,3))[,c(2010,2015,2020),]
# })
# 
# 
# total v32_land over time glo
# lapply(gdx,function(x) {
#   dimSums(readGDX(x,"ov42_irrig_eff", select=list(type="level")),dim=c(1))[,c(2010,2015,2020),]
# })
# 
# 
# 
# #total v32_land over time glo
# lapply(gdx,function(x) {
#   emisCO2(x,level="glo",unit="gas")[,1:10,]
# })
# 
# # 
# # #total v32_land over time glo
# # lapply(gdx,function(x) {
# #   dimSums(readGDX(x,"p32_max_aff_area")[,1,],dim=1)
# # })
# 
# 
# #total v32_land over time glo
# lapply(gdx,function(x) {
#   PriceGHG(x)
# })
# 
# #fix f55_awms_shr
# 
# gdx<-"sdp.gdx"
# a <- readGDX(gdx,"f50_snupe")
# collapseNames(a[,2015,c("neff65_70_starty2010")])-collapseNames(a[,2015,c("neff60_60_starty2010")])
# 
# gdx<-"sdp.gdx"
# a <- readGDX(gdx,"i60_1stgen_bioenergy_dem")
# collapseNames(a[,2015,c("SDP")])-collapseNames(a[,2015,c("SSP2")])
# 
# [,,"livst_pig"]
# 
# 
# vm_dem_material