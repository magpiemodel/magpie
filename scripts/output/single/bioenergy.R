# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

###########################
#### bioenergy outputs ####
###########################
# Version 2.07, Florian Humpenoeder
#
# 2.01, adjusted libraries
# 2.02, added net trade
# 2.03, reactivated water related issues
# 2.04, reactivated rainfed and irrigated yields
# 2.05, changed irrigated area share to total irrigated croparea / LPJ yields for y1995
# 2.06, added global total cost listing
# 2.07, modified so that it also works without bioenergy demand

##########################################################
library(gdx)
library(luscale)
library(luplot)
library(lucode)
library(lusweave)
library(magpie4)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {

  outputdir        <- 'output/'     # title of the run (with date)
  gdx<-path(outputdir,"fulldata.gdx")
  title <- "default"
  #Define arguments that can be read from command line
  readArgs("outputdir","title")
} else{
  gdx<-path(outputdir,"fulldata.gdx")
}
###############################################################################

sw<-swopen(paste(outputdir,"/",title,"_Bioenergy_outputs.pdf",sep=""))
swR(sw,options,magclass.verbosity=1)
years_all <- getYears(modelstat(gdx))

swlatex(sw,"\\huge")
swlatex(sw,"\\textbf{Bioenergy outputs}\\newline")
swlatex(sw,"\\normalsize")
swlatex(sw,"\\newline")
swlatex(sw,"\\tableofcontents")

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Inputs}")


# Food Demand
swlatex(sw,paste("\\subsection{Food Demand}"))
food <- demand(gdx,product_aggr = TRUE, type="Food", level="regglo")
dimnames(food)[[3]]<-paste("Food Demand in mio. t DM")
swfigure(sw,"scratch_plot",food["GLO",,,invert=TRUE][,years_all,],add=TRUE,ylab=dimnames(food)[[3]],sw_option="width=10")
swtable(sw,round(food[,years_all,],0),digits=0,table.placement="H",caption.placement="top",caption=dimnames(food)[[3]],vert.lines=1,align="r",hor.lines=1,transpose=TRUE)

swlatex(sw,paste("\\subsection{Feed Demand}"))
feed <- demand(gdx,product_aggr = TRUE, type="Feed", level="regglo")
dimnames(feed)[[3]]<-paste("Feed Demand in mio. t DM")
swfigure(sw,"scratch_plot",feed["GLO",,,invert=TRUE][,years_all,],add=TRUE,ylab=dimnames(feed)[[3]],sw_option="width=10")
swtable(sw,round(feed[,years_all,],0),digits=0,table.placement="H",caption.placement="top",caption=dimnames(feed)[[3]],vert.lines=1,align="r",hor.lines=1,transpose=TRUE)

# Material Demand
swlatex(sw,"\\newpage")
swlatex(sw,paste("\\subsection{Material Demand}"))
mat <- demand(gdx,product_aggr = TRUE, type="Material", level="regglo")
dimnames(mat)[[3]]<-paste("Material Demand in in mio. t DM")
swfigure(sw,"scratch_plot",mat["GLO",,,invert=TRUE][,years_all,],add=TRUE,ylab=dimnames(mat)[[3]],sw_option="width=10")
swtable(sw,round(mat[,years_all,],0),digits=0,table.placement="H",caption.placement="top",caption=dimnames(mat)[[3]],vert.lines=1,align="r",hor.lines=1,transpose=TRUE)

# Bioenergy demand
swlatex(sw,"\\newpage")
swlatex(sw,paste("\\subsection{Bioenergy Demand (1st \\& 2nd gen.)}"))
sm_biodem_level<-readGDX(gdx,"c60_biodem_level", "sm_biodem_level", format="first_found")
dem <- demand(gdx,product_aggr = TRUE, type="Bioenergy", level="reg", attributes = "ge")
if (sm_biodem_level == 0) dem<-superAggregate(dem,aggr_type="sum",level="glo")
dimnames(dem)[[3]] <- "Bioenergy demand (EJ)"
dem <- dem/1000
swfigure(sw,"scratch_plot",dem[,intersect(years_all,getYears(dem)),],add=TRUE,ylab=dimnames(dem)[[3]],sw_option="width=10")
swtable(sw,round(dem[,intersect(years_all,getYears(dem)),],1),digits=1,table.placement="H",caption.placement="top",caption=dimnames(dem)[[3]],
        vert.lines=1,align="r",hor.lines=1,transpose=TRUE)

