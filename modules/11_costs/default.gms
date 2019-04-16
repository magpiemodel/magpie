*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @description The default realization of the costs module calculates global production
*' costs with a constraint of production always fulfilling the demand.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/11_costs/default/declarations.gms"
$Ifi "%phase%" == "equations" $include "./modules/11_costs/default/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/11_costs/default/scaling.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/11_costs/default/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
