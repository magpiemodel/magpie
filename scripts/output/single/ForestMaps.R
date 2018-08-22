# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

library(magclass)
library(luplot)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir    <-"."
}

load(paste0(outputdir, "/config.Rdata"))
title          <- cfg$title
land_hr_file        <- paste0(outputdir, "/cell.land_0.5.mz")

###############################################################################

land_hr <- read.magpie(land_hr_file)

defor_primforest <- land_hr[,c(2020,2050,2100),"primforest"] - setYears(land_hr[,1995,"primforest"],NULL)
plotmap2(defor_primforest,paste0(outputdir,"/",title,"_defor_primforest.pdf"),legend_range = c(-0.1,0.1),title = paste(title,"diff map area"),midpoint = 0,lowcol = "darkred",midcol = "grey95",highcol = "darkgreen",plot_height=15,plot_width=10)

defor_secdforest <- land_hr[,c(2020,2050,2100),"secdforest"] - setYears(land_hr[,1995,"secdforest"],NULL)
plotmap2(defor_secdforest,paste0(outputdir,"/",title,"_defor_secdforest.pdf"),legend_range = c(-0.1,0.1),title = paste(title,"diff map area"),midpoint = 0,lowcol = "darkred",midcol = "grey95",highcol = "darkgreen",plot_height=15,plot_width=10)

defor <- dimSums(land_hr[,c(2020,2050,2100),c("primforest","secdforest")],dim=3) - dimSums(setYears(land_hr[,1995,c("primforest","secdforest")],NULL),dim=3)
plotmap2(defor,paste0(outputdir,"/",title,"_defor.pdf"),legend_range = c(-0.1,0.1),title = paste(title,"diff map area"),midpoint = 0,lowcol = "darkred",midcol = "grey95",highcol = "darkgreen",plot_height=15,plot_width=10)
