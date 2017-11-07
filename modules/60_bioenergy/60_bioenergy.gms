*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%bioenergy%" == "combined_bio_aug18" $include "./modules/60_bioenergy/combined_bio_aug18.gms"
$Ifi "%bioenergy%" == "standard_flexreg_may17" $include "./modules/60_bioenergy/standard_flexreg_may17.gms"
$Ifi "%bioenergy%" == "bioenergyspecialized_nov17" $include "./modules/60_bioenergy/bioenergyspecialized_nov17.gms"
*###################### R SECTION END (MODULETYPES) ############################
