*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the endo_jun13 realization, pasture area and related carbon
*' stocks are modelled endogenously. The initial spatially explicit patterns of
*' pasture are defined in the module [10_land] by the land use input data set.
*' For future time steps, pasture area depends on the demand for biomass from
*' pastures to feed livestock as calculated in the module [70_livestock] and
*' from the intensity of pasture utilization ("pasture yield") as determined in
*' the module [14_yields].

*' @limitations No consideration of generic differences between extensive and
*' intensive grazing systems, of explicit pasture management options and of
*' related degradation of pastures.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/31_past/endo_jun13/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/31_past/endo_jun13/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/31_past/endo_jun13/equations.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/31_past/endo_jun13/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
