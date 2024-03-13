*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Agroforestry
*'
*' @description The purpose of the agroforestry module is to model different agroforestry 
*' systems such as bioenergy trees and tree cover on cropland (hedgerows). 
*' The agroforestry module interacts via the interfaces $vm\_area$ and $vm\_land$ with 
*' the [30_crop] module. Furthermore, the agroforestry module provides cropland tree cover 
*' ($vm\_treecover\_area$) and corresponding carbon stocks $vm\_treecover\_carbon$ to the [30_crop] module.
*'
*' @authors Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%agroforestry%" == "endo" $include "./modules/61_agroforestry/endo/realization.gms"
$Ifi "%agroforestry%" == "exo" $include "./modules/61_agroforestry/exo/realization.gms"
$Ifi "%agroforestry%" == "off" $include "./modules/61_agroforestry/off/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
