*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%land_tax%" == "exp_jul16" $include "./modules/37_land_tax/exp_jul16.gms"
$Ifi "%land_tax%" == "off_jul16" $include "./modules/37_land_tax/off_jul16.gms"
$Ifi "%land_tax%" == "stock_jul16" $include "./modules/37_land_tax/stock_jul16.gms"
*###################### R SECTION END (MODULETYPES) ############################
