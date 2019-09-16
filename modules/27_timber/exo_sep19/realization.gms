*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the exo_sep19 realization, pasture area and related carbon
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
$Ifi "%phase%" == "sets" $include "./modules/27_timber/exo_sep19/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/27_timber/exo_sep19/declarations.gms"
$Ifi "%phase%" == "equations" $include "./modules/27_timber/exo_sep19/equations.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/27_timber/exo_sep19/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
