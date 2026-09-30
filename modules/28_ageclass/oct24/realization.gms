*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description  This realization provides forest area in age-classes `im_forest_ageclass`,
*' by default (`c28_ageclass_source=gami`) from GAMI v2.1 [@besnard_gami_2024] or, with
*' `c28_ageclass_source=gfad`, from the Global Forest Age Dataset (GFAD V1.1) @poulter_global_2019.

*' @limitations The age-class data give the age of forest but not why it is young. In reality much
*' young forest is repeatedly reset by disturbances (shifting cultivation, fire, small-scale clearing)
*' that MAgPIE does not represent explicitly, so it would not all grow into old forest. Module
*' [35_natveg] accounts for this when it initialises secondary forest from `im_forest_ageclass`.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/28_ageclass/oct24/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/28_ageclass/oct24/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/28_ageclass/oct24/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/28_ageclass/oct24/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/28_ageclass/oct24/presolve.gms"
*######################## R SECTION END (PHASES) ###############################
