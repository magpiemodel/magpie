# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de

library(gdx)
library(magpie4)
library(ncdf4)
library(raster)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir    <-"."
}

gdx        <- paste0(outputdir, "/fulldata.gdx")

###############################################################################

cshare <- mbind(add_dimension(cshare(gdx, level="grid",  reference="actual", spamfiledirectory=outputdir), 
                              add = "reference", nm = "actual"),
                add_dimension(cshare(gdx, level="grid",  reference="target", spamfiledirectory=outputdir), 
                              add = "reference", nm = "target"))

## Writing netcdf files
writeLines("\nWriting soil C-share data to spatially explicit file\n")
write.magpie(cshare,file_name=paste0(outputdir,"/soil_c-share.nc"), comment="Soil Carbon share compared to potential natural vegetation")


SOM   <- mbind(add_dimension(SOM(gdx, level="grid", type="density", reference="actual", spamfiledirectory=outputdir), 
                              add = "reference", nm = "actual"),
                add_dimension(SOM(gdx, level="grid", type="density", reference="target", spamfiledirectory=outputdir), 
                              add = "reference", nm = "target"))

## Writing netcdf files
writeLines("\nWriting soil carbon density data to spatially explicit file\n")
write.magpie(SOM,file_name=paste0(outputdir,"/soil_c-density.nc"), comment="Soil Carbon density")



