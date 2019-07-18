*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The static_jan19 realization is built on the IPCC 2006 Guidelines for
*' National Greenhouse Gas Inventories (@ipcc_2006_2006.). It calculates based
*' on the idea of stock change factors regarding the potential natural vegetation
*' the loss of soil carbon due to cropping activities and management.
*' This approach does not accounts for the temporal dimension of soil organic carbon change,
*' since it assumes a complete loss of carbon directly after land conversion to cropland.
*' Only one stock change factors for all crop types is used, 
*' neglecting e.g. differences for annual and perenial crops.

*' @limitations The soil carbon dynamics are instantaneously and do not account
*' for any time dependent release of soil carbon. The soil carbon pools on cropland
*' are also not crop type specific. The release of nitrogen due to soil organic matter loss is not calculated.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/59_som/static_jan19/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/59_som/static_jan19/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/59_som/static_jan19/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/59_som/static_jan19/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/59_som/static_jan19/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/59_som/static_jan19/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/59_som/static_jan19/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
