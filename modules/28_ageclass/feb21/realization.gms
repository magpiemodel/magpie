*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description  This realization calculates use the results from @poulter2018global
*' for secondary forests (and timber plantations) based on MODIS satellite data.
*' This is used in [32_forestry] and [35_natveg] for initialization of forest areas
*' based on specification of endogenous (or exogenous) forest harvests. These numbers
*' are the most consistent dataset available on spatial scale and are preferred over
*' extarcting such numbers from LUH data due to ease of generating these numbers.

*' @limitations Forest fires change how the age structures of secondary or
*' human-intervention forests over time. This being a satellite observation data
*' probably includes such disturbances. These disturbances are not modeled extensively
*' in MAgPIE and hence using these numbers directly in the model might generate biases.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/28_ageclass/feb21/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/28_ageclass/feb21/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/28_ageclass/feb21/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/28_ageclass/feb21/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/28_ageclass/feb21/presolve.gms"
*######################## R SECTION END (PHASES) ###############################
