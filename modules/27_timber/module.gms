*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Timber
*'
*' @description The timber module Calculates geographically explicit production
*' of wood and wood fuel while endogenously determining the optimal share of
*' wood and woodfuel production coming from plantation forests and natural forests
*' based on an exogenous timber demand calculated from FAO. 
*'
*' @authors Abhijeet Mishra

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%timber%" == "exo_sep19" $include "./modules/27_timber/exo_sep19/realization.gms"
$Ifi "%timber%" == "off" $include "./modules/27_timber/off/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
