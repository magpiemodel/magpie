*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/80_optimization/lp_nlp_glo_jan15/declarations.gms"
$Ifi "%phase%" == "l_solve" $include "./modules/80_optimization/lp_nlp_glo_jan15/l_solve.gms"
$Ifi "%phase%" == "nl_solve" $include "./modules/80_optimization/lp_nlp_glo_jan15/nl_solve.gms"
*######################## R SECTION END (PHASES) ###############################
