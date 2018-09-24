*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Yields
*'
*' @description The yields module simulates the temporal development of crop 
*' yields and pasture productivity. Spatially explicit information on pasture 
*' productivity and crop yields under both rainfed and irrigated conditions is 
*' provided by the global gridded crop model LPJmL (Lund-Potsdam-Jena with 
*' managed Land) [@bondeau_lpjml_2007]. In the initial year of the simulation 
*' period, crop yields and pasture productivity are calibrated at the regional 
*' level to meet the observed cropland and pasture area as reported by 
*' [@FAOSTAT]. For the simulation of the temporal development of agricultural 
*' yields, the module receives information about the agricultural land use 
*' intensity represented by the $\tau$ factor coming from the module [13_tc]. 
*' 
*' The module returns yields for all crops and for pasture, which is then used 
*' by the modules [30_crop] and [31_past].
*' 
*' @authors Jan Philipp Dietrich, Isabelle Weindl, Florian Humpenöder, Anne Biewald



*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%yields%" == "biocorrect" $include "./modules/14_yields/biocorrect.gms"
$Ifi "%yields%" == "dynamic_aug18" $include "./modules/14_yields/dynamic_aug18.gms"
*###################### R SECTION END (MODULETYPES) ############################
