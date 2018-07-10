*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
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
*' The module also calculates how much additional crops have to be
*' produced in the case that feed requirements for residues exceed the production.
*' The module is therefore of use for the general model behaviour as well as the nitrogen module. 

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%residues%" == "flexreg_apr16" $include "./modules/18_residues/flexreg_apr16.gms"
$Ifi "%residues%" == "off" $include "./modules/18_residues/off.gms"
*###################### R SECTION END (MODULETYPES) ############################

*** EOF residues.gms ***
