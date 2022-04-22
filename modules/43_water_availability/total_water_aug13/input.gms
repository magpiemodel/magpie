*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
s43_shock_year                     Year in which policy shock can be implemented (1)  / 1995 /
;

$setglobal c43_watavail_scenario  exo
*   options:   cc       (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)
*             exo       (exogenous restrictions on water availability)

parameters
f43_wat_avail(t_all,j) Surface water available for irrigation per cell from LPJmL (mio. m^3 per yr)
/
$ondelim
$include "./modules/43_water_availability/input/lpj_watavail_grper.cs2"
$offdelim
/
;
