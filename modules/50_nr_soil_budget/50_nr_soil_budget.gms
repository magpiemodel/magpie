*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%nr_soil_budget%" == "exoeff_aug16" $include "./modules/50_nr_soil_budget/exoeff_aug16.gms"
$Ifi "%nr_soil_budget%" == "off" $include "./modules/50_nr_soil_budget/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
