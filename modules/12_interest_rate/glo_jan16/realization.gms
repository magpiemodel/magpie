*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the glo_jan16 realization, interest rates are identical in all regions.
*' The initial global interest rate is 7% (in 1995) for all scenarios defined in `scen12`.
*' It undergoes a transition towards 4%, 7% and 10% until 2030 for the low-, medium-
*' and high- interest rate scenarios, respectively.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/12_interest_rate/glo_jan16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/12_interest_rate/glo_jan16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/12_interest_rate/glo_jan16/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/12_interest_rate/glo_jan16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/12_interest_rate/glo_jan16/presolve.gms"
*######################## R SECTION END (PHASES) ###############################
