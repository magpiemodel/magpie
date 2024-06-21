*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Forestry
*'
*' @description The forestry module describes the constraints under which three different 
*' types of managed age-class forests exist: plantations used for wood harvesting (plant), 
*' prescribed re/afforestation based on existing national policies (ndc) and endogenous 
*' CO2-price driven re/afforestation (aff) (@humpenoeder_overcoming_2022). 
*' These types of managed forests are made 
*' available to other modules via the interface `vm_land_forestry`. At the same time, 
*' the module calculates the corresponding carbon stocks and biodiversity values for all 
*' three types of managed forest. The module provides expected carbon dioxide removal (CDR) 
*' from endogenous re/afforestation to the GHG policy module ([56_ghg_policy]). 
*' Costs related to managed forests, including costs for harvesting, establishment and 
*' management, are provided to the cost module ([11_costs]).
*'
*' @authors Florian Humpenöder, Abhijeet Mishra

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%forestry%" == "dynamic_may24" $include "./modules/32_forestry/dynamic_may24/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
