*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Residues
*'
*' @description The residues module calculates the production of crop residues
*' (straw etc.) and its subsequent use. Residues can be burned, used for feed,
*' recycled to soils or used for other purposes (construction, fuel etc).
*'
*' The module also calculates the costs of crop residue harvest when it is used
*' for feed or material purposes.

*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%residues%" == "flexreg_apr16" $include "./modules/18_residues/flexreg_apr16.gms"
$Ifi "%residues%" == "off" $include "./modules/18_residues/off.gms"
*###################### R SECTION END (MODULETYPES) ############################

*** EOF residues.gms ***
