*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The foragebased_aug18 realization constrains the cellular ruminant livestock production by 
*' the feed availability for grazed pasture and fodder crops. This accounts for the fact that pasture and fodder 
*' (summarized with forage) feed stuff is usually not transported over long distances and at the same time 
*' is very essential in livestock diets. Internally it distinguishs between extensively and intensively fed ruminants. 
*' The monogastric livestock is distributed following the idea that these animals are held close to densely populated 
*' areas. For more detailed information on cellular livestock distribution see @robinson_mapping_2014, which inspired 
*' this realization.

*' This realization includes a minimal lower bound for ruminant production to avoid avoid GAMS corner solutions at 
*' higher spatial resolutions.

*' @limitations Distribution of monogastrics do not account for feed availability within a cell. 
*' Crop residue feed stuff for ruminant production is also not considered to restrict livestock 
*' production. Forage feed stuff is consider not to be transported, but is in reality.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/71_disagg_lvst/foragebased_aug18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/71_disagg_lvst/foragebased_aug18/declarations.gms"
$Ifi "%phase%" == "equations" $include "./modules/71_disagg_lvst/foragebased_aug18/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/71_disagg_lvst/foragebased_aug18/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/71_disagg_lvst/foragebased_aug18/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/71_disagg_lvst/foragebased_aug18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
