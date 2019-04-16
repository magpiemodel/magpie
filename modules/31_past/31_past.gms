*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Pasture
*'
*' @description The pasture module determines land used as pasture for livestock
*' rearing. At the same time, it calculates geographically explicit production
*' of pasture biomass and the carbon content of pasture land. Therefore, the
*' module requires cellular information about the carbon density related to the
*' different pasture carbon pools. Furthermore, it delivers regional production
*' costs associated with pastures.
*'
*' @authors Isabelle Weindl, Jan Philipp Dietrich

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%past%" == "endo_jun13" $include "./modules/31_past/endo_jun13.gms"
$Ifi "%past%" == "static" $include "./modules/31_past/static.gms"
*###################### R SECTION END (MODULETYPES) ############################
