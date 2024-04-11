*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Nitrogen
*' @description
*' The nitrogen module calculates nitrogeneous emissions before technical
*' mitigation, including N2O, NOx, NH3, NO3- and N2. Sources of these emissions include
*' manure, inorganic fertilizers, crop residues, soil organic matter, and indirect emissions.
*'
*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%nitrogen%" == "off" $include "./modules/51_nitrogen/off/realization.gms"
$Ifi "%nitrogen%" == "rescaled_jan21" $include "./modules/51_nitrogen/rescaled_jan21/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
