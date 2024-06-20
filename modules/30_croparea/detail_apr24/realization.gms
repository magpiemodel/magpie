*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization calculates the crop specific
*' agricultural crop area endogenously based on yield data provided by 
*' module [14_yields] and detailed rotational constraints.
*' In addition, corresponding carbons stocks and BII values are calculated.
*'
*' The crop specific interface `vm_area` is used in many other modules, 
*' including [18_residues], [38_factor_costs],
*' [41_area_equipped_for_irrigation], [42_water_demand], [50_nr_soil_budget],
*' [53_methane] and [59_som].
*'
*' This realization allows for different scenarios of rotational
*' constraints which are either implemented via hard constraints or penalty payments 
*' if constraints are exceeded. Rotational constraints are defined for total croparea 
*' as well as for irrigated areas only to avoid overspecialization on irrigated land.

*' @limitations There are currently no known limitations of this realization.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/30_croparea/detail_apr24/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/30_croparea/detail_apr24/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/30_croparea/detail_apr24/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/30_croparea/detail_apr24/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/30_croparea/detail_apr24/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/30_croparea/detail_apr24/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/30_croparea/detail_apr24/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
