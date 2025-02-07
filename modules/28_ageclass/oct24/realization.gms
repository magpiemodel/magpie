*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description  This realization provides forest area in age-classes `im_forest_ageclass`
*' based on the Global Forest Age Dataset (GFAD V1.1) from @poulter_global_2019. 

*' @limitations Disturbances such as forest fires change the age structure of forests over time. 
*' GFAD V1.1 likely includes such disturbances in younger age-classes (`ac_young`).
*' Since forest disturbances are not modeled extensively in MAgPIE, 
*' using these numbers directly in the model might generate biases.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/28_ageclass/oct24/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/28_ageclass/oct24/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/28_ageclass/oct24/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/28_ageclass/oct24/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/28_ageclass/oct24/presolve.gms"
*######################## R SECTION END (PHASES) ###############################
