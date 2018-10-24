*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Costs
*'
*' @description The cost module determines the sum total of global production
*' costs in each time step. MAgPIE's objective is to minimize the global cost of
*' production in a recursive dynamic way. The interface variable `vm_cost_glo`
*' is used for this purpose. The model optimizes the production activities
*' accordingly to ensure that all the demand and supply constraints are met
*' while minimizing the global production costs.

*' @authors Benjamin Leon Bodirsky, Florian Humpenöder, Jan Philipp Dietrich

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%costs%" == "default" $include "./modules/11_costs/default.gms"
*###################### R SECTION END (MODULETYPES) ############################
