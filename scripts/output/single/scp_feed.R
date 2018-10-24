# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


library(gdx)
library(magclass)
library(magpie4)
library(lucode)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {

  gdx    <-'fulldata.gdx'
  output_folder        <- 'output/SSP5_Baseline'
  output_folder        <- 'output/ssp5_sugar_cons__2016-01-28_18.39.43'
  gdx<-path(output_folder,"fulldata.gdx")
  title <- "TEST"

  #Define arguments that can be read from command line
  readArgs("gdx_file","output_folder","title")
} else{
  output_folder<-outputdir
  gdx<-path(outputdir,"fulldata.gdx")
}
print("---")
print(paste0("Starting SCP report for ",title))
###############################################################################





library(magpiesets)



kcr<-readGDX(gdx,"kcr")
kli<-readGDX(gdx,"kli")
cereals<-findset("cereals")
conc<-setdiff(kcr,c(cereals,"foddr"))
attributes<-readGDX(gdx,"im_attributes_harvest")[,,c("dm","nr")]
attributes<-readGDX(gdx,"im_attributes_harvest")[,,c("dm","nr")]
attributes_kcr<-attributes[,,kcr]
attributes_pasture<-attributes[,,"pasture"]
attributes_scp<-readGDX(gdx,"fm_attributes_scp")[,,c("dm","nr")]
attributes_kli<-readGDX(gdx,"f55_attributes_livstproducts")[,,c("dm","nr")]
feed<-collapseNames(readGDX(gdx,"ov_dem_feed")[,,"level"])
feed_convby<-collapseNames(readGDX(gdx,"ov_convby_feed")[,,"level"])[,,c("dm","nr")]
feed_res<-collapseNames(readGDX(gdx,"ov_res_use_feed")[,,"level"])[,,c("dm","nr")]
scav<-collapseNames(readGDX(gdx,"fm_scavenging_1995"))

feed_pasture <-add_dimension(dimSums((feed[,,"pasture"]+scav)*attributes_pasture,dim=3.2),dim = 3.1,add = "feed",nm="Grazing")
feed_conc    <-add_dimension(dimSums(feed[,,conc]*attributes_kcr[,,conc],dim=3.2),dim = 3.1,add = "feed",nm="Other concentrates")
feed_foddr   <-add_dimension(dimSums(feed[,,"foddr"]*attributes_kcr[,,"foddr"],dim=3.2),dim = 3.1,add = "feed",nm="Forage")
feed_cer     <-add_dimension(dimSums(feed[,,cereals]*attributes_kcr[,,cereals],dim=3.2),dim = 3.1,add = "feed",nm="Cereals")
feed_scp     <-add_dimension(dimSums(feed[,,"scp"]*attributes_scp,dim=3.2),dim = 3.1,add = "feed",nm="Microbial Protein")
feed_convby  <-add_dimension(feed_convby,dim = 3.1,add = "feed",nm="Conversion Byproducts")
feed_res     <-add_dimension(feed_res,dim = 3.1,add = "feed",nm="Crop residues")
feed_food    <-add_dimension(add_dimension(collapseNames(feed[,,"non_eaten_food"]),dim=3.2,add="attributes",nm="dm"),dim = 3.1,add = "feed",nm="Non eaten food")
feed_food    <-add_columns(feed_food,addnm = "nr",dim = 3.3)
feed_food[,,"nr"]<-feed_food[,,"dm"]*0.02 # based on wirsenius


kli2<-paste0(kli,2)
feed2<-feed
getNames(feed2,dim=2)<-paste0(getNames(feed2,dim=2),"2")
feed2<-feed2[,,kli2]
attributes_kli2<-attributes_kli
getNames(attributes_kli2)<-paste0(getNames(attributes_kli2),2)
feed_kli     <-add_dimension(dimSums(feed2[,,kli2]*attributes_kli2,dim=3.2),dim = 3.1,add = "feed",nm="Animal Feed")


out<-mbind(feed_scp,feed_cer)
out<-mbind(out,feed_convby)
out<-mbind(out,feed_conc)
out<-mbind(out,feed_foddr)
out<-mbind(out,feed_res)
out<-mbind(out,feed_kli)
out<-mbind(out,feed_pasture)
out<-mbind(out,feed_food)
out<-mbind(out,colSums(out))
out<-as.magpie(aperm(unwrap(out),perm = c(1,2,4,3,5)))
tmp<-dimSums(out,dim=3.1)
out<-add_columns(out,addnm = "livst_all",dim = 3.1)
out[,,"livst_all"]<-tmp

out2<-round(out,4)[,c("y2005","y2050")]
write.magpie(collapseNames(out2[,,"nr"]),file_name = "feed_nr.csv",file_type = "cs3")
out3<-round(out,2)[,c("y2005","y2050")]
write.magpie(collapseNames(out3[,,"dm"]),file_name = "feed_dm.csv",file_type = "cs3")

products<-collapseNames(readGDX(gdx,"ov_prod_reg")[,,"level"][,,kli])*attributes_kli
products<-mbind(products,colSums(products))
tmp<-dimSums(products,dim=3.1)
products<-add_columns(products,addnm = "livst_all",dim = 3.1)
products[,,"livst_all"]<-tmp

fbask<-out/products
fbask2<-round(fbask,2)[,c("y2005","y2050")]

#write report
write.report(fbask2,file=path("output/scp_feed_jun16.csv"),scenario=title,model="MAgPIE",append=TRUE)

print(paste0("Finished SCP report for ",title))
print("---")
