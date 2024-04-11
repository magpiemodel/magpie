*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Pasture
*'
*' @description The pasture module determines land used as pasture for livestock
*' rearing. At the same time, it calculates geographically explicit production
*' of pasture biomass and the carbon content of pasture land. Therefore, the
*' module requires cellular information about the carbon density related to the
*' different pasture carbon pools. Furthermore, it delivers regional production
*' costs associated with pastures and biodiversity values for pasture and rangeland.
*'
*' @authors Isabelle Weindl, Jan Philipp Dietrich, Marcos Alves

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%past%" == "endo_jun13" $include "./modules/31_past/endo_jun13/realization.gms"
$Ifi "%past%" == "grasslands_apr22" $include "./modules/31_past/grasslands_apr22/realization.gms"
$Ifi "%past%" == "static" $include "./modules/31_past/static/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
