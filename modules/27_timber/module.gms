*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
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
*' costs associated with pastures.
*'
*' @authors Abhijeet Mishra

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%timber%" == "exo_sep19" $include "./modules/27_timber/exo_sep19/realization.gms"
$Ifi "%timber%" == "off" $include "./modules/27_timber/off/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
