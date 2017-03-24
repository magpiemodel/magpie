*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/37_land_tax/off_jul16/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/37_land_tax/off_jul16/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/37_land_tax/off_jul16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
