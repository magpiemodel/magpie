*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the static realisation, forestry land is held fixed on the
*' observed 1995 level. This represents a static forestry sector,
*' i.e., these areas are prohibited to be used by other land-use types.
*' This also assumes that the roundwood demand can be fulfilled with current areas.

*' @limitations forestry sector is static over time, Afforestation for carbon
*' dioxide removal(CDR) purposes `vm_cdr_aff` and afforestation costs
*' `vm_cost_fore` are set to 0.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/32_forestry/static_sep16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/32_forestry/static_sep16/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/32_forestry/static_sep16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/32_forestry/static_sep16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/32_forestry/static_sep16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
