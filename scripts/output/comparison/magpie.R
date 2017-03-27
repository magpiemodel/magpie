# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

####################################
#### MAgPIE scenario comparison ####
####################################
# Version 1.0, Florian Humpenoeder
#

library(ludata)
library(luplot)
library(lusweave)
library(magpie4)
library(lucode)
library(validation)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdirs <- c("output/Reference")
  xlim <- c(2000,2100)        # limits for x-axis in years
  titles <- c("Reference")        # Titles for the runs
  filename <- paste("./output/MAgPIE_comparison_",basename(getwd()),".pdf",sep="")
  #Define arguments that can be read from command line
  readArgs("outputdirs","xlim","titles","filename")
}
###############################################################################
#xlim <- c(2000,2100)        # limits for x-axis in years

pointwidth <- 1.5
ncol <- 4

gdx <- list()
title_list <- list()

print("Starting data preparation")
for (i in 1:length(outputdirs)) {
  #title of the run
  if(file.exists(path(outputdirs[i],"config.Rdata"))) {
    load(path(outputdirs[i],"config.Rdata"))
    if (exists("titles")) title <- titles[i] else title <- cfg$title
    gms      <- cfg$gms
    title_list[[title]] <- title
  } else {
    config <- grep("\\.cfg$",list.files(outputdirs[i]), value=TRUE)
    l<-readLines(path(outputdirs[i],config))
    if (exists("titles")) title <- titles[i] else title <- strsplit(grep("title +<-",l,value=TRUE),"\"")[[1]][2]
    gms <- list()
    gms$scenarios <- strsplit(grep("(cfg\\$|)gms\\$scenarios +<-",l,value=TRUE),"\"")[[1]][2]
    title_list[[title]] <- title
  }
  gdx[[title]] <- path(outputdirs[i],"fulldata.gdx")
}

t <- lapply(lapply(gdx,modelstat),getYears,as.integer=TRUE)
#t <- sort(Reduce(union,t))
if (exists("xlim")) {
  if(is.vector(xlim)) t <- lapply(t,function(x,xlim) x[c(head(which(x>=xlim[1]),n=1):tail(which(x<=xlim[2]),n=1))],xlim=xlim)
} else xlim=NULL
baseyear <- min(mapply(min,t))

if (!exists("filename")) filename <- paste("./output/MAgPIE_comparison_",basename(getwd()),".pdf",sep="")


print("Starting output generation")
sw<-swopen(filename)
swlatex(sw,"\\huge")
swlatex(sw,"\\textbf{MAgPIE scenario comparison}\\newline")
swlatex(sw,"\\normalsize")
swlatex(sw,"\\newline")
swlatex(sw,"\\tableofcontents")

#Population

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Population}")
reg <- lapply(gdx,readGDX,"i16_pop","f16_pop",format="first_found")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
swoutput(sw,all,unit="Million People",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=0,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

#GDP

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{GDP per capita}")
reg <- lapply(gdx,readGDX,"im_gdp_pc","fm_gdp_pc",format="first_found")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
swoutput(sw,reg,unit="MER (US Dollar 2005)",facet_x="Scenario",color="Region",digits=0,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

### new demand
k <- setdiff(as.matrix(readGDX(gdx[[1]],"k", format="first_found")),"foddr")
kcr <- setdiff(as.matrix(readGDX(gdx[[1]],"kcr", format="first_found")),"foddr")
kfo <- c(as.matrix(readGDX(gdx[[1]],"kfo", format="first_found")))
kli <- c(as.matrix(readGDX(gdx[[1]],"kli", format="first_found")))
kbe <- c("betr","begr")

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Ag. Demand (Mt DM)}")
dem <- mapply(function(a,b,c,d,e) a+b+c+d+e,
              lapply(lapply(gdx,readGDX,"im_dem_food",format="first_found"),function(x) dimSums(x[,,c(k)],dim=3.1)),
              lapply(lapply(gdx,readGDX,"im_dem_material",format="first_found"),function(x) dimSums(x[,,c(k)],dim=3.1)),
              lapply(lapply(gdx,readGDX,"ov_dem_feed",format="first_found",select=list(kbio=c(kcr,kli),type="level")),dimSums,dim=c(3.1,3.2)),
              lapply(lapply(gdx,readGDX,"ov_dem_bioen",format="first_found",select=list(type="level")),function(x) dimSums(x[,,c(kfo,kbe)],dim=3.1)),
              lapply(mapply("*",lapply(gdx,readGDX,"ov_prod_reg",format="first_found",select=list(type="level")),
                            lapply(gdx,readGDX,"fm_seed_shr",format="first_found"),
                            SIMPLIFY = FALSE),dimSums,dim=3.1),
              SIMPLIFY = FALSE)
swoutput(sw,dem,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\subsection{Food}")
x <- lapply(lapply(gdx,readGDX,"im_dem_food",format="first_found"),function(x) dimSums(x[,,c(kfo,kli)],dim=3.1))
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Food|Crops}")
x <- lapply(lapply(gdx,readGDX,"im_dem_food",format="first_found"),function(x) dimSums(x[,,c(kfo)],dim=3.1))
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Food|Livestock}")
x <- lapply(lapply(gdx,readGDX,"im_dem_food",format="first_found"),function(x) dimSums(x[,,c(kli)],dim=3.1))
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)


swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Non-Food}")
a <- lapply(lapply(gdx,readGDX,"im_dem_material",format="first_found"),function(x) dimSums(x[,,c(k)],dim=3.1))
b <- lapply(mapply("*",lapply(lapply(gdx,readGDX,"ov_prod_reg",format="first_found",select=list(type="level")),function(x) x[,,setdiff(k,kbe)]),
                   lapply(lapply(gdx,readGDX,"fm_seed_shr",format="first_found"),function(x) x[,,setdiff(k,kbe)]),
                   SIMPLIFY = FALSE),dimSums,dim=3.1)
x <- mapply("+",a,b,SIMPLIFY = FALSE)
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Non-Food|Crops}")
a <- lapply(lapply(gdx,readGDX,"im_dem_material",format="first_found"),function(x) dimSums(x[,,c(kcr)],dim=3.1))
b <- lapply(mapply("*",lapply(lapply(gdx,readGDX,"ov_prod_reg",format="first_found",select=list(type="level")),function(x) x[,,setdiff(kcr,kbe)]),
                   lapply(lapply(gdx,readGDX,"fm_seed_shr",format="first_found"),function(x) x[,,setdiff(kcr,kbe)]),
                   SIMPLIFY = FALSE),dimSums,dim=3.1)
x <- mapply("+",a,b,SIMPLIFY = FALSE)
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Non-Food|Livestock}")
a <- lapply(lapply(gdx,readGDX,"im_dem_material",format="first_found"),function(x) dimSums(x[,,c(kli)],dim=3.1))
b <- lapply(mapply("*",lapply(lapply(gdx,readGDX,"ov_prod_reg",format="first_found",select=list(type="level")),function(x) x[,,kli]),
                   lapply(lapply(gdx,readGDX,"fm_seed_shr",format="first_found"),function(x) x[,,kli]),
                   SIMPLIFY = FALSE),dimSums,dim=3.1)
x <- mapply("+",a,b,SIMPLIFY = FALSE)
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Feed}")
x <- lapply(lapply(gdx,readGDX,"ov_dem_feed",format="first_found",select=list(kbio=c(kcr,kli),type="level")),dimSums,dim=c(3.1,3.2))
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Feed|Crops}")
x <- lapply(lapply(gdx,readGDX,"ov_dem_feed",format="first_found",select=list(kbio=c(kcr),type="level")),dimSums,dim=c(3.1,3.2))
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Feed|Livestock}")
x <- lapply(lapply(gdx,readGDX,"ov_dem_feed",format="first_found",select=list(kbio=c(kli),type="level")),dimSums,dim=c(3.1,3.2))
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)


swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Bioenergy}")
a <- lapply(lapply(gdx,readGDX,"ov_dem_bioen",format="first_found",select=list(type="level")),function(x) dimSums(x[,,c(kfo,kbe)],dim=3.1))
b <- lapply(mapply("*",lapply(lapply(gdx,readGDX,"ov_prod_reg",format="first_found",select=list(type="level")),function(x) x[,,kbe]),
                   lapply(lapply(gdx,readGDX,"fm_seed_shr",format="first_found"),function(x) x[,,kbe]),
                   SIMPLIFY = FALSE),dimSums,dim=3.1)
x <- mapply("+",a,b,SIMPLIFY = FALSE)
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Bioenergy|1st generation}")
x <- lapply(lapply(gdx,readGDX,"ov_dem_bioen",format="first_found",select=list(type="level")),function(x) dimSums(x[,,c(kfo)],dim=3.1))
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Bioenergy|2nd generation}")
a <- lapply(lapply(gdx,readGDX,"ov_dem_bioen",format="first_found",select=list(type="level")),function(x) dimSums(x[,,c(kbe)],dim=3.1))
b <- lapply(mapply("*",lapply(lapply(gdx,readGDX,"ov_prod_reg",format="first_found",select=list(type="level")),function(x) x[,,kbe]),
                   lapply(lapply(gdx,readGDX,"fm_seed_shr",format="first_found"),function(x) x[,,kbe]),
                   SIMPLIFY = FALSE),dimSums,dim=3.1)
x <- mapply("+",a,b,SIMPLIFY = FALSE)
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)


### new production

