*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization, total cropland equals croparea because 
*' fallow land and tree cover on cropland are fixed to zero. 
*' Therefore, also cropland carbon stocks consist only of croparea carbon stocks.
*' Biodiversity BII values are fixed to zero. 
*' Costs are fixed to zero. 

*' This realisation also includes the option to reserve a minimum semi-natural
*' vegetation share within the total available cropland for other land cover
*' classes, including grassland, forest, and other land (by a given target year),
*' in order to provide species habitats and to benefit from ecosystem ervices in
*' agricultural landscapes.

*' @limitations Fallow land and tree cover on cropland are fixed to zero 

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/29_cropland/simple_apr24/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/29_cropland/simple_apr24/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/29_cropland/simple_apr24/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/29_cropland/simple_apr24/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/29_cropland/simple_apr24/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/29_cropland/simple_apr24/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/29_cropland/simple_apr24/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
