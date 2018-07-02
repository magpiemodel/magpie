*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Carbon
*'
*' @description The carbon module provides annual land-related CO2 emissions for the 
*' [56_ghg_policy] module. 
*'
*' @authors Benjamin Leon Bodirsky, Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%carbon%" == "normal_dec17" $include "./modules/52_carbon/normal_dec17.gms"
$Ifi "%carbon%" == "off" $include "./modules/52_carbon/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
