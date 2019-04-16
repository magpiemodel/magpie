*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Methane

*' @description This module calculates methane emissions according
*' to 2006 IPCC Guidelines of National Greenhouse Gas Inventories.
*' See also @ipcc_2006_2006.

*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%methane%" == "ipcc2006_flexreg_apr16" $include "./modules/53_methane/ipcc2006_flexreg_apr16.gms"
$Ifi "%methane%" == "off" $include "./modules/53_methane/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
