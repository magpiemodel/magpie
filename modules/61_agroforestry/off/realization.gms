*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization, agroforestry does not exist. Therefore, 
*' cropland tree cover and corresponding carbon stocks are fixed to zero.

*' @limitations Cropland tree cover and corresponding carbon stocks are fixed to zero.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/61_agroforestry/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/61_agroforestry/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/61_agroforestry/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
