*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Forestry
*'
*' @description The forestry module describes the constraints under which managed
*' forest (age-class forest) exists. At the same time it calculates the corresponding
*' carbon stocks and biodiversity value. The module provides carbon dioxide removal (CDR) from afforestation
*' to the GHG policy module ([56_ghg_policy]) as well as afforestation related costs
*' to the costs module ([11_costs]).
*'
*' @authors Florian Humpenöder, Abhijeet Mishra

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%forestry%" == "dynamic_feb21" $include "./modules/32_forestry/dynamic_feb21/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
