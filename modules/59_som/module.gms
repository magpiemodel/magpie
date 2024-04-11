*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Soil organic matter

*' @description
*' The soil organic matter module calculates the soil organic carbon loss due to landuse activities.
*' It also estimates the nitrogen release due to the soil organic carbon turnover.  

*' @authors Benjamin Leon Bodirsky, Kristine Karstens




*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%som%" == "cellpool_aug16" $include "./modules/59_som/cellpool_aug16/realization.gms"
$Ifi "%som%" == "cellpool_jan23" $include "./modules/59_som/cellpool_jan23/realization.gms"
$Ifi "%som%" == "static_jan19" $include "./modules/59_som/static_jan19/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