# GHG prices
swlatex(sw,"\\newpage")
swlatex(sw,paste("\\subsection{GHG Prices}"))


pol_prices <- readGDX(gdx,"im_pollutant_prices")


swlatex(sw,"\\subsubsection{CO2 price}")
co2_c <- pol_prices[,,"co2_c"]*12/44
dimnames(co2_c)[[3]]<-"CO2 price (US Dollar 2004 per ton CO2)"
swfigure(sw,"scratch_plot",co2_c[,intersect(years_all,getYears(co2_c)),],add=FALSE,ylab=dimnames(co2_c)[[3]],sw_option="width=10")
swtable(sw,round(co2_c[,intersect(years_all,getYears(co2_c)),],0),table.placement="H",caption.placement="top",caption=dimnames(co2_c)[[3]],
        vert.lines=1,align="r",hor.lines=1,digits=0,transpose=TRUE)


#n2o price
swlatex(sw,"\\subsubsection{N2O price}")
n2o_n <- pol_prices[,,"n2o_n_direct"]*28/44
dimnames(n2o_n)[[3]]<-"N2O price (US Dollar 2004 per ton N2O)"
swfigure(sw,"scratch_plot",n2o_n[,intersect(years_all,getYears(n2o_n)),],add=FALSE,ylab=dimnames(n2o_n)[[3]],sw_option="width=10")
swtable(sw,round(n2o_n[,intersect(years_all,getYears(n2o_n)),],0),table.placement="H",caption.placement="top",caption=dimnames(n2o_n)[[3]],
        vert.lines=1,align="r",hor.lines=1,digits=0,transpose=TRUE)

#ch4 price
swlatex(sw,"\\subsubsection{CH4 price}")
ch4 <- pol_prices[,,"ch4"]
dimnames(ch4)[[3]]<-"CH4 price (US Dollar 2004 per ton CH4)"
swfigure(sw,"scratch_plot",ch4[,intersect(years_all,getYears(ch4)),],add=FALSE,ylab=dimnames(ch4)[[3]],sw_option="width=10")
swtable(sw,round(ch4[,intersect(years_all,getYears(ch4)),],0),table.placement="H",caption.placement="top",caption=dimnames(ch4)[[3]],
        vert.lines=1,align="r",hor.lines=1,digits=0,transpose=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{MAgPIE outputs}")

# croparea
swlatex(sw,"\\subsection{Croparea}")
crop_area <- croparea(gdx,level="reg")
bioenergy_area <- croparea(gdx,level="reg",products=c("begr","betr"))
other_crop_area <- as.magpie(crop_area-bioenergy_area)
dimnames(bioenergy_area)[[3]]<-"Bioenergy area mio ha"
dimnames(other_crop_area)[[3]]<-"Other crop area mio ha"
bioenergy_area_glo <- colSums(bioenergy_area)
other_crop_area_glo <- colSums(other_crop_area)
dimnames(bioenergy_area_glo)[[1]]<-"GLO"
dimnames(other_crop_area_glo)[[1]]<-"GLO"
bioenergy_area <- mbind(bioenergy_area,bioenergy_area_glo)
other_crop_area <- mbind(other_crop_area,other_crop_area_glo)
all<-mbind(other_crop_area,bioenergy_area)
swfigure(sw,"scratch_plot",all["GLO",,,invert=TRUE][,years_all,],add=TRUE,ylab="croparea mio. ha",sw_option="width=10")
swtable(sw,round(dimSums(all[,years_all,],dim=3),2),table.placement="H",caption.placement="top",caption="Total crop area mio.ha",vert.lines=1,
        align="r",hor.lines=1,digits=0,transpose=TRUE)
swtable(sw,round(all[,years_all,2]),table.placement="H",caption.placement="top",caption=dimnames(bioenergy_area)[[3]],vert.lines=1,align="r",
        hor.lines=1,digits=0,transpose=TRUE)
swtable(sw,round(all[,years_all,1]),table.placement="H",caption.placement="top",caption=dimnames(other_crop_area)[[3]],vert.lines=1,align="r",
        hor.lines=1,digits=0,transpose=TRUE)

# Bioenergy production
swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Bioenergy production (2nd gen.)}")
all <- production(gdx,products=c("begr","betr"),product_aggr=FALSE,level="regglo",attributes="ge")/1000
swfigure(sw,"scratch_plot",all["GLO",,,invert=TRUE][,years_all,],add=TRUE,ylab="Bioenergy production (EJ)",sw_option="width=10")
swtable(sw,round(dimSums(all[,years_all,],dim=3),2),table.placement="H",caption.placement="top",caption="Total bioenergy production (EJ)",
        vert.lines=1,align="r",hor.lines=1,transpose=TRUE)
