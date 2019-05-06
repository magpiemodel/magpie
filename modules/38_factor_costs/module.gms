*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @title Factor Costs

*' @description This module is used to calculate factor costs of production in
*' crop activities. The costs of factors of production included in this module
*' are specifically of labor, capital, and energy and related costs. The costs
*' are crop-specific, and pass to the the cost function in [11_costs].
*' Thus, factor costs will contribute to and influence the choice of production
*' pattern in the model.

*' @authors Jan Philipp Dietrich, Benjamin Bodirsky, Kristine Karstens


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%factor_costs%" == "fixed_per_ton_mar18" $include "./modules/38_factor_costs/fixed_per_ton_mar18/realization.gms"
$Ifi "%factor_costs%" == "mixed_feb17" $include "./modules/38_factor_costs/mixed_feb17/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
