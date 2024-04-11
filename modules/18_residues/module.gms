*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Residues
*'
*' @description The residues module calculates the production of crop residues
*' (straw, etc.) and its subsequent use. Residues can be burned, used for feed,
*' recycled to soils or used for other purposes (construction, fuel, etc.).
*'
*' The module also calculates the costs of crop residue harvest when it is used
*' for feed or material purposes.
*'
*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%residues%" == "flexcluster_jul23" $include "./modules/18_residues/flexcluster_jul23/realization.gms"
$Ifi "%residues%" == "flexreg_apr16" $include "./modules/18_residues/flexreg_apr16/realization.gms"
$Ifi "%residues%" == "off" $include "./modules/18_residues/off/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################

*** EOF residues.gms ***
