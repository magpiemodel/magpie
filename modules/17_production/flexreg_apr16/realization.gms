*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description  This realization aggregates agricultural production from
*' cluster level `j` to regional level `i`. Currently, cluster level production
*' is available only for plant commodities, i.e for crops and pastures.
*' Cluster level production of different crops and pasture is calculated in
*' module [30_crop] and [31_past] respectively.

*' @limitations For the time being, this approach is not applied to livestock
*' products.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/17_production/flexreg_apr16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/17_production/flexreg_apr16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/17_production/flexreg_apr16/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/17_production/flexreg_apr16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/17_production/flexreg_apr16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
