*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' Emissions are set to zero.
*'
*' @authors Benjamin Leon Bodirsky
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/51_nitrogen/off/declarations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/51_nitrogen/off/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/51_nitrogen/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################