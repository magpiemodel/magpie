*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Forestry
*'
*' @description The Forestry module describes the constraints under which managed
*' forest (age-class forest) exists. At the same time it calculates the
*' corresponding carbon stocks.
*'
*' @authors Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%forestry%" == "affore_vegc_dec16" $include "./modules/32_forestry/affore_vegc_dec16.gms"
$Ifi "%forestry%" == "static_sep16" $include "./modules/32_forestry/static_sep16.gms"
*###################### R SECTION END (MODULETYPES) ############################