kcr <- setdiff(as.matrix(readGDX(gdx[[1]],"kcr", format="first_found")),"foddr")
kli <- c(as.matrix(readGDX(gdx[[1]],"kli", format="first_found")))
kbe <- c("betr","begr")
k_non_energy <- setdiff(kcr,kbe)

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Ag. Production (Mt DM)}")
prod <- lapply(lapply(gdx,readGDX,"ov_prod_reg",format="first_found",select=list(type="level")),function(x) dimSums(x[,,c(kcr,kli)],dim=3.1))
swoutput(sw,prod,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Non-Energy Crops (Mt DM)}")
x <- lapply(lapply(gdx,readGDX,"ov_prod_reg",format="first_found",select=list(type="level")),function(x) dimSums(x[,,k_non_energy],dim=3.1))
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Livestock (Mt DM)}")
x <- lapply(lapply(gdx,readGDX,"ov_prod_reg",format="first_found",select=list(type="level")),function(x) dimSums(x[,,kli],dim=3.1))
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Energy Crops (Mt DM)}")
x <- lapply(lapply(gdx,readGDX,"ov_prod_reg",format="first_found",select=list(type="level")),function(x) dimSums(x[,,kbe],dim=3.1))
swoutput(sw,x,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

#Net Trade = prod - demand
prod_reg <- lapply(lapply(gdx,inp,"ov_prod_reg"),function(x) as.magpie(x[,,,"level"]))
prod_glo <- lapply(prod_reg,dimSums,dim=1)
prod <- mapply(mbind,prod_reg,prod_glo,SIMPLIFY=F)

dem_reg <- lapply(lapply(gdx,inp,"ov_supply"),function(x) as.magpie(x[,,,"level"]))
dem_glo <- lapply(dem_reg,dimSums,dim=1)
dem <- mapply(mbind,dem_reg,dem_glo,SIMPLIFY=F)

trade <- mapply("-",prod,dem,SIMPLIFY = FALSE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Net trade (Mt DM)}")
swlatex(sw,"\\subsection{Food crops}")
swlatex(sw,"Net trade = production - demand\\newline Net trade > 0: Export\\newline Net trade < 0: Import")
sel <- inp(gdx[[1]],"kfo")
all <- lapply(trade,function(x) dimSums(x[,,sel],dim=3.1))
swoutput(sw,all,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Livestock}")
swlatex(sw,"Net trade = production - demand\\newline Net trade > 0: Export\\newline Net trade < 0: Import")
sel <- inp(gdx[[1]],"kli")
all <- lapply(trade,function(x) dimSums(x[,,sel],dim=3.1))
swoutput(sw,all,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Feed}")
swlatex(sw,"Net trade = production - demand\\newline Net trade > 0: Export\\newline Net trade < 0: Import")
sel <- "foddr"
all <- lapply(trade,function(x) dimSums(x[,,sel],dim=3.1))
swoutput(sw,all,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{2nd gen. Bioenergy}")
swlatex(sw,"Net trade = production - demand\\newline Net trade > 0: Export\\newline Net trade < 0: Import")
sel <- c("begr","betr")
all <- lapply(trade,function(x) dimSums(x[,,sel],dim=3.1))
swoutput(sw,all,unit="Mt DM/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,plot_level="reg",digits=2,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

#Trade bal reduction factor
swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Trade barrier reduction factor}")
all <- lapply(lapply(gdx,inp,"i21_trade_bal_reduction",as.magpie=T),function(x) setNames(x[,,1],NULL))
swoutput(sw,all,unit="-",color="Scenario",geom="line",group=NULL,legend_position="bottom",legend_ncol=2,plot_level="glo",digits=3,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)



swlatex(sw,"\\newpage")
swlatex(sw,"\\section{GHG prices}")
swlatex(sw,"\\subsection{CO2}")
reg <- lapply(gdx,readGDX,"im_ghg_prices", "i57_ghg_prices","f_ghg_prices",format="first_found")
reg <- lapply(reg,function(x) return(x[,,"co2_c"]*12/44))
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
swoutput(sw,reg,unit="US Dollar 2004 per ton CO2",facet_x="Scenario",color="Region",table=F,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)
swoutput(sw,reg,unit="US Dollar 2004 per ton CO2",facet_x="Scenario",color="Region",table=T,scales="free_y",xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{N2O}")
reg <- lapply(gdx,readGDX,"im_ghg_prices", "i57_ghg_prices","f_ghg_prices",format="first_found")
reg <- lapply(reg,function(x) return(x[,,"n2o_n"]*28/44))
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
swoutput(sw,reg,unit="US Dollar 2004 per ton N2O",facet_x="Scenario",color="Region",table=F,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)
swoutput(sw,reg,unit="US Dollar 2004 per ton N2O",facet_x="Scenario",color="Region",table=T,scales="free_y",xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{CH4}")
reg <- lapply(gdx,readGDX,"im_ghg_prices", "i57_ghg_prices","f_ghg_prices",format="first_found")
reg <- lapply(reg,function(x) return(x[,,"ch4"]))
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
swoutput(sw,reg,unit="US Dollar 2004 per ton CH4",facet_x="Scenario",color="Region",table=F,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)
swoutput(sw,reg,unit="US Dollar 2004 per ton CH4",facet_x="Scenario",color="Region",table=T,scales="free_y",xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{GHG Policies}")
pol <- lapply(gdx,readGDX, "i56_emis_policy", "f57_policy_emis_integration",format="first_found")
swoutput(sw,pol,unit="share of GHG price applied",table=TRUE,plot=FALSE)


swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Land-use pattern}")
swlatex(sw,"\\subsection{Overview}")
reg <- lapply(gdx,land,level="reg")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
swoutput(sw,all,stack=T,color=NULL,fill="Data1",facet_x="Scenario",title="Total land (si0+nsi0 | global)",geom="area",unit="Area [mio. ha]",labs=c("","Land type","",""),plot_level="glo",table=T,digits=0,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Cropland}")
reg_all <- lapply(gdx,croparea,level="reg",crop_aggr=TRUE,water="sum")
reg_bio <- lapply(gdx,croparea,level="reg",crops=c("begr","betr"),crop_aggr=TRUE,water="sum")
reg_other <- mapply(function(x,y) return(x-y),reg_all,reg_bio,SIMPLIFY=F)
reg_all <- mapply(mbind,reg_other,reg_bio,SIMPLIFY=F)
reg_all <- lapply(reg_all,setNames,c("Food crops","Bioenergy"))
glo_all <- lapply(reg_all,dimSums,dim=1)
all <- mapply(mbind,reg_all,glo_all,SIMPLIFY=F)
all <- mapply(function(x,t) x[,t,],x=all,t=t,SIMPLIFY=FALSE)
swoutput(sw,all,unit="Area [mio. ha]",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,alpha="Data1",labs=c("","Region","","Area"),plot_level="reg",table=F,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Pasture}")
reg <- lapply(gdx,land,level="reg",type="past")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
swoutput(sw,all,unit="Area [mio. ha]",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,alpha=NULL,labs=c("","Region","","Area"),plot_level="reg",table=F,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Forest}")
reg <- lapply(gdx,land,level="reg",type="forest")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
swoutput(sw,all,unit="Area [mio. ha]",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,alpha=NULL,labs=c("","Region","","Area"),plot_level="reg",table=F,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Forestry}")
reg <- lapply(gdx,land,level="reg",type="forestry")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
swoutput(sw,all,unit="Area [mio. ha]",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,alpha=NULL,labs=c("","Region","","Area"),plot_level="reg",table=F,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Other land}")
reg <- lapply(gdx,land,level="reg",type="other")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
swoutput(sw,all,unit="Area [mio. ha]",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,alpha=NULL,labs=c("","Region","","Area"),plot_level="reg",table=F,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Urban land}")
reg <- lapply(gdx,land,level="reg",type="urban")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
swoutput(sw,all,unit="Area [mio. ha]",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,alpha=NULL,labs=c("","Region","","Area"),plot_level="reg",table=F,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Land-use change}")
swlatex(sw,"\\subsection{Overview}")
reg <- lapply(gdx,land,level="reg")
reg <- mapply(function(x,t) x[,t,]-setYears(x[,t[1],],NULL),x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist = NULL,facet_x = "Data1",ncol = 3,ylab = "Change in area [mio. ha]",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,plot=F,table=T,digits=0)

swlatex(sw,"\\subsection{Cropland}")
reg <- lapply(gdx,land,level="reg",type="crop")
reg <- mapply(function(x,t) x[,t,]-setYears(x[,t[1],],NULL),x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(reg,data_hist = NULL,facet_x = "Region",ncol = 5,ylab = "Change in area [mio. ha]",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,plot=F,table=T,digits=0)

swlatex(sw,"\\subsection{Pasture}")
reg <- lapply(gdx,land,level="reg",type="past")
reg <- mapply(function(x,t) x[,t,]-setYears(x[,t[1],],NULL),x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(reg,data_hist = NULL,facet_x = "Region",ncol = 5,ylab = "Change in area [mio. ha]",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,plot=F,table=T,digits=0)

swlatex(sw,"\\subsection{Forest}")
reg <- lapply(gdx,land,level="reg",type="forest")
reg <- mapply(function(x,t) x[,t,]-setYears(x[,t[1],],NULL),x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(reg,data_hist = NULL,facet_x = "Region",ncol = 5,ylab = "Change in area [mio. ha]",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,plot=F,table=T,digits=0)

swlatex(sw,"\\subsection{Forestry}")
reg <- lapply(gdx,land,level="reg",type="forestry")
reg <- mapply(function(x,t) x[,t,]-setYears(x[,t[1],],NULL),x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(reg,data_hist = NULL,facet_x = "Region",ncol = 5,ylab = "Change in area [mio. ha]",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,plot=F,table=T,digits=0)

swlatex(sw,"\\subsection{Other land}")
reg <- lapply(gdx,land,level="reg",type="other")
reg <- mapply(function(x,t) x[,t,]-setYears(x[,t[1],],NULL),x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(reg,data_hist = NULL,facet_x = "Region",ncol = 5,ylab = "Change in area [mio. ha]",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,plot=F,table=T,digits=0)

swlatex(sw,"\\subsection{Urban land}")
reg <- lapply(gdx,land,level="reg",type="urban")
reg <- mapply(function(x,t) x[,t,]-setYears(x[,t[1],],NULL),x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(reg,data_hist = NULL,facet_x = "Region",ncol = 5,ylab = "Change in area [mio. ha]",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,plot=F,table=T,digits=0)


swlatex(sw,"\\newpage")
swlatex(sw,"\\section{2nd gen. Bioenergy}")
swlatex(sw,"\\subsection{Production}")
reg <- lapply(gdx,production,crops=c("begr","betr"),crop_aggr=TRUE,level="reg",water="sum",unit="EJ")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=NULL,ylab="EJ/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="EJ/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,alpha=NULL,labs=c("","Region","","Type"),plot_level="reg",digits=2,table=F,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)
swoutput(sw,all,unit="EJ/yr",facet_x="Scenario",fill="Region",color=NULL,geom="area",stack=T,alpha=NULL,labs=c("","Region","","Type"),plot_level="reg",digits=2,table=T,scales="free_y",xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

if(!all(unlist(lapply(gdx,croparea,crops=c("begr","betr")))==0)){
  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsection{Prices}")
  reg <- lapply(gdx,prices,crops=c("begr","betr"),crop_aggr=TRUE,level="reg",unit="GJ")
  reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
  glo <- lapply(gdx,prices,crops=c("begr","betr"),crop_aggr=TRUE,level="glo",unit="GJ")
  glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
  all <- mapply(mbind,reg,glo,SIMPLIFY=F)
  ylab <- "US Dollar 2004 per GJ"
  p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
  swfigure(sw, print, p , sw_option = "width=10")
  p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
  swfigure(sw, print, p , sw_option = "width=10")
  swoutput(sw,all,unit=ylab,plot=F,digits=2)

  swlatex(sw,"\\newpage")
  swlatex(sw,"\\subsection{Yields}")
  reg <- lapply(gdx,yields,crops=c("begr","betr"),level="reg",crop_aggr=TRUE,water="sum")
  reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
  glo <- lapply(gdx,yields,crops=c("begr","betr"),level="glo",crop_aggr=TRUE,water="sum")
  glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
  all <- mapply(mbind,reg,glo,SIMPLIFY=F)
  ylab <- "t DM/ha"
  p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
  swfigure(sw, print, p , sw_option = "width=10")
  p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
  swfigure(sw, print, p , sw_option = "width=10")
  swoutput(sw,all,unit=ylab,plot=F,digits=2)

}

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Costs}")

swlatex(sw,"\\subsection{Cost types (global)}")
swlatex(sw,"Cost types included in the objective function")
reg <- lapply(lapply(gdx,readGDX,"ov_cost_prod",format="first_found", select=list(type="level")),function(x) return(setNames(dimSums(x,dim=3.1),"Prod")))
reg <- mapply(mbind,reg,lapply(lapply(gdx,readGDX,"ov_cost_transp",format="first_found", select=list(type="level")),function(x) return(superAggregate(setNames(dimSums(x,dim=3.1),"Transp"),level="reg",aggr_type="sum"))),SIMPLIFY=FALSE)
reg <- mapply(mbind,reg,lapply(lapply(gdx,readGDX,"ov_cost_trade",format="first_found", select=list(type="level")),function(x) return(setNames(dimSums(x,dim=3.1),"Trade"))),SIMPLIFY=FALSE)
reg <- mapply(mbind,reg,lapply(lapply(gdx,readGDX,"ov_cost_landcon",format="first_found", select=list(type="level")),function(x) return(superAggregate(setNames(dimSums(x,dim=3.1),"Landcon"),level="reg",aggr_type="sum"))),SIMPLIFY=FALSE)
reg <- mapply(mbind,reg,lapply(lapply(gdx,readGDX,"ov_cost_past",format="first_found", select=list(type="level")),function(x) return(setNames(dimSums(x,dim=3.1),"Pasture"))),SIMPLIFY=FALSE)
reg <- mapply(mbind,reg,lapply(lapply(gdx,readGDX,"ov_cost_AEI",format="first_found", select=list(type="level")),function(x) return(setNames(dimSums(x,dim=3.1),"AEI"))),SIMPLIFY=FALSE)
reg <- mapply(mbind,reg,lapply(lapply(gdx,readGDX,"ov_tech_cost",format="first_found", select=list(type="level")),function(x) return(setNames(dimSums(x,dim=3.1),"TC"))),SIMPLIFY=FALSE)
reg <- mapply(mbind,reg,lapply(lapply(gdx,readGDX,"ov_maccs_costs",format="first_found", select=list(type="level")),function(x) return(setNames(dimSums(x,dim=3.1),"MACCs"))),SIMPLIFY=FALSE)
reg <- mapply(mbind,reg,lapply(lapply(gdx,readGDX,"ov_cost_fore",format="first_found", select=list(type="level")),function(x) return(setNames(dimSums(x,dim=3.1),"AFF"))),SIMPLIFY=FALSE)
reg <- mapply(mbind,reg,lapply(lapply(gdx,readGDX,"ov_cost_cdr",format="first_found", select=list(type="level")),function(x) return(setNames(dimSums(x,dim=3.1),"CDR"))),SIMPLIFY=FALSE)
reg <- mapply(mbind,reg,lapply(lapply(gdx,readGDX,"ov_emission_costs",format="first_found", select=list(type="level")),function(x) return(setNames(dimSums(x,dim=3.1),"GHG emis"))),SIMPLIFY=FALSE)
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
all <- lapply(all,function(x) return(x/1000))
swoutput(sw,all,unit="bill. US Dollar",facet_x="Scenario",geom="area",stack=T,color=NULL,fill="Data1",stat="sum",plot_level="glo",table=T,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Regional costs}")
swlatex(sw,"\\subsubsection{Total}")
swlatex(sw,"Total regional costs including GHG market")
reg <- lapply(gdx,costs,level="reg",type="total",crop_aggr=TRUE)
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
all <- lapply(all,function(x) return(x/1000))
swoutput(sw,all,unit="bill. US Dollar",facet_x="Scenario",geom="area",stack=T,color=NULL,fill="Region",stat="sum",plot_level="reg",table=T,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsubsection{Excluding GHG market}")
swlatex(sw,"Total regional costs excluding GHG market")
costs_all <- lapply(gdx,costs,level="reg",type="total",crop_aggr=TRUE)
costs_all <- mapply(function(x,t) x[,t,],x=costs_all,t=t,SIMPLIFY=FALSE)
costs_ghg <- lapply(gdx,costs,level="reg",type="emissions",crop_aggr=TRUE)
costs_ghg <- mapply(function(x,t) x[,t,],x=costs_ghg,t=t,SIMPLIFY=FALSE)
reg <- mapply("-",costs_all,costs_ghg,SIMPLIFY = FALSE)
glo <- lapply(reg,dimSums,dim=1)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
all <- lapply(all,function(x) return(x/1000))
swoutput(sw,all,unit="bill. US Dollar",facet_x="Scenario",geom="area",stack=T,color=NULL,fill="Region",stat="sum",plot_level="reg",table=T,xlim=xlim,ncol=ncol,pointwidth=pointwidth,show_grid=TRUE)

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{CO2 emissions}")
swlatex(sw,"\\subsection{Annual}")
swlatex(sw,"\\subsubsection{Model output}")
reg <- mapply("*",lapply(gdx,emissions,level="reg",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE)
reg <- mapply(function(x,t) x[,t[-1],],x=reg,t=t,SIMPLIFY=FALSE)
glo <- mapply("*",lapply(gdx,emissions,level="glo",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE)
glo <- mapply(function(x,t) x[,t[-1],],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="glo")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="reg")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt CO2/yr",plot=F,digits=2)

swlatex(sw,"\\subsubsection{lowpass i=1,fix=NULL}")
reg <- lapply(mapply("*",lapply(gdx,emissions,level="reg",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=1,fix=NULL)
reg <- mapply(function(x,t) x[,t[-1],],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(mapply("*",lapply(gdx,emissions,level="glo",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=1,fix=NULL)
glo <- mapply(function(x,t) x[,t[-1],],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="glo")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="reg")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt CO2/yr",plot=F,digits=2)

swlatex(sw,"\\subsubsection{lowpass i=1,fix=start}")
reg <- lapply(mapply("*",lapply(gdx,emissions,level="reg",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=1,fix="start")
reg <- mapply(function(x,t) x[,t[-1],],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(mapply("*",lapply(gdx,emissions,level="glo",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=1,fix="start")
glo <- mapply(function(x,t) x[,t[-1],],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="glo")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="reg")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt CO2/yr",plot=F,digits=2)

swlatex(sw,"\\subsubsection{lowpass i=2,fix=start}")
reg <- lapply(mapply("*",lapply(gdx,emissions,level="reg",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=2,fix="start")
reg <- mapply(function(x,t) x[,t[-1],],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(mapply("*",lapply(gdx,emissions,level="glo",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=2,fix="start")
glo <- mapply(function(x,t) x[,t[-1],],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="glo")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="reg")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt CO2/yr",plot=F,digits=2)

swlatex(sw,"\\subsubsection{lowpass i=3,fix=start}")
reg <- lapply(mapply("*",lapply(gdx,emissions,level="reg",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=3,fix="start")
reg <- mapply(function(x,t) x[,t[-1],],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(mapply("*",lapply(gdx,emissions,level="glo",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=3,fix="start")
glo <- mapply(function(x,t) x[,t[-1],],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="glo")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="reg")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt CO2/yr",plot=F,digits=2)

swlatex(sw,"\\subsubsection{lowpass i=4,fix=start}")
reg <- lapply(mapply("*",lapply(gdx,emissions,level="reg",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=4,fix="start")
reg <- mapply(function(x,t) x[,t[-1],],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(mapply("*",lapply(gdx,emissions,level="glo",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=4,fix="start")
glo <- mapply(function(x,t) x[,t[-1],],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="glo")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="reg")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt CO2/yr",plot=F,digits=2)

swlatex(sw,"\\subsubsection{lowpass i=5,fix=start}")
reg <- lapply(mapply("*",lapply(gdx,emissions,level="reg",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=5,fix="start")
reg <- mapply(function(x,t) x[,t[-1],],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(mapply("*",lapply(gdx,emissions,level="glo",type="co2_c",cumulative=FALSE),44/12,SIMPLIFY=FALSE),lowpass,i=5,fix="start")
glo <- mapply(function(x,t) x[,t[-1],],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="glo")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=lapply(getData(emissions,gdx=gdx,type="co2_c",level="reg")[[1]][[2]][[1]],function(x) return(x*44/12)),ylab="Mt CO2/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt CO2/yr",plot=F,digits=2)



swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Cumulative}")
reg <- mapply("*",lapply(gdx,emissions,level="reg",type="co2_c",cumulative=TRUE,y1995=TRUE),44/12/1000,SIMPLIFY=FALSE)
reg <- mapply(function(x,t) x-setYears(x[,baseyear,],NULL),x=reg,t=t,SIMPLIFY=FALSE)
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- mapply("*",lapply(gdx,emissions,level="glo",type="co2_c",cumulative=TRUE,y1995=TRUE),44/12/1000,SIMPLIFY=FALSE)
glo <- mapply(function(x,t) x-setYears(x[,baseyear,],NULL),x=glo,t=t,SIMPLIFY=FALSE)
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=NULL,ylab="Gt CO2 (cumulative)",ncol=1,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab="Gt CO2 (cumulative)",ncol=5,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Gt CO2 (cumulative)",plot=F,digits=2)


swlatex(sw,"\\newpage")
swlatex(sw,"\\section{N2O emissions}")
swlatex(sw,"\\subsection{Annual}")
reg <- mapply("*",lapply(gdx,emissions,level="reg",type="n2o_n",cumulative=FALSE,y1995=TRUE),44/28,SIMPLIFY=FALSE)
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- mapply("*",lapply(gdx,emissions,level="glo",type="n2o_n",cumulative=FALSE,y1995=TRUE),44/28,SIMPLIFY=FALSE)
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=lapply(getData(emissions,gdx=gdx,type="n2o_n",level="glo")[[1]][[2]][[1]],function(x) return(x*44/28)),ylab="Mt N2O/yr",ncol=1,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=lapply(getData(emissions,gdx=gdx,type="n2o_n",level="reg")[[1]][[2]][[1]],function(x) return(x*44/28)),ylab="Mt N2O/yr",ncol=5,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt N2O/yr",plot=F,digits=2)

swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Cumulative}")
reg <- mapply("*",lapply(gdx,emissions,level="reg",type="n2o_n",cumulative=TRUE,y1995=TRUE),44/28/1000,SIMPLIFY=FALSE)
reg <- mapply(function(x,t) x-setYears(x[,baseyear,],NULL),x=reg,t=t,SIMPLIFY=FALSE)
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- mapply("*",lapply(gdx,emissions,level="glo",type="n2o_n",cumulative=TRUE,y1995=TRUE),44/28/1000,SIMPLIFY=FALSE)
glo <- mapply(function(x,t) x-setYears(x[,baseyear,],NULL),x=glo,t=t,SIMPLIFY=FALSE)
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=NULL,ylab="Gt N2O (cumulative)",ncol=1,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab="Gt N2O (cumulative)",ncol=5,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Gt N2O (cumulative)",plot=F,digits=2)

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{CH4 emissions}")
swlatex(sw,"\\subsection{Annual}")
swlatex(sw,"\\subsubsection{Total}")
reg <- mapply("*",lapply(gdx,emissions,level="reg",type="ch4",cumulative=FALSE,y1995=TRUE),1,SIMPLIFY=FALSE)
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- mapply("*",lapply(gdx,emissions,level="glo",type="ch4",cumulative=FALSE,y1995=TRUE),1,SIMPLIFY=FALSE)
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=getData(emissions,gdx=gdx,type="ch4",level="glo")[[1]][[2]][[1]],ylab="Mt CH4/yr",ncol=1,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=getData(emissions,gdx=gdx,type="ch4",level="reg")[[1]][[2]][[1]],ylab="Mt CH4/yr",ncol=5,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt CH4/yr",plot=F,digits=2)



emis_reg <- lapply(lapply(gdx,inp,"ov56_emis_reg","ov57_emis_reg"),function(x) as.magpie(x[,,,"level"]))
emis_glo <- lapply(emis_reg,dimSums,dim=1)
emis <- mapply(mbind,emis_reg,emis_glo,SIMPLIFY=F)

swlatex(sw,"\\subsubsection{Rice}")
sel <- "rice_ch4"
all <- lapply(emis,function(x) dimSums(x[1:10,,sel],dim=3.1))
p <- histoplot2(all,data_hist = NULL,ylab="Mt CH4/yr",ncol=5,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt CH4/yr",digits=2,plot=F)

swlatex(sw,"\\subsubsection{AWM}")
sel <- "awms_ch4"
all <- lapply(emis,function(x) dimSums(x[1:10,,sel],dim=3.1))
p <- histoplot2(all,data_hist = NULL,ylab="Mt CH4/yr",ncol=5,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt CH4/yr",digits=2,plot=F)

swlatex(sw,"\\subsubsection{Enteric Fermentation}")
sel <- "ent_ferm_ch4"
all <- lapply(emis,function(x) dimSums(x[1:10,,sel],dim=3.1))
p <- histoplot2(all,data_hist = NULL,ylab="Mt CH4/yr",ncol=5,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Mt CH4/yr",digits=2,plot=F)


swlatex(sw,"\\newpage")
swlatex(sw,"\\subsection{Cumulative}")
reg <- mapply("*",lapply(gdx,emissions,level="reg",type="ch4",cumulative=TRUE,y1995=TRUE),1/1000,SIMPLIFY=FALSE)
reg <- mapply(function(x,t) x-setYears(x[,baseyear,],NULL),x=reg,t=t,SIMPLIFY=FALSE)
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- mapply("*",lapply(gdx,emissions,level="glo",type="ch4",cumulative=TRUE,y1995=TRUE),1/1000,SIMPLIFY=FALSE)
glo <- mapply(function(x,t) x-setYears(x[,baseyear,],NULL),x=glo,t=t,SIMPLIFY=FALSE)
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
p <- histoplot2(glo,data_hist=NULL,ylab="Gt CH4 (cumulative)",ncol=1,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab="Gt CH4 (cumulative)",ncol=5,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="Gt CH4 (cumulative)",plot=F,digits=2)


swlatex(sw,"\\newpage")
swlatex(sw,"\\section{TC}")
swlatex(sw,"\\subsection{Annual}")
reg <- lapply(lapply(gdx,tc,level="reg"), function(x) return(x*100))
reg <- mapply(function(x,t) x[,t[-1],],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(lapply(gdx,tc,level="glo"), function(x) return(x*100))
glo <- mapply(function(x,t) x[,t[-1],],x=glo,t=t,SIMPLIFY=FALSE)
all <- lapply(mapply(mbind,reg,glo,SIMPLIFY=F),function(x) return(x[,,]))
ylab <- "Annual TC rates (percent per year)"
p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit=ylab,plot=F,digits=2)


swlatex(sw,"\\subsection{Average annual}")
reg <- lapply(lapply(gdx,tc,level="reg",avrg=TRUE,baseyear=baseyear), function(x) return(x*100))
glo <- lapply(lapply(gdx,tc,level="glo",avrg=TRUE,baseyear=baseyear), function(x) return(x*100))
all <- lapply(mapply(mbind,reg,glo,SIMPLIFY=F),function(x) return(x[,,]))
ylab <- "Average annual TC rates (percent per year)"
p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit=ylab,plot=F,digits=2)

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{TAU}")

reg <- lapply(gdx,tau,level="reg")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(gdx,tau,level="glo")
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- lapply(mapply(mbind,reg,glo,SIMPLIFY=F),function(x) return(x[,-1,]))
ylab <- "TAU"
p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit=ylab,plot=F,digits=2)

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Food Price Index (kfo,kli)}")
swlatex(sw,"Laspeyres-Index: baseyear weighting; shows the development of prices for a fixed basket\\newline")

reg <- lapply(gdx,priceIndex,level="reg",crops=c("kfo","kli"),index="lasp",baseyear=baseyear)
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(gdx,priceIndex,level="glo",crops=c("kfo","kli"),index="lasp",baseyear=baseyear)
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
ylab <- paste0("Index (",baseyear,"=100)")
p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit=ylab,plot=F,digits=2)

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Agricultural Water Withdrawals}")
reg <- mapply("*",lapply(gdx,water_usage,level="reg",users="kcr",sum=TRUE,digits=3),10^3,SIMPLIFY=FALSE)
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- mapply("*",lapply(gdx,water_usage,level="glo",users="kcr",sum=TRUE,digits=3),10^3,SIMPLIFY=FALSE)
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=FALSE)
p <- histoplot2(glo,data_hist=NULL,ylab="mio m3/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab="mio m3/yr",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="mio m3/yr",plot=F,digits=0)

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Irrigated area}")
reg <- lapply(gdx,croparea,level="reg",water="ir",crop_aggr=TRUE)
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(gdx,croparea,level="glo",water="ir",crop_aggr=TRUE)
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=FALSE)
p <- histoplot2(glo,data_hist=NULL,ylab="mio ha",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab="mio ha",xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit="mio ha",plot=F,digits=2)


swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Food crop yields}")
swlatex(sw,"\\subsection{All crops - rf+ir}")
reg <- lapply(gdx,yields,crops="kfo",level="reg",crop_aggr=TRUE,water="sum")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(gdx,yields,crops="kfo",level="glo",crop_aggr=TRUE,water="sum")
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
ylab <- "t DM/ha"
p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit=ylab,plot=F,digits=2)

swlatex(sw,"\\subsection{All crops - rf}")
reg <- lapply(gdx,yields,crops="kfo",level="reg",crop_aggr=TRUE,water="rf")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(gdx,yields,crops="kfo",level="glo",crop_aggr=TRUE,water="rf")
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
ylab <- "t DM/ha"
p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit=ylab,plot=F,digits=2)

swlatex(sw,"\\subsection{All crops - ir}")
reg <- lapply(gdx,yields,crops="kfo",level="reg",crop_aggr=TRUE,water="ir")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(gdx,yields,crops="kfo",level="glo",crop_aggr=TRUE,water="ir")
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
ylab <- "t DM/ha"
p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit=ylab,plot=F,digits=2)

swlatex(sw,"\\subsection{maiz - rf}")
reg <- lapply(gdx,yields,crops="maiz",level="reg",crop_aggr=TRUE,water="rf")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(gdx,yields,crops="maiz",level="glo",crop_aggr=TRUE,water="rf")
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
ylab <- "t DM/ha"
p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit=ylab,plot=F,digits=2)

swlatex(sw,"\\subsection{maiz - ir}")
reg <- lapply(gdx,yields,crops="maiz",level="reg",crop_aggr=TRUE,water="ir")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(gdx,yields,crops="maiz",level="glo",crop_aggr=TRUE,water="ir")
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
ylab <- "t DM/ha"
p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit=ylab,plot=F,digits=2)

swlatex(sw,"\\subsection{tece - rf}")
reg <- lapply(gdx,yields,crops="tece",level="reg",crop_aggr=TRUE,water="rf")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(gdx,yields,crops="tece",level="glo",crop_aggr=TRUE,water="rf")
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
ylab <- "t DM/ha"
p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit=ylab,plot=F,digits=2)

swlatex(sw,"\\subsection{tece - ir}")
reg <- lapply(gdx,yields,crops="tece",level="reg",crop_aggr=TRUE,water="ir")
reg <- mapply(function(x,t) x[,t,],x=reg,t=t,SIMPLIFY=FALSE)
glo <- lapply(gdx,yields,crops="tece",level="glo",crop_aggr=TRUE,water="ir")
glo <- mapply(function(x,t) x[,t,],x=glo,t=t,SIMPLIFY=FALSE)
all <- mapply(mbind,reg,glo,SIMPLIFY=F)
ylab <- "t DM/ha"
p <- histoplot2(glo,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
p <- histoplot2(reg,data_hist=NULL,ylab=ylab,xlim=xlim,pointwidth=pointwidth)
swfigure(sw, print, p , sw_option = "width=10")
swoutput(sw,all,unit=ylab,plot=F,digits=2)

swclose(sw,clean_output=TRUE)
