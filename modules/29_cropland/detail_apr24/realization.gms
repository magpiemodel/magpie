*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization, total cropland equals the sum of croparea,  
*' fallow land and tree cover on cropland. Correspondingly, cropland carbon stocks consist 
*' of carbons stocks for croparea, fallow land and tree cover on cropland.
*' The development of fallow land and tree cover on cropland depends on targets defined 
*' as a certain fraction of total cropland. These targets can be either exogenously enforced 
*' (rule-based) or endogenously incentivized by a penalty term, which enters the objective function. 

*' This realisation also includes the option to reserve a minimum semi-natural
*' vegetation share within the total available cropland for other land cover
*' classes, including grassland, forest, and other land (by a given target year),
*' in order to provide species habitats and to benefit from ecosystem ervices in
*' agricultural landscapes.

*' @limitations There are currently no known limitations of this realization.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/29_cropland/detail_apr24/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/29_cropland/detail_apr24/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/29_cropland/detail_apr24/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/29_cropland/detail_apr24/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/29_cropland/detail_apr24/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/29_cropland/detail_apr24/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/29_cropland/detail_apr24/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
