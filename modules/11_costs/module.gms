*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
$Ifi "%costs%" == "default" $include "./modules/11_costs/default/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
