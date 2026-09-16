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
*' This realization allows for different scenarios of rotational
*' constraints, which are implemented as hard constraints that cannot be
*' exceeded at any price. Rotational constraints are defined for total croparea.
*' No separate constraint is applied to irrigated areas, as a hard limit on
*' irrigated shares can easily render the model infeasible. See realization
*' `penalties_sep26` for rotational constraints implemented as penalty payments,
*' which uses a smaller, fixed rule set and does include the irrigated constraint.

*' @limitations There are currently no known limitations of this realization.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/30_croparea/rules_sep26/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/30_croparea/rules_sep26/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/30_croparea/rules_sep26/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/30_croparea/rules_sep26/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/30_croparea/rules_sep26/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/30_croparea/rules_sep26/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/30_croparea/rules_sep26/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/30_croparea/rules_sep26/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
