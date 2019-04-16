*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description This 'mixed' realization specifies factors costs to depend on
*' area harvested and agricultural land use intensity and corresponding average
*' production volumes.
*' Consequently, factor costs in this realization react on both: area under
*' production and average productivity of a region as captured by the $\tau$
*' factor. A detailed description of the approach can be found
*' in @dietrich_forecasting_2014 with background information about the used
*' intensity measure in @dietrich_measuring_2012.
*'
*' @limitations This realization assumes that factor costs only depend on area
*' and average productivity of a region. Productivity differences within a
*' region are ignored. Therefore, cases in which the cellular productivity
*' levels affect factors costs are only partially accounted for.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/38_factor_costs/mixed_feb17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/38_factor_costs/mixed_feb17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/38_factor_costs/mixed_feb17/equations.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/38_factor_costs/mixed_feb17/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
