*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization, aggregated timber demand for wood and woodfuel 
*' `pm_demand_forestry` is calculated based on demand equation from @lauri_timber_demand
*' and income elasticities from @morland2018supply. See @mishra_forestry_2021 for more details. 
*' This realization can also account for construction wood demand based on 
*' @churkina2020buildings which is added on top of industrial roundwood demand (see @mishra_timbercities_2022).
*' Timber can be produced from both timber plantations `vm_prod_forestry` provided by [32_forestry] 
*' and natural vegetation `vm_prod_natveg` provided by [35_natveg]. 

*' @limitations Timber demand cannot be determined endogenously

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/73_timber/default/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/73_timber/default/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/73_timber/default/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/73_timber/default/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/73_timber/default/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/73_timber/default/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/73_timber/default/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
