*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization specifies factors costs
*' to depend on area harvested and agricultural land use intensity.
*' Consequently, we dubbed it as 'mixed' as the factor costs depend on both area harvested
*' and agricultural productivity as captured by the $\tau$ factor.
*' We refer the reader to @dietrich_measuring_2012 and @dietrich_forecasting_2014 for more on
*' the calculations of the initial agricultural land use intensities.
*'
*' @limitations This realization assumes that factor costs, within a region,
*' purely depend on the area harvested regardless of the productivity potential of different cells.
*' Therefore, cases in which the cellular productivity level significantly affect factors costs per area,
*' other than the regional intensity factor ($\tau$) are not fully accounted.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/38_factor_costs/mixed_feb17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/38_factor_costs/mixed_feb17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/38_factor_costs/mixed_feb17/equations.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/38_factor_costs/mixed_feb17/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
