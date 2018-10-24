*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the static realization, pasture areas are constant over time,
*' independent from developments in the livestock sector and land competition.

*' @limitations There are no computational limitations to this realization.
*' Since pasture areas are static, they do not respond to demand trajectories
*' and trends in the land use and agricultural sectors like intensification
*' pathways, increasing production of animal products, bioenergy production or
*' afforestation policies. This may lead to an inconsistent overall picture of
*' future land use dynamics.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "presolve" $include "./modules/31_past/static/presolve.gms"
*######################## R SECTION END (PHASES) ###############################
