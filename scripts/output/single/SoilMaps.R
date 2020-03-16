# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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



