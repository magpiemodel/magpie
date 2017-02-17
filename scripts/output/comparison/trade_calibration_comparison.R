# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

##########################################################
#### Trade calibration comparison####
##########################################################
# Version 1.0
# Xiaoxi Wang
# compare calibrated trade volumes and transport costs

library(lucode)
library(ludata)
library(lusweave)
library(luplot)
library(luplayground)
library(magpie4)
library(faodata)
library(validation)
library(gdx)


############################# BASIC CONFIGURATION #############################
lr_input_folder        <- "../../input/cellular"

additional_input <- "fulldata.gdx"                # Further data that needs to be provided, can be gdx or lst

if(!exists("source_include")) {

  outputdirs    <-"../../output/default_2013-04-16_15.10.49"
  #Define arguments that can be read from command line
  readArgs("outputdirs")
}
###############################################################################


years <- getYears(modelstat(path(outputdirs[1],"fulldata.gdx")))

gdx <- list()
title_list <- list()

print("Starting data preparation")
for (i in 1:length(outputdirs)) {
  #title of the run
  if(file.exists(path(outputdirs[i],"config.Rdata"))) {
    load(path(outputdirs[i],"config.Rdata"))
    title <- cfg$title
    gms      <- cfg$gms
    title_list[[title]] <- title
  } else {
    config <- grep("\\.cfg$",list.files(outputdirs[i]), value=TRUE)
    l<-readLines(path(outputdirs[i],config))
    title <- strsplit(grep("title +<-",l,value=TRUE),"\"")[[1]][2]
    gms <- list()
    gms$scenarios <- strsplit(grep("(cfg\\$|)gms\\$scenarios +<-",l,value=TRUE),"\"")[[1]][2]
    title_list[[title]] <- title
  }
  gdx[[title]] <- path(outputdirs[i],"fulldata.gdx")  
}

print("Starting output generation")


title <- "trade_calibration_comparison"

################################################



share <- function(gdx=NULL,x,type="import",data.type="magpie"){
  if (is.character(x)){
    if (data.type=="magpie"){
      df <- inp(gdx,x,as.magpie=F)["y1995",,,,"level"]
    }else{
      df <- inp(gdx,x,as.magpie=F)
    }
  }
  if (is.numeric(x)){
    df <-x 
  }
    total <- colSums(colSums(df,dim=1),dim=1)
  if(type=="import"){
    tmp <- colSums(df,dims=1)
    share <- t(t(tmp)/total)
  }
  if(type =="export"){
    tmp <- colSums(aperm(df, c(2,1,3)), dims = 1)
    share <- t(t(tmp)/total)
  }
  if(type == "bilateral"){
    share <-  aperm(aperm(df,c(3,1,2)) / total, c(2,3,1))
  }
  return(share)
}

reshape_share <- function(x,type="import",var.names=NULL,data.type="magpie",timevar=NULL){
  out <- array_to_dataframe(x,xdim=NULL)
  colnames(out) <- gsub("value.","",colnames(out))
  if (type=="import"){
    out <- reshape(data=out,idvar="i",timevar=timevar,direction="wide")
    colnames(out) <- c(paste(type,"reg",sep="_"),var.names)
  }
  if (type == "export"){
    if(data.type=="magpie"){
      out <- reshape(data=out,idvar="i2",timevar=timevar,direction="wide")
    }else{
      out <- reshape(data=out,idvar="i",timevar=timevar,direction="wide")
    }
    colnames(out) <- c(paste(type,"reg",sep="_"),var.names)
  }
  if (type=="bilateral"){
    out <- reshape(data=out,idvar = c("i2","i"), timevar = timevar, direction = "wide")
    colnames(out) <- c(paste(c("export","import"),"reg",sep="_"),var.names)
  }
  return(out)
}

