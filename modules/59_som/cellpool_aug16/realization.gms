*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' The cellpool_aug16 realization is built on the IPCC 2006 Guidelines for
*' National Greenhouse Gas Inventories (@ipcc_2006_2006.). It calculates the loss of
*' soil carbon due to cropping activities and management based on stock change factors,
*' compared to potential natural vegetation.
*' This approach also accounts for the temporal dimension of soil organic carbon change,
*' since it assumes a gradual step of 15% in the direction of the new equilibrium soil
*' organic carbon pool each year. Stock change factors tracks crop types as well as
*' management (e.g. irrigation) and input differences on cropland.

*' @limitations It is assumed that pastures and rangelandes as well as managed forests
*' do not change in soil carbon compared to the natural reference state. Moreover only
*' transitions from other land and primary forest to secondary forest between optimization
*' steps (due to natural regrowth and disturbance loss) are accounted for.


*' @authors Kristine Karstens, Benjamin Leon Bodirsky



*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/59_som/cellpool_aug16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/59_som/cellpool_aug16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/59_som/cellpool_aug16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/59_som/cellpool_aug16/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/59_som/cellpool_aug16/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/59_som/cellpool_aug16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/59_som/cellpool_aug16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/59_som/cellpool_aug16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