swtable(sw,round(all[,years_all,"betr"],2),table.placement="H",caption.placement="top",caption="betr production (EJ)",
        vert.lines=1,align="r",hor.lines=1,transpose=TRUE)
swtable(sw,round(all[,years_all,"begr"],2),table.placement="H",caption.placement="top",caption="begr production (EJ)",
        vert.lines=1,align="r",hor.lines=1,transpose=TRUE)

# landuse pattern
pre <- readGDX(gdx,"o90_land", format="first_found", react = "silent")
if(!is.null(pre)) {
  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsection{Land-use pattern}")
  main <- land(gdx)
  pre <- superAggregate(dimSums(pre,dim=3.2),aggr_type="sum",level="reg")
  swfigure(sw,alloc_plot,main,title="Main | Total land (si0+nsi0 | regional)",fig.orientation="landscape")
  swfigure(sw,alloc_plot,pre,title="Presolve | Total land (si0+nsi0 | regional)",fig.orientation="landscape")
  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsection{Land-use change}")
  bioen_pos <- main-pre
  bioen_pos[bioen_pos < 0] <- 0
  swfigure(sw,alloc_plot,bioen_pos,title="Positive land-use change due to 2nd gen. bioenergy prod",fig.orientation="landscape")
  bioen_neg <- main-pre
  bioen_neg[bioen_neg > 0] <- 0
  swfigure(sw,alloc_plot,bioen_neg,title="Negative land-use change due to 2nd gen. bioenergy prod",fig.orientation="landscape")
} else {
  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsection{Land-use pattern}")
  main <- land(gdx)
  swfigure(sw,alloc_plot,dimSums(main,dim=1),title="Total land (si0+nsi0 | global)",fig.orientation="landscape")
  swfigure(sw,alloc_plot,main,title="Total land (si0+nsi0 | regional)",fig.orientation="landscape")
}

#costs
swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Costs - regional}")
costs <- readGDX(gdx,"ov_cost_reg", format="first_found", select=list(type="level"))/1000
costs <- mbind(costs,dimSums(costs,dim=1))
swoutput(sw,costs[,years_all,],"bill. US Dollar",geom="bar",stack=T,color=NULL,facet_x=NULL,stat="sum",scenario=title,plot_level="reg")

#other crops
pre_costs <- readGDX(gdx,"o90_cost_reg", format="first_found", react="silent")
if(!is.null(pre_costs)) {
  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsubsection{Costs|Bioenergy}")
  costs <- (readGDX(gdx,"ov_cost_reg", format="first_found", select=list(type="level")) - readGDX(gdx,"o90_cost_reg",  format="first_found"))/1000
  costs <- mbind(costs,dimSums(costs,dim=1))
  swoutput(sw,costs[,years_all,],"bill. US Dollar",geom="bar",stack=T,color=NULL,facet_x=NULL,stat="sum",scenario=title,plot_level="reg")

  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsubsection{Costs|Other crops}")
  costs <- readGDX(gdx,"o90_cost_reg", format="first_found")/1000
  costs <- mbind(costs,dimSums(costs,dim=1))
  swoutput(sw,costs[,years_all,],"bill. US Dollar",geom="bar",stack=T,color=NULL,facet_x=NULL,stat="sum",scenario=title,plot_level="reg")
}



#cost listing
swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Cost listing - global}")

all <- costs(gdx, sum=FALSE,level="glo")
all <- round(all)/1000
swoutput(sw,all[,years_all,],"bill. US Dollar",table=F,geom="bar",stack=T,fill="Data1",color=NULL,stat="sum",labs=c("","Cost Type"),scenario=title)
swtable(sw,round(all[,years_all,],2),table.placement="H",caption.placement="top",caption="Cost listing (bill. US Dollar)",
        vert.lines=1,align="r",hor.lines=1,digits=0,transpose=TRUE)



