# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

options(error=function()traceback(2))
######################################
#### ipbes output script #############
######################################
#Author: FH based on interpolation output script

library(lucode)
library(luscale)
library(magpie4)
library(ludata)

############################# BASIC CONFIGURATION ##############################
if(!exists("source_include")) {
  sum_spam_file    <- "0.5-to-h1000_sum.spam"
  title       <- "REF-noCC"
  outputdir       <- "output/h1000/REF-noCC/"

  ###Define arguments that can be read from command line
  readArgs("sum_spam_file","outputdir","title")
}

gdx<-path(outputdir,"fulldata.gdx")
cfg<-path(outputdir,"config.Rdata")

################################################################################

# yields
print("Yields")
print(outputdir)

spam <- path(outputdir,"0.5-to-h1000_sum.spam")
x <- dimSums(readGDX(gdx,"ov_yld")[,,"level"],dim=3.3)
x[is.na(x)|is.infinite(x)] <- 9999
x <- speed_aggregate(x,t(spam))
x[x == 9999] <- NA
write.magpie(x,file_name = path(paste0("output/",title,"_yields.nc")))
write.magpie(x,file_name = path(paste0("output/",title,"_yields.csv")))


print("Prices")
rep_magpie<-NULL
reg <- producer.price(gdx,commodities="k")
getNames(reg) <- paste0("Prices|",getNames(reg))

write.report(mbind(reg),file=path("output/sofa_prices_mar16.csv"),scenario=title,model="MAgPIE",append=TRUE,unit = "US Dollar 2005 in Market exchange rate per ton dry matter")
