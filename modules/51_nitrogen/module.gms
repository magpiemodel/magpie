*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Nitrogen
*' @description
*' The nitrogen module calculates nitrogeneous emissions before technical
*' mitigation, including N2O, NOx, NH3, NO3- and N2.
*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%nitrogen%" == "ipcc2006_sep16" $include "./modules/51_nitrogen/ipcc2006_sep16/realization.gms"
$Ifi "%nitrogen%" == "off" $include "./modules/51_nitrogen/off/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
