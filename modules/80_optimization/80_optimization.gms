*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%optimization%" == "lp_nlp_glo_jan15" $include "./modules/80_optimization/lp_nlp_glo_jan15.gms"
$Ifi "%optimization%" == "lp_only_glo_feb16" $include "./modules/80_optimization/lp_only_glo_feb16.gms"
$Ifi "%optimization%" == "nlp_only_glo_jan15" $include "./modules/80_optimization/nlp_only_glo_jan15.gms"
*###################### R SECTION END (MODULETYPES) ############################