# Bioenergy prices: MAgPIE
if(!all(croparea(gdx,products=c("begr","betr")) == 0)){
  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsection{Bioenergy prices: MAgPIE}")
  all<-prices(gdx,products=c("begr","betr"),level="regglo",attributes="ge",product_aggr=TRUE)
  getNames(all) <- "price"
  swfigure(sw,"scratch_plot",all["GLO",,,invert=TRUE][,years_all,],add=FALSE,ylab="Bioenergy prices ($2005/GJ)",sw_option="width=10")
  swtable(sw,round(all[,years_all,],2),table.placement="H",caption.placement="top",caption="MAgPIE bioenergy prices (US dollar / GJ)",
          vert.lines=1,align="r",hor.lines=1,transpose=TRUE)
}
# Bioenergy prices: ReMIND vs. MAgPIE
remind_prices<-path(outputdir,"bioenergy_priceemu_purpose_reg.rem.csv")
if (file.exists(remind_prices)) {
  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsection{Bioenergy prices: ReMIND vs. MAgPIE (one diagram)}")
  remind<-read.magpie(remind_prices)
  magpie<-prices(gdx,crops=c("begr","betr"),crop_aggr=TRUE,level="reg",unit="GJ")
  dimnames(remind)[[3]]<-"ReMIND"
  dimnames(magpie)[[3]]<-"MAgPIE"
  remind <- time_interpolate(remind,getYears(magpie))
  all<-mbind(magpie,remind)
  swfigure(sw,"scratch_plot",all[,years_all,],add=FALSE,ylab="Bioenergy prices ($2005/GJ)",sw_option="width=10")
  swtable(sw,round(remind[,years_all,],2),table.placement="H",caption.placement="top",caption="ReMIND Bioenergy prices (US dollar / GJ)",
          vert.lines=1,align="r",hor.lines=1,transpose=TRUE)
  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsection{Bioenergy prices: ReMIND vs. MAgPIE (regional diagrams)}")
  for (i in getRegions(all)) {
    swfigure(sw,"scratch_plot",all[i,years_all,],large=TRUE,ylab="Bioenergy prices ($2005/GJ)")
  }
}
if(!all(croparea(gdx, products=c("begr","betr")) == 0)){
  # Bioenergy Yields
  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsection{Bioenergy Yields}")
  if(!all(is.na(yields(gdx, products=c("begr","betr"), level="regglo", product_aggr=FALSE, water_aggr=FALSE)[,,"irrigated",drop=TRUE]))) {
    swlatex(sw,"\\subsubsection{rainfed and irrigated}")
    yld <- yields(gdx, products=c("begr","betr"), level="regglo", product_aggr=FALSE)
    swfigure(sw,"scratch_plot",yld["GLO",,,invert=TRUE][,years_all,],ylab="Bioenergy yields t/ha - rf and ir",sw_option="width=10")
    swlatex(sw,"\\newpage")
    for (i in dimnames(yld)[[3]]) {
      swtable(sw,round(yld[,years_all,i],2),table.placement="H",caption.placement="top",caption=paste(i," yields t/ha - rf and ir"),vert.lines=1,align="r",hor.lines=1,transpose=TRUE)
    }
    swlatex(sw,"\\newpage")
    swlatex(sw,"\\subsubsection{rainfed only}")
    yld <- yields(gdx, products=c("begr","betr"), level="regglo", product_aggr=FALSE, water_aggr=FALSE)[,,"rainfed",drop=TRUE]
    swfigure(sw,"scratch_plot",yld["GLO",,,invert=TRUE][,years_all,],ylab="Bioenergy yields t/ha - rf",sw_option="width=10")

    swlatex(sw,"\\newpage")
    for (i in dimnames(yld)[[3]]) {
      swtable(sw,round(yld[,years_all,i],2),table.placement="H",caption.placement="top",caption=paste(i," yields t/ha - rf"),vert.lines=1,align="r",hor.lines=1,transpose=TRUE)
    }
    swlatex(sw,"\\newpage")
    swlatex(sw,"\\subsubsection{irrigated only}")
    yld <- yields(gdx, products=c("begr","betr"), level="regglo", product_aggr=FALSE, water_aggr=FALSE)[,,"irrigated",drop=TRUE]
    swfigure(sw,"scratch_plot",yld["GLO",,,invert=TRUE][,years_all,],ylab="Bioenergy yields t/ha - ir",sw_option="width=10")

    swlatex(sw,"\\newpage")
    for (i in dimnames(yld)[[3]]) {
      swtable(sw,round(yld[,years_all,i],2),table.placement="H",caption.placement="top",caption=paste(i," yields t/ha - ir"),vert.lines=1,align="r",hor.lines=1,transpose=TRUE)
    }
  } else {
    swlatex(sw,"\\subsubsection{rainfed only}")
    yld <- yields(gdx, products=c("begr","betr"), level="regglo", product_aggr=FALSE, water_aggr=FALSE)[,,"rainfed",drop=TRUE]
    swfigure(sw,"scratch_plot",yld["GLO",,,invert=TRUE][,years_all,],ylab="Bioenergy yields t/ha - rf",sw_option="width=10")

    swlatex(sw,"\\newpage")
    for (i in dimnames(yld)[[3]]) {
      swtable(sw,round(yld[,years_all,i],2),table.placement="H",caption.placement="top",caption=paste(i," yields t/ha - rf"),vert.lines=1,align="r",hor.lines=1,transpose=TRUE)
    }
  }
}

