*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Nitrogen
*' @description
*' The nitrogen module calculates nitrogeneous emissions before technical
*' mitigation, including N2O, NOx, NH3, NO3- and N2.
*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%nitrogen%" == "ipcc2006_sep16" $include "./modules/51_nitrogen/ipcc2006_sep16.gms"
$Ifi "%nitrogen%" == "off" $include "./modules/51_nitrogen/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
