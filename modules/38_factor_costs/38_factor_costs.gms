*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @title Factor Costs
*' @description In factor costs module we present parts of crop-specific factor costs of production. 
*' These costs pass to the the cost optimization (cost minimization in MAgPIE's case) function which is in ([11_costs]).
*' The costs of factors of production included in this module are specifically of labor, capital, and related costs.
*' Thus, factor costs will influence the choice of production pattern in the model.




*' @authors Jan Philipp Dietrich, Benjamin Bodirsky, Amsalu Woldie Yalew, Kristine Karstens


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%factor_costs%" == "fixed_per_ton_mar18" $include "./modules/38_factor_costs/fixed_per_ton_mar18.gms"
$Ifi "%factor_costs%" == "mixed_feb17" $include "./modules/38_factor_costs/mixed_feb17.gms"
*###################### R SECTION END (MODULETYPES) ############################