performance_wx <- function(mod1,mod2,obs,col1="blue",col2="red",ylab=NULL,xlab=NULL,main=NULL,names=NULL...){
  xlim <- c(0,max(mod1,mod2,obs))
  xlim <- (1+0.3)*xlim
  ylim <- xlim
  plot(mod1,obs,col=col1,pch=17,ylab=ylab,xlab=xlab,xlim=xlim,ylim=ylim,main=main)
  abline(0,1)
  points(mod2,obs,col=col2,pch=20)
  indices1 <- round(cor(mod1, obs,method="pearson"),2)
  indices2 <- round(cor(mod2, obs, method="pearson"),2)
  indices <- c(indices1,indices2)
  if(length(names)>2) stop("Only works for two strings")
  names(indices) <- names
  ind_box <- NULL
  for (i in 1:2) {
    ind_box <- c(ind_box, paste(names(indices[i]), as.numeric(indices[i]), sep = ": "))}
  legend(x = "bottomright", ind_box, cex=1, pch=c(17,20),col=c("blue","red"),title="Pearson coeffients")
}



bilateral_share_gtap <- inp(gdx[[1]],"i21_total_share")
import_share_gtap <- inp(gdx[[1]],"i21_import_share")
export_share_gtap <- inp(gdx[[1]],"i21_export_share")
gtap_crops <- dimnames(export_share_gtap)[[2]]

import_share_gtap <- reshape_share(import_share_gtap,type ="import",var.names = gtap_crops,data.type = "gtap",timevar="trc")
export_share_gtap <- reshape_share(export_share_gtap,type="export",var.names=gtap_crops,data.type = "gtap",timevar="trc")
bilateral_share_gtap <- reshape_share(bilateral_share_gtap,type="bilateral",var.names = gtap_crops,data.type = "gtap",timevar="trc")



# dm_content <- inp(gdx[[1]], "f21_DM_content")
gtap.magpie1 <- list()
gtap.magpie1[["cereals"]] <- c("tece","maiz","trce")
gtap.magpie1[["rice"]] <- c("rice_pro")
gtap.magpie1[["oilseeds"]] <- c("soybean","rapeseed","groundnut","sunflower","oilpalm")
gtap.magpie1[["sugar"]]  <- c("sugr_cane","sugr_beet")
gtap.magpie1[["others"]] <- c("others","puls_pro","potato","cassav_sp","begr","betr")
gtap.magpie1[["textiles"]] <- c("cottn_pro")
gtap.magpie1[["meat"]] <- c("livst_rum","livst_pig","livst_chick","livst_egg","livst_milk")

bilateral_magpie <- list()
import_share_magpie <- list()
export_share_magpie <- list()
bilateral_share_magpie <- list()
tmp <- list()

for (i in names(gdx)){
  tmp[[i]] <- inp(gdx[[grep("calib",names(gdx))]],"i21_total_share")
  bilateral_magpie[[i]] <- inp(gdx[[i]],"ov21_trade", react="warning", as.magpie = F)["y1995",,,,"level"]
  for(j in 1:length(gtap.magpie1)) {
    if (length(gtap.magpie1[[j]]) == 1) {tmp[[i]][,,names(gtap.magpie1)[[j]]] <-bilateral_magpie[[i]][,,gtap.magpie1[[j]]]}
    else{tmp[[i]][,,names(gtap.magpie1)[[j]]] <- dimSums(bilateral_magpie[[i]][,,gtap.magpie1[[j]]])}
  }
  
  bilateral_share_magpie[[i]] <- share(x=tmp[[i]],type = "bilateral",data.type = "magpie")
  export_share_magpie[[i]] <- share(x=tmp[[i]],type = "export",data.type = "magpie")
  import_share_magpie[[i]] <- share(x=tmp[[i]],type = "import",data.type = "magpie")
  
  bilateral_share_magpie[[i]] <- reshape_share(bilateral_share_magpie[[i]],type = "bilateral",var.names = gtap_crops,data.type = "gtap",timevar = "trc")
  names(dimnames(export_share_magpie[[i]]))[1] <- "i"
  export_share_magpie[[i]] <- reshape_share(export_share_magpie[[i]],type = "export",var.names = gtap_crops,data.type = "gtap",timevar = "trc")
  import_share_magpie[[i]] <- reshape_share(import_share_magpie[[i]],type = "import",var.names = gtap_crops,data.type = "gtap",timevar = "trc")
}





