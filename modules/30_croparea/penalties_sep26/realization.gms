*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
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
*' Rotational constraints are implemented as penalty payments that are due if a
*' constraint is exceeded. Crops can therefore still be grown beyond the
*' rotational limit, but only if the additional revenue outweighs the penalty.
*' Constraints are defined for total croparea as well as for irrigated areas
*' only, to avoid overspecialization on irrigated land. The rule set is fixed
*' and covers only rules that carry a penalty; different levels of ambition are
*' selected through `c30_rotation_policy` rather than through the rules
*' themselves. See realization `rules_sep26` for rotational constraints
*' implemented as hard limits, which uses a larger, scenario-dependent rule set.

*' @limitations There are currently no known limitations of this realization.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/30_croparea/penalties_sep26/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/30_croparea/penalties_sep26/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/30_croparea/penalties_sep26/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/30_croparea/penalties_sep26/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/30_croparea/penalties_sep26/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/30_croparea/penalties_sep26/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/30_croparea/penalties_sep26/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/30_croparea/penalties_sep26/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
