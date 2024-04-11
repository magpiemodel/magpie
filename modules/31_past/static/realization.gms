*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