######### output ##########
swout<-swopen(paste(outputdirs,"/",title,"trade_validation.pdf",sep=""))

swlatex(swout,"\\newpage")
swlatex(swout,"\\section{Calibrtion of trade volumes}")
swlatex(swout,"\\subsection{Share of export volumes}")
n <- dim(export_share_gtap)[1]*(dim(export_share_gtap)[2]-1)
obs <- as.vector(as.matrix(export_share_gtap[,-grep("reg",dimnames(export_share_gtap)[[2]])]))
mod1 <- as.vector(as.matrix(export_share_magpie[[1]][,-grep("reg",dimnames(export_share_magpie[[1]])[[2]])]))
mod2 <- as.vector(as.matrix(export_share_magpie[[2]][,-grep("reg",dimnames(export_share_magpie[[2]])[[2]])]))

gdx_names <-c("calib","bilateral")


png(filename=path(outputdirs,"prep_todd_summed_export_1995_test.png"),width=6, height=6, units="in", res=500)
performance_wx(mod1=mod1,mod2=mod2,obs=obs,names=names(gdx))
dev.off()

swfigure(swout,performance_wx,mod1=mod1,mod2=mod2,obs=obs,names=gdx_names,
         ylab = "MAgPIE [%]",xlab = "GTAP [%]",
         tex_caption = "Share of export volumes w.r.t. total trade flows of each GTAP commodity")

swlatex(swout,"\\subsection{Share of import volumes}")
n <- dim(import_share_gtap)[1]*(dim(import_share_gtap)[2]-1)
obs <- as.vector(as.matrix(import_share_gtap[,-grep("reg",dimnames(import_share_gtap)[[2]])]))
mod1 <- as.vector(as.matrix(import_share_magpie[[1]][,-grep("reg",dimnames(import_share_magpie[[1]])[[2]])]))
mod2 <- as.vector(as.matrix(import_share_magpie[[2]][,-grep("reg",dimnames(import_share_magpie[[2]])[[2]])]))

swfigure(swout,performance_wx,mod1=mod1,mod2=mod2,obs=obs,names=gdx_names,
         ylab = "MAgPIE [%]",xlab = "GTAP [%]",
         tex_caption = "Share of import volumes w.r.t. total trade flows of each GTAP commodity")

swlatex(swout,"\\subsection{Share of bilateral trade volumes}")
n <- dim(bilateral_share_gtap)[1]*(dim(bilateral_share_gtap)[2]-1)
obs <- as.vector(as.matrix(bilateral_share_gtap[,-grep("reg",dimnames(bilateral_share_gtap)[[2]])]))
mod1 <- as.vector(as.matrix(bilateral_share_magpie[[1]][,-grep("reg",dimnames(bilateral_share_magpie[[1]])[[2]])]))
mod2 <- as.vector(as.matrix(bilateral_share_magpie[[2]][,-grep("reg",dimnames(bilateral_share_magpie[[2]])[[2]])]))

swfigure(swout,performance_wx,mod1=mod1,mod2=mod2,obs=obs,names=gdx_names,
         ylab = "MAgPIE [%]",xlab = "GTAP [%]",
         tex_caption = "Share of bilateral trade volumes w.r.t. total trade flows of each GTAP commodity")

swlatex(swout,"\\subsection{Share of bilateral trade volumes for each commodity}")
vars <-   names(bilateral_share_magpie[[1]][,-grep("reg",dimnames(bilateral_share_magpie[[1]])[[2]])])
for (i in vars){

  obs <- as.vector(as.matrix(bilateral_share_gtap[,-grep("reg",dimnames(bilateral_share_gtap)[[2]])][i]))
  mod1 <- as.vector(as.matrix(bilateral_share_magpie[[1]][,-grep("reg",dimnames(bilateral_share_magpie[[1]])[[2]])][i]))
  mod2 <- as.vector(as.matrix(bilateral_share_magpie[[2]][,-grep("reg",dimnames(bilateral_share_magpie[[2]])[[2]])][i]))
  
  swfigure(swout,performance_wx,mod1=mod1,mod2=mod2,obs=obs,names=gdx_names,
           ylab = "MAgPIE [%]",xlab = "GTAP [%]",
           tex_caption = paste("Share of bilateral trade volumes w.r.t. total trade flows of GTAP commodity for", i, sep=" "))
}