# Irrigated bioenergy area
swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Irrigated bioenergy area}")
swlatex(sw,"\\subsubsection{Absolut value (mio. ha)}")
kbe <- croparea(gdx,level="reg",products=c("begr","betr"),water_aggr=FALSE)[,,"irrigated"]
swfigure(sw,scratch_plot,kbe[,years_all,],add=TRUE,ylab="Irrigated bioenergy area (mio. ha)",sw_option="width=10")
all <- croparea(gdx,level="regglo",products=c("begr","betr"),water_aggr=FALSE)[,,"irrigated"]
swtable(sw,round(all[,years_all,],2),table.placement="H",caption.placement="top",caption="Irrigated bioenergy area (mio. ha)",vert.lines=1,align="r",
        hor.lines=1,digits=2,transpose=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Share (in terms of total croparea)}")
kbe <- croparea(gdx,level="regglo",products=c("begr","betr"),water_aggr=FALSE)[,,"irrigated"]
crop_area <- croparea(gdx,level="regglo")
ratio <- kbe/crop_area*100
dimnames(ratio)[[3]] <- "Bioenergy irrigated area percentage"
swfigure(sw,scratch_plot,ratio[,years_all,],add=FALSE,ylab=dimnames(ratio)[[3]],sw_option="width=10")
swtable(sw,round(ratio[,years_all,],2),table.placement="H",caption.placement="top",caption="Bioenergy irrigated area percentage (in terms of total croparea)",
        vert.lines=1,align="r",hor.lines=1,digits=2,transpose=TRUE)


#Bioenergy water usage
swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Bioenergy water usage}")
water_reg <- water_usage(gdx,level="reg",users=c("begr","betr"),sum=FALSE)
water_reg <- as.magpie(water_reg/1000)
swfigure(sw,scratch_plot,water_reg[,years_all,],add=TRUE,ylab="Bioenergy Water usage (bill. cubic metre/yr)",sw_option="width=10")
water_glo <- water_usage(gdx,level="glo",users=c("begr","betr"),sum=FALSE)
water_glo <- as.magpie(water_glo/1000)
water <- mbind(water_reg,water_glo)
swtable(sw,round(rowSums(water[,years_all,],dim=2),2),table.placement="H",caption.placement="top",
        caption="Total bioenergy water usage (bill. cubic metre/yr)",vert.lines=1,align="r",hor.lines=1,transpose=TRUE)
swtable(sw,round(water[,years_all,"betr"],2),table.placement="H",caption.placement="top",
        caption="betr water usage (bill. cubic metre/yr)",vert.lines=1,align="r",hor.lines=1,transpose=TRUE)
swtable(sw,round(water[,years_all,"begr"],2),table.placement="H",caption.placement="top",
        caption="begr water usage (bill. cubic metre/yr)",vert.lines=1,align="r",hor.lines=1,transpose=TRUE)



# C emissions
swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{C emissions}")
swlatex(sw,"\\subsubsection{Annual}")
if (cfg$gms$presolve == "on") {
  pre_reg <- dimSums(readGDX(gdx,"o90_emissions_reg", format="first_found"),dim=3.1)
  main_reg <- setNames(emisCO2(gdx,level="reg")[,1995,,invert=TRUE],"All crops")
  pre_reg <- setNames(collapseNames(pre_reg[,,"co2_c"])[,getYears(main_reg),],"Other crops")
  bioen_reg <- setNames(main_reg - pre_reg,"Bioenergy")
  all_reg <- mbind(pre_reg,bioen_reg)
  all <- mbind(all_reg,dimSums(all_reg,dim=1))
  swoutput(sw,all,unit="Mt C",geom="bar",stack=T,facet_x=NULL,color=NULL,stat="sum",alpha="Data1",labs=c("","Region","","LUC emissions"),plot_level="reg",digits=2)
} else {
  all <- emisCO2(gdx,level="regglo")[,1995,,invert=TRUE]
  swoutput(sw,all,unit="Mt C",geom="bar",stack=T,facet_x=NULL,color=NULL,stat="sum",plot_level="reg",digits=2)
}

