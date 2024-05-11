*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description biomass_mar20 realization acts as a common tunnel for land related
*' decisions in forestry [32_forestry] and natveg [35_natveg] modules and corresponding
*' production of woody biomass realized. This realization harvests timber from
*' available plantations to meet a portion of overall timber demand. Rest of the timber
*' production comes by harvesting natural vegetation. Aggregated timber demand for
*' wood and woodfuel is calculated based on demand equation from @lauri_timber_demand
*' and income elasticities from @morland2018supply. See @mishra_forestry_2021 for more details. 
*' This realization can also account for construction wood demand based on 
*' @churkina2020buildings which is added on top of industrial roundwood demand (see @mishra_timbercities_2022).

*' @limitations Timber demand cannot be determined endogenously

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/73_timber/default/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/73_timber/default/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/73_timber/default/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/73_timber/default/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/73_timber/default/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/73_timber/default/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/73_timber/default/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/73_timber/default/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
