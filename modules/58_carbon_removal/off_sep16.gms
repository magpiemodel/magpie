*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the off_sep16 realization, carbon dioxide removal costs and 
*' emissions before technical mitigation are set to 0. Thus, there is no economic incentive 
*' to remove carbon from the atmosphere.
*'
*' @limitations The lack of representation of carbon removal mechanisms might be relevant for 
*' developing countries reducing emissions from the land use change sector, especially  
*' if they are part of the UN-REDD Programme. 

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/58_carbon_removal/off_sep16/declarations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/58_carbon_removal/off_sep16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/58_carbon_removal/off_sep16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
