*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the grasslands_apr22 realization, grassland areas and related
*' carbon stocks are modelled endogenously. The initial spatially explicit patterns
*' of grasslands ("past") are defined in the module [10_land] by the land use input
*' data set. These areas are further divided into rangelands and managed pastures
*' under different management assumptions. For future time steps, grasslands spatial
*' distribution depend on the demand of grass biomass to feed livestock as calculated
*' in the module [70_livestock] and from the intensity of grassland utilization
*' ("grassland yields"). Grassland yields are defined separately for rangelands
*' and managed pasture based on historical estimates or areas and biomass production
*' for these two systems. Managed pastures yields can be increased endogenously
*' by investments in technology as calculated in [13_tc]. Rising yields alter the
*' nitrogen budged on grasslands triggering costs for N inorganic fertilization as
*' calculated in [50_nr_soil_budget] and control the balance between intensive and
*' extensive grass biomass production.

*' @limitations At the moment this realization only runs with a single climate scenario
*' (SPP1-RCP2p6 from MRI_ESM-0), which is used in all (except constant climate) settings.
*' We currently do not accout for specific differences within intensive
*' pasture management systems and related degradation of grasslands for both
*' rangelands or managed pastures. Grass production costs and conversion costs between 
*' grassland types are set 1 USD05MER per unit due to lack of data.



*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/31_past/grasslands_apr22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/31_past/grasslands_apr22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/31_past/grasslands_apr22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/31_past/grasslands_apr22/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/31_past/grasslands_apr22/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/31_past/grasslands_apr22/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/31_past/grasslands_apr22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
