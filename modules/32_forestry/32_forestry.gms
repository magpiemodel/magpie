*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Forestry
*'
*' @description The Forestry module describes the constraints under which managed
*' forest (age-class forest) exists. At the same time it calculates the corresponding
*' carbon stocks. This module provides the total carbon dioxide removal from afforestation
*' to the Green House Gases policy module ([56_ghg-policy]), aggregated difference in
*' forestry land compared to previous timestep to the land module ([10_land]) and also
*' provides the forestry related costs to the costs module ([11_costs]) while accounting
*' for drivers in the form of timber demand ([16-demand]), carbon stock and carbon density
*' ([52_carbon]) and land use levels (i.e., initialization and land use patterns) ([10_land]).
*'
*' @authors Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%forestry%" == "affore_vegc_dec16" $include "./modules/32_forestry/affore_vegc_dec16.gms"
$Ifi "%forestry%" == "static_sep16" $include "./modules/32_forestry/static_sep16.gms"
*###################### R SECTION END (MODULETYPES) ############################
