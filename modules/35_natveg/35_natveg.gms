*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%natveg%" == "dynamic_mai17" $include "./modules/35_natveg/dynamic_mai17.gms"
$Ifi "%natveg%" == "static" $include "./modules/35_natveg/static.gms"
*###################### R SECTION END (MODULETYPES) ############################