# C emissions cumulative
swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Cumulative}")
all <-  emisCO2(gdx,level="regglo",cumulative=TRUE)[,1995,,invert=TRUE]/1000
swoutput(sw,all,unit="Gt C (1995=0)",stack=T,geom="bar",fill="Region",color=NULL,facet_x=NULL,stat="sum",asDate=T,plot_level="reg",digits=2)



# TC
swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{TC}")
tc_reg<-tc(gdx,level="reg")
tc_glo<-tc(gdx,level="glo")
tc_all<-mbind(tc_reg[,years_all,], tc_glo[,years_all,])
getNames(tc_all) <- "tc"
swfigure(sw,"scratch_plot",tc_all[,2:length(years_all),],ylab="Annual TC rates",sw_option="width=10")
swtable(sw,round(tc_all[,2:length(years_all),],3),table.placement="H",caption.placement="top",caption="Annual TC rates",vert.lines=1,align="r",hor.lines=1,
        digits=3,transpose=TRUE)


# Net trade food, feedstock and livestock
swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Net trade food, feedstock and livestock (kfo + foddr + kli)}")
swlatex(sw,"Net trade = production - demand\\newline Net trade > 0: Export\\newline Net trade < 0: Import")
kfo_foddr_kli<-c("tece", "trce", "maiz", "rice_pro", "others", "potato", "cassav_sp",
                 "puls_pro", "soybean", "rapeseed", "groundnut", "sunflower",
                 "oilpalm", "sugr_beet", "sugr_cane", "foddr", "livst_rum", "livst_pig", "livst_chick", "livst_egg", "livst_milk")
demand <- readGDX(gdx,"ov_supply", format="first_found")[,,kfo_foddr_kli][,,"level"]
demand <- dimSums(collapseNames(demand),dim=3)
prod<-readGDX(gdx,"ov_prod_reg", format="first_found")[,,kfo_foddr_kli][,,"level"]
prod <- dimSums(collapseNames(prod),dim=3)
trade <- as.magpie(prod-demand)
dimnames(trade)[[3]] <- "Net trade"
swfigure(sw,"scratch_plot",trade,ylab="Net trade (mil. tons DM)",sw_option="width=10")
swtable(sw,round(trade,0),table.placement="H",caption.placement="top",caption="Net trade (mil. tons DM)",vert.lines=1,align="r",hor.lines=1,digits=0,transpose=TRUE)


#Food price indices kfo,kli
if (any(!is.na(priceIndex(gdx)))) {
  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsection{Food Price Index}")
  swlatex(sw,"Laspeyres-Index: baseyear weighting; shows the development of prices for a fixed basket\\newline")
  fpi_kfo_lasp <- priceIndex(gdx,level="regglo",products="kfo",index="lasp",baseyear = 1995)
  swoutput(sw,fpi_kfo_lasp,unit="Index - 1995=100",facet_x=NULL,color="Region",plot=T,table=T)
}

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Food crop yields}")

# Tece Yields
swlatex(sw,"\\subsubsection{Tece Yields}")
yld <- yields(gdx,products="tece",level="regglo")
getNames(yld) <-"Yield t/ha"
swfigure(sw,"scratch_plot",yld[,years_all,],ylab="Tece yields t/ha",height=15,sw_option="width=10")
swtable(sw,round(yld[,years_all,],2),table.placement="H",caption.placement="top",caption="Tece yields t/ha",vert.lines=1,align="r",hor.lines=1,transpose=TRUE)

# Maiz Yields
swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Maiz Yields}")
yld <- yields(gdx,products="maiz",level="regglo")
getNames(yld) <- "Yield t/ha"
swfigure(sw,"scratch_plot",yld[,years_all,],ylab="Maiz yields t/ha",height=15,sw_option="width=10")
swtable(sw,round(yld[,years_all,],2),table.placement="H",caption.placement="top",caption="Maiz yields t/ha",vert.lines=1,align="r",hor.lines=1,transpose=TRUE)

swclose(sw)
