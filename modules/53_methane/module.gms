*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Methane

*' @description This module calculates methane emissions according
*' to 2006 IPCC Guidelines of National Greenhouse Gas Inventories.
*' See also @ipcc_2006_2006.

*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%methane%" == "ipcc2006_flexreg_apr16" $include "./modules/53_methane/ipcc2006_flexreg_apr16/realization.gms"
$Ifi "%methane%" == "off" $include "./modules/53_methane/off/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
