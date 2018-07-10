*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Soil organic matter

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%som%" == "cellpool_aug16" $include "./modules/59_som/cellpool_aug16.gms"
$Ifi "%som%" == "off" $include "./modules/59_som/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