#****************************
# Calibrated transport costs
#****************************
costs_gtap <- inp(gdx[[1]],"f21_transp_costs", react="warning", as.magpie = F)
costs_magpie <- inp(gdx[[1]],"p21_transp_costs", react="warning", as.magpie = F)

gtap.magpie2 <- list()
gtap.magpie2[["rice_t"]] <- c("rice_pro")
gtap.magpie2[["cereals_t"]] <- c("tece","trce","maiz")
gtap.magpie2[["puls_t"]] <- c("puls_pro")
gtap.magpie2[["roots_t"]] <- c("potato","cassav_sp")
gtap.magpie2[["others_t"]] <- c("others")
gtap.magpie2[["oilcrops_t"]] <- c("soybean","groundnut","rapeseed","sunflower","oilpalm")
gtap.magpie2[["sugar_t"]] <- c("sugr_cane","sugr_beet")
gtap.magpie2[["meat_rumi_t"]] <- c("livst_rum")
gtap.magpie2[["milk_t"]] <- c("livst_milk")
gtap.magpie2[["meat_nonr_t"]] <- c("livst_pig","livst_chick","livst_egg")
gtap.magpie2[["cottn_t"]] <- c("cottn_pro")
gtap.magpie2[["kbe_t"]] <- c("begr","betr")

tmp <- costs_magpie
for(i in 1:length(gtap.magpie2)) {
  tmp[,,gtap.magpie2[[i]]] <- costs_gtap[,,names(gtap.magpie2)[i]]
}
costs_gtap <- tmp

costs_gtap<- reshape_share(costs_gtap,type = "bilateral",var.names = dimnames(costs_gtap)[[3]],data.type ="magpie",timevar = "k" )
costs_magpie <- reshape_share(costs_magpie,type = "bilateral",var.names = dimnames(costs_magpie)[[3]],data.type ="magpie",timevar = "k" )

obs <- as.vector(as.matrix(costs_gtap[,-grep("reg",dimnames(costs_gtap)[[2]])]))
mod <- as.vector(as.matrix(costs_magpie [,-grep("reg",dimnames(costs_magpie )[[2]])]))

swlatex(swout,"\\section{Calibration of trade costs}")
swlatex(swout,"\\subsection{Overall calibration of trade costs}")
swfigure(swout,performancePlot, pdata=mod,odata=obs,measures=c("Pearson"),na.rm=T,
         ylab = "MAgPIE [Mio. USD]",xlab = "GTAP [Mio. USD]", tex_caption ="Calibrated transport costs",
         col = "blue", pch=8, fig.placement="H")

#           performancePlot(pdata=mod,odata=obs,measures=c("Pearson"),na.rm=T,ylab = "MAgPIE [Mio. USD]",xlab = "GTAP [Mio. USD]", 
#                           col = "blue", pch=8, fig.placement="H", main="Calibrated transport costs in 1995")

swlatex(swout,"\\subsection{Calibration of trade costs for each MAgPIE commodity}")


for (i in colnames(costs_magpie)[-grep("reg",colnames(costs_magpie))]){
  print(i)
  obs <- as.vector(as.matrix(costs_gtap[[i]]))
  mod <- as.vector(as.matrix(costs_magpie[[i]]))
  swfigure(swout,performancePlot, pdata=mod,odata=obs,measures=c("Pearson"),na.rm=T,
           ylab = "MAgPIE [Mio. USD]",xlab = "GTAP [Mio. USD]", tex_caption =paste("Calibrated transport costs","of",i),
           col = "blue", pch=8, fig.placement="H")
}

swclose(swout,clean_output=FALSE,engine="knitr")




