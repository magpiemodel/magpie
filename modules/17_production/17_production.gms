*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Production

*' @description The production module calculates regional production of
*' MAgPIE commodities for which cellular production is available.

*' @authors

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%production%" == "flexreg_apr16" $include "./modules/17_production/flexreg_apr16.gms"
*###################### R SECTION END (MODULETYPES) ############################
