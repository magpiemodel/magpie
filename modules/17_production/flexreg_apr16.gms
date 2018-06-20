*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization aggregates agricultural production
*' from cellular level to MAgPIE regions of the world.
*' Currently, cellular level production is available only for plant commodities, i.e,
*' for crops and pastures.
*' Cellular level production of different crops and pasture
*' is calculated in module [30_crop]
*' and [31_past] respectively.

*' @limitations For the time being, this approach is not applied to livestock products.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/17_production/flexreg_apr16/declarations.gms"
$Ifi "%phase%" == "equations" $include "./modules/17_production/flexreg_apr16/equations.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/17_production/flexreg_apr16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
